//
//  NTESOcrMainView.m
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/11/30.
//

#import "NTESOcrMainView.h"
#import "NTESOcrDemoDefines.h"

@interface NTESOcrMainView()

@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *startDetectButton;

@property (nonatomic, strong) UILabel *frontDetailLabel;
@property (nonatomic, strong) UILabel *backDetailLabel;

@property (nonatomic, strong) UIButton *againUploadButton;
@property (nonatomic, strong) UIButton *againUploadBackButton;

@end

@implementation NTESOcrMainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(KHeightScale * 44);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100 * KWidthScale, 26 * KHeightScale));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"身份证OCR体验DEMO";
    titleLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:20 * KWidthScale];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(logoImageView.mas_bottom).mas_offset(9 * KHeightScale);
    }];
    
    UIImageView *frontBackImageView = [[UIImageView alloc] init];
    frontBackImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *frontTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frontBackImageViewDidTapped:)];
    [frontBackImageView addGestureRecognizer:frontTap];
    frontBackImageView.image = [UIImage imageNamed:@"cardBackground"];
    [self addSubview:frontBackImageView];
    [frontBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(KHeightScale * 28);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(303 * KWidthScale, 140 * KHeightScale));
    }];
    
    UIImageView *frontImageView = [[UIImageView alloc] init];
    self.frontImageView = frontImageView;
    frontImageView.userInteractionEnabled = YES;
    frontImageView.image = [UIImage imageNamed:@"cardFront"];
    [frontBackImageView addSubview:frontImageView];
    [frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(frontBackImageView);
        make.size.mas_equalTo(CGSizeMake(168 * KWidthScale, 110 * KWidthScale));
    }];
    
    UILabel *frontDetailLabel = [[UILabel alloc] init];
    frontDetailLabel.text = @"拍摄人像面";
    self.frontDetailLabel = frontDetailLabel;
    frontDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"666666"];
    frontDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regula" size:14 * KWidthScale];
    frontDetailLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:frontDetailLabel];
    [frontDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(frontBackImageView.mas_bottom).mas_offset(8 * KHeightScale);
    }];
    
    UIButton *againUploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.againUploadButton = againUploadButton;
    againUploadButton.hidden = YES;
    [againUploadButton addTarget:self action:@selector(againUploadButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    againUploadButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regula" size:14 * KWidthScale];
    [againUploadButton setTitle:@"重新上传" forState:UIControlStateNormal];
    [againUploadButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:againUploadButton];
    [againUploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(frontDetailLabel.mas_right);
        make.centerY.equalTo(frontDetailLabel);
        make.height.mas_equalTo(20 * KHeightScale);
    }];
    
    UIImageView *backBackImageView = [[UIImageView alloc] init];
    backBackImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBackImageViewDidTapped:)];
    [backBackImageView addGestureRecognizer:backTap];
    backBackImageView.image = [UIImage imageNamed:@"cardBackground"];
    [self addSubview:backBackImageView];
    [backBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(frontDetailLabel.mas_bottom).mas_offset(KHeightScale * 20);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(303 * KWidthScale, 140 * KHeightScale));
    }];
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    self.backImageView = backImageView;
    backImageView.userInteractionEnabled = YES;
    backImageView.image = [UIImage imageNamed:@"cardBack"];
    [backBackImageView addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(backBackImageView);
        make.size.mas_equalTo(CGSizeMake(168 * KWidthScale, 110 * KWidthScale));
    }];
    
    UILabel *backDetailLabel = [[UILabel alloc] init];
    self.backDetailLabel = backDetailLabel;
    backDetailLabel.text = @"拍摄国徽面";
    backDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"666666"];
    backDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regula" size:14 * KWidthScale];
    backDetailLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:backDetailLabel];
    [backDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(backBackImageView.mas_bottom).mas_offset(8 * KHeightScale);
    }];
    
    UIButton *againUploadBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.againUploadBackButton = againUploadBackButton;
    againUploadBackButton.hidden = YES;
    [againUploadBackButton addTarget:self action:@selector(againUploadBackButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    againUploadBackButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regula" size:14 * KWidthScale];
    [againUploadBackButton setTitle:@"重新上传" forState:UIControlStateNormal];
    [againUploadBackButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:againUploadBackButton];
    [againUploadBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backDetailLabel.mas_right);
        make.centerY.equalTo(backDetailLabel);
        make.height.mas_equalTo(20 * KHeightScale);
    }];
    
    UIButton *startDetectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startDetectButton = startDetectButton;
    [startDetectButton setTitle:@"开始识别" forState:UIControlStateNormal];
    [startDetectButton setTitle:@"开始识别" forState:UIControlStateHighlighted];
    [startDetectButton setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateNormal];
    [startDetectButton setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateHighlighted];
    startDetectButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16*KWidthScale];
    startDetectButton.layer.cornerRadius = 44.0*KHeightScale/2;
    startDetectButton.layer.masksToBounds = YES;
    startDetectButton.alpha = 0.3;
    startDetectButton.enabled = NO;
    [startDetectButton addTarget:self action:@selector(startLiveDetect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:startDetectButton];
    [startDetectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backDetailLabel.mas_bottom).offset(30*KHeightScale);
        make.centerX.equalTo(self);
        make.height.equalTo(@(44*KHeightScale));
        make.width.equalTo(@(295*KWidthScale));
    }];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 295*KWidthScale, 44*KHeightScale);
    gradientLayer.colors = @[(id)[UIColor ntes_colorWithHexString:@"5F83FE"].CGColor, (id)[UIColor ntes_colorWithHexString:@"324DFF"].CGColor];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    [startDetectButton.layer insertSublayer:gradientLayer atIndex:0];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.numberOfLines = 0;
    detailLabel.text = @"网易易盾不会留存您在使用过程中产生的任何信息， 请放心体验";
    detailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    detailLabel.textColor = [UIColor ntes_colorWithHexString:@"999999"];
    [self addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startDetectButton.mas_bottom).offset(16*KHeightScale);
        make.centerX.equalTo(self);
        make.width.mas_lessThanOrEqualTo(280*KWidthScale);
    }];
}

/**
 更新照片信息
 */
- (void)updateCardImage:(NTESOcrMainViewType)mainViewType param:(NSDictionary * _Nullable)param {
    NSString *imageFilePath = [param objectForKey:@"imageFilePath"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageFilePath];
    image = [self cutImage:image imgViewWidth:168 * KWidthScale imgViewHeight:110 * KHeightScale];
    if (mainViewType == NTESOcrMainViewTypeFront) {
        self.frontDetailLabel.text = @"拍摄人像面，";
        self.againUploadButton.hidden = NO;
        self.frontImageView.image = image;
        [self.frontDetailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).mas_offset(-30 * KWidthScale);
        }];
    } else {
        self.backDetailLabel.text = @"拍摄国徽面，";
        self.againUploadBackButton.hidden = NO;
        self.backImageView.image = image;
        [self.backDetailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).mas_offset(-30 * KWidthScale);
        }];
    }
    self.startDetectButton.alpha = 1;
    self.startDetectButton.enabled = YES;
}

/**
 清空照片信息
 */
- (void)clearCardImage {
    self.frontDetailLabel.text = @"拍摄人像面";
    self.againUploadButton.hidden = YES;
    self.frontImageView.image = [UIImage imageNamed:@"cardFront"];;
    [self.frontDetailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
    }];
    
    self.backDetailLabel.text = @"拍摄国徽面";
    self.againUploadBackButton.hidden = YES;
    self.backImageView.image = [UIImage imageNamed:@"cardBack"];
    [self.backDetailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
    }];
    
    self.startDetectButton.alpha = 0.3;
    self.startDetectButton.enabled = NO;
}

- (void)startLiveDetect:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(beginIdentifyCard)]) {
        [_delegate beginIdentifyCard];
    }
}

/**
 正面照重新上传
 */
- (void)againUploadButtonDidTapped:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(frontCardDidTapped)]) {
        [_delegate frontCardDidTapped];
    }
}

/**
 国徽照重新上传
 */
- (void)againUploadBackButtonDidTapped:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(backCardDidTapped)]) {
        [_delegate backCardDidTapped];
    }
}

#pragma NTESOcrMainViewDelegate

/**
 正面面点击
 */
- (void)frontBackImageViewDidTapped:(UITapGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(frontCardDidTapped)]) {
        [_delegate frontCardDidTapped];
    }
}

/**
 国徽面点击
 */
- (void)backBackImageViewDidTapped:(UITapGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(backCardDidTapped)]) {
        [_delegate backCardDidTapped];
    }
}


- (UIImage *)cutImage:(UIImage*)image imgViewWidth:(CGFloat)width imgViewHeight:(CGFloat)height {
    //压缩图片
    CGSize newSize;CGImageRef imageRef = nil;
    if ((image.size.width / image.size.height) < (width / height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * height /width;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
    } else {
        newSize.height = image.size.height;newSize.width = image.size.height * width / height;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    return [UIImage imageWithCGImage:imageRef];
}

@end
