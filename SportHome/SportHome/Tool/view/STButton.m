//
//  STButton.m
//  STTools
//
//  Created by stoneobs on 16/4/5.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STButton.h"
//#import "STSendButton.h"
@implementation STButton
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titlecolor titleFont:(CGFloat)fontsize cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)backcolor backgroundImage:(UIImage *)backgroundimage image:(UIImage *)image
{
    if (self=[super init]) {
        self.frame=frame;
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titlecolor forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:fontsize]];
        self.layer.cornerRadius=radius;
        self.clipsToBounds=YES;
        self.backgroundColor=backcolor;
        [self setBackgroundImage:backgroundimage forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
        [self addTarget:self action:@selector(clicAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
//添加badgeValue
-(void)setBadgeValue:(NSString *)badgeValue
{
    if (badgeValue) {
        if (badgeValue.length>2) {
            badgeValue=@"99";
        }
        UIButton * test =[[UIButton alloc] initWithFrame:CGRectMake(self.width-7, -7, 14, 14)];
        [test setBackgroundImage:[UIImage imageNamed:@"icon_Number"] forState:UIControlStateNormal];
        [test setTitle:badgeValue forState:UIControlStateNormal];
        [test setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        test.titleLabel.font=[UIFont systemFontOfSize:10];
        test.layer.cornerRadius=7;
        test.clipsToBounds=YES;
        self.clipsToBounds=NO;
        [self addSubview:test];
        
    }
}
//边框 一般0.3 黑色
-(void)setBrderWidth:(CGFloat)width borderColor:(UIColor*)borderColor
{
    self.layer.borderColor=borderColor.CGColor;
    self.layer.borderWidth=width;
}
+(STButton*)logoutBut
{
    STButton* but= [[[self class] alloc]initWithFrame:CGRectZero title:@"退出登录" titleColor:[UIColor whiteColor] titleFont:15 cornerRadius:10 backgroundColor:[UIColor darkGrayColor] backgroundImage:nil image:nil];
    
    return but;
}
+(STButton*)registerBut
{
    STButton* but= [[[self class] alloc]initWithFrame:CGRectZero title:@"注册" titleColor:[UIColor whiteColor] titleFont:15 cornerRadius:10 backgroundColor:[UIColor redColor] backgroundImage:nil image:nil];
    
    
    return but;
}
-(void)setClicAction:(SACTION)clicAction
{
    if (clicAction) {
        _clicAction=clicAction;
    }
}
-(void)clicAction:(STButton*)sender
{
    if (self.clicAction) {
        self.clicAction(sender);
    }
}
@end
