//
//  STUrlPhotoModel.h
//  STTools
//
//  Created by stoneobs on 16/10/13.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface STUrlPhotoModel : NSObject
@property(nonatomic,strong)NSString * thumbImageUrl;//缩略图url
@property(nonatomic,strong)NSString * orignImageUrl;//高清图url
@property(nonatomic,strong)UIImage * thumbImage;//缩略图
@property(nonatomic,strong)UIImage * orignImage;//高清图
@end
