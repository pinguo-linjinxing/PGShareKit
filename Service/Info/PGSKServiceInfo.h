//
//  PGSKServiceInfo.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKShareData.h"
#import "PGSKTypes.h"

/* 各平台的ID定义 */
FOUNDATION_EXPORT NSString *const kPKSGServiceWechat ;
FOUNDATION_EXPORT NSString *const kPKSGServiceWechatMoments;
FOUNDATION_EXPORT NSString *const kPKSGServiceQQ ;
FOUNDATION_EXPORT NSString *const kPKSGServiceWeiBo ;
FOUNDATION_EXPORT NSString *const kPKSGServiceQQZone;
FOUNDATION_EXPORT NSString *const kPKSGServiceInstagram ;


/* 支持分享的数据类型 */
FOUNDATION_EXPORT NSString *const kPKSGServiceSupportedTypeImage   ;
FOUNDATION_EXPORT NSString *const kPKSGServiceSupportedTypeWebpage ;
FOUNDATION_EXPORT NSString *const kPKSGServiceSupportedTypeVideo   ;


/**
 各社交平台属性定义
 */
@protocol PGSKServiceInfo <NSObject>
@property(nonatomic, readonly, strong) NSString* name;
@property(nonatomic, readonly, strong) NSString* key;
@property(nonatomic, readonly, strong) NSString* appKey;
@property(nonatomic, readonly, strong) NSString* appSecret;
@property(nonatomic, readonly, strong) NSString* redirectURL;
@property(nonatomic, readonly, strong) NSString* sloganImageName;
@property(nonatomic, readonly, assign) PGSKServiceSupportedDataType supportedShareTypes;
@end




@interface PGSKServiceInfoPOD : NSObject<PGSKServiceInfo>
@property(readonly, nonatomic, strong) NSString* name;
@property(readonly, nonatomic, strong) NSString* key;
@property(readonly, nonatomic, strong) NSString* appKey;
@property(readonly, nonatomic, strong) NSString* appSecret;
@property(readonly, nonatomic, strong) NSString* redirectURL;
@property(readonly, nonatomic, strong) NSString* sloganImageName;
@property(readonly, nonatomic, assign) PGSKServiceSupportedDataType supportedShareTypes;
//+ (instancetype)serviceInfoPODWithDictionary:(NSDictionary*)dict;
@end






