//
//  PGSKServiceInfo.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/31.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceInfo.h"
#import "PGSKConfig.h"
#import "NSArray+BlocksKit.h"
#import "NSObject+Init.h"
#import "NSDictionary+BlocksKit.h"

/* 以下值要和配置里的对应，否则会出错 */
NSString *const kPKSGServiceWechat = @"wechat";
NSString *const kPKSGServiceWechatMoments = @"wechatMoments";
NSString *const kPKSGServiceQQ = @"qq";
NSString *const kPKSGServiceWeiBo = @"sina";
NSString *const kPKSGServiceQQZone = @"qqzone";
NSString *const kPKSGServiceInstagram = @"instagram";

NSString *const kPKSGServiceSupportedTypeImage = @"image";
NSString *const kPKSGServiceSupportedTypeWebpage = @"webpage";
NSString *const kPKSGServiceSupportedTypeVideo = @"video";


@interface PGSKServiceInfoPOD()// : NSObject<PGSKServiceInfo>
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* key;
@property(nonatomic, strong) NSString* appKey;
@property(nonatomic, strong) NSString* appSecret;
@property(nonatomic, strong) NSString* redirectURL;
@property(nonatomic, strong) NSString* sloganImageName;
@property(nonatomic, assign) PGSKServiceSupportedDataType supportedShareTypes;
//+ (instancetype)serviceInfoPODWithDictionary:(NSDictionary*)dict;
@end


@implementation PGSKServiceInfoPOD
//+ (instancetype)serviceInfoPODWithDictionary:(NSDictionary*)dict{
//    assert(dict);
//    return [PGSKServiceInfoPOD instanceWithDictionary:dict];
//}
@end

/**
 配置里的字符串转换转换为枚举变量

 @return <#return value description#>
 */
//static NSDictionary* PGSKServiceSupportedDataTypeStringToNSNumberDictionary(){
//    return @{
//             kPKSGServiceSupportedTypeImage:@(PGSKServiceSupportedDataTypeImage),
//             kPKSGServiceSupportedTypeWebpage:@(PGSKServiceSupportedDataTypeWebPage),
//             kPKSGServiceSupportedTypeVideo:@(PGSKServiceSupportedDataTypeVideo)
//             };
//}
//
//static NSNumber* PGSKServiceSupportedDataTypeStringToNSNumber(NSString* type){
//    return [PGSKServiceSupportedDataTypeStringToNSNumberDictionary() valueForKey:type];
//}



