//
//  STPhotoModel.h
//  STTools
//
//  Created by stoneobs on 16/10/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STBaseModel.h"
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface STPhotoModel : STBaseModel
@property(nonatomic,strong)PHAsset * asset;
@property(nonatomic)BOOL    isChosed;//是否被选中
@property(nonatomic,strong)UIImage * thumbImage;//缩略图
@property(nonatomic,strong)UIImage * originImage;//原图
@property(nonatomic)PHImageRequestID  requsetID;//请求id
@end
