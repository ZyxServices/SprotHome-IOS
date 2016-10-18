//
//  STSegementButton.m
//  lover
//
//  Created by Cymbi on 16/4/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STSegementButton.h"
#import "UIView+Direction.h"
@interface STSegementButton()

@property(nonatomic,strong)NSMutableArray<UIButton*> * butArray;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UIView * lineSelectedView;
@property(nonatomic)NSInteger selectedNum;
@end
@implementation STSegementButton
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSArray *)titles
{
    if (self=[super initWithFrame:frame]) {
        self.butArray=[NSMutableArray new];
        
        for (int i=0; i<titles.count; i++) {
            UIButton * but =[[UIButton alloc]initWithFrame:CGRectMake(i*self.width/titles.count, 2,self.width/titles.count , self.height-5)];
            if (i==0) {
                but.selected=YES;
            }
            but.tag=i;
            but.backgroundColor=[UIColor whiteColor];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
            [but setTitle:titles[i] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(clicAction:) forControlEvents:UIControlEventTouchUpInside];
            but.titleLabel.font=[UIFont systemFontOfSize:15];
            [self.butArray addObject:but];
            
            
            [self addSubview:but];
        }
        self.lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.height-3, self.width, 3)];
        self.lineView.backgroundColor=[UIColor redColor];
        [self addSubview:self.lineView];
        self.lineSelectedView=[[UIView alloc]initWithFrame:CGRectMake(0, self.height-3, self.width/titles.count, 3)];
        self.lineSelectedView.backgroundColor=[UIColor blackColor];
        [self addSubview:self.lineSelectedView];
        self.lineColor=[UIColor whiteColor];
        self.lineSelectedColor=THEME_RED;
        self.butTitleSelectedColor=THEME_RED;
        self.butTitleColor=FirstTextColor;
    }
    return self;
}
-(void)setLineColor:(UIColor *)lineColor
{
    if (lineColor) {
        self.lineView.backgroundColor=lineColor;
        _lineColor=lineColor;
    }
}
-(void)setLineSelectedColor:(UIColor *)lineSelectedColor
{
    if (lineSelectedColor) {
        _lineSelectedColor=lineSelectedColor;
        self.lineSelectedView.backgroundColor=lineSelectedColor;
    }
}
-(void)setButTitleColor:(UIColor *)butTitleColor
{
    if (butTitleColor) {
        for (int i=0; i<_butArray.count; i++) {
            
            [_butArray[i] setTitleColor:butTitleColor forState:UIControlStateNormal];
            
        }
        _butTitleColor=butTitleColor;
    }
    
    
}
-(void)setButTitleSelectedColor:(UIColor *)butTitleSelectedColor
{
    if (butTitleSelectedColor) {
        _butTitleSelectedColor=butTitleSelectedColor;
        for (int i=0; i<_butArray.count; i++) {
            
            [_butArray[i] setTitleColor:butTitleSelectedColor forState:UIControlStateSelected];
            
            
        }
    }
}
-(void)setAction:(STSegementButtonCLICACTION)action
{
    if (action) {
        _action=action;
    }
}
-(void)clicAction:(STSegementButton*)sender
{
    if (sender.tag!=_selectedNum) {
        sender.selected=!sender.selected;
    }
    
    for (int i=0; i<_butArray.count; i++) {
        if (i!=sender.tag) {
            _butArray[i].selected=NO;
        }
    }
    [UIView animateWithDuration:0.15 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.lineSelectedView.frame=CGRectMake(sender.tag*self.width/_butArray.count, self.height-3, self.width/_butArray.count, 3);
        
    } completion:^(BOOL finished) {
        
    }];
    
    if (self.action) {
        self.action(sender);
        
    }
    _selectedNum=sender.tag;
}
@end
