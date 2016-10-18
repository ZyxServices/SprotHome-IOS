//
//  STMonthModel.h
//  SportClub
//
//  Created by stoneobs on 16/8/1.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
// 第一层cell的数据模型

#import <Foundation/Foundation.h>
#import "STCalenderModel.h"
@interface STMonthModel : NSObject
@property(nonatomic,strong)NSDate*  currentMonth;
@property(nonatomic,strong)NSMutableArray<STCalenderModel *>* calenderArray;
@end
