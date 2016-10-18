//
//  STCollectionViewCell.m
//  STTools
//
//  Created by stoneobs on 16/10/13.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STCollectionViewCell.h"
#import "UIView+Direction.h"
#import "WebImage.h"
@interface STCollectionViewCell()
@property(nonatomic)CGFloat lastScale;
@property(nonatomic)CGFloat Scale;
@property(nonatomic)CGFloat lastRotation;
@property(nonatomic)CGFloat firstY;
@property(nonatomic)CGFloat firstX;
@property(nonatomic)CGAffineTransform  origin;
@property(nonatomic,strong)UIScrollView * scrollView;
@end
@implementation STCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc]initWithFrame:SCREEN_FRAME];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        _scrollView.scrollEnabled = YES;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.imageView.center = [UIApplication sharedApplication].keyWindow.center;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.backgroundColor = [UIColor blackColor];
        self.imageView.userInteractionEnabled = YES;
        self.imageView.transform = CGAffineTransformIdentity;
        _origin = self.imageView.transform ;
        [_scrollView addSubview:self.imageView];
        [self addSubview:_scrollView];
        


    }
    return self;
}
-(void)setModel:(STUrlPhotoModel *)model
{

    if (model) {
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
        [self.imageView addGestureRecognizer:pinchRecognizer];
        

       
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.orignImageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            model.orignImage = image;
//            if (self.finshBlock) {
//                self.finshBlock(image);
//            }
//        }];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.orignImageUrl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            NSLog(@"--------下载-%ld------总%ld",receivedSize,expectedSize);
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
             model.orignImage = image;
            if (self.finshBlock) {
                self.finshBlock(image);
            }
             //[_act removeFromSuperview];
        }];

        _model = model;
    }

}
-(void)scale:(UIPinchGestureRecognizer*)sender {
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    CGAffineTransform currentTransform = _imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [_imageView setTransform:newTransform];
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    
 
    _scrollView.contentSize = CGSizeMake(self.imageView.size.width-ABS(self.imageView.frame.origin.x), self.imageView.size.height-ABS(self.imageView.frame.origin.y));
}

//将要remove 的时候将所有还原
-(void)backToOrigin
{
    self.imageView.transform = _origin;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}

@end
