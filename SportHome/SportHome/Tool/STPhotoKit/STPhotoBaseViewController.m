//
//  STPhotoBaseViewController.m
//  STTools
//
//  Created by stoneobs on 16/10/9.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 仿系统imagepiker的 的布局模式

#import "STPhotoBaseViewController.h"
#import <Photos/Photos.h>
#import "STPhotoCollectionViewController.h"
@interface STPhotoBaseViewController ()
@property(nonatomic,strong)NSMutableArray<NSMutableArray*> * dataSouce;
@property(nonatomic,strong)NSMutableArray * sectionOne;
@property(nonatomic,strong)NSMutableArray * sectionTwo;
@property(nonatomic,strong)NSMutableArray<NSMutableArray*> * albumArray;
@end

@implementation STPhotoBaseViewController
-(instancetype)init
{
    if (self = [super init]) {
        [self setRightTitle:@"取消" titleColor:[UIColor blackColor]];
        self.title = @"相册";
        self.dataSouce = [NSMutableArray new];
        self.albumArray = [NSMutableArray new];
        [self getPhotoCollection];
        [self getMyselfAlbum];
    }
    return self;
}
-(void)getPhotoCollection
{
    //智能获取所有相册
    self.sectionOne = [NSMutableArray new];
    NSMutableArray * albumOne = [NSMutableArray new];
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        // 获取一个相册（PHAssetCollection）
        PHCollection *collection = smartAlbums[i];
        NSLog(@"one-title%@",collection.localizedTitle);
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            // 从每一个智能相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
            
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            NSNumber * count = [NSNumber numberWithInteger:fetchResult.count];
            PHAsset  * asset = fetchResult.lastObject;
            if (count.integerValue!=0&&![collection.localizedTitle isEqualToString:@"视频"]) {
                [albumOne addObject:collection];
                PHImageRequestOptions *originRequestOptions = [[PHImageRequestOptions alloc] init];
                originRequestOptions.networkAccessAllowed = YES;
                originRequestOptions.synchronous = YES;
                originRequestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(75, 75) contentMode:PHImageContentModeAspectFill options:originRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    
                    NSDictionary * dic = @{@"image":result,@"title":collection.localizedTitle,@"count":count };
                    [_sectionOne addObject:dic];
                    
                }];
            }
            
            
            
            
        }
    }
    [self.albumArray addObject:albumOne];
    [self.dataSouce addObject:_sectionOne];
    
   
    


}
//获取自身的相册
-(void)getMyselfAlbum
{
    _sectionTwo = [NSMutableArray new];
    NSMutableArray * albumTwo = [NSMutableArray new];
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
  
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        // 获取一个相册（PHAssetCollection）
        PHCollection *collection = smartAlbums[i];
        NSLog(@"two-title%@",collection.localizedTitle);
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            // 从每一个智能相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            NSNumber * count = [NSNumber numberWithInteger:fetchResult.count];
            PHAsset  * asset = fetchResult.lastObject;
            if (count.integerValue!=0) {
                 [albumTwo addObject:collection];
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeDefault options:[PHImageRequestOptions new] resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    
                    NSDictionary * dic = @{@"image":result,@"title":collection.localizedTitle,@"count":count };
                    [_sectionTwo addObject:dic];
                    
                }];
            }
            
            
            
            
        }
    }
    [self.albumArray addObject:albumTwo];
    [self.dataSouce addObject:_sectionTwo];
    [self.tableView reloadData];


}
-(void)rightBarAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma --mark tableview datasouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSouce.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce[section].count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 33;
    }
    return 1;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return @"我的相簿";
    }
    return @"";
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier =  @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        
    }
    cell.imageView.image = [self.dataSouce[indexPath.section][indexPath.row] valueForKey:@"image"];
    cell.textLabel.text = [self.dataSouce[indexPath.section][indexPath.row]  valueForKey:@"title"];
    cell.detailTextLabel.text = [[self.dataSouce[indexPath.section][indexPath.row]  valueForKey:@"count"] description];
    cell.detailTextLabel.textColor = SecendTextColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma --mark tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PHAssetCollection * selectdeAlbum = self.albumArray[indexPath.section][indexPath.row];
    STPhotoCollectionViewController * vc  = [STPhotoCollectionViewController new];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:selectdeAlbum options:nil];
    vc.curentAlbum = fetchResult;
    vc.title = selectdeAlbum.localizedTitle;
    [self.navigationController pushViewController:vc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
