//
//  PGSKServiceInfo.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKServiceData.h"
#import "PGSKTypes.h"
/**
 各社交平台属性定义
 */
@protocol PGSKServiceInfo <NSObject>
@property(nonatomic, readonly, strong) NSString* name;
@property(nonatomic, readonly, strong) NSString* key;
@property(nonatomic, readonly, strong) NSString* appKey;
@property(nonatomic, readonly, strong) NSString* appSecret;
@property(nonatomic, readonly, strong) UIImage* slogan;
@property(nonatomic, readonly, assign) PGSKServiceSupportedDataType supportedShareType;
@end




typedef void(^PGSKConfigLoadServiceSuccess)(NSArray<id<PGSKServiceInfo>>*services);

void PGSKConfigLoadServiceInfo(NSDictionary* param,PGSKConfigLoadServiceSuccess success, PGSKFailBlock fail);








