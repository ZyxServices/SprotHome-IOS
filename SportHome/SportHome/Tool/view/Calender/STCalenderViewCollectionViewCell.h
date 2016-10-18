//
//  STCalenderViewCollectionViewCell.h
//  SportClub
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
// 日历第一层cell

#import <UIKit/UIKit.h>
#import "STLabel.h"
#import "STButton.h"
#import "STCalenderModel.h"

@interface STCalenderViewCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray<STCalenderModel*> * dayArray;
@end

//-------------------------------最小cell，21号这种-----------------------------------------------
@interface STCalenderViewCollectionViewItem : UICollectionViewCell
@property(nonatomic,strong)STButton * numBut;
@property(nonatomic,strong)STButton * numSlectedBut;
@property(nonatomic,strong)STCalenderModel * model;
@end
