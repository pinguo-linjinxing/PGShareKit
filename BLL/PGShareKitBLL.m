//
//  PGShareKitBLL.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGShareKitBLL.h"
#import "PGSKTypes.h"
#import "PGSKServiceType.h"
#import "PGSKService.h"
#import "PGSKServiceSelectorController.h"
#import "PGSKServiceData.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

NSString *const PKSGServiceDataDictKeyAuthor       = @"author";
NSString *const PKSGServiceDataDictKeyDescription  = @"description";
NSString *const PKSGServiceDataDictKeyTitle        = @"title";
NSString *const PKSGServiceDataDictKeyMessage      = @"message";
NSString *const PKSGServiceDataDictKeyThumbnail    = @"thumbnail";
NSString *const PKSGServiceDataDictKeyThumbnailURL = @"thumbnailURL";
NSString *const PKSGServiceDataDictKeyURL          = @"URL";
NSString *const PKSGServiceDataDictKeyDataType     = @"supportedShareType";





void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock,
                        PGSKSuccessBlock success,
                        PGSKFailBlock fail){
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        PGSKConfigLoadServiceInfo(nil, ^(NSArray<id<PGSKServiceInfo>> *services) {
            [subscriber sendNext:services];
            [subscriber sendCompleted];
        }, ^(NSError *error) {
            [subscriber sendError:error];
        });
        return nil;
    }]
     flattenMap:^RACStream *(NSArray<id<PGSKServiceInfo>> *services) {
      return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            PGSKServiceSelectorController* con = [PGSKServiceSelectorController new];
            [con showWithSelectBlock:^(id<PGSKServiceInfo> service) {
                [subscriber sendNext:service];
                [subscriber sendCompleted];
            } cancelBlock:^(id sender) {
//                [subscriber sendError:error];
            }];
            return nil;
        }];
    }]
     flattenMap:^RACStream *(id<PGSKServiceInfo> serviceInfo) {
             if (getParamBlock) {
                 NSDictionary* dict = getParamBlock(PGSKServiceSupportedDataTypeVideo);
                 assert(nil != dict[PKSGServiceDataDictKeyDataType]);
//                 NSAssert(nil != dict[PKSGServiceDataDictKeyDataType], @"PKSGServiceDataDictKeyDataType必须要传");
                 PGSKServiceSupportedDataType type = [dict[PKSGServiceDataDictKeyDataType] unsignedIntegerValue];
                 id data = [[PGShareKitData(type) alloc] init];
                 [data setValuesForKeysWithDictionary:dict];
                 
                 id<PGSKService> service = [[PGShareKitService(serviceInfo) alloc] init];
                 RACSignal* successSignal = [service rac_signalForSelector:@selector(service:didSuccess:) fromProtocol:@protocol(PGSKServiceDelegate)];
                 RACSignal* failSignal = [service rac_signalForSelector:@selector(service:didFail:) fromProtocol:@protocol(PGSKServiceDelegate)];
                 RACSignal* cancelSignal = [service rac_signalForSelector:@selector(serviceDidCancel:) fromProtocol:@protocol(PGSKServiceDelegate)];
                 
                 [service performSelector:PGShareKitSelector(serviceInfo.supportedShareType)
                               withObject:data];
                 
             }
         return nil;
    }];
}




