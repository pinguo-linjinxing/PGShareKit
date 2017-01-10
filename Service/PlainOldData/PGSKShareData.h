//
//  PGSKShareData.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PGSKTypes.h"

@protocol PGSKShareDataText <NSObject>
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* desc;
@end


@protocol PGSKShareDataImage <NSObject>
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* desc;
@property(nonatomic, readonly) UIImage* image;
@property(nonatomic, readonly) UIImage* thumbnail;
@end

//@protocol PGSKShareDataMultiImages <PGSKShareDataText>
//@property(nonatomic, readonly) NSArray<UIImage*>* image;
//@property(nonatomic, readonly) NSArray<NSURL*>* urls;
//@end

@protocol PGSKShareDataVideo <NSObject>
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* desc;
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* url; /* 视频位置 */
@end

@protocol PGSKShareDataWebPage <NSObject>
@property(nonatomic, readonly) PGSKServiceWebPageDataContentType type;
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* desc;
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* url;
@end

/**
 像新浪，twitter这样，需要编辑的数据
 */
@protocol PGSKShareDataComposer <NSObject>
@property(nonatomic, readonly) NSString* content;
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* url;
@property(nonatomic, readonly) NSArray<NSString*>* tags;
@end



@interface PGSKShareDataTextPOD : NSObject<PGSKShareDataText>

@end

@interface PGSKShareDataImagePOD : NSObject<PGSKShareDataImage>
+ (instancetype)shareDataImagePODWithTitle:(NSString*)title
                                      desc:(NSString*)desc
                                     image:(UIImage*)image
                             thubnailImage:(UIImage*)thubnailImage;
@end

@interface PGSKShareDataVideoPOD : NSObject<PGSKShareDataVideo>

@end

@interface PGSKShareDataWebPagePOD : NSObject<PGSKShareDataWebPage>

@end

@interface PGSKShareDataComposerPOD : NSObject<PGSKShareDataComposer>

@end



id PGShareKitCreateData(PGSKServiceSupportedDataType type, NSDictionary* initDict);







