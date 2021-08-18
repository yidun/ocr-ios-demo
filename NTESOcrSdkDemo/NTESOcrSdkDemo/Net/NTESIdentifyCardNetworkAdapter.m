//
//  NTESIdentifyCardNetworkAdapter.m
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/12/2.
//

#import "NTESIdentifyCardNetworkAdapter.h"
#import <AFNetworking/AFNetworking.h>

@implementation NTESIdentifyCardNetworkAdapter

+ (void)startIdentifyCard:(NSString *)URL
               frontParam:(NSDictionary *)frontParam
                backParam:(NSDictionary *)backParam
            successHandle:(SuccessHandle)successHandle {
    NSString *frontImagePath = [frontParam objectForKey:@"imageFilePath"];
    NSString *backImagePath = [backParam objectForKey:@"imageFilePath"];
    NSData *frontImageData = [NSData dataWithContentsOfFile:frontImagePath];
    NSData *backImageData = [NSData dataWithContentsOfFile:backImagePath];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"content-Type"];
    
    manager.requestSerializer.timeoutInterval = 10.f;
    
    [manager POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (frontImagePath.length > 0 && backImagePath.length > 0 ) {
            for (NSInteger i = 0; i < 2; i++) {
                if (i == 0) {
                    [formData appendPartWithFileData:frontImageData name:@"frontPicture" fileName:frontImagePath mimeType:@"image/jpeg"];
                } else {
                    [formData appendPartWithFileData:backImageData name:@"backPicture" fileName:backImagePath mimeType:@"image/jpeg"];
                }
            }
        } else if (frontImagePath.length > 0 &&  backImagePath.length == 0) {
            [formData appendPartWithFileData:frontImageData name:@"frontPicture" fileName:frontImagePath mimeType:@"image/jpeg"];
        } else if (frontImagePath.length == 0 &&  backImagePath.length > 0) {
            [formData appendPartWithFileData:backImageData name:@"backPicture" fileName:backImagePath mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NTESIDCardMessageModel *cardModel = [self parseObject:responseObject];
        if (cardModel) {
            successHandle(cardModel,nil);
        } else {
            successHandle(nil,[[NSError alloc] init]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        successHandle(nil,error);
    }];
}

+ (NTESIDCardMessageModel *)parseObject:(NSData *)data {
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error) {
        return  nil;
    }
    NSLog(@"==========%@",dict);

    if ([dict objectForKey:@"result"]) {
        id result = [dict objectForKey:@"result"];
        
        if (result && [result isKindOfClass:[NSDictionary class]]) {
            NTESIDCardMessageModel *model = [[NTESIDCardMessageModel alloc] initWithDict:result];
            return model;
        } else {
            return  nil;
        }
    } else {
        return  nil;
    }
    return  nil;
}

@end
