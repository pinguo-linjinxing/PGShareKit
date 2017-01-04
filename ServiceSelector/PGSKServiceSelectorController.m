//
//  PGSKServiceSelectorController.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceSelectorController.h"

@interface PGSKServiceSelectorController()
@property(strong) NSArray<PGSKServiceInfo>* service;
@property(strong) id<PGSKServiceSelector> selectorView;
@property(copy) PGSKSelectServiceBlock selectBlock;
@property(copy) PGSKCanelBlock cancelBlock;
@end

@implementation PGSKServiceSelectorController
+ (instancetype)serviceSelectorControllerWithselectorView:(id<PGSKServiceSelector>) selectorView
                                                  service:(NSArray<PGSKServiceInfo>*)service{
    PGSKServiceSelectorController* controller = [[self alloc] init];
    controller.selectorView = selectorView;
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
    return [self.service count];
}

- (id<PGSKServiceInfo>)selector:(id<PGSKServiceSelector>)selector serviceForIndex:(NSUInteger)index{
    return self.service[index];
}

- (void)selectorDidCancel:(id<PGSKServiceSelector>)selector{
    if (self.cancelBlock) {
        self.cancelBlock(selector);
    }
}
- (void)selector:(id<PGSKServiceSelector>)selector didSelectIndex:(NSUInteger)index{
    if (self.selectBlock) {
        self.selectBlock(self.service[index]);
    }
}
@end


