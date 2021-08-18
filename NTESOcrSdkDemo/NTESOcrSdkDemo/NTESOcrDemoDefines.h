//
//  NTESOcrDemoDefines.h
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/11/19.
//

#ifndef NTESOcrDemoDefines_h
#define NTESOcrDemoDefines_h

//#define TEST_ENV

#ifndef __OPTIMIZE__
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...) {}
#endif

#define WeakSelf(type) __weak __typeof__(type) weakSelf = type;
#define StrongSelf(type) __strong __typeof__(type) strongSelf = type;

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define statusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)

#define IS_IPHONE_X ((statusBarHeight == 44) ? YES : NO)

#define DT_IS_IPHONEX_XS   (SCREEN_HEIGHT == 812.f)  //是否是iPhoneX、iPhoneXS
#define DT_IS_IPHONEXR_XSMax   (SCREEN_HEIGHT == 896.f)  //是否是iPhoneXR、iPhoneX Max
#define IS_IPHONEX_SET  (DT_IS_IPHONEX_XS||DT_IS_IPHONEXR_XSMax)  //是否是iPhoneX系列手机

#define State_Bar_H  ( ( ![[UIApplication sharedApplication] isStatusBarHidden] ) ? [[UIApplication sharedApplication] statusBarFrame].size.height : (IS_IPHONEX_SET?44.f:20.f))

#define KWidthScale ((SCREEN_WIDTH) / 375.0)
#define KHeightScale ((SCREEN_HEIGHT) / 667.0)

#define UIColorFromHexA(hexValue, a)     [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16))/255.0f green:(((hexValue & 0xFF00) >> 8))/255.0f blue:((hexValue & 0xFF))/255.0f alpha:a]
#define UIColorFromHex(hexValue)        UIColorFromHexA(hexValue, 1.0f)

#define bottomCopyRightText         @"© 1997-2020 网易公司"
#define imageViewWidth              (300 * KWidthScale)
// 传入imageView的宽高比应为3:4
#define imageViewHeight             (imageViewWidth * 4 / 3)
#define cameraViewRadius            (130 * KWidthScale)

#import <Masonry/Masonry.h>
#import "UIColor+NTESOcrSdkDemo.h"
#import "NTESBaseController.h"
#import "NTESToastView.h"

#endif /* NTESOcrDemoDefines_h */
