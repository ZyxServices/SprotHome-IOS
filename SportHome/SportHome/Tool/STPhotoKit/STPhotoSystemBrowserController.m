//
//  STPhotoBrowserController.m
//  STTools
//
//  Created by stoneobs on 16/10/10.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STPhotoSystemBrowserController.h"
#import "STPhotoModel.h"
#import "STBrowserCollectionViewCell.h"
#import <Photos/Photos.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD+Add.h"
#import "STButton+SelectedAnimation.h"
#import "STPhotoCollectionViewController.h"
@interface STPhotoSystemBrowserController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray<STPhotoModel*> * dataSouce;
@property(nonatomic)NSInteger curentIndex;//传入进来的照片位置
@property(nonatomic,strong)NSIndexPath * curentIndexpath;//当前被浏览的照片位置

//top
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UIActivityIndicatorView * act;
@property(nonatomic,strong)STButton * titleButton;
@property(nonatomic,strong)STButton * chosedButton;
//底部
@property(nonatomic,strong)UIView * bootView;//底部bottom
@property(nonatomic,strong)STButton * finshButton;
@property(nonatomic,strong)STButton * numButton;

//模态这个vc的控制器
@property(nonatomic,strong)STPhotoCollectionViewController * STPhotoCollectionViewControllerVC;
@end

@implementation STPhotoSystemBrowserController
-(instancetype)initWithArray:(NSArray<STPhotoModel*>*)dataSouce curentIndex:(NSInteger)curentIndex
{
    if (self = [super init]) {
        if (dataSouce.count==0) {
             NSAssert(NO, @"STPhotoBrowserController数组不能为空");
        }
        if (![dataSouce.firstObject isKindOfClass:[STPhotoModel class]]) {
             NSAssert(NO, @"dataSouce数组中的类型必须是STPhotoModel");
        }
        self.showBottomView = YES;
        self.dataSouce = [NSMutableArray arrayWithArray:dataSouce];
        self.curentIndex = 0;
        if (curentIndex>0) {
             self.curentIndex = curentIndex;
        }
        [self initSubviews];
    }
    return self;
}
-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"chosedArray"];
}
-(void)initBottomView
{
    if (!self.showBottomView) {
        return;
    }
    self.bootView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    [self.bootView showTopShodow];
    [self.bootView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    self.finshButton = [[STButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-45, 0, 40, 20)title:@"确认" titleColor:RGB(0x43c56a) titleFont:16 cornerRadius:0 backgroundColor:nil backgroundImage:nil image:nil];
    self.finshButton.centerY = 25;
    __weak typeof(self) weakSelf =self;
    [self.finshButton setClicAction:^(STButton *sender) {
        [weakSelf dismissViewControllerAnimated:NO completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"STPhotoKitFinshChosed" object:weakSelf.chosedArray];
        }];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chosedButton.selected = self.dataSouce[_curentIndex].isChosed;
    UICollectionViewFlowLayout * flow = [UICollectionViewFlowLayout new];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = NO;
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor= [UIColor blackColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.collectionView registerClass:[STBrowserCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    
    [self.view addSubview:self.collectionView];
    if (self.curentIndex>0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.curentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [self initBottomView];
     [self  addObserver:self forKeyPath:@"chosedArray" options:NSKeyValueObservingOptionNew context:nil];
    //避免第一次进来点击无效
    [self scrollViewDidScroll:self.collectionView];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UINavigationController * nav = (UINavigationController*)self.presentingViewController;
    if ([nav.childViewControllers.lastObject isKindOfClass:[STPhotoCollectionViewController class]]) {
         self.STPhotoCollectionViewControllerVC = (STPhotoCollectionViewController*)nav.childViewControllers.lastObject;//出了这个方法会被释放，所以赋值
    }
   
}
//退出控制器，之后添加动画
-(void)backToLastVC
{
    [self dismissViewControllerAnimated:NO completion:^{
        
        [self.STPhotoCollectionViewControllerVC showAnimation:self.curentIndexpath];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissedFormSTPhotoSystemBrowserController" object:self.curentIndexpath];
    }];

}
-(BOOL)prefersStatusBarHidden
{
    return YES;
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
        [weakSelf backToLastVC];
    }];
    [self.topView addSubview:cancelButton];
    //title
    _titleButton = [[STButton alloc] initWithFrame:CGRectMake(5, 0, 100, 30)title:@"" titleColor:[UIColor whiteColor] titleFont:14 cornerRadius:0 backgroundColor:[UIColor clearColor] backgroundImage:nil image:nil];
    _titleButton.centerX = SCREEN_WIDTH/2;
    _titleButton.centerY = 32;
    [self.topView addSubview:_titleButton];
    
    _chosedButton= [[STButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-10, 0, 25, 25)title:nil titleColor:[UIColor whiteColor] titleFont:15 cornerRadius:12.5 backgroundColor:[UIColor clearColor] backgroundImage:[UIImage imageNamed:@"ImageSelectedOff"] image:nil];
    [_chosedButton setBackgroundImage:[UIImage imageNamed:@"ImageSelectedOn"] forState:UIControlStateSelected];
    _chosedButton.centerY = 32;
    
    
    [self.topView addSubview:self.chosedButton];
    [self.view addSubview:self.topView];
    
}

#pragma mark --kvo
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
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    STBrowserCollectionViewCell * item =[collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    item.model = self.dataSouce[indexPath.item];
    return item;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{

 

    //视图将要出现的时候，开始请求大图
    STBrowserCollectionViewCell * mycell = (STBrowserCollectionViewCell*)cell;
    [_act removeFromSuperview];
    _act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _act.frame = CGRectMake(0, 0, 60, 60);
    _act.center = self.view.window.center;
    _act.tintColor = [UIColor blackColor];
    
    [_act startAnimating];
    [self.view addSubview:_act];
    if (mycell.model.originImage.size.width>10) {
        mycell.imageView.image = mycell.model.originImage;
        [_act stopAnimating];
        [_act removeFromSuperview];
        
    }
    else{

        PHAsset * aset = mycell.model.asset;
        PHImageRequestOptions *originRequestOptions = [[PHImageRequestOptions alloc] init];
        originRequestOptions.networkAccessAllowed = YES;
        
        originRequestOptions.progressHandler =  ^(double progress, NSError * error, BOOL *stop, NSDictionary * info){
            NSLog(@"这是第%ld张图片正在被请求%f",indexPath.item,progress);
         
            
        };
        mycell.model.requsetID = [[PHImageManager defaultManager] requestImageForAsset:aset targetSize:CGSizeMake(600, 600) contentMode:PHImageContentModeDefault options:originRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result&&info.allKeys.count!=5) {//这个方法如果是异步的会加载2次左右，一般info有5个值的时候，是还没有完全加载
                [_act stopAnimating];
                [_act removeFromSuperview];
                mycell.model.originImage = result;
                mycell.imageView.image = result;
            }
  
        }];

        
    }



}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //试图被移除， 那么删除这个请求，避免多次查看，所有全部进入下载状态
    [[PHImageManager defaultManager] cancelImageRequest:self.dataSouce[indexPath.item].requsetID];
    STBrowserCollectionViewCell * mycell = (STBrowserCollectionViewCell*)cell;
    //经过旋转，放大等之后回到初始
    [mycell backToOrigin];
   
}
#pragma --mark collectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    //点击手势和cell中的scroleview的手势冲突，所以点击事件用的imageview的手势
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];

}
//用来判断当前的indexpath，之所以不在willdisplay方法里面写，是因为，滑动些许，触发willdisplay方法，但是又返回到当前视图，造成错误
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    __weak typeof(self) weakSelf =self;
    CGFloat width = scrollView.contentOffset.x;
    NSInteger num = (width+10)/SCREEN_WIDTH;
    self.curentIndexpath = [NSIndexPath indexPathForRow:num inSection:0];
    
    if (self.STPhotoCollectionViewControllerVC) {
        [self.STPhotoCollectionViewControllerVC.collectionView scrollToItemAtIndexPath:self.curentIndexpath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        
    }
    if (self.STPhotoSystemBrowserControllerdlegate&&[self respondsToSelector:@selector(STPhotoSystemBrowserControllerDidScrollToIndexpath:)]) {
        [self.STPhotoSystemBrowserControllerdlegate STPhotoSystemBrowserControllerDidScrollToIndexpath:self.curentIndexpath];
    }
    self.chosedButton.selected = self.dataSouce[num].isChosed;
    [self.titleButton setTitle:[NSString stringWithFormat:@"%ld/%ld",num+1,self.dataSouce.count] forState:UIControlStateNormal];
    [self.chosedButton setClicAction:^(STButton *sender) {
        weakSelf.dataSouce[num].isChosed = !weakSelf.dataSouce[num].isChosed;
        weakSelf.chosedButton.selected = weakSelf.dataSouce[num].isChosed;
        STPhotoModel * model = weakSelf.dataSouce[num];
        if (weakSelf.STPhotoSystemBrowserControllerdlegate&&[weakSelf respondsToSelector:@selector(STPhotoSystemBrowserControllerDidClicTheChosedButton:isSlected:)]) {
            [weakSelf.STPhotoSystemBrowserControllerdlegate STPhotoSystemBrowserControllerDidClicTheChosedButton:weakSelf.curentIndexpath isSlected:sender.selected];
        }
        if (weakSelf.chosedButton.selected) {
            [weakSelf.chosedButton showSlectedAnimation];
            
            [[weakSelf mutableArrayValueForKey:@"chosedArray"] addObject:model];
        }
        else
        {
            NSLog(@"删除钱的数组%ld",weakSelf.chosedArray.count);
            [[weakSelf mutableArrayValueForKey:@"chosedArray"]removeObject:model];
            NSLog(@"删除后的数组%ld",weakSelf.chosedArray.count);
        }
        if (weakSelf.STPhotoCollectionViewControllerVC) {
            [weakSelf.STPhotoCollectionViewControllerVC.collectionView reloadItemsAtIndexPaths:@[weakSelf.curentIndexpath]];
            
        }
        
        
    }];
    
}





@end
