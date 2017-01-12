//
//  PGSKServiceInfo.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKShareData.h"
#import "PGSKServiceInfo.h"

@protocol PGSKServiceDelegate;


@protocol PGSKService<NSObject>
@property(nonatomic, weak) id<PGSKServiceDelegate> delegate;

//@property(nonatomic, readonly) BOOL isInitDone;
//- (void)shareText:(id<PGSKShareDataText>)text;
+ (BOOL) canShare;
- (void)shareImage:(id<PGSKShareDataImage>)image;
//- (void)shareMultiImages:(id<PGSKShareDataMultiImages>)images;
- (void)shareWebPage:(id<PGSKShareDataWebPage>)webpage;

@optional
- (void)shareVideo:(id<PGSKShareDataVideo>)video;
- (void)shareComposer:(id<PGSKShareDataComposer>)composer;
@end

@protocol PGSKServiceDelegate <NSObject>
@optional
- (void)service:(id<PGSKService>)service didCompleteWithResults:(NSDictionary *)results;
- (void)service:(id<PGSKService>)service didFailWithError:(NSError *)error;
//- (void)service:(id<PGSKService>)service didReceiveRequest:(id)param;
//- (void)serviceDidLogined:(id<PGSKService>)service;
//- (void)serviceWillShare:(id<PGSKService>)service;
//- (void)serviceDidInitDone:(id<PGSKService>)service;
@end


NSObject<PGSKService>* PGShareKitCreateService(id<PGSKServiceInfo> serviceInfo);
BOOL PGShareKitServiceCanShare(id<PGSKServiceInfo> serviceInfo);
SEL PGShareKitGetServiceSelector(PGSKServiceSupportedDataType type);





