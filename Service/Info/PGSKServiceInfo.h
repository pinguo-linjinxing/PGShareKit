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

FOUNDATION_EXPORT NSString *const kPKSGServiceWechat ;
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
@property(nonatomic, readonly, strong) NSString* sloganURL;
@property(nonatomic, readonly, assign) PGSKServiceSupportedDataType supportedShareType;
@end



NSString* PGSKServiceInfoGetAppKeyWithKey(NSString*key);
UIImage* PGSKServiceInfoGetImageWithKey(NSString*key);
//id<PGSKServiceInfo> PGSKServiceInfoLoadWithKey(NSString*key);

NSArray<id<PGSKServiceInfo>>* PGSKServiceInfoLoadCameraOrder();







