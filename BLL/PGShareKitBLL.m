//
//  PGShareKitBLL.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGShareKitBLL.h"
#import "PGSKTypes.h"
#import "PGSKService.h"
#import "PGSKServiceSelectorController.h"
#import "PGSKShareData.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

NSString *const PKSGServiceDataDictKeyAuthor       = @"author";
NSString *const PKSGServiceDataDictKeyDescription  = @"description";
NSString *const PKSGServiceDataDictKeyTitle        = @"title";
NSString *const PKSGServiceDataDictKeyMessage      = @"message";
NSString *const PKSGServiceDataDictKeyThumbnail    = @"thumbnail";
NSString *const PKSGServiceDataDictKeyThumbnailURL = @"thumbnailURL";
NSString *const PKSGServiceDataDictKeyURL          = @"URL";
NSString *const PKSGServiceDataDictKeyDataType     = @"supportedShareType";


NSString *const  PGShareKitErrorDomain = @"PGShareKitErrorDomain";

static inline NSError* PGShareKitReturnError(){
    return [NSError errorWithDomain:PGShareKitErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@"用户取消分享"}];
}
static RACSignal* PGShareKitCreateShareSignal(NSDictionary* dict, id<PGSKServiceInfo> serviceInfo);


void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock,
                        PGSKSuccessBlock success,
                        PGSKFailBlock fail){
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        PGSKServiceInfoLoadConfig(nil, ^(NSArray<id<PGSKServiceInfo>> *services) {
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
                [subscriber sendError:PGShareKitReturnError()];
            }];
            return nil;
        }];
    }]
     flattenMap:^RACStream *(id<PGSKServiceInfo> serviceInfo) {
         assert(nil != getParamBlock);
         return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
             getParamBlock(PGSKServiceSupportedDataTypeVideo,
                           ^(NSDictionary* dict){
                               [subscriber sendNext:PGShareKitCreateShareSignal(dict, serviceInfo)];
                           },
                           ^(NSError* error){
                               [subscriber sendError:error];
                           }
                           );
             return nil;
         }]
                 flatten];

    }];
}

static RACSignal* PGShareKitCreateShareSignal(NSDictionary* dict, id<PGSKServiceInfo> serviceInfo){
    assert(nil != dict[PKSGServiceDataDictKeyDataType]);
    //                 NSAssert(nil != dict[PKSGServiceDataDictKeyDataType], @"PKSGServiceDataDictKeyDataType必须要传");
    PGSKServiceSupportedDataType type = [dict[PKSGServiceDataDictKeyDataType] unsignedIntegerValue];
    
    id data = PGShareKitCreateData(type, dict);
    [data setValuesForKeysWithDictionary:dict];
    if (PGSKServiceSupportedDataTypeImage == type){
        assert([data conformsToProtocol:@protocol(PGSKShareDataImage)]);
    }
    if (PGSKServiceSupportedDataTypeVideo == type){
        assert([data conformsToProtocol:@protocol(PGSKShareDataVideo)]);
    }
    if (PGSKServiceSupportedDataTypeWebPage == type){
        assert([data conformsToProtocol:@protocol(PGSKShareDataWebPage)]);
    }
    
    NSObject<PGSKService>* service = PGShareKitCreateService(serviceInfo);
    assert([service conformsToProtocol:@protocol(PGSKService)]);
    RACSignal* successSignal = [[service rac_signalForSelector:@selector(service:didSuccess:)
                                                  fromProtocol:@protocol(PGSKServiceDelegate)]
                                map:^id(RACTuple* value) {
                                    return value.second;
                                }];
    RACSignal* failSignal = [[service rac_signalForSelector:@selector(service:didFail:)
                                               fromProtocol:@protocol(PGSKServiceDelegate)]
                             map:^id(RACTuple* value) {
                                 return value.second;
                             }];
    
    [service performSelector:PGShareKitGetServiceSelector(type)
                  withObject:data];
    return [RACSignal merge:@[successSignal, failSignal]];
}




