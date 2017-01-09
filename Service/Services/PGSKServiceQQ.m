//
//  PGSKServiceQQ.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKServiceQQ.h"
#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "PGSKServiceInfo.h"

@interface PGSKServiceQQ()<TencentSessionDelegate>
@property (nonatomic) BOOL inited;
@end

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
//    QQApiObject* obj = nil;
//    switch (webpage.type) {
//        case PGSKServiceWebPageDataContentTypeVideo:{
            QQApiNewsObject* obj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:webpage.url]
                                                                      title:webpage.title
                                                                description:webpage.message
                                                           previewImageData:UIImageJPEGRepresentation(webpage.thumbnail, 0.8)];
            
//            break;
//        }
//        case PGSKServiceWebPageDataContentTypeImage:{
//            obj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:@[UIImageJPEGRepresentation(webpage.thumbnail, 0.9)]
//                                                                                                       title:webpage.title];
//        }
//        default:
//            break;
//    }
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:obj];
}

- (void)lasyInit
{
    if (_inited) return;
//    _auth = [[TencentOAuth alloc] initWithAppId:_appKey andDelegate:self];
    [[TencentOAuth alloc] initWithAppId:PGSKServiceInfoGetAppKeyWithKey(PKSGServiceWeiBo) andDelegate:self];
    _inited = YES;
}

/**
 *	@brief	接住外部openurl回调
 *
 *	@param 	application 	当前application
 *	@param 	url 	url
 *	@param 	sourceApplication 	来源application
 *	@param 	annotation 	不知道
 *
 *	@return	是否处理
 */
- (BOOL)handleApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [self lasyInit];
    if ([TencentOAuth HandleOpenURL:url]) return YES;
    else return [QQApiInterface handleOpenURL:url delegate:self];
}


@end



