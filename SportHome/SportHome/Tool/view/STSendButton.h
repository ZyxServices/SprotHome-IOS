//
//  STSendButton.h
//  STTools
//
//  Created by stoneobs on 16/3/17.
//  Copyright © 2016年 stoneobs. All rights reserved.
//  发送验证码button，可以倒计时

#import <UIKit/UIKit.h>
typedef void (^STSendButtonACTION)();
@interface STSendButton : UIButton

@property(nonatomic)NSInteger time;
-(instancetype)initWithFrame:(CGRect)frame andWithTime:(NSInteger)time;
//结束timer，场景是用于点击这个but判断有些东西是否输入，可以停止timer的计时。
-(void)timerEnding;
-(void)setActionBlock:(STSendButtonACTION)actionBlock;
@end
