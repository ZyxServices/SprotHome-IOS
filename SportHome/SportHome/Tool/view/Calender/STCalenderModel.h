//
//  STCalenderModel.h
//  SportClub
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STCalenderModel : NSObject

@property(nonatomic)BOOL isSelectedDay;//是否今天
@property(nonatomic)BOOL isToday;
@property(nonatomic)BOOL isThisMonth;
@property(nonatomic)BOOL isNextMonth;
@property(nonatomic)BOOL isLastMonth;
@property(nonatomic)NSInteger dayValue;//今天几号
@property(nonatomic,strong)NSDate * dateValue;//今天date
@property(nonatomic,strong)NSDate*  monthValue;//这是几月
@end
