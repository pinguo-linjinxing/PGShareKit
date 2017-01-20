//
//  PGSKConfig.m
//  PGShareKit
//
//  Created by linjinxing on 17/1/7.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "PGSKConfig.h"
#import "PGSKServiceInfo.h"
#import "PGSKShareData.h"
#import "NSArray+BlocksKit.h"
#import "NSObject+Init.h"
#import "NSDictionary+BlocksKit.h"

NSString* const PGSKConfigDictionaryKeyServices     = @"services";
NSString* const PGSKConfigDictionaryKeyCameraOrder     = @"cameraOrder";
NSString* const PGSKConfigDictionaryKeySlogan = @"slogan";
NSString* const PGSKConfigDictionaryKey = @"key";
NSString* const PGSKConfigDictionaryKeySupportedShareType = @"supportedShareTypes";

NSString* const PGSKConfigBundleName = @"PGSNChannelSelector.bundle";
//NSString* const PGSKConfigDictionaryKeyLanguage    = @"zh";
//NSString* const PGSKConfigDictionaryKeyDescription = @"Description";

NSDictionary* PGSKLoadConfigSyn(){
    static dispatch_once_t onceToken;
    static NSDictionary* dict = nil;
    dispatch_once(&onceToken, ^{
        NSError* error;
        NSData* data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"PGSKConfig.json"
                                                       ofType:nil]
                                              options:NSDataReadingMappedIfSafe
                                                error:&error];
        if (error) {
            NSLog(@"error:%@", error);
        }else{
            dict = [NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingAllowFragments
                                                     error:&error];
            if (error) {
                NSLog(@"error:%@", error);
            }
        }
    });
    return dict;
}


void PGSKLoadConfigAsyn(NSDictionary* param, PGSKSuccessBlock success, PGSKFailBlock fail){
    
}


/**
 获取某个服务配置
 
 @param key <#key description#>
 @return <#return value description#>
 */
id<PGSKServiceInfo> PGSKServiceInfoLoadWithKey(NSString*key){
    assert(key);
    NSDictionary* dict = [PGSKLoadConfigSyn() valueForKeyPath:[PGSKConfigDictionaryKeyServices stringByAppendingFormat:@".%@", key]];
    assert(dict);
    return [PGSKServiceInfoPOD instanceWithDictionary:dict];
}

/**
 根据service的key来获取服务的appKey
 
 @param key <#key description#>
 @return <#return value description#>
 */
NSString* PGSKServiceInfoGetAppKeyWithKey(NSString*key){
    assert(key);
    return PGSKServiceInfoLoadWithKey(key).appKey;
}

/**
 根据service的key来获取相应的图片
 
 @param key <#key description#>
 @return <#return value description#>
 */
UIImage* PGSKServiceInfoGetImageWithKey(NSString*key){
    assert(key);
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
    assert(keypath);
    assert(value);
    PGSKReturnDataBlock block = @{
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
    assert(dictServices);
    assert(dict[PGSKConfigDictionaryKeyCameraOrder]);
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


