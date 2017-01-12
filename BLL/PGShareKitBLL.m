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
#import "NSArray+BlocksKit.h"


NSString *const kPKSGServiceDataDictKeyAuthor       = @"author";
NSString *const kPKSGServiceDataDictKeyDescription  = @"description";
NSString *const kPKSGServiceDataDictKeyTitle        = @"title";
NSString *const kPKSGServiceDataDictKeyMessage      = @"message";
NSString *const kPKSGServiceDataDictKeyThumbnail    = @"thumbnail";
NSString *const kPKSGServiceDataDictKeyThumbnailURL = @"thumbnailURL";
NSString *const kPKSGServiceDataDictKeyURL          = @"URL";
NSString *const kPKSGServiceDataDictKeyDataType     = @"supportedShareType";


NSString *const  PGShareKitErrorDomain = @"PGShareKitErrorDomain";

static inline NSError* PGShareKitReturnError(){
    return [NSError errorWithDomain:PGShareKitErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@"用户取消分享"}];
}
static RACSignal* PGShareKitCreateShareSignal(NSDictionary* dict, id<PGSKServiceInfo> serviceInfo);


void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock,
                              PGSKSuccessBlock success,
                              PGSKFailBlock fail)
//RACSignal* PGShareKitBLLShare(PGShareKitBLLGetSharInfo)
{
   [[[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        PGSKServiceInfoLoadConfig(nil, ^(NSArray<id<PGSKServiceInfo>> *services) {
//            [subscriber sendNext:services];
//            [subscriber sendCompleted];
//        }, ^(NSError *error) {
//            [subscriber sendError:error];
//        });
        [subscriber sendNext:PGSKServiceInfoLoadCameraOrder()];
        return nil;
    }] /* 过滤没安装的 */
       map:^id(NSArray<id<PGSKServiceInfo>> *services) {
       return [services bk_select:^BOOL(id<PGSKServiceInfo>  _Nonnull obj) {
           return PGShareKitServiceCanShare(obj);
       }];
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

    }] subscribeNext:^(id x) {
        if (success) success(x);
    } error:^(NSError *error) {
        if (fail) fail(error);
    }];
}

static RACSignal* PGShareKitCreateShareSignal(NSDictionary* dict, id<PGSKServiceInfo> serviceInfo){
    assert(nil != dict[kPKSGServiceDataDictKeyDataType]);
    //                 NSAssert(nil != dict[PKSGServiceDataDictKeyDataType], @"PKSGServiceDataDictKeyDataType必须要传");
    PGSKServiceSupportedDataType type = [dict[kPKSGServiceDataDictKeyDataType] unsignedIntegerValue];
    
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
    RACSignal* successSignal = [[service rac_signalForSelector:@selector(service:didCompleteWithResults:)
                                                  fromProtocol:@protocol(PGSKServiceDelegate)]
                                map:^id(RACTuple* value) {
                                    return value.second;
                                }];
    RACSignal* failSignal = [[service rac_signalForSelector:@selector(service:didFailWithError:)
                                               fromProtocol:@protocol(PGSKServiceDelegate)]
                             map:^id(RACTuple* value) {
                                 return value.second;
                             }];
    
    [service performSelector:PGShareKitGetServiceSelector(type)
                  withObject:data];
    return [RACSignal merge:@[successSignal, failSignal]];
}




