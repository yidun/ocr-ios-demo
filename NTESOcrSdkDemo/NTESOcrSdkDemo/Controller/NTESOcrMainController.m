//
//  NTESOcrMainController.m
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/11/19.
//

#import "NTESOcrMainController.h"
#import <NTESOcrSdk/NTESOcrSdk.h>
#import "NTESOcrMainView.h"
#import "NTESOcrDetectController.h"
#import "NTESIdentifyCardNetworkAdapter.h"
#import "NTESOcrDetectResultController.h"

@interface NTESOcrMainController ()<NTESOcrMainViewDelegate>

@property (nonatomic, strong) NTESOcrSdkManager *manager;

@property (nonatomic, strong) NTESOcrMainView *mainView;

@property (nonatomic, copy) NSDictionary *frontParam;
@property (nonatomic, copy) NSDictionary *backParam;

@end

@implementation NTESOcrMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    
    NTESOcrMainView *mainView = [[NTESOcrMainView alloc] initWithFrame:CGRectZero];
    self.mainView = mainView;
    mainView.delegate = self;
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma NTESOcrMainViewDelegate

/**
 拍摄人像面
 */
- (void)frontCardDidTapped {
    NTESOcrDetectController *detectController = [[NTESOcrDetectController alloc] init];
    WeakSelf(self);
    detectController.completionHandler = ^(NSDictionary * _Nullable params) {
        weakSelf.frontParam = params;
        [weakSelf.mainView updateCardImage:NTESOcrMainViewTypeFront param:params];
    };
    detectController.detectType = NTESOcrDetectTypeFront;
    [self.navigationController pushViewController:detectController animated:YES];
}

/**
 拍摄国徽面
 */
- (void)backCardDidTapped {
    NTESOcrDetectController *detectController = [[NTESOcrDetectController alloc] init];
    WeakSelf(self);
    detectController.completionHandler = ^(NSDictionary * _Nullable params) {
        weakSelf.backParam = params;
        [weakSelf.mainView updateCardImage:NTESOcrMainViewTypeBack param:params];
    };
    detectController.detectType = NTESOcrDetectTypeback;
    [self.navigationController pushViewController:detectController animated:YES];
}

/**
 开始识别
 */
- (void)beginIdentifyCard {
    WeakSelf(self);
    [NTESIdentifyCardNetworkAdapter startIdentifyCard:@"图片识别接口地址" frontParam:self.frontParam backParam:self.backParam successHandle:^(NTESIDCardMessageModel * _Nullable cardModel, NSError * _Nullable error) {
        NTESOcrDetectResultController *resultController = [[NTESOcrDetectResultController alloc] init];
        resultController.cardModel = cardModel;
        resultController.completionHandler = ^{
            weakSelf.backParam = nil;
            weakSelf.frontParam = nil;
            [weakSelf.mainView clearCardImage];
        };
        [weakSelf.navigationController pushViewController:resultController animated:YES];
    }];
}

@end
