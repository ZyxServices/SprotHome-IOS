//
//  STCalenderView.h
//  SportClub
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
// 日历
/**
 *  这是一个日历控件，最外层是一个collectionview，
    collectionview的cell 也是一个collectionview，
    原因：为了实现左右滑动，只能这样做，如果用一个collectionview，分为不同section的情况下，造成的情形是一个月的所有数据会排到一行，并不能有目前的效果
    不足：以后会优化自定义delegate，目前无法修改格式
    思路：考虑到要将点击事件传出，delegate和block会穿透很多层view才能到vc，所以此处的传值用的是通知。滑动一个cell就会新增加一条数据，新增一条数据就会删除一条数据，保证流畅性，cell数量是三个。
    改进：日后将一个view改成一个vc，这样逻辑会清楚更多
 
 */
#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const STCalenderViewCollectionViewCellSlectedNotification;//可以接收到点击有效日历的点击事件，通知的object是nsdate
UIKIT_EXTERN NSString *const STCalenderViewCollectionViewCellNeedScrollToLastNotification;//可以接受到点击灰色按钮，跳转到上一个月的通知，obje是字符串last
UIKIT_EXTERN NSString *const STCalenderViewCollectionViewCellNeedScrollToNextNotification;//可以接受到点击灰色按钮，跳转到下一个月的通知，obje是字符串next

@interface STCalenderView : UIView
@property(nonatomic,strong)UICollectionView * collectionView;
@end
