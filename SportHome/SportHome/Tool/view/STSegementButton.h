//
//  STSegementButton.h
//  lover
//
//  Created by Cymbi on 16/4/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
//   单选按钮segement样式，类似内涵段子上方

#import <UIKit/UIKit.h>
@class STSegementButton;
typedef void (^STSegementButtonCLICACTION)(STSegementButton *sender);
@interface STSegementButton : UIControl
@property(nonatomic,strong)UIColor * lineColor;//未选中线颜色
@property(nonatomic,strong)UIColor * lineSelectedColor;//选中颜色
@property(nonatomic,strong)UIColor * butTitleColor;//标题颜色
@property(nonatomic,strong)UIColor * butTitleSelectedColor;
@property(nonatomic,copy)STSegementButtonCLICACTION action;
-(void)setAction:(STSegementButtonCLICACTION)action;
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSArray*)titles;
@end
