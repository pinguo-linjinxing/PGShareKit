//
//  PGSKServiceSelector.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PGSKServiceInfo.h"

@protocol PGSKServiceSelectorDataSource;
@protocol PGSKServiceSelectorDelegate;

@protocol PGSKServiceSelector <NSObject>
@property(weak) id<PGSKServiceSelectorDataSource> dataSource;
@property(weak) id<PGSKServiceSelectorDelegate> delegate;
- (void)show;
@end

@protocol PGSKServiceSelectorDataSource <NSObject>
- (id<PGSKServiceInfo>)selector:(id<PGSKServiceSelector>)selector serviceForIndex:(NSUInteger)index;
- (NSInteger)numberOfRowsInSelector:(id<PGSKServiceSelector>)selector;
@end

@protocol PGSKServiceSelectorDelegate <NSObject>
- (void)selectorDidCancel:(id<PGSKServiceSelector>)selector;
- (void)selector:(id<PGSKServiceSelector>)selector didSelectIndex:(NSUInteger)index;
@end






