//
//  NTESIDCardMessageModel.h
//  NTESOcrSdkDemo
//
//  Created by 罗礼豪 on 2020/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NTESIDCardMessageModel : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *authority;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *expireDate;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *nation;
@property (nonatomic, copy) NSString *ocrAvatar;
@property (nonatomic, copy) NSString *ocrCardNo;
@property (nonatomic, copy) NSString *ocrName;
@property (nonatomic, copy) NSString *taskId;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
