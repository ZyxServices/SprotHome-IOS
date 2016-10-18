//
//  LVScanTwoCodeController.h
//  lover
//
//  Created by stoneobs on 16/4/8.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 二维码控制器，

#import <UIKit/UIKit.h>
#import "STBaseViewController.h"
typedef void(^TWOCODERESULT)(NSString * result);
@interface STScanTwoCodeController : STBaseViewController
//二维码扫描结果
@property(nonatomic,copy)TWOCODERESULT resultBlock;
@end
