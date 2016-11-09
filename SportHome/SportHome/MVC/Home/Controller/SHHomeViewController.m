//
//  SHHomeViewController.m
//  SportHome
//
//  Created by stoneobs on 16/11/9.
//  Copyright © 2016年 zhaowei. All rights reserved.
//

#import "SHHomeViewController.h"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController
#pragma mark --vc生命周期
-(void)viewDidLoad
{
    [super viewDidLoad];
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
