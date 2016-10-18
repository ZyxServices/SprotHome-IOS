//
//  STCommunityController.m
//  SportHome
//
//  Created by stoneobs on 16/10/18.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "SHCommunityController.h"
#import "SHCommunityCollectionViewCell.h"
#import "SHHeaderReusableView.h"
@interface SHCommunityControlle ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
@end

@implementation SHCommunityControlle

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout * flow = [UICollectionViewFlowLayout new];
    flow.minimumLineSpacing = 20;
    flow.minimumInteritemSpacing = 40;
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    flow.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30);
    flow.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:SCREEN_FRAME collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = BACKROUND_COLOR;
    [self.collectionView registerClass:[SHCommunityCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.collectionView registerClass:[SHHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:self.collectionView];
}

#pragma --mark collectionviewdatasouce
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2-40, 80);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHCommunityCollectionViewCell * item =[collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    return item;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = @[@"全程热点",@"达人圣地",@"特色运动"];
    SHHeaderReusableView * head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    head.title = array[indexPath.section];
    return head;
}
#pragma --mark collectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
}





@end
