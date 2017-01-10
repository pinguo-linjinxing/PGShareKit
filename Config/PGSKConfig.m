//
//  PGSKConfig.m
//  PGShareKit
//
//  Created by linjinxing on 17/1/7.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "PGSKConfig.h"


NSString* const PGSKConfigDictionaryKeyServices     = @"services";
NSString* const PGSKConfigDictionaryKeyCameraOrder     = @"cameraOrder";
NSString* const PGSKConfigDictionaryKeySlogan = @"slogan";
NSString* const PGSKConfigDictionaryKey = @"key";
NSString* const PGSKConfigDictionaryKeySupportedShareType = @"supportedShareType";

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
