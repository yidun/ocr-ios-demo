//
//  NTESToastView.m
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/12/1.
//

#import "NTESToastView.h"
#import "NTESOcrDemoDefines.h"
#import "NTESAppInfo.h"

@interface NTESToastView()

@end

@implementation NTESToastView

+ (void)showNotice:(NSString *)notice {
    
    UILabel *noticeLabel = [[UILabel alloc] init];
    noticeLabel.backgroundColor = [UIColor ntes_colorWithHexString:@"#000000"];
    noticeLabel.font = [UIFont systemFontOfSize:13 *KWidthScale];
    noticeLabel.textColor = [UIColor whiteColor];
    noticeLabel.numberOfLines = 1;
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.layer.cornerRadius = 22;
    noticeLabel.layer.masksToBounds = YES;
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:noticeLabel];
    noticeLabel.text = notice;
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(window);
        make.centerY.equalTo(window).mas_offset(100);
        make.size.mas_equalTo(CGSizeMake(191 * KWidthScale, 44 * KWidthScale));
    }];
       
    noticeLabel.alpha = 0;
    [UIView animateWithDuration:.5f animations:^{
        noticeLabel.alpha = 1;
    } completion:^(BOOL finished) {
        double delayInSeconds = 2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:.5f animations:^{
                noticeLabel.alpha = 0;
            } completion:^(BOOL finished) {
                [noticeLabel removeFromSuperview];
            }];
        });
    }];
}

+ (void)showDetectTimeout:(id)object {
    NTESToastView *toastView = [[NTESToastView alloc] init];
    toastView.delegate = object;
    UIViewController *controller = (UIViewController *)object;
    [controller.view addSubview:toastView];
    [toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(controller.view );
        make.size.mas_equalTo(CGSizeMake(280 * KWidthScale, 204 * KHeightScale));
    }];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 16 * KWidthScale;
    self.layer.masksToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"拍摄超时";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:20 * KWidthScale];
    titleLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).mas_offset(32 * KHeightScale);
        make.width.mas_equalTo(200);
    }];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.text = @"请重试";
    contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16 * KWidthScale];
    contentLabel.textColor = [UIColor ntes_colorWithHexString:@"666666"];
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(24 * KHeightScale);
        make.width.mas_equalTo(80);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateHighlighted];
    [backButton setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateNormal];
    [backButton setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateHighlighted];
    backButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*KWidthScale];
    backButton.layer.cornerRadius = 20.0*KHeightScale;
    backButton.layer.masksToBounds = YES;
    [backButton addTarget:self action:@selector(backButtonDidTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(32*KHeightScale);
        make.centerX.equalTo(self);
        make.height.equalTo(@(40*KHeightScale));
        make.width.equalTo(@(220*KWidthScale));
    }];
   
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 220*KWidthScale, 40*KHeightScale);
    gradientLayer.colors = @[(id)[UIColor ntes_colorWithHexString:@"5F83FE"].CGColor, (id)[UIColor ntes_colorWithHexString:@"324DFF"].CGColor];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    [backButton.layer insertSublayer:gradientLayer atIndex:0];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(10*KHeightScale);
        make.right.equalTo(self).mas_offset(-10*KHeightScale);
        make.height.equalTo(@(24*KWidthScale));
        make.width.equalTo(@(24*KWidthScale));
    }];
}

- (void)backButtonDidTapped {
    [self diaposeView];
    if (_delegate && [_delegate respondsToSelector:@selector(backAndCloseButtonDidTapped)]) {
        [_delegate backAndCloseButtonDidTapped];
    }
}

- (void)closeButtonDidTapped:(UIButton *)sender {
    [self diaposeView];
    if (_delegate && [_delegate respondsToSelector:@selector(backAndCloseButtonDidTapped)]) {
        [_delegate backAndCloseButtonDidTapped];
    }
}

- (void)diaposeView {
    [self removeFromSuperview];
}

@end
