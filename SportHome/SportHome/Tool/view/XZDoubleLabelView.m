//
//  XZDoubleLabelView.m
//  SportHome
//
//  Created by zhaowei on 10/11/16.
//  Copyright © 2016年 zhaowei. All rights reserved.
//

#import "XZDoubleLabelView.h"

@implementation XZDoubleLabelView

- (instancetype)initWithFrame:(CGRect)frame {
   self =  [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 12)];
        [self addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.alpha = 0.5;
        _titleLabel.textColor = [UIColor whiteColor];
        
        _numsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 10, 70, 12)];
        [self addSubview:_numsLabel];
        _numsLabel.textAlignment = NSTextAlignmentCenter;
        _numsLabel.textColor = [UIColor whiteColor];
    }
    return self;
}
@end
