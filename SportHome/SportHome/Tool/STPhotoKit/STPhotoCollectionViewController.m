//
//  STPhotoCollectionViewController.m
//  STTools
//
//  Created by stoneobs on 16/10/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STPhotoCollectionViewController.h"
#import "UIView+Direction.h"
#import "STPhotoCollectionViewCell.h"
#import "STPhotoModel.h"
#import "STPhotoSystemBrowserController.h"
#import "STButton+SelectedAnimation.h"
@interface STPhotoCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray<STPhotoModel*> * dataSouce;
@property(nonatomic,strong)UIView * bootView;//底部bottom
@property(nonatomic,strong)STButton * finshButton;
@property(nonatomic,strong)STButton * numButton;
@end

@implementation STPhotoCollectionViewController
-(instancetype)init
{
    if (self = [super init]) {
        self.dataSouce = [NSMutableArray new];
    }
    return self;
}
-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"chosedArray"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setCurentAlbum:(PHFetchResult *)curentAlbum
{
    if (curentAlbum) {
 
        for (PHAsset * asset  in curentAlbum) {
            STPhotoModel * model = [STPhotoModel new];
            model.asset = asset;
            [self.dataSouce addObject:model];
        }
        _curentAlbum = curentAlbum;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.chosedArray = [NSMutableArray new];
    [self setRightTitle:@"取消" titleColor:[UIColor blackColor]];
    UICollectionViewFlowLayout * flow = [UICollectionViewFlowLayout new];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50.5) collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[STPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.view addSubview:self.collectionView];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataSouce.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    [self initBottomView];
    [self  addObserver:self forKeyPath:@"chosedArray" options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)initBottomView
{
    self.bootView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    [self.bootView showTopShodow];
    [self.bootView setBackgroundColor:[UIColor whiteColor]];
    self.finshButton = [[STButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-45, 0, 40, 20)title:@"确认" titleColor:RGB(0x43c56a) titleFont:16 cornerRadius:0 backgroundColor:nil backgroundImage:nil image:nil];
    self.finshButton.centerY = 25;
    __weak typeof(self) weakSelf =self;
    [self.finshButton setClicAction:^(STButton *sender) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"STPhotoKitFinshChosed" object:weakSelf.chosedArray];
    }];
    [self.bootView addSubview:self.finshButton];
    self.numButton = [[STButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-45-20, 10, 20, 20) title:@"10" titleColor:[UIColor whiteColor] titleFont:10 cornerRadius:10 backgroundColor:RGB(0x43c56a) backgroundImage:nil image:nil];
    self.numButton.centerY = 25;
    [self.bootView addSubview:self.numButton];
    [self.view addSubview:self.bootView];
    //底部数字
    self.numButton.hidden = NO;
    [self.numButton setTitle:[NSString stringWithFormat:@"%ld",self.chosedArray.count] forState:UIControlStateNormal];
    if (self.chosedArray.count==0) {
        self.numButton.hidden = YES;
    }
    
}

-(void)showAnimation:(NSIndexPath*)indexpath
{
    
        NSIndexPath * path = indexpath;
        NSLog(@"收到的位置%ld",path.item);
        if (path.item<=self.dataSouce.count-1) {
            STPhotoCollectionViewCell * mycell = (STPhotoCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:path];
            
            CGSize  imageSize = self.dataSouce[path.item].thumbImage.size;
            CGFloat bili = SCREEN_WIDTH/imageSize.width;
            
            UIImageView * animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, bili*imageSize.height)];
            animationImageView.transform= CGAffineTransformMakeScale(0.8, 0.8);
            animationImageView.center = self.view.center;
            animationImageView.image = mycell.imageView.image;
            [[UIApplication sharedApplication].keyWindow addSubview:animationImageView];
            CGFloat duration = 0.3;
            [UIView animateWithDuration:duration animations:^{
                
                CGRect frame = [mycell convertRect:mycell.bounds toView:self.view.window];
                animationImageView.frame = frame;
                
            } completion:^(BOOL finished) {
                [animationImageView removeFromSuperview];
            }];
            
            
            
        }
        
        
  

    


    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.numButton.hidden = NO;
    [self.numButton setTitle:[NSString stringWithFormat:@"%ld",self.chosedArray.count] forState:UIControlStateNormal];
    if (self.chosedArray.count==0) {
        self.numButton.hidden = YES;
    }
   

}
//监听数组
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object==self&&[keyPath isEqualToString:@"chosedArray"]) {
        [self.numButton setTitle:[NSString stringWithFormat:@"%ld",self.chosedArray.count] forState:UIControlStateNormal];
        if (self.chosedArray.count==0) {
            self.numButton.hidden = YES;
            return;
        }
        self.numButton.hidden = NO;
        [UIView animateWithDuration:0.1 animations:^{
            self.numButton.frame = CGRectMake(SCREEN_WIDTH-45-20, 10, 18, 18);
            self.numButton.centerY = 25;
            self.numButton.layer.cornerRadius = 9;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.12 animations:^{
                self.numButton.frame = CGRectMake(SCREEN_WIDTH-45-20, 10, 15, 15);
                self.numButton.centerY = 25;
                self.numButton.layer.cornerRadius = 7.5;
            }];
        }];
    }
}
//要实现对容器类的监听，就必须实现insert和remove这两个方法
-(void)insertObject:(STPhotoModel *)object inChosedArrayAtIndex:(NSUInteger)index
{
    [self.chosedArray insertObject:object atIndex:index];
    NSLog(@"数组增加了");
}
-(void)removeObjectFromChosedArrayAtIndex:(NSUInteger)index
{
    [self.chosedArray removeObjectAtIndex:index];

}
-(void)addChosedArrayObject:(STPhotoModel *)object
{
    [self.chosedArray addObject:object];
    NSLog(@"数组增加了");
}
-(void)removeChosedArrayObject:(STPhotoModel *)object
{
    [self removeChosedArrayObject:object];
    NSLog(@"数组减少了");
}
-(void)rightBarAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma --mark collectionviewdatasouce
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/4, SCREEN_WIDTH/4);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    STPhotoCollectionViewCell * item =[collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    item.model= self.dataSouce[indexPath.item];
    __weak typeof(self) weakSelf =self;
    [item setClicAtion:^(UIImageView *imageView) {
        NSLog(@"类型%ld",weakSelf.dataSouce[indexPath.item].asset.mediaType);
        if (weakSelf.dataSouce[indexPath.item].asset.mediaType == PHAssetMediaTypeVideo) {
            NSLog(@"将来跳转到视屏播放");
        }
        else
        {
        
        STPhotoSystemBrowserController * vc = [[STPhotoSystemBrowserController alloc] initWithArray:weakSelf.dataSouce curentIndex:indexPath.item];
            vc.chosedArray = self.chosedArray;
        [weakSelf presentViewController:vc animated:NO completion:nil];
        }
    }];

    __weak typeof(item) weakItme =item;
    [item.chosedButton setClicAction:^(STButton *sender) {
        weakSelf.dataSouce[indexPath.item].isChosed =  !weakSelf.dataSouce[indexPath.item].isChosed;
        //[weakSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        weakItme.chosedButton.selected = weakSelf.dataSouce[indexPath.item].isChosed;
        STPhotoModel * model = weakSelf.dataSouce[indexPath.item];
       
        if (weakSelf.dataSouce[indexPath.item].isChosed) {
            [weakItme.chosedButton showSlectedAnimation];
             [[weakSelf mutableArrayValueForKey:@"chosedArray"] addObject:model];
        }
        else
        {
            NSLog(@"删除钱的数组%ld",weakSelf.chosedArray.count);
           [[weakSelf mutableArrayValueForKey:@"chosedArray"] removeObject:model];
            NSLog(@"删除后的数组%ld",weakSelf.chosedArray.count);
        }
    }];
    return item;
}
#pragma --mark collectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
}




@end
