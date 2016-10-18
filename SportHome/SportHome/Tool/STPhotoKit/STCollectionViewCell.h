//
//  STCollectionViewCell.h
//  STTools
//
//  Created by stoneobs on 16/10/13.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STUrlPhotoModel.h"
typedef void(^STCollectionViewCellFinsh)(UIImage* image);
@interface STCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)STUrlPhotoModel * model;
@property(nonatomic,copy)STCollectionViewCellFinsh finshBlock;//图片加载完的回调，现在基本不用
-(void)backToOrigin;
-(void)setFinshBlock:(STCollectionViewCellFinsh)finshBlock;
@end
