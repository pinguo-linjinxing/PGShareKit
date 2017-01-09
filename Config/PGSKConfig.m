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
//NSString* const PGSKConfigDictionaryKeyLanguage    = @"zh";
//NSString* const PGSKConfigDictionaryKeyDescription = @"Description";

NSDictionary* PGSKLoadConfigSyn(){
    static dispatch_once_t onceToken;
    static NSDictionary* dict = nil;
    dispatch_once(&onceToken, ^{
        dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                           pathForResource:@"PGSKConfig.json"
                                                           ofType:nil]];
    });
    return dict;
}


void PGSKLoadConfigAsyn(NSDictionary* param, PGSKSuccessBlock success, PGSKFailBlock fail){
    
}
