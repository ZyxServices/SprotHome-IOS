//
//  STButton.h
//  STTools
//
//  Created by stoneobs on 16/4/5.
//  Copyright © 2016年 stoneobs. All rights reserved.
// but工厂

#import <UIKit/UIKit.h>
#import "UIView+Direction.h"
//#import "STSendButton.h"
//#import "STButton.h"
@class STButton;
typedef void (^SACTION)(STButton* sender);
@interface STButton : UIButton
@property(nonatomic,copy)SACTION clicAction;
@property(nonatomic,strong)NSString * badgeValue;
@property(nonatomic,strong)NSString * urlString;//用来标志but的网络图片
-(instancetype)initWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titlecolor titleFont:(CGFloat)fongtsize cornerRadius:(CGFloat)radiu backgroundColor:(UIColor*)color backgroundImage:(UIImage*)image image:(UIImage*)image ;
+(STButton*)logoutBut;
+(STButton*)registerBut;
-(void)setClicAction:(SACTION)clicAction;
-(void)setBrderWidth:(CGFloat)width borderColor:(UIColor*)borderColor;
@end
