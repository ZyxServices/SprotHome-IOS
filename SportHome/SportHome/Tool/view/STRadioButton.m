//
//  STRadioButton.m
//  STTools
//
//  Created by stoneobs on 16/3/17.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STRadioButton.h"
@interface STRadioButton()
@property(nonatomic,strong)NSMutableArray<UIButton*>* butArray;
@end
@implementation STRadioButton
-(instancetype)initWithRadio:(NSArray <NSString*>*)array andWithFrame:(CGRect)frame

{
    if (self=[super initWithFrame:frame]) {
        NSInteger num =array.count;
        self.count=num;
        self.butArray=[[NSMutableArray alloc]init];
        for (int i=0; i<num; i++) {
            UIButton * but =[[UIButton alloc]initWithFrame:CGRectMake(i*frame.size.width/array.count, 10, frame.size.width/array.count, frame.size.height-20)];
            [but setImage:[UIImage imageNamed:@"anniu_xianzhong"] forState:UIControlStateSelected];
            [but setImage:[UIImage imageNamed:@"anniu_weixianzhong"] forState:UIControlStateNormal];
            [but setTitle:array[i] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(clic:) forControlEvents:UIControlEventTouchUpInside];
            but.tag=i;
            but.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 6);
            [but.titleLabel setFont:[UIFont systemFontOfSize:15]];
            // [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self addSubview:but];
            [self.butArray addObject:but];
            
        }
    }
    return self;
}
-(void)clic:(id)sender
{
    UIButton * but=sender;
    int num =(int)[sender tag];
    for (int i=0; i<num; i++) {
        self.butArray[i].selected=NO;
        
    }
    for (int k=num; k<self.count; k++) {
        self.butArray[k].selected=NO;
    }
    self.checked=self.butArray[num].titleLabel.text;
    but.selected=!but.selected;
    NSLog(@"%@",self.checked);
}
-(void)setMakenumOfarrayChecked:(NSInteger)makenumOfarrayChecked
{
    UIButton * but =self.butArray[makenumOfarrayChecked];
    but.selected=YES;
}
@end
