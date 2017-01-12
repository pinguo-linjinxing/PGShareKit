//
//  PGSKServiceSelectorController.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PGSKServiceInfo.h"
#import "PGSKServiceDefaultSelectorView.h"
#import "PGSKTypes.h"


typedef void(^PGSKSelectServiceBlock)(id<PGSKServiceInfo>service);


@interface PGSKServiceSelectorController : NSObject<PGSKServiceSelectorDataSource, PGSKServiceSelectorDelegate>
//@property(strong, readonly) NSArray<PGSKServiceInfo>* service;
//@property(strong, readonly) id<PGSKServiceSelector> selectorView;
+ (instancetype)controllerWithselectorView:(id<PGSKServiceSelector>) selectorView
                                                  service:(NSArray<id<PGSKServiceInfo>>*)services;
- (void)showWithSelectBlock:(PGSKSelectServiceBlock)select cancelBlock:(PGSKCanelBlock)cancel;
@end




