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


NSObject<PGSKService>* PGShareKitCreateService(id<PGSKServiceInfo> serviceInfo){
    return [@{kPKSGServiceWechat:[PGSKServiceWechat class],
              kPKSGServiceQQ:[PGSKServiceQQ class]
              }
            valueForKey:serviceInfo.name];
}




SEL PGShareKitGetServiceSelector(PGSKServiceSupportedDataType type){
    NSString* selector = [@{@(PGSKServiceSupportedDataTypeVideo):NSStringFromSelector(@selector(shareVideo:)),
                            @(PGSKServiceSupportedDataTypeImage):NSStringFromSelector(@selector(shareImage:)),
                            @(PGSKServiceSupportedDataTypeWebPage):NSStringFromSelector(@selector(shareWebPage:))
                            }
                          objectForKey:@(type)];
    return NSSelectorFromString(selector);
}






