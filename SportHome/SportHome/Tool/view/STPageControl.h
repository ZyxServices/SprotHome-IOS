//
//  STPageControl.h
//  SportHome
//
//  Created by stoneobs on 16/11/9.
//  Copyright © 2016年 zhaowei. All rights reserved.
// 自定义pagecontrol

#import <UIKit/UIKit.h>

@interface STPageControl : UIControl
@property(nonatomic) NSInteger currentPage;            // default is 0. value pinned to
@property(nonatomic) BOOL autoMoveWithScrolling;    // 滑动的时候自动更新pagecontrol当前值
@property(nonatomic) BOOL isShowAnimation;    // 默认显示动画
@property(nonatomic,strong) UIColor *pageIndicatorTintColor;//普通状态颜色
@property(nonatomic)CGSize pageSize;//普通状态大小，有默认值
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor ; //选择后状态颜色
@property(nonatomic)CGSize currentPageSize;//选择状态大小，有默认值

-(instancetype)initWithPages:(NSInteger)Pages;
@end
