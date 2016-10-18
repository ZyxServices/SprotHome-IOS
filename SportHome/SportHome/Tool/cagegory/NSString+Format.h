//
//  NSString+Format.h
//  STTools
//
//  Created by stoneobs on 16/10/8.
//  Copyright © 2016年 stoneobs. All rights reserved.
//这是字符串格式判断，比如需要判断是否中文，是否纯数字，正则表达式，动态算高度，等

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Format)

/**
 是否中文

 */
- (BOOL)isChinese;

/**
 是否纯数字

 */
- (BOOL)isPureNumandCharacters;
/**
 *  驼峰转下划线（loveYou -> love_you）
 */
- (NSString *)ST_underlineFromCamel;
/**
 *  下划线转驼峰（love_you -> loveYou）
 */
- (NSString *)ST_camelFromUnderline;
/**
 * 首字母变大写
 */
- (NSString *)ST_firstCharUpper;
/**
 * 首字母变小写
 */
- (NSString *)ST_firstCharLower;
/**
 *  返回字符串高度，规定宽，规定字体大小
 */

-(CGFloat)heigthWithwidth:(CGFloat)width font:(CGFloat)font;
-(CGFloat)widthWithheight:(CGFloat)height font:(CGFloat)font;

/**
 时间字符转转date
 formatStr  yyyy-MM-dd HH:mm:ss
            yyyy-MM-dd
            
 */
- (NSDate *)dateByFormatString:(NSString *)formatStr;
@end
