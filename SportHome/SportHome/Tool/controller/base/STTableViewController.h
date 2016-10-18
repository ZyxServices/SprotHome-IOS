//
//  STTableViewController.h
//  SportClub
//
//  Created by stoneobs on 16/7/28.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//
#import <UIKit/UIKit.h>
@class STTableViewController;
@protocol STTableViewControllerKeyBord <NSObject>
@optional;
//如果view释放掉，会报错，所以remove得时候记得从数组中删除。
-(NSArray<UIView*>*)viewsNeedChangeFrameWhenKeyBordFrameChanged;

-(void)keyBordEndChangeFrame:(CGRect)frame;

@end
#import "STBaseViewController.h"

@interface STTableViewController : STBaseViewController<UITableViewDelegate,UITableViewDataSource,STTableViewControllerKeyBord>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,weak)id<STTableViewControllerKeyBord>  STTableViewControllerKeyBordDelegate;
-(instancetype)initwithStyle:(UITableViewStyle)style;
-(instancetype)init;
@end
