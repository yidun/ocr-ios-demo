//
//  NTESBaseController.m
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/11/30.
//

#import "NTESBaseController.h"

@interface NTESBaseController ()

@property (nonatomic, strong) UIButton *backBarButton;


@property (nonatomic, strong) UILabel  *navTitleLabel;

@end

@implementation NTESBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    [self.view addSubview:self.backBarButton];
    [self.view bringSubviewToFront:self.backBarButton];
    [self.backBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*KWidthScale);
        make.top.equalTo(self.view).offset(58 * KHeightScale);
        make.width.equalTo(@(32*KWidthScale));
        make.height.equalTo(@(32*KWidthScale));
    }];
    
    [self.view addSubview:self.navTitleLabel];
    [self.view bringSubviewToFront:self.navTitleLabel];
    [self.navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBarButton);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(200));
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
        _navTitleLabel.textColor = [UIColor redColor];
    }
    return _navTitleLabel;
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
