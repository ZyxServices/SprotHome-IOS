//
//  STCalenderView.m
//  SportClub
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//
#import "STButton.h"
#import "STCalenderView.h"
#import "STLabel.h"
#import "STMonthModel.h"
#import "STCalenderModel.h"
#import "STCalenderViewCollectionViewCell.h"
#import "NSDate+Formatter.h"
@interface STCalenderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic)CGFloat  calenderWidh;
@property(nonatomic)CGFloat  calenderHeight;
@property(nonatomic,strong)STButton * leftButton;
@property(nonatomic,strong)STButton * middleButton;
@property(nonatomic,strong)STButton * rightButton;
@property (strong, nonatomic) NSDate *tempDate;
@property(nonatomic,strong)NSMutableArray<STMonthModel*> * datasouce;
@end
@implementation STCalenderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: date];
        self.tempDate = [date  dateByAddingTimeInterval: interval];
        self.calenderWidh=self.right-50;
        [self initBasicButton];
        [self initBasicLabel];
        //接受点击事件的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollNotifi:) name:@"STCalenderViewCollectionViewCellNeedScrollToLastNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollNotifi:) name:@"STCalenderViewCollectionViewCellNeedScrollToNextNotification" object:nil];
        
        self.datasouce=[NSMutableArray new];
        [self getBasicData];
        
        
        UICollectionViewFlowLayout * flow =[UICollectionViewFlowLayout new];
        [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flow.minimumLineSpacing=0;
        flow.minimumInteritemSpacing=0;
        flow.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, self.right, self.height-60) collectionViewLayout:flow];
        self.collectionView.backgroundColor=[UIColor grayColor];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.pagingEnabled=YES;
        
        self.collectionView.showsHorizontalScrollIndicator=NO;
        [self.collectionView registerClass:[STCalenderViewCollectionViewCell class] forCellWithReuseIdentifier:@"firstItem"];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.datasouce.count/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        [self addSubview:self.collectionView];
        
    }
    return self;
}
//收到通知选择左右滑动
-(void)scrollNotifi:(NSNotification*)sender
{
    if ([sender.object isEqualToString:@"last"]) {
        [self topButtonAction:self.leftButton];
    }
    else
    {
        [self topButtonAction:self.rightButton];
    }
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//获取基本数据，三个月，本月和上下月
-(NSMutableArray*)getBasicData
{
    [self.datasouce addObject:[self getDataDayModel:self.tempDate todayOrOther:0] ];
    
    [self.datasouce addObject:[self getDataDayModel:self.tempDate todayOrOther:1] ];
    [self.datasouce addObject:[self getDataDayModel:self.tempDate todayOrOther:2] ];
    return nil;
    
}
//以后会通过delegate 自定义一些布局
-(void)initBasicButton
{
    self.leftButton=[[STButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44) title:@"" titleColor:nil titleFont:0 cornerRadius:0 backgroundColor:nil backgroundImage:[UIImage imageNamed:@"turn_left"] image:nil];
    self.leftButton.tag=1;
    [self.leftButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftButton];
    self.middleButton=[[STButton alloc] initWithFrame:CGRectZero title:@"2016年5月" titleColor:RGB(0x2e343b) titleFont:13 cornerRadius:0 backgroundColor:nil backgroundImage:nil image:nil];
    self.middleButton.frame=CGRectMake(0, 0, 100, 20);
    self.middleButton.center=CGPointMake(self.center.x, self.leftButton.center.y);
    
    self.middleButton.contentHorizontalAlignment=UIControlContentVerticalAlignmentCenter;
    self.middleButton.tag=2;
    [self.middleButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.middleButton];
    
    self.rightButton=[[STButton alloc] initWithFrame:CGRectMake(self.right-44, 20, 44, 44) title:nil titleColor:nil titleFont:0 cornerRadius:0 backgroundColor:nil backgroundImage:[UIImage imageNamed:@"turn_right"] image:nil];
    self.rightButton.tag=3;
    [self.rightButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightButton];
}
-(void)initBasicLabel
{
    CGFloat lableWidth =self.calenderWidh/6;
    NSArray * array =@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i=0; i<7; i++) {
        STLabel * label = [[STLabel alloc] initWithFrame:CGRectMake(i*lableWidth+25, self.leftButton.bottom+10, lableWidth, 12) text:array[i] textColor:[UIColor grayColor] font:11 isSizetoFit:NO textAlignment:NSTextAlignmentLeft];
        [self addSubview:label];
    }
}
-(void)topButtonAction:(UIButton*)sender
{
    if (sender.tag==1) {
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x-self.width, 0) animated:YES];
    }
    if (sender.tag==2) {
        
    }
    if (sender.tag==3) {
        
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x+self.width, 0) animated:YES];
        
        
        
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{

    STCalenderViewCollectionViewCell * mycell =(STCalenderViewCollectionViewCell*)cell;
    
    [mycell.collectionView reloadData];
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.datasouce.count;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.width, self.height-60);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    STCalenderViewCollectionViewCell * cell =[self.collectionView dequeueReusableCellWithReuseIdentifier:@"firstItem" forIndexPath:indexPath];
    cell.dayArray=self.datasouce[indexPath.section].calenderArray;
 
    return cell;
}

//动态加入新数据
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //  NSLog(@"%f",scrollView.contentOffset.x);
    //滑动到最左或者最右增加新数据
    if (scrollView.contentOffset.x<=0) {
        //增加一个就删除一个，优化
        [self.datasouce insertObject:[self getDataDayModel:self.datasouce.firstObject.currentMonth todayOrOther:0] atIndex:0];
        [self.datasouce removeObjectAtIndex:self.datasouce.count-1];
        [self.collectionView reloadData];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
  
        
    }
    //倒数第1个开始加数据
    if (scrollView.contentOffset.x>=self.width*self.datasouce.count-self.width) {
        //增加一个就删除一个，优化
        [self.datasouce insertObject:[self getDataDayModel:self.datasouce.lastObject.currentMonth todayOrOther:2] atIndex:self.datasouce.count];
        [self.datasouce removeObjectAtIndex:0];
        [self.collectionView reloadData];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.datasouce.count-2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        
        
    }
    CGFloat xxxx=scrollView.contentOffset.x;
    int num =xxxx/self.width;
    [self.middleButton setTitle:self.datasouce[num].currentMonth.yyyyMMByLineWithDate forState:UIControlStateNormal];
   // [self.collectionView reloadData];千万不要在这里reloaddata，不然会卡死的，这里滑动一下会触发无数次事件
    
}


#pragma mark -Private-----------------------------日历计算------------------------------
//获得cell上cell的数据，num，0昨天，1今天2明天

- (STMonthModel*)getDataDayModel:(NSDate *)date todayOrOther:(NSInteger)num
{
    NSUInteger days ;//这个月多少天
    NSInteger week ;//将要新加的数据这月的第一天是周几，因为从周日开始，所以如果是4其实是周三
    switch (num) {
        case 0:
            days =[self numberOfDaysInMonth:[self getLastMonth:date]];
            week= [self startDayOfWeek:[self getLastMonth:date]];
            break;
        case 1:
            days =[self numberOfDaysInMonth:date];
            week= [self startDayOfWeek:date];
            break;
        case 2:
            days =[self numberOfDaysInMonth:[self getNextMonth:date]];
            week= [self startDayOfWeek:[self getNextMonth:date]];
            break;
        default:
            break;
    }
    STMonthModel * monthModel =[STMonthModel new];
    
    monthModel.calenderArray= [[NSMutableArray alloc] initWithCapacity:42];
    monthModel.currentMonth=[self currentMonthIsWhat:date thisMonthOrOther:num];
    
    int day = 1;
    for (int i= 1; i<days+week; i++) {
        if (i<week) {
            NSInteger lastnum=0;//将要新家的数据上个月多少天
            if (num==0) {lastnum =[self numberOfDaysInMonth:[self getLastMonth:[self getLastMonth:date]]];}
            if (num==1) {lastnum=[self numberOfDaysInMonth:[self getLastMonth:date]];}
            if (num==2) {lastnum=[self numberOfDaysInMonth:date];}
            STCalenderModel *mon = [STCalenderModel new];
            mon.dayValue = lastnum-week+i+1;
            mon.monthValue=[self currentMonthIsWhat:[self getLastMonth:date] thisMonthOrOther:0];
            mon.isLastMonth=YES;
            
            
            [monthModel.calenderArray addObject:mon];
        }else{
            STCalenderModel *mon = [STCalenderModel new];
            mon.dayValue = day;
            //下午四点再来测试，四点会出bug
            NSDate *dayDate = [self dateOfDay:day thisMonthOrOther:num date:date];
            mon.dateValue = dayDate;
//              NSTimeZone *zone = [NSTimeZone systemTimeZone];
//                NSInteger interval = [zone secondsFromGMTForDate: dayDate];
//                dayDate = [dayDate  dateByAddingTimeInterval: interval];
            
            if ([dayDate.yyyyMMddByLineWithDate isEqualToString:self.tempDate.yyyyMMddByLineWithDate]) {
                mon.isSelectedDay = YES;
            }
            else{
                mon.isSelectedDay=NO;
            }

            mon.monthValue=[self currentMonthIsWhat:date thisMonthOrOther:1];
            mon.isThisMonth=YES;
            [monthModel.calenderArray addObject:mon];
            day++;
            
            
        }
    }
    NSInteger mmmm=days+week;
    for (NSInteger i= mmmm; i<=42; i++) {
        STCalenderModel *mon = [STCalenderModel new];
        mon.isNextMonth=YES;
        mon.dayValue = i-mmmm+1;
        mon.monthValue=[self currentMonthIsWhat:date thisMonthOrOther:2];
        [monthModel.calenderArray addObject:mon];
    }
    return monthModel;
    
}
//测试正确
- (NSUInteger)numberOfDaysInMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
}
//当前月错误，应该是这里，日期都是对的就是月错误
- (NSDate*)currentMonthIsWhat:(NSDate*)date thisMonthOrOther:(NSInteger)num
{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];//Asia/Shanghai
    // [greCalendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute|NSCalendarUnitSecond
                               fromDate:[self firstDateOfMonth:date]];
   // comps.hour=10;
    switch (num) {
        case 0:
            comps.month=comps.month-1;
            break;
        case 1:
            comps.month=comps.month;
            break;
        case 2:
            comps.month=comps.month+1;
            break;
        default:
            break;
    }
    
    return [greCalendar dateFromComponents:comps];
    
}
- (NSDate *)firstDateOfMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute|NSCalendarUnitSecond
                               fromDate:date];
    comps.day = 1;
    return [greCalendar dateFromComponents:comps];
}

- (NSUInteger)startDayOfWeek:(NSDate *)date
{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];//Asia/Shanghai
    // [greCalendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay
                               fromDate:[self firstDateOfMonth:date]];
    return comps.weekday;
}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!之前差距八小时，将年到秒写完时间就对了
- (NSDate *)getLastMonth:(NSDate *)date{
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    // [greCalendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute|NSCalendarUnitSecond
                               fromDate:date];
    comps.month =comps.month - 1;
    //comps.hour=10;
    //时间不对，差了40分钟
    NSDate * test =[greCalendar dateFromComponents:comps];
  //  NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: test];
//    test = [test  dateByAddingTimeInterval: interval];
    
    
    return test;
}

- (NSDate *)getNextMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute|NSCalendarUnitSecond
                               fromDate:date];
    comps.month += 1;
    comps.hour=10;
    return [greCalendar dateFromComponents:comps];
}
//需要传入月
- (NSDate *)dateOfDay:(NSInteger)day  thisMonthOrOther:(NSInteger)num  date:(NSDate*)date
{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute|NSCalendarUnitSecond
                               fromDate:date];
    comps.day = day;
    
    switch (num) {
        case 0:
            comps.month=comps.month-1;
            break;
        case 1:
            comps.month=comps.month;
            break;
        case 2:
            comps.month=comps.month+1;
            break;
        default:
            break;
    }
    
    return [greCalendar dateFromComponents:comps];
}
@end
