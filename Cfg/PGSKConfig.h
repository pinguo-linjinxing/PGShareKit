//
//  PGSKConfig.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKServiceInfo.h"
#import "BlocksDefines.h"

typedef void(^PGSKConfigLoadServiceSuccess)(NSArray<id<PGSKServiceInfo>>*services);

typedef void(^PGSKConfigLoadCopyWritingSuccess)(NSString* title, NSString* message);

void PGSKConfigLoadServiceInfo(NSDictionary* param,PGSKConfigLoadServiceSuccess success, PGSKFailBlock fail);

void PGSKConfigLoadCopyWritingInfo(NSDictionary* param,PGSKConfigLoadCopyWritingSuccess success, PGSKFailBlock fail);
