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

FOUNDATION_EXPORT NSString *const PKSGServiceWechat ;
FOUNDATION_EXPORT NSString *const PKSGServiceQQ ;
FOUNDATION_EXPORT NSString *const PKSGServiceWeiBo ;
FOUNDATION_EXPORT NSString *const PKSGServiceQQZone;
FOUNDATION_EXPORT NSString *const PKSGServiceInstagram ;

/**
 各社交平台属性定义
 */
@protocol PGSKServiceInfo <NSObject>
@property(nonatomic, readonly, strong) NSString* name;
@property(nonatomic, readonly, strong) NSString* key;
@property(nonatomic, readonly, strong) NSString* appKey;
@property(nonatomic, readonly, strong) NSString* appSecret;
@property(nonatomic, readonly, strong) NSString* redirectURL;
@property(nonatomic, readonly, strong) UIImage* slogan;
@property(nonatomic, readonly, assign) PGSKServiceSupportedDataType supportedShareType;
@end



NSString* PGSKServiceInfoGetAppKeyWithKey(NSString*key);
//id<PGSKServiceInfo> PGSKServiceInfoLoadWithKey(NSString*key);

NSArray<id<PGSKServiceInfo>>* PGSKServiceInfoLoadCameraOrder();







