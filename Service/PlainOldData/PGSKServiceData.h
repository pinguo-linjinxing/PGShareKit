//
//  PGSKServiceData.h
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


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
