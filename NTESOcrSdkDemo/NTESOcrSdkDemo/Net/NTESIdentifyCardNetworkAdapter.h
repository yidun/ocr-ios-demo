//
//  NTESIdentifyCardNetworkAdapter.h
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import "NTESIDCardMessageModel.h"

typedef void(^SuccessHandle)(NTESIDCardMessageModel * _Nullable cardModel, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface NTESIdentifyCardNetworkAdapter : NSObject

+ (void)startIdentifyCard:(NSString *)URL
               frontParam:(NSDictionary *)frontParam
                backParam:(NSDictionary *)backParam
            successHandle:(SuccessHandle)successHandle;

@end

NS_ASSUME_NONNULL_END
