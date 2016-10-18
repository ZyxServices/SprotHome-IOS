//
//  STPhotoBrowerController.m
//  STTools
//
//  Created by stoneobs on 16/10/13.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STPhotoBrowerController.h"
#import "STCollectionViewCell.h"
#import "UIView+Direction.h"
#import "STButton.h"
@interface STPhotoBrowerController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
//top
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)STButton * titleButton;
@property(nonatomic,strong)UIActivityIndicatorView * act;
@property(nonatomic)NSIndexPath * nowIndexpath;
@end

@implementation STPhotoBrowerController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout * flow = [UICollectionViewFlowLayout new];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:SCREEN_FRAME collectionViewLayout:flow];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.allowsSelection = YES;
    [self.collectionView registerClass:[STCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.collectionView];
    if (self.curentIndex>0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.curentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }
    [self initSubviews];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.collectionView];
}
//电池
-(BOOL)prefersStatusBarHidden
{
    return NO;
}
-(void)initSubviews
{
    __weak typeof(self) weakSelf =self;
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.topView showBottomShodow];
    //返回按钮 -之后点击哪个view就返回到哪个view
    STButton * cancelButton = [[STButton alloc] initWithFrame:CGRectMake(5, 0, 40, 40)title:@"" titleColor:[UIColor whiteColor] titleFont:14 cornerRadius:0 backgroundColor:[UIColor clearColor] backgroundImage:[UIImage imageNamed:@"nav_return"] image:nil];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.centerY = 32;
    [cancelButton setClicAction:^(STButton *sender) {
        [weakSelf showDismisAnimation];
    }];
    [self.topView addSubview:cancelButton];
    //title
    _titleButton = [[STButton alloc] initWithFrame:CGRectMake(5, 0, 100, 30)title:@"" titleColor:[UIColor whiteColor] titleFont:14 cornerRadius:0 backgroundColor:[UIColor clearColor] backgroundImage:nil image:nil];
    _titleButton.centerX = SCREEN_WIDTH/2;
    _titleButton.centerY = 32;
    [self.topView addSubview:_titleButton];

    [self.view addSubview:self.topView];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataSouce.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    STCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = self.dataSouce[indexPath.item];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDismisAnimation)];
    [cell.imageView addGestureRecognizer:tap];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{

}
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    STCollectionViewCell * mycell = (STCollectionViewCell*)cell;
    [mycell backToOrigin];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.contentOffset.x;
    NSInteger num = (width+10)/SCREEN_WIDTH;
    [self.titleButton setTitle:[NSString stringWithFormat:@"%ld/%ld",num+1,self.dataSouce.count] forState:UIControlStateNormal];
     self.nowIndexpath = [NSIndexPath indexPathForRow:num inSection:0];

    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}
-(void)showDismisAnimation
{

    STCollectionViewCell * mycell = (STCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:_nowIndexpath];
    CGSize  imageSize = mycell.imageView.image.size;
    CGFloat bili = SCREEN_WIDTH/imageSize.width;
    UIImageView * animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, bili*imageSize.height)];
    animationImageView.center = self.view.center;
    animationImageView.image = mycell.imageView.image;
     [[UIApplication sharedApplication].keyWindow addSubview:animationImageView];
    CGFloat duration = 0.2;
    if (self.curentIndex == _nowIndexpath.item&&self.curentView) {
        duration = 0.4;
    }
    [self dismissViewControllerAnimated:NO completion:^{
       
        [UIView animateWithDuration:duration animations:^{
            if (self.curentIndex == _nowIndexpath.item&&self.curentView) {
                CGRect frame = [self.curentView convertRect:self.curentView.bounds toView:self.view.window];
                animationImageView.frame = frame;
                //animationImageView.contentMode = UIViewContentModeScaleToFill;
            }
            else
            {
                animationImageView.transform = CGAffineTransformMakeScale(1.4, 1.4);
                animationImageView.alpha = 0.1;
                animationImageView.center = self.view.center;
                
                
            }
            
        } completion:^(BOOL finished) {
            [animationImageView removeFromSuperview];
        }];
    }];

}
@end
