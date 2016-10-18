//
//  STPhotoBrowerController.h
//  STTools
//
//  Created by stoneobs on 16/10/13.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 常见网络图片浏览器

#import <UIKit/UIKit.h>
#import "STUrlPhotoModel.h"
@interface STPhotoBrowerController : UIViewController
@property(nonatomic,strong)NSMutableArray<STUrlPhotoModel*> * dataSouce;
@property(nonatomic)NSInteger curentIndex;//当前被选中
@property(nonatomic,strong)UIView * curentView;//传入被选中的view，则返回的时候就会缩放到那个位置
@end
