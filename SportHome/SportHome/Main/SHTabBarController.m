//
//  SHTabBarController.m
//  SportHome
//
//  Created by stoneobs on 16/10/18.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "SHTabBarController.h"
#import "STNavigationController.h"
#import "SHHomeViewController.h"
#import "SHCommunityController.h"
#import "SHRecordViewController.h"
#import "SHMyselfController.h"
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
@interface SHTabBarController ()

@end

@implementation SHTabBarController
-(instancetype)init
{
    if (self = [super init]) {
        [self addChildVc:[SHHomeViewController new] title:@"主页" image:nil selectedImage:nil];
        [self addChildVc:[SHRecordViewController new] title:@"记录" image:nil selectedImage:nil];
        [self addChildVc:[SHCommunityController new] title:@"社交" image:nil selectedImage:nil];
        [self addChildVc:[SHMyselfController new] title:@"我的" image:nil selectedImage:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11.0], NSFontAttributeName,  RGB(0x33333), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11.0], NSFontAttributeName,  RGB(0xd80204), NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    STNavigationController *nav = [[STNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
}

@end
