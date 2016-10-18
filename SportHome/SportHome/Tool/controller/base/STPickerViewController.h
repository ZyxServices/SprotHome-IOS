//
//  STPickerVIewController.h
//  SportClub
//
//  Created by stoneobs on 16/8/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 此vc用来做弹出view的一个模态控制器，默认有时间和地区选择器，当传入自定义view时，一样可以弹出，调用不同初始方法即可。
#import <UIKit/UIKit.h>
typedef void (^STPickerVIewControllerAREPICKER)(NSString *finshString,NSString * city,NSString * provence);
typedef void (^STPickerVIewControllerDATEPICKER)(NSString *finshString,NSDate * date);
#import <UIKit/UIKit.h>
@class STPickerVIewController;
@interface STPickerViewController : UIViewController
/**
 *  默认是dateicker时候有效，否则无效
 */
@property (nonatomic) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDate *minimumDate; // datepikcer 有效，否则忽略
@property (nonatomic, strong) NSDate *maximumDate;
/**
 *  是否开启弹性动画
 */
@property(nonatomic)BOOL isSpringAnimation;
/**
 *  是否显示确定和取消按钮,在传入view时，默认不显示
 */
@property(nonatomic)BOOL isShowConfirm;
/**
 *  弹出框的高度
 */
@property(nonatomic)CGFloat  bottomHeight;
@property(nonatomic,copy)STPickerVIewControllerAREPICKER areaPickerBlock;
@property(nonatomic,copy)STPickerVIewControllerDATEPICKER datePickerBlock;
-(void)setDatePickerBlock:(STPickerVIewControllerDATEPICKER)datePickerBlock;
-(void)setAreaPickerBlock:(STPickerVIewControllerAREPICKER)areaPickerBlock;
/**
 *  初始化时间picker,和setDatePickerBlock回调
 *
 *  
 */
-(instancetype)initWithDefualtDatePicker;
/**
 *  初始化默认地区选择器，和setAreaPickerBlock回调
 *
 *
 */
-(instancetype)initWithDefualtAreaPicker;
//
-(instancetype)initWithPikcerView:(NSArray<UIView*>*)views;//自定义弹出view,可以多个，如果传入的view是没有点击事件的，那么点击view也会让模态的vc消失

@end
