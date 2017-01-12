//
//  PGSKServiceSelectorController.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceSelectorController.h"

@interface PGSKServiceSelectorController()
@property(strong) NSArray<id<PGSKServiceInfo>>* services;
@property(strong) id<PGSKServiceSelector> selectorView;
@property(copy) PGSKSelectServiceBlock selectBlock;
@property(copy) PGSKCanelBlock cancelBlock;
@end

@implementation PGSKServiceSelectorController
+ (instancetype)controllerWithselectorView:(id<PGSKServiceSelector>) selectorView
                                                  service:(NSArray<id<PGSKServiceInfo>>*)services{
    PGSKServiceSelectorController* controller = [[self alloc] init];
    controller.selectorView = selectorView;
    controller.services = services;
    selectorView.dataSource = controller;
    selectorView.delegate = controller;
    return controller;
}

- (void)showWithSelectBlock:(PGSKSelectServiceBlock)select cancelBlock:(PGSKCanelBlock)cancel{
    self.selectBlock = select;
    self.cancelBlock = cancel;
    [self.selectorView show];
}

- (NSInteger)numberOfRowsInSelector:(id<PGSKServiceSelector>)selector{
    return [self.services count];
}

- (id<PGSKServiceInfo>)selector:(id<PGSKServiceSelector>)selector serviceForIndex:(NSUInteger)index{
    return self.services[index];
}

- (void)selectorDidCancel:(id<PGSKServiceSelector>)selector{
    if (self.cancelBlock) {
        self.cancelBlock(selector);
    }
    [selector dismiss];
}
- (void)selector:(id<PGSKServiceSelector>)selector didSelectIndex:(NSUInteger)index{
    if (self.selectBlock) {
        self.selectBlock(self.services[index]);
    }
    [selector dismiss];
}
@end






