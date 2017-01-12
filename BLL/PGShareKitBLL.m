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
#import "PGSKServiceSelectorView.h"

NSString *const kPKSGServiceDataDictKeyAuthor       = @"author";
NSString *const kPKSGServiceDataDictKeyDescription  = @"description";
NSString *const kPKSGServiceDataDictKeyTitle        = @"title";
NSString *const kPKSGServiceDataDictKeyMessage      = @"message";
NSString *const kPKSGServiceDataDictKeyThumbnail    = @"thumbnail";
NSString *const kPKSGServiceDataDictKeyThumbnailURL = @"thumbnailURL";
NSString *const kPKSGServiceDataDictKeyURL          = @"URL";
NSString *const kPKSGServiceDataDictKeyDataType     = @"supportedShareTypes";


NSString *const  PGShareKitErrorDomain = @"PGShareKitErrorDomain";

static inline NSError* PGShareKitReturnError(){
    return [NSError errorWithDomain:PGShareKitErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@"用户取消分享"}];
}
static RACSignal* PGShareKitCreateShareSignal(id data, id<PGSKServiceInfo> serviceInfo, PGSKServiceSupportedDataType type);


void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock,
                              PGSKSuccessBlock success,
                              PGSKFailBlock fail)
//RACSignal* PGShareKitBLLShare(PGShareKitBLLGetSharInfo)
{
   [[[[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       /* 从配置获取分享的社交平台 */
//        PGSKServiceInfoLoadConfig(nil, ^(NSArray<id<PGSKServiceInfo>> *services) {
//            [subscriber sendNext:services];
//            [subscriber sendCompleted];
//        }, ^(NSError *error) {
//            [subscriber sendError:error];
//        });
        [subscriber sendNext:PGSKServiceInfoLoadCameraOrder()];
        [subscriber sendCompleted];
        return nil;
    }] /* 过滤没安装的 */
       map:^id(NSArray<id<PGSKServiceInfo>> *services) {
       return [services bk_select:^BOOL(id<PGSKServiceInfo>  _Nonnull obj) {
           return PGShareKitServiceCanShare(obj);
       }];
    }]/* 让用户选择分享平台 */
     flattenMap:^RACStream *(NSArray<id<PGSKServiceInfo>> *services) {
      return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
          static PGSKServiceSelectorController* con = nil;
            con = [PGSKServiceSelectorController controllerWithselectorView:[PGSKServiceSelectorView new]
                                                                    service:services];
            [con showWithSelectBlock:^(id<PGSKServiceInfo> service) {
                [subscriber sendNext:service];
                [subscriber sendCompleted];
                con = nil;
            } cancelBlock:^(id sender) {
                [subscriber sendError:PGShareKitReturnError()];
                con = nil;
            }];
            return nil;
        }];
    }]
      /* 获取分享的参数数据 */
     flattenMap:^RACStream *(NSObject<PGSKServiceInfo>* serviceInfo) {
         assert(nil != getParamBlock);
         return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
             PGSKServiceSupportedDataType type = PGSKServiceSupportedDataTypeImage;
             getParamBlock(type,
                           ^(id param){
                               [subscriber sendNext:RACTuplePack(param, serviceInfo, @(type))];
                               [subscriber sendCompleted];
                           },
                           ^(NSError* error){
                               [subscriber sendError:error];
                           }
                           );
             return nil;
         }];
    }]
     /* 分享到社交平台 */
     flattenMap:^RACStream *(RACTuple* tuple) {
         return PGShareKitCreateShareSignal(tuple.first, tuple.second, (PGSKServiceSupportedDataType)[tuple.third integerValue]);
    }]
    subscribeNext:^(id x) {
        if (success) success(x);
    }
    error:^(NSError *error) {
        if (fail) fail(error);
    }];
}

static RACSignal* PGShareKitCreateShareSignal(id data, id<PGSKServiceInfo> serviceInfo, PGSKServiceSupportedDataType type){
//    assert(nil != dict[kPKSGServiceDataDictKeyDataType]);
    //                 NSAssert(nil != dict[PKSGServiceDataDictKeyDataType], @"PKSGServiceDataDictKeyDataType必须要传");
//    PGSKServiceSupportedDataType type = [dict[kPKSGServiceDataDictKeyDataType] unsignedIntegerValue];
    
//    id data = PGShareKitCreateData(type, dict);
//    [data setValuesForKeysWithDictionary:dict];
//    if (PGSKServiceSupportedDataTypeImage == type){
//        assert([data conformsToProtocol:@protocol(PGSKShareDataImage)]);
//    }
//    if (PGSKServiceSupportedDataTypeVideo == type){
//        assert([data conformsToProtocol:@protocol(PGSKShareDataVideo)]);
//    }
//    if (PGSKServiceSupportedDataTypeWebPage == type){
//        assert([data conformsToProtocol:@protocol(PGSKShareDataWebPage)]);
//    }
    
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
    SEL selector = PGShareKitGetServiceSelector(type);
    ((void (*)(id, SEL, id))[service methodForSelector:selector])(service, selector, data);
    return [RACSignal merge:@[successSignal, failSignal]];
}




