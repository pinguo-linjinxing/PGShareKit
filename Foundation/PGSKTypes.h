//
//  PGSKTypes.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//
#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const  PGShareKitErrorDomain;
/**
 支持的数据类型定义
 */
typedef NS_OPTIONS(NSUInteger, PGSKServiceSupportedDataType) {
    PGSKServiceSupportedDataTypeText        = 1 << 0,
    PGSKServiceSupportedDataTypeImage       = 1 << 1,
    PGSKServiceSupportedDataTypeMultiImages = 1 << 2,
    PGSKServiceSupportedDataTypeGif         = 1 << 3,
    PGSKServiceSupportedDataTypeVideo       = 1 << 4,
    PGSKServiceSupportedDataTypeWebPage     = 1 << 5,
    PGSKServiceSupportedDataTypeComposer    = 1 << 6,
};


/**
 分享的网页内容类型
 */
typedef NS_OPTIONS(NSUInteger, PGSKServiceWebPageDataContentType) {
    PGSKServiceWebPageDataContentTypeNormal,
    PGSKServiceWebPageDataContentTypeImage,
    PGSKServiceWebPageDataContentTypeVideo
};


