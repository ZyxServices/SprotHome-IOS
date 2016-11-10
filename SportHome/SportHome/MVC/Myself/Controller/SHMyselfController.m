//
//  SHMyselfController.m
//  SportHome
//
//  Created by stoneobs on 16/10/18.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "SHMyselfController.h"
#import "SHMyHomeTableViewCell.h"
@interface SHMyselfController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,assign)float backImgOrgy;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) UIImageView *headerBg;
@property (nonatomic,retain) UIView *headerView;
@end

@implementation SHMyselfController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    // [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //[self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addHeadView];
    [self addTableView];

}
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)addTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorInset = UIEdgeInsetsZero;
    
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = [UIView new];

}

- (void)addHeadView {
    _headerBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    _headerBg.image = [UIImage imageNamed:@"bg_me"];
    [self.view addSubview:_headerBg];
    _backImgHeight=_headerBg.frame.size.height;
    _backImgWidth=_headerBg.frame.size.width;
    _backImgOrgy=_headerBg.frame.origin.y;
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 37, 30, 25, 25);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"nav_set"] forState:UIControlStateNormal];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(12, 30, 25, 25);
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"nav_mail"] forState:UIControlStateNormal];
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];

    _headerView.backgroundColor = [UIColor clearColor];
    
//    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [loginBtn setTitle:@"点击登录" forState:UIControlStateNormal];
//    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_headerView addSubview:loginBtn];
//    loginBtn.frame = CGRectMake(SCREEN_WIDTH/2-55, 150, 110, 45);
//    loginBtn.layer.masksToBounds = YES;
//    loginBtn.layer.borderWidth = 0.5;
//    loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    loginBtn.layer.cornerRadius = 22.5;
//    
//    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-70, CGRectGetMaxY(loginBtn.frame) + 10, 140, 13)];
//    loginLabel.text = @"快来登录查看详情哟～";
//    loginLabel.textAlignment = NSTextAlignmentCenter;
//    loginLabel.font = [UIFont systemFontOfSize:13];
//    loginLabel.alpha = 0.6;
//    loginLabel.textColor = RGB(0xffffff);
//    [_headerView addSubview:loginLabel];
    
    XZImageOC *avatar = [[XZImageOC alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 64, 80, 80)];
    avatar.backgroundColor = [UIColor grayColor];
    avatar.cornerRadius = 40;
    [_headerView addSubview:avatar];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, CGRectGetMaxY(avatar.frame) + 20, 100, 15)];
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.text = @"萌妹子";
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor whiteColor];
    [_headerView addSubview:nameLabel];
    
    XZLabelOC *lvLabel = [[XZLabelOC alloc] init];
    lvLabel.frame = CGRectMake(SCREEN_WIDTH/2 + 5, CGRectGetMaxY(avatar.frame) + 20, 60, 12);
    lvLabel.text = @"略有小成";
    lvLabel.textColor = [UIColor whiteColor];
    lvLabel.font = [UIFont systemFontOfSize:12];
    lvLabel.bwidth = 0.5;
    lvLabel.bcolor = [UIColor whiteColor];
    lvLabel.cornerRadius = 5;
    lvLabel.centerY = nameLabel.centerY;
    [_headerView addSubview:lvLabel];
    
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, CGRectGetMaxY(nameLabel.frame) + 10, 200, 12)];
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.alpha = 0.5;
    desLabel.text = @"个人简介:";
    desLabel.font = [UIFont systemFontOfSize:12];
    desLabel.textColor = [UIColor whiteColor];
    [_headerView addSubview:desLabel];

    
    XZDoubleLabelView *centerView = [[XZDoubleLabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 35, CGRectGetMaxY(desLabel.frame) + 20, 70, 34)];
    centerView.titleLabel.text = @"粉丝";
    centerView.numsLabel.text = @"25";
    [_headerView addSubview:centerView];
    
    XZDoubleLabelView *leftView = [[XZDoubleLabelView alloc] initWithFrame:CGRectMake(centerView.left - 100, centerView.top, 70, 34)];
    leftView.titleLabel.text = @"关注";
    leftView.numsLabel.text = @"20";
    [_headerView addSubview:leftView];
    
    XZDoubleLabelView *rightView = [[XZDoubleLabelView alloc] initWithFrame:CGRectMake(centerView.right + 30, centerView.top, 70, 34)];
    rightView.titleLabel.text = @"攀岩币";
    rightView.numsLabel.text = @"30";
    [_headerView addSubview:rightView];
    
}


- (void)rightBtnClick {
    
}

- (void)leftBtnClick {
    
}

#pragma --mark tableview datasouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier =  @"myCell";
    SHMyHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[SHMyHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"我的活动";
        cell.icon.image = [UIImage imageNamed:@"btn_active"];
    } else if(indexPath.row == 1) {
       cell.titleLabel.text = @"我的动态";
        cell.icon.image = [UIImage imageNamed:@"btn_trends"];;
    } else if(indexPath.row == 2) {
        cell.titleLabel.text = @"我的装备秀";
        cell.icon.image = [UIImage imageNamed:@"btn_show"];;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma --mark tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offY = scrollView.contentOffset.y;
    if (offY < 0) {
        CGRect rect =  _headerBg.frame;
        rect.size.height = _backImgHeight - offY;
        rect.size.width = _backImgWidth* (_backImgHeight - offY)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _headerBg.frame = rect;

    }
}
@end
