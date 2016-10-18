//
//  STBrowserCollectionViewCell.m
//  STTools
//
//  Created by stoneobs on 16/10/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STBrowserCollectionViewCell.h"
#import "STButton+SelectedAnimation.h"
@interface STBrowserCollectionViewCell()<UIGestureRecognizerDelegate>
@property(nonatomic)CGFloat lastScale;
@property(nonatomic)CGFloat Scale;
@property(nonatomic)CGFloat lastRotation;
@property(nonatomic)CGFloat firstY;
@property(nonatomic)CGFloat firstX;
@property(nonatomic)CGAffineTransform  origin;

@property(nonatomic,strong)UIScrollView * scrollView;
@end
@implementation STBrowserCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
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

-(void)setModel:(STPhotoModel *)model
{
    if (model) {
 
        NSLog(@"%@",NSStringFromCGRect(self.imageView.frame));
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
        [self.imageView addGestureRecognizer:pinchRecognizer];
        
//        UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
//        [rotationRecognizer setDelegate:self];
//        [self.imageView addGestureRecognizer:rotationRecognizer];
        if (model.thumbImage) {
            self.imageView.image = model.thumbImage;
            
        }
        else{
            [[PHImageManager defaultManager] requestImageForAsset:model.asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                model.thumbImage = result;
                self.imageView.image = model.thumbImage;
                
                
            }];
        }

        
        _model = model;
    }
}
// 缩放
-(void)scale:(UIPinchGestureRecognizer*)sender {
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    CGAffineTransform currentTransform = _imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [_imageView setTransform:newTransform];
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    
     NSLog(@"imageFrame%@",NSStringFromCGRect(self.imageView.frame));
    NSLog(@"imageSize%@",NSStringFromCGSize(self.imageView.size));
    NSLog(@"contenSize%@",NSStringFromCGSize(self.scrollView.contentSize));
    _scrollView.contentSize = CGSizeMake(self.imageView.size.width-ABS(self.imageView.frame.origin.x), self.imageView.size.height-ABS(self.imageView.frame.origin.y));
}

// 旋转
-(void)rotate:(UIRotationGestureRecognizer*)sender {

    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = _imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [_imageView setTransform:newTransform];
    
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
    
    _scrollView.contentSize = CGSizeMake(self.imageView.size.width-ABS(self.imageView.frame.origin.x), self.imageView.size.height-ABS(self.imageView.frame.origin.y));
}
-(void)move:(id)sender {
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:_imageView];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _firstX = [_imageView center].x;
        _firstY = [_imageView center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY+translatedPoint.y);
    
    [_imageView setCenter:translatedPoint];
  
}
//将要remove 的时候将所有还原
-(void)backToOrigin
{
    self.imageView.transform = _origin;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}
-(void)layoutSubviews
{

}
@end
