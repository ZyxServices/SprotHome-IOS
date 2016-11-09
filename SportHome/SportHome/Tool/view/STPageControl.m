//
//  STPageControl.m
//  SportHome
//
//  Created by stoneobs on 16/11/9.
//  Copyright © 2016年 zhaowei. All rights reserved.
//  如果没有设置颜色，选中默认橘色，未选中默认白色

#import "STPageControl.h"
#import "UIView+Direction.h"
@interface STPageControl()
@property(nonatomic) NSInteger numberOfPages;          // default is 0
@end
@implementation STPageControl

-(instancetype)initWithPages:(NSInteger)numberOfPages
{

    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, 10*numberOfPages + 5 * (numberOfPages-1), 18);
        self.centerX = SCREEN_WIDTH/2;
        self.numberOfPages = numberOfPages;
        _currentPage = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setNumberOfPages:(NSInteger)numberOfPages
{

    for (NSInteger i =0; i<numberOfPages; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i*10 + 5* i, 1, 10, 10)];
        view.backgroundColor = [UIColor whiteColor];
        view.tag = i;
        view.layer.cornerRadius = 5;
        [self addSubview:view];
    }
    _numberOfPages = numberOfPages;
}
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    for (UIView * view in self.subviews) {
        if (view.tag!=self.currentPage) {
            //未选中状态
            
            view.backgroundColor = pageIndicatorTintColor;
        }
        else
        {
            //选中状态
            if (_currentPageIndicatorTintColor) {
                view.backgroundColor = _currentPageIndicatorTintColor;
            }
            else
            {
            
                view.backgroundColor = [UIColor orangeColor];
            }
        
        }
    }
    _pageIndicatorTintColor = pageIndicatorTintColor;
}
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{

    for (UIView * view in self.subviews) {
        if (view.tag==self.currentPage) {
            view.backgroundColor = currentPageIndicatorTintColor;
        }
        else
        {
            //未选中状态
            if (_pageIndicatorTintColor) {
                view.backgroundColor = _pageIndicatorTintColor;
            }
            else
            {
                
                view.backgroundColor = [UIColor whiteColor];
            }
        
        }
    }
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
-(void)setCurrentPage:(NSInteger)currentPage
{
    for (UIView * view in self.subviews) {
        if (view.tag==currentPage) {
            //选中状态
            if (_currentPageIndicatorTintColor) {
                view.backgroundColor = _currentPageIndicatorTintColor;
            }
            else
            {
                
                view.backgroundColor = [UIColor orangeColor];
            }
        }
        else
        {
            //未选中状态
            if (_pageIndicatorTintColor) {
                view.backgroundColor = _pageIndicatorTintColor;
            }
            else
            {
                
                view.backgroundColor = [UIColor whiteColor];
            }
            
        }
    }
    
    _currentPage = currentPage;
}

-(void)drawRect:(CGRect)rect
{

    NSLog(@"jiazai");
   // [super drawRect:rect];
}
@end
