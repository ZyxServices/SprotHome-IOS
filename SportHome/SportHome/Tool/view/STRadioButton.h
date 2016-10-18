//
//  STRadioButton.h
//  STTools
//
//  Created by stoneobs on 16/3/17.
//  Copyright © 2016年 stoneobs. All rights reserved.
//单选按钮控件，上面控件大小写死了，这是不足

#import <UIKit/UIKit.h>

@interface STRadioButton : UIView
/**
 *  选中的单选按钮的值
 */
@property(nonatomic,strong)NSString * checked;
@property(nonatomic)NSInteger makenumOfarrayChecked;
@property(nonatomic)NSInteger count;
-(instancetype)initWithRadio:(NSArray<NSString*>*)array andWithFrame:(CGRect)frame;

@end
