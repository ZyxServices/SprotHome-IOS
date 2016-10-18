//
//  STAdvertingScrollView.m
//  STTools
//
//  Created by stoneobs on 16/3/17.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 广告栏,可以左右图片滚动，上下文字滚动

#import "STAdvertingScrollView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface STAdvertingScrollView()<UIScrollViewDelegate>
/**
 *  数据源
 */
/**
 *  timer
 */
@property(nonatomic,strong)NSArray * dataSouce;
@property(nonatomic,strong)NSTimer * timer;
/**
 *  因为cgpointzero是（0.64）所以偏移量会有问题
 */
@property(nonatomic)CGPoint ypoint;
@end
@implementation STAdvertingScrollView

-(instancetype)initWithFrame:(CGRect)frame andWithArray:(NSArray<NSString *> *)array
{
    if (self=[super initWithFrame:frame]) {
        self.dataSouce=array;
        _titleInset=UIEdgeInsetsZero;
        self.scrollStyle=ScrollStyleDefult;
        _ypoint=CGPointMake(0, 0);
        self.pagingEnabled=YES;
        self.canAutoScroll=NO;
        self.alwaysBounceHorizontal=YES;
        self.scrollEnabled=YES;
        self.delegate=self;
        self.showsHorizontalScrollIndicator=NO;
        
    }
    return self;
}
-(void)setTime:(NSTimeInterval)time
{
    if (time) {
        _time=time;
        [self.timer invalidate];
        self.timer=[NSTimer timerWithTimeInterval:time target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];

    }
}
#pragma mark -----style 设置but 的
-(void)setTitleInset:(UIEdgeInsets)titleInset
{
        _titleInset=titleInset;
    if (self.scrollStyle==ScrollStyleString) {
        for (UIButton * but in [self subviews]) {
            but.titleEdgeInsets=titleInset;
        }
    }

}
-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor=titleColor;
    if (self.scrollStyle==ScrollStyleString) {
        for (UIButton * but in [self subviews]) {
            [but setTitleColor:titleColor forState:UIControlStateNormal];
        }
    }
}
-(void)setTitleFont:(CGFloat)titleFont
{
    _titleFont=titleFont;
    if (self.scrollStyle==ScrollStyleString) {
        for (UIButton * but in [self subviews]) {
            [but.titleLabel setFont:[UIFont systemFontOfSize:titleFont]];
        }
    }
}
#pragma mark -----style 在这里加载了各种情况下的but
-(void)setScrollStyle:(ScrollStyle)scrollStyle
{
    if (scrollStyle==ScrollStyleString) {
        for (UIView * view in [self subviews]) {
            [view removeFromSuperview];
        }
        _scrollStyle=scrollStyle;
        self.showsVerticalScrollIndicator=NO;
        self.alwaysBounceHorizontal=NO;
        self.alwaysBounceVertical=YES;
        self.contentSize=CGSizeMake(0, self.frame.size.height*self.dataSouce.count) ;
        
        for (int i=0; i<self.dataSouce.count; i++) {
            UIButton * but=[[UIButton alloc]initWithFrame:CGRectMake(0, self.frame.size.height*i, self.frame.size.width, self.frame.size.height)];
            [but setTitle:self.dataSouce[i] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
            but.tag=i;
            if (!UIEdgeInsetsEqualToEdgeInsets(_titleInset, UIEdgeInsetsZero)) {
                but.titleEdgeInsets=_titleInset;
            }
            if (_titleColor) {
                [but setTitleColor:_titleColor forState:UIControlStateNormal];
            }
            if (_titleFont) {
                [but.titleLabel setFont:[UIFont systemFontOfSize:_titleFont]];
            }
            [self addSubview:but];
            
        }
    }
    else
    {
        for (UIView * view in [self subviews]) {
            [view removeFromSuperview];
        }
        _scrollStyle=scrollStyle;
        self.showsVerticalScrollIndicator=NO;
        self.alwaysBounceHorizontal=YES;
        self.alwaysBounceVertical=NO;
        self.contentSize=CGSizeMake(SCREEN_WIDTH*self.dataSouce.count, 0) ;
        NSLog(@"%f",self.contentSize.width);
        for (int i=0; i<self.dataSouce.count; i++) {
            UIButton * but=[[UIButton alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height)];
            [but setBackgroundImage:[UIImage imageNamed:self.dataSouce[i]] forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage imageNamed:self.dataSouce[i]] forState:UIControlStateSelected];
            [but addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
            but.tag=i;
            [self addSubview:but];
            
        }
    }
    
}
#pragma mark -----是否自动滚动
-(void)setCanAutoScroll:(BOOL)canAutoScroll
{
    if (canAutoScroll) {
        _timer=nil;
        _canAutoScroll=canAutoScroll;
        
        _timer=[NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
        
    }
    else{
        _timer=nil;
    }
}

#pragma mark -----timer事件
-(void)timerAction{
    
    if (self.scrollStyle==ScrollStyleDefult) {
        CGPoint offSet = self.contentOffset;
        offSet.x += self.frame.size.width;
        
        if (offSet.x >= self.frame.size.width * _dataSouce.count) {
            offSet.x = 0;
            
        }
        [self setContentOffset:offSet animated:YES];
    }
    
    else{
        
        _ypoint.y += self.frame.size.height;
        
        if (_ypoint.y >= self.frame.size.height * _dataSouce.count) {
            _ypoint.y = 0;
            
        }
        [self setContentOffset:_ypoint animated:YES];

    
    
    }
    
}
#pragma mark -----数据源
-(void)setDataSouce:(NSArray *)dataSouce
{
    if (dataSouce&&[dataSouce[0] isKindOfClass:[NSString class]]) {
        _dataSouce=dataSouce;
    }
    else{
        NSLog(@"轮播数组必须是字符串");
        _dataSouce=nil;
    }
    
}

#pragma mark -----传出去的点击事件
-(void)butAction:(id)sender
{
    
    UIButton * but=sender;
    NSLog(@"%lu",but.tag);
    if (self.action) {
        self.action(but.tag);
        
    }
    
}
#pragma mark -----拖拽重新纪时间
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer=[NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}
@end
