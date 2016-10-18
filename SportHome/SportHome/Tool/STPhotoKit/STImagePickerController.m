//
//  STImagePickerController.m
//  STTools
//
//  Created by stoneobs on 16/10/9.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STImagePickerController.h"
#import "STPhotoBaseViewController.h"

@interface STImagePickerController ()

@end

@implementation STImagePickerController
-(instancetype)initWithDefultRootVC
{
 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss:) name:@"STPhotoKitFinshChosed" object:nil];
    return [self initWithRootViewController:[STPhotoBaseViewController new]];
   


}
-(void)setNavagationBarTintColor:(UIColor *)navagationBarTintColor
{

    if (navagationBarTintColor) {
        self.navigationBar.barTintColor = navagationBarTintColor;
        _navagationBarTintColor = navagationBarTintColor;
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)dismiss:(NSNotification*)sender
{
    NSArray <STPhotoModel*>* array = sender.object;
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.finshedBlock) {
            self.finshedBlock(array);
        }
    }];

}
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        
    }
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
