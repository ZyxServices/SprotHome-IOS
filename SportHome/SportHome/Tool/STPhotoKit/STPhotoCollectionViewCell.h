//
//  STPhotoCollectionViewCell.h
//  STTools
//
//  Created by stoneobs on 16/10/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "UIView+Direction.h"
#import "STPhotoModel.h"
typedef void(^STPhotoCollectionViewCellAction)(UIImageView * imageView);
@interface STPhotoCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)STButton * chosedButton;
@property(nonatomic,strong)STPhotoModel * model;
@property(nonatomic,copy)STPhotoCollectionViewCellAction clicAtion;
-(void)setClicAtion:(STPhotoCollectionViewCellAction)clicAtion;//imageview的点击回调
@end
