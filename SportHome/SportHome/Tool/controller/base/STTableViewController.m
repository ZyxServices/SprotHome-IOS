//
//  STTableViewController.m
//  SportClub
//
//  Created by stoneobs on 16/7/28.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "STTableViewController.h"
@interface STTableViewController()
@property(nonatomic,strong)NSMutableArray * heightArray;
@property(nonatomic,strong)NSArray * dataSouce;
@end
@implementation STTableViewController
- (instancetype)init
{
    
    return [self initwithStyle:UITableViewStyleGrouped];
}
-(instancetype)initwithStyle:(UITableViewStyle )style
{
    if (self==[super init]) {
        self.tableView=[[UITableView alloc] initWithFrame:SCREEN_FRAME style:style];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
        self.tableView.backgroundColor=BACKROUND_COLOR;
        self.tableView.separatorColor=RGB(0xE5E5E5);
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    self.heightArray=[NSMutableArray new];
    [self.view addSubview:self.tableView];
}
#pragma mark --接受通知和处理
-(void)getTheNotifacationkkk:(NSString*)notifacationName
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReciveNotifacationActionkkk:) name:notifacationName object:nil];
    
}
//8.3号添加，返回cell上的键盘时未测试
-(void)didReciveNotifacationActionkkk:(NSNotification*)object
{
    
    NSDictionary *userInfo = object.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //随着键盘变换高度
    
    for (int i=0; i<self.dataSouce.count; i++) {
        UIView * view =self.dataSouce[i];
        if (![view.superview isKindOfClass:[UIView class]]) {
            
            NSLog(@"STTableViewControllerKeyBordDelegate 代理中返回的数组中的%@为空，不做处理",NSStringFromClass([view class]));
            // NSAssert(NO, @"STTableViewControllerKeyBordDelegate 代理中返回的数组中含有非view得对象");
        }
        else if ([view.superview isKindOfClass:[UITableViewCell class]]) {
            [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:(UITableViewCell*)view] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        else
        {
            
                CGFloat hei =[self.heightArray[i] floatValue];
                [UIView animateWithDuration:duration animations:^{
                    
                    view.bottom=keyboardF.origin.y-hei;
                }];
            
            
            
            
        }
        
    }
    
    
    
    if (self.STTableViewControllerKeyBordDelegate&&[self.STTableViewControllerKeyBordDelegate respondsToSelector:@selector(keyBordEndChangeFrame:)]) {
        [self.STTableViewControllerKeyBordDelegate keyBordEndChangeFrame:keyboardF];
    }
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.STTableViewControllerKeyBordDelegate) {

        
        
    }
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.STTableViewControllerKeyBordDelegate&&[self.STTableViewControllerKeyBordDelegate respondsToSelector:@selector(viewsNeedChangeFrameWhenKeyBordFrameChanged)]) {
        self.dataSouce=[self.STTableViewControllerKeyBordDelegate viewsNeedChangeFrameWhenKeyBordFrameChanged];
        [self getTheNotifacationkkk:@"UIKeyboardWillChangeFrameNotification"];
        for (UIView * view in self.dataSouce) {
            if (![view.superview isKindOfClass:[UIView class]]) {
                NSLog(@"STTableViewControllerKeyBordDelegate 代理中返回的数组中的%@为空，将不做处理",NSStringFromClass([view class]));
                CGFloat heigth =0;
                NSString * hStr=[NSString stringWithFormat:@"%f",heigth];
                [self.heightArray addObject:hStr];
            }
            else{
                
                CGFloat heigth =SCREEN_HEIGHT- view.bottom;
                NSString * hStr=[NSString stringWithFormat:@"%f",heigth];
                [self.heightArray addObject:hStr];
                
                
            }
        }
    }
}
#pragma --mark tableview datasouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier =  @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%lu",indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma --mark tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
