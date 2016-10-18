//
//  SHHeaderReusableView.m
//  SportHome
//
//  Created by stoneobs on 16/10/18.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "SHHeaderReusableView.h"
#import "UIView+Direction.h"
@interface SHHeaderReusableView()
@property(nonatomic,strong)STLabel * titleLable;
@end
@implementation SHHeaderReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BACKROUND_COLOR;
        self.titleLable = [[STLabel alloc] initWithFrame:CGRectMake(5, 2, 300, 20) text:@"hello" textColor:[UIColor blackColor] font:15 isSizetoFit:NO textAlignment:NSTextAlignmentLeft];
        self.titleLable.font = Font15;
        [self addSubview:self.titleLable];
    }
    return self;
}
-(void)setTitle:(NSString *)title
{
    self.titleLable.text = title;
    _title = title;
    
}
@end
