//
//  NTESOcrDetectResultController.m
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/12/1.
//

#import "NTESOcrDetectResultController.h"
#import "NTESOcrDemoDefines.h"
#import "NTESToastView.h"

@interface NTESOcrDetectResultController()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation NTESOcrDetectResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(63 * KHeightScale);
        make.left.equalTo(self.view).mas_offset(32 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(100 * KWidthScale, 26 * KHeightScale));
    }];
    
    UILabel *resultLabel = [[UILabel alloc] init];
    resultLabel.text = @"识别结果";
    resultLabel.textAlignment = NSTextAlignmentCenter;
    resultLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20 * KWidthScale];
    resultLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [self.view addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(108 * KHeightScale);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.layer.cornerRadius = 1;
    bottomView.layer.masksToBounds = YES;
    bottomView.backgroundColor = [UIColor ntes_colorWithHexString:@"F7F8FB"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resultLabel.mas_bottom).mas_offset(16 * KHeightScale);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(295 * KWidthScale, 258 * KHeightScale));
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"姓名：";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    nameLabel.textColor = [UIColor ntes_colorWithHexString:@"999999"];
    [bottomView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).mas_offset(20 * KHeightScale);
        make.left.equalTo(bottomView).mas_offset(16 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(44 * KWidthScale, 18 * KHeightScale));
    }];
    
    UILabel *nameDetailLabel = [[UILabel alloc] init];
    nameDetailLabel.text = self.cardModel.ocrName ? : @"null";
    nameDetailLabel.textAlignment = NSTextAlignmentLeft;
    nameDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    nameDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [bottomView addSubview:nameDetailLabel];
    [nameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel);
        make.left.equalTo(nameLabel.mas_right).mas_offset(24 * KWidthScale);
        make.right.equalTo(bottomView).mas_offset(-16 * KWidthScale);
    }];
    
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.text = @"性别：";
    genderLabel.textAlignment = NSTextAlignmentLeft;
    genderLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    genderLabel.textColor = [UIColor ntes_colorWithHexString:@"999999"];
    [bottomView addSubview:genderLabel];
    [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).mas_offset(8 * KHeightScale);
        make.left.equalTo(bottomView).mas_offset(16 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(44 * KWidthScale, 18 * KHeightScale));
    }];
    
    UILabel *genderDetailLabel = [[UILabel alloc] init];
    genderDetailLabel.text = self.cardModel.gender ? : @"null";
    genderDetailLabel.textAlignment = NSTextAlignmentLeft;
    genderDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    genderDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [bottomView addSubview:genderDetailLabel];
    [genderDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(genderLabel);
        make.left.equalTo(genderLabel.mas_right).mas_offset(24 * KWidthScale);
        make.right.equalTo(bottomView).mas_offset(-16 * KWidthScale);
    }];
    
    UILabel *nationLabel = [[UILabel alloc] init];
    nationLabel.text = @"民族：";
    nationLabel.textAlignment = NSTextAlignmentLeft;
    nationLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    nationLabel.textColor = [UIColor ntes_colorWithHexString:@"999999"];
    [bottomView addSubview:nationLabel];
    [nationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(genderLabel.mas_bottom).mas_offset(8 * KHeightScale);
        make.left.equalTo(bottomView).mas_offset(16 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(44 * KWidthScale, 18 * KHeightScale));
    }];
    
    UILabel *nationDetailLabel = [[UILabel alloc] init];
    nationDetailLabel.text = self.cardModel.nation ? : @"null";
    nationDetailLabel.textAlignment = NSTextAlignmentLeft;
    nationDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    nationDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [bottomView addSubview:nationDetailLabel];
    [nationDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nationLabel);
        make.left.equalTo(nationLabel.mas_right).mas_offset(24 * KWidthScale);
        make.right.equalTo(bottomView).mas_offset(-16 * KWidthScale);
    }];
    
    UILabel *birthdayLabel = [[UILabel alloc] init];
    birthdayLabel.text = @"出生：";
    birthdayLabel.textAlignment = NSTextAlignmentLeft;
    birthdayLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    birthdayLabel.textColor = [UIColor ntes_colorWithHexString:@"999999"];
    [bottomView addSubview:birthdayLabel];
    [birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nationLabel.mas_bottom).mas_offset(8 * KHeightScale);
        make.left.equalTo(bottomView).mas_offset(16 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(44 * KWidthScale, 18 * KHeightScale));
    }];
    
    UILabel *birthdayDetailLabel = [[UILabel alloc] init];
    birthdayDetailLabel.text = self.cardModel.birthday ? : @"null";
    birthdayDetailLabel.textAlignment = NSTextAlignmentLeft;
    birthdayDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    birthdayDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [bottomView addSubview:birthdayDetailLabel];
    [birthdayDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(birthdayLabel);
        make.left.equalTo(birthdayLabel.mas_right).mas_offset(24 * KWidthScale);
        make.right.equalTo(bottomView).mas_offset(-16 * KWidthScale);
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.text = @"住址：";
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    addressLabel.textColor = [UIColor ntes_colorWithHexString:@"999999"];
    [bottomView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(birthdayLabel.mas_bottom).mas_offset(8 * KHeightScale);
        make.left.equalTo(bottomView).mas_offset(16 * KWidthScale);
        make.size.mas_equalTo(CGSizeMake(44 * KWidthScale, 18 * KHeightScale));
    }];
    
    UILabel *addressDetailLabel = [[UILabel alloc] init];
    addressDetailLabel.text = self.cardModel.address ? : @"null";
    addressDetailLabel.numberOfLines = 0;
    addressDetailLabel.textAlignment = NSTextAlignmentLeft;
    addressDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    addressDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [bottomView addSubview:addressDetailLabel];
    [addressDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel);
        make.left.equalTo(addressLabel.mas_right).mas_offset(24 * KWidthScale);
        make.right.equalTo(bottomView).mas_offset(-16 * KWidthScale);
    }];
    
    UILabel *ocrCardNoLabel = [[UILabel alloc] init];
    ocrCardNoLabel.text = @"证件号码：";
    ocrCardNoLabel.textAlignment = NSTextAlignmentLeft;
    ocrCardNoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    ocrCardNoLabel.textColor = [UIColor ntes_colorWithHexString:@"999999"];
    [bottomView addSubview:ocrCardNoLabel];
    [ocrCardNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.cardModel.address.length > 0) {
            make.top.equalTo(addressDetailLabel.mas_bottom).mas_offset(8 * KHeightScale);
        } else {
            make.top.equalTo(addressLabel.mas_bottom).mas_offset(8 * KHeightScale);
        }
        make.left.equalTo(bottomView).mas_offset(16 * KWidthScale);
        make.height.mas_equalTo(18 * KHeightScale);
    }];
    
    UILabel *ocrCardNoDetailLabel = [[UILabel alloc] init];
    ocrCardNoDetailLabel.text = self.cardModel.ocrCardNo ? : @"null";
    ocrCardNoDetailLabel.textAlignment = NSTextAlignmentLeft;
    ocrCardNoDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    ocrCardNoDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [bottomView addSubview:ocrCardNoDetailLabel];
    [ocrCardNoDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ocrCardNoLabel);
        make.left.equalTo(ocrCardNoLabel.mas_right).mas_offset(24 * KWidthScale);
        make.right.equalTo(bottomView).mas_offset(-16 * KWidthScale);
    }];
    
    UILabel *authorityLabel = [[UILabel alloc] init];
    authorityLabel.text = @"签发机关：";
    authorityLabel.textAlignment = NSTextAlignmentLeft;
    authorityLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    authorityLabel.textColor = [UIColor ntes_colorWithHexString:@"999999"];
    [bottomView addSubview:authorityLabel];
    [authorityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ocrCardNoLabel.mas_bottom).mas_offset(8 * KHeightScale);
        make.left.equalTo(bottomView).mas_offset(16 * KWidthScale);
        make.height.mas_equalTo(18 * KHeightScale);
    }];
    
    UILabel *authorityDetailLabel = [[UILabel alloc] init];
    authorityDetailLabel.text = self.cardModel.authority ? : @"null";
    authorityDetailLabel.textAlignment = NSTextAlignmentLeft;
    authorityDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    authorityDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [bottomView addSubview:authorityDetailLabel];
    [authorityDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authorityLabel);
        make.left.equalTo(authorityLabel.mas_right).mas_offset(24 * KWidthScale);
        make.right.equalTo(bottomView).mas_offset(-16 * KWidthScale);
    }];
    
    UILabel *expireDateLabel = [[UILabel alloc] init];
    expireDateLabel.text = @"有效日期：";
    expireDateLabel.textAlignment = NSTextAlignmentLeft;
    expireDateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    expireDateLabel.textColor = [UIColor ntes_colorWithHexString:@"999999"];
    [bottomView addSubview:expireDateLabel];
    [expireDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authorityLabel.mas_bottom).mas_offset(8 * KHeightScale);
        make.left.equalTo(bottomView).mas_offset(16 * KWidthScale);
        make.height.mas_equalTo(18 * KHeightScale);
    }];
    
    UILabel *expireDateDetailLabel = [[UILabel alloc] init];
    expireDateDetailLabel.text = self.cardModel.expireDate ? : @"null";
    expireDateDetailLabel.textAlignment = NSTextAlignmentLeft;
    expireDateDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * KWidthScale];
    expireDateDetailLabel.textColor = [UIColor ntes_colorWithHexString:@"333333"];
    [bottomView addSubview:expireDateDetailLabel];
    [expireDateDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expireDateLabel);
        make.left.equalTo(expireDateLabel.mas_right).mas_offset(24 * KWidthScale);
        make.right.equalTo(bottomView).mas_offset(-16 * KWidthScale);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton = backButton;
    [backButton setTitle:@"返回首页" forState:UIControlStateNormal];
    [backButton setTitle:@"返回首页" forState:UIControlStateHighlighted];
    [backButton setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateNormal];
    [backButton setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateHighlighted];
    backButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16*KWidthScale];
    backButton.layer.cornerRadius = 44.0*KHeightScale/2;
    backButton.layer.masksToBounds = YES;
    [backButton addTarget:self action:@selector(backButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom).offset(36*KHeightScale);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(44*KHeightScale));
        make.width.equalTo(@(295*KWidthScale));
    }];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 295*KWidthScale, 44*KHeightScale);
    gradientLayer.colors = @[(id)[UIColor ntes_colorWithHexString:@"5F83FE"].CGColor, (id)[UIColor ntes_colorWithHexString:@"324DFF"].CGColor];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    [backButton.layer insertSublayer:gradientLayer atIndex:0];
    
    [self __initTokenButtomView];
}

- (void)__initTokenButtomView {
    UIView *tokenBottomView  = [[UIView alloc] init];
    tokenBottomView.layer.cornerRadius = 60.0*KHeightScale/2;
    tokenBottomView.layer.masksToBounds = YES;
    [self.view addSubview:tokenBottomView];
    [tokenBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backButton.mas_bottom).offset(36 * KHeightScale);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(56*KHeightScale));
        make.width.equalTo(@(295*KWidthScale));
    }];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 295*KWidthScale, 56*KHeightScale);
    gradientLayer.colors = @[(id)UIColorFromHex(0x60b1fe).CGColor, (id)UIColorFromHex(0x6551f6).CGColor];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    [tokenBottomView.layer insertSublayer:gradientLayer atIndex:0];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 60.0*KHeightScale/2;
    bottomView.layer.masksToBounds = YES;
    [tokenBottomView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tokenBottomView).mas_offset(1);
        make.top.equalTo(tokenBottomView).mas_offset(1);
        make.bottom.equalTo(tokenBottomView).mas_offset(-1);
        make.right.equalTo(tokenBottomView).mas_offset(-1);
    }];
    
    UILabel *tokenLabel = [[UILabel alloc] init];
    tokenLabel.numberOfLines = 2;
    tokenLabel.text = [NSString stringWithFormat:@"TaskID:%@",self.cardModel.taskId];
    tokenLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14 *KWidthScale];
    tokenLabel.textColor = [UIColor ntes_colorWithHexString:@"#000000"];
    [bottomView addSubview:tokenLabel];
    [tokenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.left.equalTo(bottomView).mas_offset(20);
        make.right.equalTo(bottomView).mas_offset(-81);
    }];
    
    UILabel *copyLabel = [[UILabel alloc] init];
    copyLabel.text = @"复制";
    copyLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyLabelDidTipped)];
    [copyLabel addGestureRecognizer:tap];
    copyLabel.textColor = [UIColor ntes_colorWithHexString:@"#2C6EFF"];
    copyLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14 * KWidthScale];
    [bottomView addSubview:copyLabel];
    [copyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).mas_offset(-24);
        make.centerY.equalTo(bottomView);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.layer.cornerRadius = 2;
    lineView.layer.masksToBounds = YES;
    lineView.backgroundColor = [UIColor ntes_colorWithHexString:@"#CCCCCC"];
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).mas_offset(-72);
        make.centerY.equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(1 * KWidthScale, 32 * KWidthScale));
    }];
}

- (void)backButtonDidTapped:(UIButton *)sender {
    if (self.completionHandler) {
        self.completionHandler();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)copyLabelDidTipped {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.cardModel.taskId ?:@"";
    [NTESToastView showNotice:@"Token复制成功"];
}

@end
