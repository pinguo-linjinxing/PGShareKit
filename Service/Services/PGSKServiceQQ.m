//
//  PGSKServiceQQ.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceQQ.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>


@implementation PGSKServiceQQ
@synthesize delegate;

+ (BOOL)isInstalled{
    return ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]);
}

- (void)shareImage:(id<PGSKShareDataImage>)image{
    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:UIImageJPEGRepresentation(image.image, 0.9)
                                               previewImageData:UIImageJPEGRepresentation(image.thumbnail, 0.8)
                                                          title:image.title
                                                    description:image.message];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
}

//- (void)shareVideo:(id<PGSKShareDataVideo>)video{
//    
//}

- (void)shareWebPage:(id<PGSKShareDataWebPage>)webpage{
    switch (webpage.type) {
        case PGSKServiceWebPageDataContentTypeVideo:
            QQApiVideoObject *videoObject = [QQApiVideoObject objectWithURL:[NSURL URLWithString:webpage.url]
                                                                      title:webpage.title
                                                                description:webpage.message
                                                           previewImageData:UIImageJPEGRepresentation(webpage.thumbnail, 0.8)];
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:videoObject];
            break;
            
        default:
            break;
    }
}

@end



