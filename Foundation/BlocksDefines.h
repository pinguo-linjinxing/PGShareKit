//
//  BlocksDefines.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void(^PGSKVoidBlock)();
typedef void(^PGSKDataBlock)(id data);
typedef PGSKDataBlock PGSKSuccessBlock;
typedef void(^PGSKFailBlock)(NSError* error);

typedef void(^PGSKSelectBlock)(id sender, NSIndexPath* indexPath);
typedef void(^PGSKSenderBlock)(id sender);
typedef PGSKSenderBlock PGSKCanelBlock;


