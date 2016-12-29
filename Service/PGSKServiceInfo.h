//
//  PGSKServiceInfo.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKServiceData.h"

/**
 各社交平台属性定义
 */
@protocol PGSKServiceInfo <NSObject>
@property(nonatomic, readonly) NSString* name;
@property(nonatomic, readonly) NSString* sloganUrl;
@property(nonatomic, readonly) PGSKServiceSupportedDataType supportedDataType;
@end

