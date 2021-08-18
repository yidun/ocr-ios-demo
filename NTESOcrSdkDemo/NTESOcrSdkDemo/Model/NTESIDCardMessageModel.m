//
//  NTESIDCardMessageModel.m
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/12/2.
//

#import "NTESIDCardMessageModel.h"

@implementation NTESIDCardMessageModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            if ([[dict objectForKey:@"taskId"] isKindOfClass:[NSString class]]) {
                self.taskId = [dict objectForKey:@"taskId"];
            }
            dict = [dict objectForKey:@"ocrResponseDetail"];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                if ([[dict objectForKey:@"address"] isKindOfClass:[NSString class]]) {
                    self.address = [dict objectForKey:@"address"];
                }
                if ([[dict objectForKey:@"authority"] isKindOfClass:[NSString class]]) {
                    self.authority = [dict objectForKey:@"authority"];
                }
                if ([[dict objectForKey:@"birthday"] isKindOfClass:[NSString class]]) {
                    self.birthday = [dict objectForKey:@"birthday"];
                }
                if ([[dict objectForKey:@"expireDate"] isKindOfClass:[NSString class]]) {
                    self.expireDate = [dict objectForKey:@"expireDate"];
                }
                if ([[dict objectForKey:@"gender"] isKindOfClass:[NSString class]]) {
                    self.gender = [dict objectForKey:@"gender"];
                }
                if ([[dict objectForKey:@"nation"] isKindOfClass:[NSString class]]) {
                    self.nation = [dict objectForKey:@"nation"];
                }
                if ([[dict objectForKey:@"ocrAvatar"] isKindOfClass:[NSString class]]) {
                    self.ocrAvatar = [dict objectForKey:@"ocrAvatar"];
                }
                if ([[dict objectForKey:@"ocrCardNo"] isKindOfClass:[NSString class]]) {
                    self.ocrCardNo = [dict objectForKey:@"ocrCardNo"];
                }
                if ([[dict objectForKey:@"ocrName"] isKindOfClass:[NSString class]]) {
                    self.ocrName = [dict objectForKey:@"ocrName"];
                }
            }
        }
    }
    return self;
}

@end
