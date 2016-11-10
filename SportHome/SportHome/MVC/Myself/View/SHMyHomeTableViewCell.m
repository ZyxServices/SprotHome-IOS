//
//  SHMyHomeTableViewCell.m
//  SportHome
//
//  Created by zhaowei on 10/11/16.
//  Copyright © 2016年 zhaowei. All rights reserved.
//

#import "SHMyHomeTableViewCell.h"

@implementation SHMyHomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    return self;
    
}

- (void)addSubViews {
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 20, 20)];
    _icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_icon];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame) + 10, 15, 100, 15)];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.textColor = RGB(0x656565);
    _titleLabel.font = [UIFont systemFontOfSize:15];
    
}
@end
