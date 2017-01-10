//
//  PGSKConfig.h
//  PGShareKit
//
//  Created by linjinxing on 17/1/7.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKServiceInfo.h"
#import "PGSKTypes.h"

FOUNDATION_EXPORT NSString* const PGSKConfigDictionaryKeyServices;
FOUNDATION_EXPORT NSString* const PGSKConfigDictionaryKeySlogan;
FOUNDATION_EXPORT NSString* const PGSKConfigDictionaryKey;
FOUNDATION_EXPORT NSString* const PGSKConfigDictionaryKeyCameraOrder;
FOUNDATION_EXPORT NSString* const PGSKConfigDictionaryKeySupportedShareType;
FOUNDATION_EXPORT NSString* const PGSKConfigBundleName;

NSDictionary* PGSKLoadConfigSyn();

void PGSKLoadConfigAsyn(NSDictionary* param, PGSKSuccessBlock success, PGSKFailBlock fail);

