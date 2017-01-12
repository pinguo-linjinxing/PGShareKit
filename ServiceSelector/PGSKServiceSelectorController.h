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
#import "PGSKServiceSelectorView.h"
#import "PGSKTypes.h"


typedef void(^PGSKSelectServiceBlock)(id<PGSKServiceInfo>service);


@interface PGSKServiceSelectorController : NSObject<PGSKServiceSelectorDataSource, PGSKServiceSelectorDelegate>
//@property(strong, readonly) NSArray<PGSKServiceInfo>* service;
//@property(strong, readonly) id<PGSKServiceSelector> selectorView;
+ (instancetype)serviceSelectorControllerWithselectorView:(id<PGSKServiceSelector>) selectorView
                                                  service:(NSArray<PGSKServiceInfo>*)service;
- (void)showWithSelectBlock:(PGSKSelectServiceBlock)select cancelBlock:(PGSKCanelBlock)cancel;
@end




