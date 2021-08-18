//
//  NTESOcrDetectController.h
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/11/30.
//

#import <UIKit/UIKit.h>
#import "NTESOcrDemoDefines.h"
/**
 NTESOcrDetectTypeFront 人像面
 NTESOcrDetectTypeback 国徽面
 */
typedef NS_ENUM(NSUInteger, NTESOcrDetectType) {
    NTESOcrDetectTypeFront = 1,
    NTESOcrDetectTypeback,
};


/**
 @说明        获取身份证检测结果的回调
 */
typedef void(^NTESOcrDetectCompletionHandler)(NSDictionary * _Nullable params);

NS_ASSUME_NONNULL_BEGIN

@interface NTESOcrDetectController : UIViewController

@property (nonatomic, assign) NTESOcrDetectType detectType;


@property (nonatomic, copy) NTESOcrDetectCompletionHandler completionHandler;

@end

NS_ASSUME_NONNULL_END
