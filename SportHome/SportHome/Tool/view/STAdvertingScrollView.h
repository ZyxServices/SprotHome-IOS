//
//  STAdvertingScrollView.h
//  STTools
//
//  Created by stoneobs on 16/3/17.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 轮播广告，默认时间两秒，有两种模式，上下文字，左右图片

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ScrollStyle)
{
    ScrollStyleImage,
    ScrollStyleString,
    ScrollStyleDefult=ScrollStyleImage,
    
};
@interface STAdvertingScrollView : UIScrollView
@property(nonatomic)BOOL showNumber;
/**
 *  是否允许自动轮播 默认是no
 */
@property(nonatomic)BOOL canAutoScroll;
/**
 *  传出点击事件，获取点击的tag
 */
@property(nonatomic,copy)void (^action)(NSInteger num);
/**
 *  设置but的titleedge，只有在文字轮播模式下才有效
 */
@property(nonatomic)UIEdgeInsets  titleInset;
/**
 *  设置but的titlefont，只有在文字轮播模式下才有效
 */
@property(nonatomic)CGFloat  titleFont;
/**
 *  设置but的titleColor，只有在文字轮播模式下才有效
 */
@property(nonatomic,strong)UIColor * titleColor;
/**
 *  轮播方式，默认是图片
 */
@property(nonatomic)ScrollStyle scrollStyle;
/**
 *  设置滑动事件间隔
 */
@property(nonatomic)NSTimeInterval time;

/**
 *  初始化控件
 *
 *  @param frame <#frame description#>
 *  @param array array 必须是数组，否则datousou是nil,数组中放的是字符传
 *
 * 
 */
-(instancetype)initWithFrame:(CGRect)frame  andWithArray:(NSArray<NSString*>*)array;

@end
