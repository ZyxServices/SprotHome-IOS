//
//  UIView+Direction.m
//  lover
//
//  Created by stoneobs on 16/1/18.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "UIView+Direction.h"

@implementation UIView (Direction)
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
-(void)showTopShodow
{
    self.layer.shadowOffset = CGSizeMake(0, -0.8);
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = .5f;
    CGRect shadowFrame = self.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath
                            bezierPathWithRect:shadowFrame].CGPath;
    self.layer.shadowPath = shadowPath;
    
    
}
-(void)showBottomShodow
{
    
    self.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = .5f;
    CGRect shadowFrame = self.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath
                            bezierPathWithRect:shadowFrame].CGPath;
    self.layer.shadowPath = shadowPath;
    
}
-(void)showEmptyData
{
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    bgView.tag = 10000;
    bgView.centerY = SCREEN_HEIGHT/2-64;
    bgView.centerX = SCREEN_WIDTH/2;
    bgView.backgroundColor = BACKROUND_COLOR;
    [self addSubview:bgView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_talk"]];
    imgView.frame = CGRectMake(0, 0, 200, 180);
    [bgView addSubview:imgView];
    
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, 200, 20)];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.textColor = SecendTextColor;
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.text = @"暂无数据";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:tipLabel];
    
    

    
    
}
-(void)hideEmptyData
{
    
    UIView * view = [self viewWithTag:10000];
    [view removeFromSuperview];
    
}
@end
