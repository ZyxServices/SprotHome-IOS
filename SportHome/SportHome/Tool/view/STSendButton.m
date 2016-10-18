//
//  STSendButton.m
//  STTools
//
//  Created by stoneobs on 16/3/17.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 

#import "STSendButton.h"
@interface STSendButton()
@property(nonatomic,strong)NSTimer * timer;
/**
 *  暂存time值
 */
@property(nonatomic,copy)STSendButtonACTION action;
@property(nonatomic)NSInteger  saveTime;
@end
@implementation STSendButton
- (instancetype)initWithFrame:(CGRect)frame andWithTime:(NSInteger)time
{
    self = [super initWithFrame:frame];
    if (self) {
        self.time=time;
        self.saveTime=time;
        self.backgroundColor=[UIColor grayColor];
        self.layer.cornerRadius=5;
        self.clipsToBounds=YES;
        [self addTarget:self action:@selector(butAction) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return self;
}
-(void)timerAction
{
    self.time--;
    if (self.time==0) {
        [self.timer invalidate];
        self.userInteractionEnabled=YES;
        self.time=self.saveTime;
        [self setTitle:@"重新发送" forState:UIControlStateNormal];
        [self addTarget:self action:@selector(butAction) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        NSString * str =@"秒";
        self.userInteractionEnabled=NO;
        [self setTitle:[[NSString stringWithFormat:@"%lu",self.time ] stringByAppendingString:str]forState:UIControlStateNormal];
    }


}
-(void)setActionBlock:(STSendButtonACTION)actionBlock
{
    if (actionBlock) {
        self.action=actionBlock;
    }
}
-(void)butAction
{
    [self timerBegin];
     self.action();
 
   
}
-(void)timerBegin
{
    self.timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.userInteractionEnabled=NO;

}
-(void)timerEnding
{
    [self.timer invalidate];
    self.userInteractionEnabled=YES;
}
@end
