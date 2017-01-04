//
//  PGSKServiceInfo.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKServiceData.h"
#import "PGSKServiceInfo.h"

@protocol PGSKServiceDelegate;


@protocol PGSKService<NSObject>
@property(nonatomic, weak) id<PGSKServiceDelegate> delegate;
@property(nonatomic, readonly) BOOL isInstalled;
@property(nonatomic, readonly) BOOL isInitDone;
//- (void)shareText:(id<PGSKServiceDataText>)text;
- (void)shareImage:(id<PGSKServiceDataImage>)image;
//- (void)shareMultiImages:(id<PGSKServiceDataMultiImages>)images;
- (void)shareVideo:(id<PGSKServiceDataVideo>)video;
- (void)shareWebPage:(id<PGSKServiceDataWebPage>)webpage;
@end

@protocol PGSKServiceDelegate <NSObject>
@optional
- (void)service:(id<PGSKService>)service didSuccess:(id)param;
- (void)service:(id<PGSKService>)service didFail:(NSError *)error;
- (void)serviceDidCancel:(id<PGSKService>)service;
//- (void)service:(id<PGSKService>)service didReceiveRequest:(id)param;
//- (void)serviceDidLogined:(id<PGSKService>)service;
//- (void)serviceWillShare:(id<PGSKService>)service;
//- (void)serviceDidInitDone:(id<PGSKService>)service;
@end


Class PGShareKitService(id<PGSKServiceInfo> serviceInfo);
SEL PGShareKitSelector(PGSKServiceSupportedDataType type);





