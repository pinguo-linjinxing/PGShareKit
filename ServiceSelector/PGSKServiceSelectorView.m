//
//  PGSKServiceSelectorView.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceSelectorView.h"
#import "UIButton+Layout.h"

@interface PGSKServiceSelectorView()<UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView* collectionView;
@property(nonatomic, strong) UIButton* btnCancel;
@end

#define Space 8
#define CollectionViewHeight 120
#define ButtonHeight 80

@implementation PGSKServiceSelectorView
@synthesize dataSource, delegate;

-(instancetype)init{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (UICollectionView*)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(78, 100);
    layout.minimumInteritemSpacing = 12;
    
    UICollectionView* cv = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:layout];
    [cv registerClass:[UICollectionViewCell class]  forCellWithReuseIdentifier:@"cell"];
    return cv;
}

- (void)createSubviews{
    self.collectionView = [self createCollectionView];
//    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.btnCancel addTarget:self
                       action:@selector(action:)
             forControlEvents:UIControlEventTouchUpInside];
}

- (void)action:(id)sender{
    if ([self.delegate respondsToSelector:@selector(selectorDidCancel:)]) {
        [self.delegate selector:self didSelectIndex:[sender tag]];
    }
}

- (void)cancelAction:(id)sender{
    if ([self.delegate respondsToSelector:@selector(selectorDidCancel:)]) {
        [self.delegate selectorDidCancel:self];
    }
}

- (void)layoutSubviews{
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.collectionView.frame = CGRectMake(0, size.height - CollectionViewHeight - Space * 3, size.width, CollectionViewHeight);
    self.btnCancel.frame = CGRectMake(0, size.height - ButtonHeight - Space * 2, size.width, ButtonHeight);
}

- (void)show{
    [self removeFromSuperview];
    UIView* superView = [[UIApplication sharedApplication].windows firstObject];
    [superView addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
}

#pragma 数据源

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInSelector:)]) {
        return [self.dataSource numberOfRowsInSelector:self];
    }
    return 0;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIButton* btn = (UIButton*)[cell.contentView viewWithTag:1];
    if (nil == btn){
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn centerVertically];
        [cell.contentView addSubview:btn];
        [btn addTarget:self
                           action:@selector(action:)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    btn.tag = indexPath.item;
    if ([self.dataSource respondsToSelector:@selector(selector:serviceForIndex:)]) {
        id<PGSKServiceInfo> info = [self.dataSource selector:self serviceForIndex:indexPath.item];
        [btn setTitle:info.name forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithContentsOfFile:info.sloganURL] forState:UIControlStateNormal];
    }
    return cell;
}


@end





