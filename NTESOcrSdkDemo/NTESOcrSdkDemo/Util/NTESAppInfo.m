//
//  NTESAppInfo.m
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/12/1.
//

#import "NTESAppInfo.h"

@implementation NTESAppInfo

+ (UIWindow *)getCurrentWindow {
    UIWindow *window = nil;
//    if (@available(iOS 13.0, *)) {
//        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
//            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
//                window = windowScene.windows.firstObject;
//                break;
//            }
//        }
//    } else {
//        window = [UIApplication sharedApplication].delegate.window;
//    }
     window = [UIApplication sharedApplication].delegate.window;
    return window;
}

@end
