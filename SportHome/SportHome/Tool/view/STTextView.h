//
//  STTextView.h
//  lover
//
//  Created by stoneobs on 16/4/28.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Direction.h"
@interface STTextView : UITextView
@property(nonatomic,strong) IBInspectable NSString * placeholder;
-(void)setText:(NSString *)text;
@end
