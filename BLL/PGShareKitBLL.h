//
//  PGShareKitBLL.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKTypes.h"

FOUNDATION_EXPORT NSString *const PKSGServiceDataDictKeyAuthor ;
FOUNDATION_EXPORT NSString *const PKSGServiceDataDictKeyDescription ;
FOUNDATION_EXPORT NSString *const PKSGServiceDataDictKeyThumbnail ;
FOUNDATION_EXPORT NSString *const PKSGServiceDataDictKeyThumbnailURL;
FOUNDATION_EXPORT NSString *const PKSGServiceDataDictKeyURL;
FOUNDATION_EXPORT NSString *const PKSGServiceDataDictKeyDataType;


/**
 调用者需要实现的block

 @param type 社交平台能支持的数据类型
 @param success 调用者成功获取到了数据，（有些需要上传视频到服务器，因此这里使用block，可以实现异步）
 @param fail 调用者获取数据失败了。
 */
typedef void (^PGShareKitBLLGetSharInfo)(PGSKServiceSupportedDataType type, PGSKDataBlock success, PGSKFailBlock fail);

/**
 加载配置->显示选择器->获取分享数据类型->分享数据
 
 @param getParamBlock 调用者需要实现这个block,根据type传数据
 @param success 成功回调
 @param fail 失败回调
 */
void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock, PGSKSuccessBlock success, PGSKFailBlock fail);






