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
@property(nonatomic, readonly) NSString* message;
@end


@protocol PGSKShareDataImage <NSObject>
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* message;
@property(nonatomic, readonly) UIImage* image;
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* url;
@end

//@protocol PGSKShareDataMultiImages <PGSKShareDataText>
//@property(nonatomic, readonly) NSArray<UIImage*>* image;
//@property(nonatomic, readonly) NSArray<NSURL*>* urls;
//@end

@protocol PGSKShareDataVideo <NSObject>
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* message;
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* thumbnailUrl;
@property(nonatomic, readonly) NSURL* url;
@end

@protocol PGSKShareDataWebPage <NSObject>
@property(nonatomic, readonly) PGSKServiceWebPageDataContentType type;
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* message;
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* thumbnailUrl;
@property(nonatomic, readonly) NSURL* url;
@end

@interface PGSKShareDataTextPOD : NSObject<PGSKShareDataText>

@end

@interface PGSKShareDataImagePOD : NSObject<PGSKShareDataImage>

@end

@interface PGSKShareDataVideoPOD : NSObject<PGSKShareDataVideo>

@end

@interface PGSKShareDataWebPagePOD : NSObject<PGSKShareDataWebPage>

@end



id PGShareKitCreateData(PGSKServiceSupportedDataType type, NSDictionary* initDict);







