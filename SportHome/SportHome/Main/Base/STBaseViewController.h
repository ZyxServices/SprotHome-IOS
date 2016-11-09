//
//  BaseViewController.h
//  lover
//
//  Created by stoneobs on 16/1/18.
//  Copyright © 2016年 stoneobs. All rights reserved.
//
/// 改进：将picker抽出，放到一个新的vc中。将下方弹出框抽出，新vc。
#import <UIKit/UIKit.h>
//#import "UIView+Direction.h"
//alert确认回调
typedef void(^ALERTBLOCK)(NSString* name);
//actionsheet 回调
typedef void (^ACTIONBLOCK)();
//图片选择回调
typedef void (^IMAGEPICKER) (UIImage * image);
@interface STBaseViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//头部左右导航视图
-(void)setLeftTitle:(NSString*)title;
-(void)setLeftImage:(UIImage *)image;
-(void)setLeftImage:(UIImage *)image andwithTitle:(NSString*)title;
-(void)setRightTitle:(NSString*)title;
-(void)setRightTitle:(NSString *)title titleColor:(UIColor*)color;
-(void)setRightImage:(UIImage*)image;
-(void)setRightImage:(UIImage*)image andwithTitle:(NSString*)title;
-(void)setLeftView:(UIView*)view;
-(void)setRightView:(UIView*)view;
-(void)rightBarAction:(id)sender;
-(void)leftBarAction:(id)sender;
// UIAlertController
-(void)showAlert:(NSString*)message;
-(void)showAlert:(NSString *)message andWithBlock:(ALERTBLOCK)finsh;
-(void)showAlertCancelAndConfirm:(NSString*)message andWithBlock:(ALERTBLOCK)finsh;//默认取消和确认按钮，可以通过finsh中的string来判断
-(void)showAlertCustomTitleOne:(NSString *)one Two:(NSString*)two  message:(NSString*)message andWithBlock:(ALERTBLOCK)finsh;
-(void)showActionSheet:(NSArray<NSString*>*)strArray andWithBlock:(ACTIONBLOCK)test;
//直接弹出图片选择控制器
-(void)showDefultImagePicker:(IMAGEPICKER)pickerBlock;
//隐藏和显示导航栏。
-(void)showNavagationbar;
-(void)hideNavagetionbar;


//播放声音
//-(void)playOpenVoice;
@end
