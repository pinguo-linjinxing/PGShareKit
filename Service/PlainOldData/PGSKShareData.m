//
//  PGSKShareData.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKShareData.h"
#import "PGSKTypes.h"


@interface PGSKShareDataTextPOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@end

@implementation PGSKShareDataTextPOD

@end

@interface PGSKShareDataImagePOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@property(nonatomic) UIImage* image;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKShareDataImagePOD

@end


@interface PGSKShareDataVideoPOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailUrl;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKShareDataVideoPOD

@end

@interface PGSKShareDataWebPagePOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailUrl;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKShareDataWebPagePOD

@end




id PGShareKitCreateData(PGSKServiceSupportedDataType type, NSDictionary* initDict){
    return [@{@(PGSKServiceSupportedDataTypeImage):[PGSKShareDataImagePOD class],
              @(PGSKServiceSupportedDataTypeVideo):[PGSKShareDataVideoPOD class],
              @(PGSKServiceSupportedDataTypeWebPage):[PGSKShareDataWebPagePOD class]
              }
            objectForKey:@(type)];
}


