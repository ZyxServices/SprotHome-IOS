//
//  STTextView.m
//  lover
//
//  Created by stoneobs on 16/4/28.
//  Copyright © 2016年 stoneobs. All rights reserved.
//
//kvo监听无效，
#import "STTextView.h"
#define RGB(v)     [UIColor colorWithRed:((float)((v & 0xFF0000) >> 16))/255.0 green:((float)((v & 0xFF00) >> 8))/255.0  blue:((float)(v & 0xFF))/255.0 alpha:1]
#define LVSecendTextColor RGB(0x999999)
#define LVFirstTextColor RGB(0x434343)
@interface STTextView()<UITextViewDelegate>
@property(nonatomic,strong)UILabel * label;

@end
@implementation STTextView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.font=[UIFont systemFontOfSize:15];
        self.textColor=LVFirstTextColor;
        
        [self getTheNotifacation:@"UITextViewTextDidChangeNotification"];
        
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self getTheNotifacation:@"UITextViewTextDidChangeNotification"];
    self.font=[UIFont systemFontOfSize:15];
    self.textColor=LVFirstTextColor;
}

-(void)setText:(NSString *)text {
    [super setText:text];
    self.label.hidden = YES;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    if (placeholder) {
        [self.label removeFromSuperview];
        self.label =[[UILabel alloc]initWithFrame:CGRectMake(12, 3, self.right-24, 29)];
        self.label .numberOfLines=0;
        self.label .text=placeholder;
        self.label .textColor=LVSecendTextColor;
        self.label.font=[UIFont systemFontOfSize:18];
        self.label .userInteractionEnabled=NO;
        
        [self addSubview:self.label ];
    }
    
}
#pragma mark --接受通知和处理
-(void)getTheNotifacation:(NSString*)notifacationName
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReciveNotifacationAction:) name:notifacationName object:nil];
    
}
-(void)didReciveNotifacationAction:(NSNotification*)object
{
    if (self.text.length>0) {
        self.label.hidden=YES;
    }
    else
    {
        self.label.hidden=0;
    }
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
