//
//  UIImage+tools.h
//  STTools
//
//  Created by stoneobs on 16/4/5.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (tools)
/**
 *  生成颜色图片
 *
 *  @param color 图片颜色
 *  @param size  图片大小
 *
 *  @return return value description
 */
+(UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size;
+(UIImage*)imageWithTwoCode:(NSString*)str andColorred:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+(UIImage*)imageWithDefaultTwoCode:(NSString*)str;
/**
 *  图片圆角
 *
 *  @param image <#image description#>
 *  @param size  <#size description#>
 *  @param r     <#r description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage*)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

@end
