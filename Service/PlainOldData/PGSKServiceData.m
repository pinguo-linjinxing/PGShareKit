//
//  PGSKServiceData.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceData.h"
#import "PGSKTypes.h"

@interface PGSKServiceDataImagePOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@property(nonatomic) UIImage* image;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKServiceDataImagePOD

@end


@interface PGSKServiceDataVideoPOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailUrl;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKServiceDataVideoPOD

@end

@interface PGSKServiceDataWebPagePOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* message;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailUrl;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKServiceDataWebPagePOD

@end




id PGShareKitCreateData(PGSKServiceSupportedDataType type, NSDictionary* initDict){
    return [@{@(PGSKServiceSupportedDataTypeImage):[PGSKServiceDataImagePOD class],
              @(PGSKServiceSupportedDataTypeVideo):[PGSKServiceDataVideoPOD class],
              @(PGSKServiceSupportedDataTypeWebPage):[PGSKServiceDataWebPagePOD class]
              }
            objectForKey:@(type)];
}


