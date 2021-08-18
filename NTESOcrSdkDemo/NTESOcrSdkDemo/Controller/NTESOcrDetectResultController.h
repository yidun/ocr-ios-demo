//
//  NTESOcrDetectResultController.h
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/12/1.
//

#import <UIKit/UIKit.h>
#import "NTESIDCardMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 @说明        返回的回调
 */
typedef void(^NTESOcrDetectResultCompletionHandler)(void);

@interface NTESOcrDetectResultController : UIViewController

@property (nonatomic, strong) NTESIDCardMessageModel *cardModel;

@property (nonatomic, copy) NTESOcrDetectResultCompletionHandler completionHandler;

@end

NS_ASSUME_NONNULL_END
