//
//  SHHomeViewController.m
//  SportHome
//
//  Created by stoneobs on 16/11/9.
//  Copyright © 2016年 zhaowei. All rights reserved.
//

#import "SHHomeViewController.h"
#import "STPageControl.h"
#import "STAdvertingScrollView.h"
@interface SHHomeViewController ()

@end

@implementation SHHomeViewController
#pragma mark --vc生命周期
-(void)viewDidLoad
{
    [super viewDidLoad];
    STPageControl * test = [[STPageControl alloc] initWithPages:4];
    test.centerY = self.view.centerY;
    [self.tableView addSubview:test];
   __block NSInteger num = 0;
     test.pageIndicatorTintColor = [UIColor grayColor];
    test.currentPageIndicatorTintColor = [UIColor redColor];
   
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        num = num+1 ;
        test.currentPage = num%4;
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideNavagetionbar];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self showNavagationbar];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


@end
