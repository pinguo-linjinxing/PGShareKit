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
#import "PGSKServiceDefaultSelectorView.h"

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

static RACSignal* PGShareKitLoadConfigSignal();
static RACSignal* PGShareKitCreateShareSignal(id data,
                                              id<PGSKServiceInfo> serviceInfo,
                                              PGSKServiceSupportedDataType type);
static RACSignal* PGShareKitCreateShareSelectorSignal(NSArray<id<PGSKServiceInfo>> *services);
static RACSignal* PGShareKitCreateShareDataSignal(PGShareKitBLLGetSharInfo getParamBlock,
                                            NSObject<PGSKServiceInfo>* serviceInfo);

void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock,
                              PGSKSuccessBlock success,
                              PGSKFailBlock fail)
//RACSignal* PGShareKitBLLShare(PGShareKitBLLGetSharInfo)
{
   [[[[/* 加载配置数据 */
       [PGShareKitLoadConfigSignal()
       /* 过滤没安装的 */
        map:^id(NSArray<id<PGSKServiceInfo>> *services) {
       return [services bk_select:^BOOL(id<PGSKServiceInfo>  _Nonnull obj) {
           return PGShareKitServiceCanShare(obj);
       }];
    }]/* 让用户选择分享平台 */
     flattenMap:^RACStream *(NSArray<id<PGSKServiceInfo>> *services) {
         return PGShareKitCreateShareSelectorSignal(services);
    }]
      /* 获取分享的参数数据 */
     flattenMap:^RACStream *(NSObject<PGSKServiceInfo>* serviceInfo) {
         return PGShareKitCreateShareDataSignal(getParamBlock, serviceInfo);
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

static RACSignal* PGShareKitLoadConfigSignal(){
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        /* 从配置获取分享的社交平台, 配置有可能从服务器加载，因此这里保留异步，建议从服务器加载 */
        //        PGSKServiceInfoLoadConfig(nil, ^(NSArray<id<PGSKServiceInfo>> *services) {
        //            [subscriber sendNext:services];
        //            [subscriber sendCompleted];
        //        }, ^(NSError *error) {
        //            [subscriber sendError:error];
        //        });
        [subscriber sendNext:PGSKServiceInfoLoadCamera()];
        [subscriber sendCompleted];
        return nil;
    }];
}


static RACSignal* PGShareKitCreateShareDataSignal(PGShareKitBLLGetSharInfo getParamBlock,
                                            NSObject<PGSKServiceInfo>* serviceInfo){
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
}

static RACSignal* PGShareKitCreateShareSelectorSignal(NSArray<id<PGSKServiceInfo>> *services){
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        static PGSKServiceSelectorController* con = nil;
        con = [PGSKServiceSelectorController controllerWithselectorView:[PGSKServiceDefaultSelectorView new]
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




