//
//  SHHomeHeaderView.m
//  SportHome
//
//  Created by stoneobs on 16/11/9.
//  Copyright © 2016年 zhaowei. All rights reserved.
//

#import "SHHomeHeaderView.h"
#import "STAdvertingScrollView.h"
#import "SHHomeViewController.h"
@interface SHHomeHeaderView()
@property(nonatomic,weak)SHHomeViewController * VC;
@end
@implementation SHHomeHeaderView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubViews];
        [self loadRequest];
    }
    return self;
}
-(void)initSubViews
{
    


}
-(void)loadRequest
{

}
@end
