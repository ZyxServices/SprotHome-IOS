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
        [self addChildVc:[SHHomeViewController new] title:@"主页" image:@"tab_home_n" selectedImage:@"tab_home_s"];
        [self addChildVc:[SHRecordViewController new] title:@"记录" image:@"tab__note_n-" selectedImage:@"tab__note_s"];
        [self addChildVc:[SHCommunityController new] title:@"社交" image:@"tab_community_n" selectedImage:@"tab_community_s"];
        [self addChildVc:[SHMyselfController new] title:@"我的" image:@"tab_user_n" selectedImage:@"tab_user_s"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11.0], NSFontAttributeName,  ThirdTextColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11.0], NSFontAttributeName,  [UIColor orangeColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];

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
