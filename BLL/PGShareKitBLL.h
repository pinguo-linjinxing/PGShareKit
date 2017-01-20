//
//  PGShareKitBLL.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKTypes.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BlocksDefines.h"

//FOUNDATION_EXPORT NSString *const kPKSGServiceDataDictKeyAuthor ;
//FOUNDATION_EXPORT NSString *const kPKSGServiceDataDictKeyDescription ;
//FOUNDATION_EXPORT NSString *const kPKSGServiceDataDictKeyThumbnail ;
//FOUNDATION_EXPORT NSString *const kPKSGServiceDataDictKeyThumbnailURL;
//FOUNDATION_EXPORT NSString *const kPKSGServiceDataDictKeyURL;
//FOUNDATION_EXPORT NSString *const kPKSGServiceDataDictKeyDataType;


/**
 调用者需要实现的block

 @param type 社交平台能支持的数据类型，调用者根据此类型构造参数，包括PGSKShareDataTextPOD，PGSKShareDataImagePOD，PGSKShareDataVideoPOD，PGSKShareDataWebPagePOD，PGSKShareDataComposerPOD
 @param success 调用者成功获取到了数据，调用此block将数据传给PGShareKit（有些需要上传视频到服务器，因此这里使用block，可以实现异步）
 @param fail 调用者获取数据失败了，调用此block将错误传给PGShareKit。
 */
typedef void (^PGShareKitBLLGetSharInfo)(PGSKServiceSupportedDataType type, PGSKDataBlock success, PGSKFailBlock fail);

/**
 加载配置->显示选择器->获取分享数据类型->分享数据
 
 @param getParamBlock 调用者需要实现这个block,根据type传数据
 @param success 成功回调
 @param fail 失败回调
 */
void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock, PGSKSuccessBlock success, PGSKFailBlock fail);






