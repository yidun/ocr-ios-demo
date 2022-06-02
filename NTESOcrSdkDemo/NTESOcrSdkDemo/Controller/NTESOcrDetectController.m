//
//  NTESOcrDetectController.m
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/11/30.
//

#import "NTESOcrDetectController.h"
#import <NTESOcrSdk/NTESOcrSdk.h>
#import "NTESToastView.h"
#import "NTESIdentifyCardNetworkAdapter.h"

@interface NTESOcrDetectController ()<NTESToastViewDelegate>

@property (nonatomic, strong) NTESOcrSdkManager *manager;

@property (nonatomic, strong) UIButton *backBarButton;
@property (nonatomic, strong) UILabel  *navTitleLabel;

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation NTESOcrDetectController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.manager = [[NTESOcrSdkManager alloc] initWithImageView:imageView scanRect:CGRectMake((SCREEN_WIDTH - 360 * KWidthScale)/2, 240, 360 * KWidthScale, 227 * KHeightScale)];
    [self.manager setTimeoutInterval:20];
    WeakSelf(self);
    [self.manager startDetectWithBusinessID:@"请输入易盾业务ID" cardReverseType:(NTESCardReverseType)self.detectType completionHandler:^(NTESOcrStatus status, NSDictionary * _Nullable params) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showToastWithLiveDetectStatus:status params:params];
        });
    }];

    [self setupViews];
}

- (void)showToastWithLiveDetectStatus:(NTESOcrStatus)status params:(NSDictionary * _Nullable) params {
    if (status == NTESOcrOperationTimeout) {
        [self.manager stopDetect];
        [NTESToastView showDetectTimeout:self];
    } else if (status == NTESOcrCheckPass) {
        [self.manager stopDetect];
        if (self.completionHandler) {
            self.completionHandler(params);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else if (status == NTESOcrCheckNotPass) {
        [self.manager stopDetect];
        [NTESToastView showNotice:@"检测不通过"];
    } else if (status == NTESOcrBusinessIdInvalid) {
        [NTESToastView showNotice:@"业务ID不可用"];
    } else if (status == NTESOcrNonGateway) {
        [NTESToastView showNotice:@"网络不可用"];
    } else if (status == NTESOcrCameraNotAvailable) {
        [NTESToastView showNotice:@"APP未获得手机权限"];
    } else if (status == NTESOcrGetConfTimeout) {
        [NTESToastView showNotice:@"获取配置信息超时"];
    }
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor blackColor];
    [self.imageView addSubview:self.backBarButton];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView bringSubviewToFront:self.backBarButton];
    [self.backBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView).offset(20*KWidthScale);
        make.top.equalTo(self.imageView).offset(58 * KHeightScale);
        make.width.equalTo(@(20*KWidthScale));
        make.height.equalTo(@(20*KWidthScale));
    }];
    
    [self.imageView addSubview:self.navTitleLabel];
    [self.imageView bringSubviewToFront:self.navTitleLabel];
    [self.navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBarButton);
        make.centerX.equalTo(self.imageView);
        make.width.equalTo(@(200));
    }];
    
    UIImageView *detectImageView = [[UIImageView alloc] init];
    detectImageView.image = [UIImage imageNamed:@"detectBorder"];
    [self.imageView addSubview:detectImageView];
    [self.imageView bringSubviewToFront:detectImageView];
    [detectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView).mas_offset(240);
        make.centerX.equalTo(self.imageView);
        make.size.mas_equalTo(CGSizeMake(360 * KWidthScale, 227 * KHeightScale));
    }];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    if (_detectType == NTESOcrDetectTypeFront) {
        detailLabel.text = @"人像面拍摄";
    } else {
        detailLabel.text = @"国徽面拍摄";
    }
    detailLabel.font = [UIFont fontWithName:@"PingFangSC" size:20 * KWidthScale];
    detailLabel.textColor = [UIColor ntes_colorWithHexString:@"#FFFFFF"];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.imageView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView);
        make.top.equalTo(detectImageView.mas_bottom).mas_offset(28 * KWidthScale);
        make.width.mas_equalTo(200);
    }];
    
    UIImageView *ellipseBrightImageView = [[UIImageView alloc] init];
    ellipseBrightImageView.image = [UIImage imageNamed:@"ellipse"];
    [self.imageView addSubview:ellipseBrightImageView];
    [ellipseBrightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detectImageView.mas_bottom).mas_offset(85 * KWidthScale);
        make.left.equalTo(self.imageView).mas_offset(88 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(10 * KWidthScale, 10 * KWidthScale));
    }];
    
    UILabel *brightLabel = [[UILabel alloc] init];
    brightLabel.text = @"保持光线明亮";
    brightLabel.font = [UIFont fontWithName:@"PingFangSC" size:14 * KWidthScale];
    brightLabel.textColor = [UIColor ntes_colorWithHexString:@"FFFFFF"];
    [self.imageView addSubview:brightLabel];
    [brightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ellipseBrightImageView);
        make.left.equalTo(ellipseBrightImageView.mas_right).mas_offset(8 * KWidthScale);
        make.height.mas_equalTo(16 * KWidthScale);
    }];
    
    UIImageView *ellipseCardImageView = [[UIImageView alloc] init];
    ellipseCardImageView.image = [UIImage imageNamed:@"ellipse"];
    [self.imageView addSubview:ellipseCardImageView];
    [ellipseCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ellipseBrightImageView.mas_bottom).mas_offset(20 * KWidthScale);
        make.left.equalTo(self.imageView).mas_offset(88 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(10 * KWidthScale, 10 * KWidthScale));
    }];
    
    UILabel *cardLabel = [[UILabel alloc] init];
    if (_detectType == NTESOcrDetectTypeFront) {
        cardLabel.text = @"将身份证人像面放入采集框中";
    } else {
        cardLabel.text = @"将身份证国徽面放入采集框中";
    }
    cardLabel.font = [UIFont fontWithName:@"PingFangSC" size:14 * KWidthScale];
    cardLabel.textColor = [UIColor ntes_colorWithHexString:@"FFFFFF"];
    [self.imageView addSubview:cardLabel];
    [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ellipseCardImageView);
        make.left.equalTo(ellipseCardImageView.mas_right).mas_offset(8 * KWidthScale);
        make.height.mas_equalTo(16 * KWidthScale);
    }];
    
    UIImageView *ellipseReflectiveImageView = [[UIImageView alloc] init];
    ellipseReflectiveImageView.image = [UIImage imageNamed:@"ellipse"];
    [self.imageView addSubview:ellipseReflectiveImageView];
    [ellipseReflectiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ellipseCardImageView.mas_bottom).mas_offset(20 * KWidthScale);
        make.left.equalTo(self.imageView).mas_offset(88 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(10 * KWidthScale, 10 * KWidthScale));
    }];
    
    UILabel *reflectiveLabel = [[UILabel alloc] init];
    reflectiveLabel.text = @"文字不要有反光、遮挡";
    reflectiveLabel.font = [UIFont fontWithName:@"PingFangSC" size:14 * KWidthScale];
    reflectiveLabel.textColor = [UIColor ntes_colorWithHexString:@"FFFFFF"];
    [self.imageView addSubview:reflectiveLabel];
    [reflectiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ellipseReflectiveImageView);
        make.left.equalTo(ellipseReflectiveImageView.mas_right).mas_offset(8 * KWidthScale);
        make.height.mas_equalTo(16 * KWidthScale);
    }];
}

- (UIButton *)backBarButton {
    if (!_backBarButton) {
        _backBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBarButton addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
        [_backBarButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBarButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    }
    return _backBarButton;
}

- (UILabel *)navTitleLabel {
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] init];
        _navTitleLabel.text = @"身份证采集";
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:KWidthScale * 17];
        _navTitleLabel.textColor = [UIColor whiteColor];
    }
    return _navTitleLabel;
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backAndCloseButtonDidTapped {
    [self doBack];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.manager stopDetect];
    });
}

@end
