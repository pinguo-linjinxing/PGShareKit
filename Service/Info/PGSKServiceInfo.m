//
//  PGSKServiceInfo.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/31.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceInfo.h"

NSString *const PKSGServiceWechat = @"wechat";
NSString *const PKSGServiceQQ = @"wechatMoments";
NSString *const PKSGServiceWeiBo = @"sina";
NSString *const PKSGServiceQQZone = @"qqzone";
NSString *const PKSGServiceInstagram = @"instagram";





void PGSKServiceInfoLoadConfig(NSDictionary* param,
                               PGSKConfigLoadServiceSuccess success,
                               PGSKFailBlock fail){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:@""];
        
    });
}

