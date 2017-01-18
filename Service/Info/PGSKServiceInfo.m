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


@interface PGSKServiceInfoPOD : NSObject<PGSKServiceInfo>
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
//    assert(nil != dict);
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

/**
 获取某个服务配置

 @param key <#key description#>
 @return <#return value description#>
 */
id<PGSKServiceInfo> PGSKServiceInfoLoadWithKey(NSString*key){
    assert(nil != key);
    NSDictionary* dict = [PGSKLoadConfigSyn() valueForKeyPath:[PGSKConfigDictionaryKeyServices stringByAppendingFormat:@".%@", key]];
    assert(nil != dict);
    return [PGSKServiceInfoPOD instanceWithDictionary:dict];
}

/**
 根据service的key来获取服务的appKey

 @param key <#key description#>
 @return <#return value description#>
 */
NSString* PGSKServiceInfoGetAppKeyWithKey(NSString*key){
    assert(nil != key);
    return PGSKServiceInfoLoadWithKey(key).appKey;
}

/**
 根据service的key来获取相应的图片

 @param key <#key description#>
 @return <#return value description#>
 */
UIImage* PGSKServiceInfoGetImageWithKey(NSString*key){
    assert(nil != key);
    return [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:[PGSKConfigBundleName stringByAppendingPathComponent:key]
                                                               ofType:@"png"]];
}


/**
 用字典初始化对象时，有些数据类型需要进行转化

 @param keypath 要解析json数据的路径
 @param value json路径对应的值
 @return 返回转换后的值
 */
static id PGSKServiceTransformBlock(NSString *keypath, id value){
    assert(nil != keypath);
    assert(nil != value);
    PGSKGetDataBlock block = @{
//             PGSKConfigDictionaryKeySlogan:^{
//                 return [[[NSBundle mainBundle] pathForResource:PGSKConfigBundleName
//                                                         ofType:nil]
//                         stringByAppendingPathComponent:value];
//             },
             PGSKConfigDictionaryKeySupportedShareType:^{
                 return @([value bk_reduceInteger:0
                                        withBlock:^NSInteger(NSInteger result, id  _Nonnull obj) {
                                            return (result | [@{
                                                                kPKSGServiceSupportedTypeImage:@(PGSKServiceSupportedDataTypeImage),
                                                                kPKSGServiceSupportedTypeWebpage:@(PGSKServiceSupportedDataTypeWebPage),
                                                                kPKSGServiceSupportedTypeVideo:@(PGSKServiceSupportedDataTypeVideo)
                                                                }[obj]
                                                              integerValue]);
                                        }]);
             },
             }[keypath];
    return block ? block() : nil;
}

/**
 加载相机的分享顺序

 @return <#return value description#>
 */
NSArray<id<PGSKServiceInfo>>* PGSKServiceInfoLoadCamera(){
    NSDictionary* dict = PGSKLoadConfigSyn();
    NSDictionary* dictServices = dict[PGSKConfigDictionaryKeyServices];
    assert(nil != dictServices);
    return [dict[PGSKConfigDictionaryKeyCameraOrder] bk_map:^id _Nonnull(id  _Nonnull obj) {
        NSMutableDictionary* tmpDict = [dictServices[obj] mutableCopy];
        tmpDict[PGSKConfigDictionaryKey] = obj;
        return [PGSKServiceInfoPOD instanceWithDictionary:tmpDict
                                                transform:^id(NSString *keypath, id value) {
                                                    return PGSKServiceTransformBlock(keypath, value);
                                                }];

//        [tmpDict[PGSKConfigDictionaryKeySupportedShareType] bk_each:^(id  _Nonnull obj) {
//            [pod setValue:PGSKServiceSupportedDataTypeStringToNSNumber(obj)
//                   forKey:PGSKConfigDictionaryKeySupportedShareType];
//        }];
//        return pod;
    }];
}




