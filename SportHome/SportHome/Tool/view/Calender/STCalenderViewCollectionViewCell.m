//
//  STCalenderViewCollectionViewCell.m
//  SportClub
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
// 头部but点击选择时间还没有写，具体思路是，传入一个date，将数据源制空，然后重新加载；

#import "STCalenderViewCollectionViewCell.h"
#import "NSDate+Formatter.h"
@interface STCalenderViewCollectionViewCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>


@end
@implementation STCalenderViewCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dayArray=[NSMutableArray new];
        self.backgroundColor=[UIColor whiteColor];
        UICollectionViewFlowLayout * flow =[UICollectionViewFlowLayout new];
        flow.minimumInteritemSpacing=0;
        flow.minimumLineSpacing=0;
        flow.sectionInset=UIEdgeInsetsMake(0, 10, 0, 0);
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flow];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.backgroundColor=[UIColor whiteColor];
        
        [self.collectionView registerClass:[STCalenderViewCollectionViewItem class] forCellWithReuseIdentifier:@"item"];
        [self addSubview:self.collectionView];
        self.dayArray=[[NSMutableArray alloc] initWithCapacity:42];
    }
    return self;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 42;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是10,也许四舍五入了，导致要多一行
    CGFloat  width =(self.width-10.1)/7;
    
    return CGSizeMake(width, self.height/6);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    STCalenderViewCollectionViewItem * cell =[self.collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.model=self.dayArray[indexPath.item];

    return cell;
}
//考虑到传值过多，此处用通知
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"时间是：%@",self.dayArray[indexPath.item].dateValue);
    
    if (self.dayArray[indexPath.item].isThisMonth) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"STCalenderViewCollectionViewCellSlectedNotification" object:self.dayArray[indexPath.item].dateValue];
    }
    else if (self.dayArray[indexPath.item].isLastMonth)
    {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"STCalenderViewCollectionViewCellNeedScrollToLastNotification" object:@"last"];
        
    
    }
    else if (self.dayArray[indexPath.item].isNextMonth)
    {
               [[NSNotificationCenter defaultCenter] postNotificationName:@"STCalenderViewCollectionViewCellNeedScrollToNextNotification" object:@"next"];
        
    }

    
}

@end
//-------------------------------最小cell-----------------------------------------------
@interface STCalenderViewCollectionViewItem()

@end
@implementation STCalenderViewCollectionViewItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.numBut=[[STButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) title:@"1" titleColor:SecendTextColor titleFont:13.5 cornerRadius:0 backgroundColor:[UIColor clearColor] backgroundImage:nil image:nil];
       
        self.numBut.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
        self.backgroundView=self.numBut;
  //      self.backgroundColor=[UIColor whiteColor];
        self.numSlectedBut =[[STButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) title:@"1" titleColor:[UIColor whiteColor] titleFont:13.5 cornerRadius:0 backgroundColor:ThirdTextColor backgroundImage:nil image:nil];
        _numSlectedBut.layer.cornerRadius=_numSlectedBut.size.width/2;
        _numSlectedBut.clipsToBounds=YES;
        
        _numSlectedBut.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
        self.selectedBackgroundView=_numSlectedBut;
      
    }
    return self;
}
-(void)setModel:(STCalenderModel *)model
{
    if (model) {
        [self.numBut setTitle:[NSString stringWithFormat:@"%lu",model.dayValue] forState:UIControlStateNormal];
        [self.numSlectedBut setTitle:[NSString stringWithFormat:@"%lu",model.dayValue] forState:UIControlStateNormal];
        if (!model.isThisMonth) {
            [self.numBut setTitleColor:ThirdTextColor forState:UIControlStateNormal];
            self.numBut.alpha=0.5;
            
        }
        else{
            [self.numBut setTitleColor:SecendTextColor forState:UIControlStateNormal];
            self.numBut.alpha=1;
        }
        if (model.isSelectedDay) {
            self.numBut.backgroundColor=THEME_RED;
            [self.numBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _numBut.layer.cornerRadius=_numSlectedBut.size.width/2;
            _numBut.clipsToBounds=YES;

        }
        else{
            self.numBut.backgroundColor=[UIColor whiteColor];
        }
    }
    _model=model;
}
@end
