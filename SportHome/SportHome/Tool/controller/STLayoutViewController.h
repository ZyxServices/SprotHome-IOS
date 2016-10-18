//
//  ETSideViewController.h
//  EasyTool
//  左右滑动抽屉效果的controller,修改于2016-3-25，增加单例模式
//
//  Copyright (c) 2016年 stoneobs. All rights reserved.

#import <UIKit/UIKit.h>
#import "UIView+Direction.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, STLayoutViewStatus)
{
    STLayoutViewStatusNormal,
    STLayoutViewStatusLeftshowing,
    STLayoutViewStatusLeftshowed,
    STLayoutViewStatusLefthiding,
    STLayoutViewStatusRightshowing,
    STLayoutViewStatusRightshowed,
    STLayoutViewStatusRighthiding,
};
/**
 *  侧滑模式
 */
typedef NS_ENUM(NSInteger, STLayoutViewDisplayMode) {
    /**
     *  悬浮框
     */
    STLayoutViewDisplayModeBackground,
    /**
     *  类似qq
     */
    STLayoutViewDisplayModeCover,
    /**
     *  默认
     */
    STLayoutViewDisplayModeDefault = STLayoutViewDisplayModeBackground,
};

NS_CLASS_AVAILABLE_IOS(7_0)

@interface STLayoutViewController : UIViewController<UIGestureRecognizerDelegate>

//-(instancetype)initWithRootViewController:(UIViewController *)      rootViewController;//the desined contructor!!
@property (nonatomic,strong,readonly)   UIViewController            *rootViewController;
@property (nonatomic,strong,readonly)   UIPanGestureRecognizer      *panGestureRecognizer;//you can't change the panGestureRecognizer's delegate in any case!!!
@property (nonatomic,strong,nullable)   UIViewController            *leftViewController;
@property (nonatomic,strong,nullable)   UIViewController            *rightViewController;
@property (nonatomic,readonly)          STLayoutViewStatus          status;
@property (nonatomic)                   STLayoutViewDisplayMode     leftDisplayMode;
@property (nonatomic)                   STLayoutViewDisplayMode     rightDisplayMode;
@property (nonatomic)                   NSTimeInterval              animationDuration;
@property (nonatomic,getter=canDisplayShadow) BOOL                  displayShadow;
/*!
 *  @author 15-03-12 14:03:13
 *
 *  @brief  relative to the baseview left-top point. use for set  the leftViewController max position
 *          default vaule is (240,64)
 *          if leftDisplayModle == STLayoutViewDisplayModleCover leftDisplayVector.y will be ignore
 */
@property (nonatomic) CGVector                                  leftDisplayVector;
/*!
 *  @author 15-03-12 14:03:47
 *
 *  @brief  relative to the baseview right-top point .use for set the rightViewController max show position
 *          default vaule is (80,64)
 *          if rightDisplayModle == STLayoutViewDisplayModleCover rightDisplayVector.y will be ignore
 */
@property (nonatomic) CGVector                                  rightDisplayVector;
//单例模式
+(STLayoutViewController*)defaultLayout;
/*------thes method may called by user  for control the status by himself-----*/
- (void)setPanGestureEnable:(BOOL)enable;//enable the gesture or not default is yes
- (void)showLeftViewController:(BOOL)animated;//show the left controller . if the leftViewController is nil or the status isn't STLayoutViewStatusNormal nothing happend.
- (void)showRightViewController:(BOOL)animated;//show the right controller.if the rightViewController is nil the status isn't STLayoutViewStatusNormal nothing happend
- (void)dismissCurrentController:(BOOL)animated;//dismiss current showed controller if status is neither STLayoutViewStatusLeftshowed nor STLayoutViewStatusRightshowed  nothing happend.
/*----------------------------------------------------------------------------*/

@end
@interface STLayoutViewController (customAnimationSuport)
/*!
 *  @author 15-03-12 15:03:42
 *
 *  @brief  subclass implement this method to add some conjoined animation during layout animating.
 *
 *  @param offset        if left controller showing the offset is relative to the leftside of bounds otherwise relative to the rightside.
 *  @param animationView the current animationview
 *  @param status        the current layout status
 */
- (void)layoutSubviewWithOffset:(CGFloat)offset maxOfsset:(CGFloat)maxofsset atView:(UIView *)animationView status:(STLayoutViewStatus)status;
@end

NS_ASSUME_NONNULL_END
