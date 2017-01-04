//
//  CopyWritingFormat.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGSKTypes.h"

typedef void(^PGSKConfigLoadCopyWritingSuccess)(NSString* title, NSString* message);

void PGSKConfigLoadCopyWritingInfo(NSDictionary* param,PGSKConfigLoadCopyWritingSuccess success, PGSKFailBlock fail);
