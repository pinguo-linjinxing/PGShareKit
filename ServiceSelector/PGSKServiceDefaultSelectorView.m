//
//  PGSKServiceSelectorView.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceDefaultSelectorView.h"
#import "UIButton+Layout.h"

@interface PGSKServiceDefaultSelectorView()<UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView* collectionView;
@property(nonatomic, strong) UIButton* btnCancel;
@end

#define Space 8
#define CollectionViewHeight 120
#define ButtonHeight 80

@implementation PGSKServiceDefaultSelectorView
@synthesize dataSource, delegate;

-(instancetype)init{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

+ (UICollectionViewFlowLayout*)collectionViewFlowLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(78, 100);
    layout.minimumInteritemSpacing = 12;
    return layout;
}

- (UICollectionView*)createCollectionView{
    UICollectionView* cv = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[[self class] collectionViewFlowLayout]];
    cv.backgroundColor = [UIColor whiteColor];
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
                       action:@selector(cancelAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.collectionView];
    [self addSubview:self.btnCancel];
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
//    UIView* superView = [[UIApplication sharedApplication].windows firstObject];
    UIView* superView = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
    [superView addSubview:self];
    [self.collectionView reloadData];
    [superView bringSubviewToFront:self];
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
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn centerVertically];
        [cell.contentView addSubview:btn];
        [btn addTarget:self
                           action:@selector(action:)
                 forControlEvents:UIControlEventTouchUpInside];
        CGRect frame = btn.frame;
        frame.size = [[self class] collectionViewFlowLayout].itemSize;
        frame.size.width /= 2;
        frame.size.height /= 2;
        btn.frame = frame;
        btn.tag = 1;
    }
    btn.tag = indexPath.item;
    if ([self.dataSource respondsToSelector:@selector(selector:serviceForIndex:)]) {
        id<PGSKServiceInfo> info = [self.dataSource selector:self serviceForIndex:indexPath.item];
        [btn setTitle:info.name forState:UIControlStateNormal];
        [btn setImage:PGSKServiceInfoGetImageWithKey([info sloganImageName]) forState:UIControlStateNormal];
    }
    return cell;
}


@end





