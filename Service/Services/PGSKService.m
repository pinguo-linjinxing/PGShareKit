//
//  PGSKServiceInfo.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKService.h"
#import "PGSKServiceQQ.h"
#import "PGSKServiceWechat.h"
#import "PGSKServiceType.h"

Class PGShareKitService(id<PGSKServiceInfo> serviceInfo){
    return [@{PKSGServiceTypeWechat:[PGSKServiceWechat class],
              PKSGServiceTypeQQ:[PGSKServiceQQ class]
              }
            valueForKey:serviceInfo.name];
}




SEL PGShareKitSelector(PGSKServiceSupportedDataType type){
    NSString* selector = [@{@(PGSKServiceSupportedDataTypeVideo):NSStringFromSelector(@selector(shareVideo:)),
                            @(PGSKServiceSupportedDataTypeImage):NSStringFromSelector(@selector(shareImage:)),
                            @(PGSKServiceSupportedDataTypeVideo):NSStringFromSelector(@selector(shareWebPage:))
                            }
                          objectForKey:@(type)];
    return NSSelectorFromString(selector);
}






