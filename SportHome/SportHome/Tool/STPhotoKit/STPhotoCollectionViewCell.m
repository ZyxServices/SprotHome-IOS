//
//  STPhotoCollectionViewCell.m
//  STTools
//
//  Created by stoneobs on 16/10/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STPhotoCollectionViewCell.h"
#import "UIView+Direction.h"
#import "STButton+SelectedAnimation.h"
@interface STPhotoCollectionViewCell()
@property(nonatomic,strong)UIView * vidioView;
@property(nonatomic,strong)STLabel * vidioTime;
@end
@implementation STPhotoCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       // self.imageView = [[STButton alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH/4-5, SCREEN_WIDTH/4-5)title:nil titleColor:nil titleFont:0 cornerRadius:0 backgroundColor:nil backgroundImage:nil image:nil];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH/4-5, SCREEN_WIDTH/4-5)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.imageView.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
        

        
        self.chosedButton = [[STButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4-20-4, 5+4, 20, 20)title:nil titleColor:nil titleFont:0 cornerRadius:10 backgroundColor:[UIColor clearColor] backgroundImage:nil image:nil];
        [self.chosedButton setBackgroundImage:[UIImage imageNamed:@"ImageSelectedOn"] forState:UIControlStateSelected];
        [self.chosedButton setBackgroundImage:[UIImage imageNamed:@"ImageSelectedOff"] forState:UIControlStateNormal];
        [self addSubview:self.chosedButton];
        //视屏
        self.vidioView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageView.height-10, self.imageView.width, 10)];
        self.vidioView.backgroundColor = [UIColor blackColor];
        STButton * live = [[STButton alloc] initWithFrame:CGRectMake(3, 0, 40, 10)title:@"vidio" titleColor:[UIColor whiteColor] titleFont:8 cornerRadius:0 backgroundColor:nil backgroundImage:nil image:[UIImage imageNamed:@"icon_live"]];
        live.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        live.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        [self.vidioView addSubview:live];
        
        self.vidioTime = [[STLabel alloc] initWithFrame:CGRectMake(self.imageView.width-26, 0, 25, 10)text:@"00:32" textColor:[UIColor whiteColor] font:7 isSizetoFit:YES textAlignment:NSTextAlignmentCenter];
        [self.vidioView addSubview:self.vidioTime];
        [self.imageView addSubview:self.vidioView];
        
        
    }
    return self;

}
-(void)imageViewClication:(UIImageView*)sender
{
    if (self.clicAtion) {
        _clicAtion(sender);
    }
}
-(void)setModel:(STPhotoModel *)model
{
    if (model) {
        UITapGestureRecognizer * re = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClication:)];
        [self.imageView addGestureRecognizer:re];
        if (model.thumbImage) {
            self.imageView.image = model.thumbImage;
          
        }
        else{
        [[PHImageManager defaultManager] requestImageForAsset:model.asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            model.thumbImage = result;
            self.imageView.image = model.thumbImage;
       
            
        }];
        }
        if (model.asset.mediaType==PHAssetMediaTypeVideo) {
            self.chosedButton.hidden = YES;
            self.vidioView.hidden = NO;
            NSLog(@"%f",model.asset.duration);
            self.vidioTime.text = [self timeForduration:model.asset.duration];
        }
        else
        {

            self.chosedButton.hidden = NO;
            self.vidioView.hidden = YES;

        }
      
        self.chosedButton.selected = model.isChosed;
     
        _model = model;
    }
}
//计算vidio时长
-(NSString*)timeForduration:(NSTimeInterval)time
{
    NSInteger num = time;
    NSString * hour = [NSString stringWithFormat:@"%ld",num/3600];
    NSString * minte =[NSString stringWithFormat:@"%ld",num/60];
    NSString * secend = [NSString stringWithFormat:@"%ld",num];
    if (hour.integerValue>=1) {
        hour = [self format:hour];
        minte = [NSString stringWithFormat:@"%ld",num%3600/60];
        minte = [self format:minte];
        
        secend = [NSString stringWithFormat:@"%ld",num%3600%60];
        secend = [self format:secend];
        return [NSString stringWithFormat:@"%@:%@:%@",hour,minte,secend];
    }
   
        minte = [NSString stringWithFormat:@"%ld",num/60];
        minte = [self format:minte];
        
        secend = [NSString stringWithFormat:@"%ld",num%60];
        secend = [self format:secend];
        return [NSString stringWithFormat:@"%@:%@",minte,secend];
    
 
}
-(NSString*)format:(NSString*)one
{
    if (one.integerValue<10) {
        return [NSString stringWithFormat:@"0%@",one];
    }
    return one;
}
@end
