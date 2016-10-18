//
//  STBrowserCollectionViewCell.h
//  STTools
//
//  Created by stoneobs on 16/10/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 可以放大和缩小

#import <UIKit/UIKit.h>
#import "STPhotoModel.h"
#import "UIView+Direction.h"
#import "WebImage.h"
@interface STBrowserCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)STPhotoModel * model;
-(void)backToOrigin;//回到初始状态
@end
