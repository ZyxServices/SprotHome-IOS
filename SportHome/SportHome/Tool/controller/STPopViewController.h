//
//  STPopViewController.h
//  STTools
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 这是一个点击加号，弹出的下拉列表控制器，可以在任何view下方出现

#import <UIKit/UIKit.h>
@class STPopViewController;
@protocol STPopViewControllerdelegate <NSObject>
@optional
-(void)popViewController:(UIViewController *)vc didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@protocol STPopViewControllerdatasouce <NSObject>
@optional
-(UITableViewCell *)popViewController:(UIViewController *)vc cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)popViewController:(UIViewController *)vc heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface STPopViewController : UIViewController <STPopViewControllerdelegate,STPopViewControllerdatasouce>
@property(nonatomic,weak)id<STPopViewControllerdelegate> PopTableViewdelegate;
@property(nonatomic,weak)id<STPopViewControllerdatasouce> PopTableViewdatasouce;
// 如果用默认左边图片 右边 title，下面必须实现来传入imag；
@property(nonatomic,strong)NSArray<NSString*> * imageAry;
//箭头方向
@property(nonatomic)UIPopoverArrowDirection  direction;
@property(nonatomic,strong)UIColor * cellColor;
@property(nonatomic)BOOL  canScroll;
-(instancetype)initWithArray:(NSArray<NSString*>*)titleAry size:(CGSize)size view:(UIView*)view;
@end
