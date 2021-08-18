//
//  NTESOcrMainView.h
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/11/30.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NTESOcrMainViewType) {
    NTESOcrMainViewTypeFront = 1,
    NTESOcrMainViewTypeBack,
};

@protocol NTESOcrMainViewDelegate <NSObject>

- (void)frontCardDidTapped;

- (void)backCardDidTapped;

- (void)beginIdentifyCard;

@end

NS_ASSUME_NONNULL_BEGIN

@interface NTESOcrMainView : UIView

@property (nonatomic, weak) id<NTESOcrMainViewDelegate> delegate;

@property (nonatomic, assign) NTESOcrMainViewType mainViewType;

- (void)updateCardImage:(NTESOcrMainViewType)mainViewType param:(NSDictionary * _Nullable)param;

- (void)clearCardImage;

@end

NS_ASSUME_NONNULL_END
