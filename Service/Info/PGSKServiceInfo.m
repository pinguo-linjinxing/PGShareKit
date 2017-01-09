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

NSString *const PKSGServiceWechat = @"wechat";
NSString *const PKSGServiceQQ = @"wechatMoments";
NSString *const PKSGServiceWeiBo = @"sina";
NSString *const PKSGServiceQQZone = @"qqzone";
NSString *const PKSGServiceInstagram = @"instagram";


@interface PGSKServiceInfoPOD : NSObject<PGSKServiceInfo>
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* key;
@property(nonatomic, strong) NSString* appKey;
@property(nonatomic, strong) NSString* appSecret;
@property(nonatomic, strong) NSString* redirectURL;
@property(nonatomic, strong) UIImage* slogan;
@property(nonatomic, assign) PGSKServiceSupportedDataType supportedShareType;
@end
@implementation PGSKServiceInfoPOD
@end


id<PGSKServiceInfo> PGSKServiceInfoLoadWithKey(NSString*key){
    NSDictionary* dict = [PGSKLoadConfigSyn() valueForKeyPath:[PGSKConfigDictionaryKeyServices stringByAppendingFormat:@".%@", key]];
    assert(nil != dict);
    PGSKServiceInfoPOD* serInfo = [[PGSKServiceInfoPOD alloc] init];
    [serInfo setValuesForKeysWithDictionary:dict];
    return serInfo;
}

NSString* PGSKServiceInfoGetAppKeyWithKey(NSString*key){
    return PGSKServiceInfoLoadWithKey(key).appKey;
}

NSArray<id<PGSKServiceInfo>>* PGSKServiceInfoLoadCameraOrder(){
    NSDictionary* dict = PGSKLoadConfigSyn();
    NSDictionary* dictServices = dict[PGSKConfigDictionaryKeyServices];
    return [dict[PGSKConfigDictionaryKeyCameraOrder] bk_map:^id _Nonnull(id  _Nonnull obj) {
        return dictServices[obj];
    }];
}




