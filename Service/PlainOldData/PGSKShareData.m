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
@property(nonatomic) NSString* desc;
@end

@implementation PGSKShareDataTextPOD

@end

@interface PGSKShareDataImagePOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* desc;
@property(nonatomic) UIImage* image;
@property(nonatomic) UIImage* thumbnail;
@end

@implementation PGSKShareDataImagePOD
+ (instancetype)shareDataImagePODWithTitle:(NSString*)title
                                      desc:(NSString*)desc
                                     image:(UIImage*)image
                             thubnailImage:(UIImage*)thubnailImage{
    PGSKShareDataImagePOD* pod = [[self alloc] init];
    pod.title = title;
    pod.desc = desc;
    pod.image = image;
    pod.thumbnail = thubnailImage;
    return pod;
}
@end


@interface PGSKShareDataVideoPOD()
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* desc;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailUrl;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKShareDataVideoPOD

@end

@interface PGSKShareDataWebPagePOD()
@property(nonatomic) PGSKServiceWebPageDataContentType type;
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* desc;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* thumbnailUrl;
@property(nonatomic) NSURL* url;
@end

@implementation PGSKShareDataWebPagePOD

@end

@interface PGSKShareDataComposerPOD()
@property(nonatomic) NSString* content;
@property(nonatomic) UIImage* thumbnail;
@property(nonatomic) NSURL* url;
@property(nonatomic) NSArray<NSString*>* tags;
@end

@implementation PGSKShareDataComposerPOD

@end






id PGShareKitCreateData(PGSKServiceSupportedDataType type, NSDictionary* initDict){
    return [@{@(PGSKServiceSupportedDataTypeImage):[PGSKShareDataImagePOD class],
              @(PGSKServiceSupportedDataTypeVideo):[PGSKShareDataVideoPOD class],
              @(PGSKServiceSupportedDataTypeWebPage):[PGSKShareDataWebPagePOD class]
              }
            objectForKey:@(type)];
}


