//
//  UIView+Direction.h
//  lover
//
//  Created by stoneobs on 16/1/18.
//  Copyright © 2016年 stoneobs. All rights reserved.
//  view的可计算属性，所以可以用property

#import <UIKit/UIKit.h>
#import "STButton.h"
#import "STLabel.h"

@interface UIView (Direction)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
-(void)showTopShodow;
-(void)showBottomShodow;
-(void)showEmptyData;//添加默认图
-(void)hideEmptyData;//隐藏默认图
@end
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREEN_FRAME  [UIScreen mainScreen].bounds
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define RGB(v)     [UIColor colorWithRed:((float)((v & 0xFF0000) >> 16))/255.0 green:((float)((v & 0xFF00) >> 8))/255.0  blue:((float)(v & 0xFF))/255.0 alpha:1]


#define BACKROUND_COLOR  RGB(0xF7F7F7)
#define BannerImage [UIImage imageNamed:@"banner_placeholder"]
#define PeopleImage [UIImage imageNamed:@"user_placeholder"]
#define GetWidthForm6(v) v/375.0*SCREEN_WIDTH
#define GetHeightForm6(v) v/375.0*SCREEN_HEIGHT
#define FirstTextColor RGB(0x333333)
#define SecendTextColor RGB(0x666666)
#define ThirdTextColor RGB(0x999999)
#define LINE_COLOR  RGB(0xE5E5E5)
#define  THEME_RED      RGB(0xD80204)

#define  Font13       [UIFont systemFontOfSize:13]
#define  Font14       [UIFont systemFontOfSize:14]
#define  Font15       [UIFont systemFontOfSize:15]
//#define  THEME_PINK      RGB(0xFF82AB)
//#define  THEME_BLUE     RGB(0xB2DFEE)
//#define THEME_GREEN RGB(0x43c56A)
