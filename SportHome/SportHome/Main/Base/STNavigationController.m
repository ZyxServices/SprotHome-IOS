//
//  STNavigationController.m
//  STTools
//
//  Created by stoneobs on 16/10/9.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STNavigationController.h"
#import "UIView+Direction.h"
@interface STNavigationController ()

@end

@implementation STNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{

    if (self = [super initWithRootViewController:rootViewController]) {
          self.interactivePopGestureRecognizer.delegate=(id)self;
          self.navigationBar.barTintColor = [UIColor whiteColor];
        //title
            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    }
    return self;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  
   
    if (self.childViewControllers.count>1) {
        self.hidesBottomBarWhenPushed = YES;
        //设置返回键
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(back)  forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateHighlighted];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        btn.frame = CGRectMake(0, 0, 44, 44);
        viewController.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
