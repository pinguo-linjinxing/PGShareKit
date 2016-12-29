//
//  PGSKServiceData.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 支持的数据类型定义
 */
typedef enum tagPGSKServiceSupportedDataType{
    PGSKServiceSupportedDataTypeText = 1 << 0,
    PGSKServiceSupportedDataTypeImage = 1 << 1,
    PGSKServiceSupportedDataTypeMultiImages = 1 << 2,
    PGSKServiceSupportedDataTypeGif = 1 << 3,
    PGSKServiceSupportedDataTypeVideo = 1 << 4,
    PGSKServiceSupportedDataTypeWebPage = 1 << 5
}PGSKServiceSupportedDataType;


@protocol PGSKServiceDataText <NSObject>
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* message;
@end


@protocol PGSKServiceDataImage <PGSKServiceDataText>
@property(nonatomic, readonly) UIImage* image;
@property(nonatomic, readonly) NSURL* url;
@end

@protocol PGSKServiceDataMultiImages <PGSKServiceDataText>
@property(nonatomic, readonly) NSArray<UIImage*>* image;
@property(nonatomic, readonly) NSArray<NSURL*>* urls;
@end

@protocol PGSKServiceDataVideo <PGSKServiceDataText>
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* thumbnailUrl;
@property(nonatomic, readonly) NSURL* url;
@end

@protocol PGSKServiceDataWebPage <PGSKServiceDataText>
@property(nonatomic, readonly) UIImage* thumbnail;
@property(nonatomic, readonly) NSURL* thumbnailUrl;
@property(nonatomic, readonly) NSURL* url;
@end




//
//@interface PGSKServiceData : NSObject
//
//@end
