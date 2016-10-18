//
//  STPhotoBrowserController.h
//  STTools
//
//  Created by stoneobs on 16/10/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 照片浏览 ，系统级别的，模态到这个控制器

#import "STBaseViewController.h"
#import "STPhotoModel.h"
@protocol STPhotoSystemBrowserControllerDlegate <NSObject>


/**
 当这个控制器浏览到某张图片的时候会调用
 
 @param indexPath datasouce中正在被浏览的itme，你可以将上一个控制器也开始滑动
 */
-(void)STPhotoSystemBrowserControllerDidScrollToIndexpath:(NSIndexPath*)indexPath;

/**
 当点击到chosedButton时候的代理，告诉你现在可以刷新某个item了,如果某个数组中对象取消选中，那么会被移除，掉用单个刷新item可能会报错，如果实现delegate的vc的datasouce和这个数组的chosedarray是同一个数组，建议全部刷新
 
 @param indexPath 当前被选择或者取消选择的item
 @param isSlected  是否被选中
 */
-(void)STPhotoSystemBrowserControllerDidClicTheChosedButton:(NSIndexPath*)indexPath isSlected:(BOOL)selected;


@end


@interface STPhotoSystemBrowserController : STBaseViewController
@property(nonatomic,strong)NSMutableArray<STPhotoModel*> * chosedArray;//被选中的数组
@property(nonatomic)BOOL showBottomView;//是否显示下方view，默认yes
@property(nonatomic,weak)id <STPhotoSystemBrowserControllerDlegate> STPhotoSystemBrowserControllerdlegate;
-(instancetype)initWithArray:(NSArray<STPhotoModel*>*)dataSouce curentIndex:(NSInteger)curentIndex;
//UIKIT_EXTERN NSNotificationName const dismissedFormSTPhotoSystemBrowserController;//获取到图片浏览返回的通知，object是当前的indexPath，你可以通过这个来做一些动画
@end
