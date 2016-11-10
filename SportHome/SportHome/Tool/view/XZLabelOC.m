//
//  XZLabelOC.m
//  SportHome
//
//  Created by zhaowei on 10/11/16.
//  Copyright © 2016年 zhaowei. All rights reserved.
//

#import "XZLabelOC.h"
IB_DESIGNABLE
@implementation XZLabelOC


- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius  = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor{
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}
@end
