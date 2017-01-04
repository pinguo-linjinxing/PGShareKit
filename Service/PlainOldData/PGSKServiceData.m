//
//  PGSKServiceData.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceData.h"

@interface PGSKServiceDataImagePOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@property(nonatomic) UIImage* image;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKServiceDataImagePOD

@end


@interface PGSKServiceDataVideo()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailUrl;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKServiceDataVideo

@end

@interface PGSKServiceDataWebPage()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailUrl;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKServiceDataWebPage

@end



