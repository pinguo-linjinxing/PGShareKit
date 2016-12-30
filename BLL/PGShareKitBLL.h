//
//  PGShareKitBLL.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKTypes.h"

typedef NSDictionary* (^PGShareKitBLLGetSharInfo)(PGSKServiceSupportedDataType type);

/**
 加载配置->显示选择器->获取分享数据类型->分享数据
 
 @param getParamBlock 调用者需要实现这个block,根据type传数据
 @param success 成功回调
 @param fail 失败回调
 */
void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock, PGSKSuccessBlock success, PGSKFailBlock fail);
