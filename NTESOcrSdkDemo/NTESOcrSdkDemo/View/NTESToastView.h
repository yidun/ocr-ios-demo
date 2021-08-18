//
//  NTESToastView.h
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/12/1.
//

#import <UIKit/UIKit.h>

@protocol NTESToastViewDelegate <NSObject>

- (void)backAndCloseButtonDidTapped;

@end

NS_ASSUME_NONNULL_BEGIN

@interface NTESToastView : UIView

+ (void)showNotice:(NSString *)notice;

+ (void)showDetectTimeout:(id)object;

@property (nonatomic, weak) id<NTESToastViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
