//
//  STImagePickerController.h
//  STTools
//
//  Created by stoneobs on 16/10/9.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 这是可以多选的imagepicker

#import "STNavigationController.h"
#import "STPhotoModel.h"
typedef void(^STImagePickerControllerFinshed)(NSArray<STPhotoModel*> *array);
@interface STImagePickerController : STNavigationController

/**
 导航栏颜色
 */
@property(nonatomic,strong)UIColor * navagationBarTintColor;

/**
 完成回调，是包含一组stphotomodel的数组
 */
@property(nonatomic,copy)STImagePickerControllerFinshed  finshedBlock;
-(void)setFinshedBlock:(STImagePickerControllerFinshed)finshedBlock;
-(instancetype)initWithDefultRootVC;
@end
