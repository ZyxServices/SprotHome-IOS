//
//  SHCommunityCollectionViewCell.m
//  SportHome
//
//  Created by stoneobs on 16/10/18.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "SHCommunityCollectionViewCell.h"
#import "UIView+Direction.h"
@interface SHCommunityCollectionViewCell()
@property(nonatomic,strong)STButton * iconButton;
@property(nonatomic,strong)STLabel * titleLable;
@property(nonatomic,strong)STLabel * numLbabel;
@end

@implementation SHCommunityCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews
{
    self.iconButton = [[STButton alloc] initWithFrame:CGRectMake(2, 2, 80, 40) title:nil titleColor:nil titleFont:0 cornerRadius:0 backgroundColor:nil backgroundImage:[UIImage imageNamed:@"IMG_0350"] image:nil];
    [self addSubview:self.iconButton];
    
    self.titleLable = [[STLabel alloc] initWithFrame:CGRectMake(self.iconButton.right+2, 10, 100, 20) text:@"蹦极" textColor:FirstTextColor font:14 isSizetoFit:YES textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.titleLable];
    
    self.numLbabel = [[STLabel alloc] initWithFrame:CGRectMake(self.iconButton.right+2, self.titleLable.bottom+3, 100, 20) text:@"1000人正在吹牛" textColor:FirstTextColor font:14 isSizetoFit:YES textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.numLbabel];

}
-(void)setModel:(NSObject *)model
{
    if (model) {
        _model = model;
    }
}
@end
