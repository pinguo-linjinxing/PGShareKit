//
//  ViewController.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/29.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "ViewController.h"
#import "PGShareKitBLL.h"
#import "PGSKShareData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)shareAction:(id)sender{
    PGShareKitBLLShare(^(PGSKServiceSupportedDataType type,
                         PGSKDataBlock success,
                         PGSKFailBlock fail) {
        NSLog(@"type:%@", @(type));
        if (/* DISABLES CODE */ (1)){
            if (success) success([PGSKShareDataImagePOD shareDataImagePODWithTitle:@"text"
                                                                              desc:@"description aa"
                                                                             image:[UIImage imageNamed:@""]
                                                                     thubnailImage:[UIImage imageWithContentsOfFile:@""]]);
        }else{
            if (fail) fail([NSError errorWithDomain:@"com.sharekit.test" code:-1 userInfo:nil]);
        }
    }, ^(id data) {
        NSLog(@"data:%@", data);
    }, ^(NSError *error) {
        NSLog(@"error:%@", error);
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
