//
//  STPickerVIewController.m
//  SportClub
//
//  Created by stoneobs on 16/8/10.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "STPickerVIewController.h"
#import "NSDate+Formatter.h"
#import "UIView+Direction.h"
@interface STPickerViewController()<UIPickerViewDelegate,UIPickerViewDataSource>
/**
 *  当前视图
 */
@property(nonatomic,strong)UIView * curentView;
@property(nonatomic,strong)UIPickerView * areaPicker;
@property(nonatomic,strong)UIDatePicker * datePicker;

@property(nonatomic,strong)UIButton * clearBut;
@property(nonatomic,strong)UIView * pickerBack;
@property(nonatomic,strong)UIButton * confirmofBottomView;
@property(nonatomic,strong)UIButton * cancelButton;

@property(nonatomic,strong)NSArray * provinceAry;
@property(nonatomic,strong)NSMutableArray * cityAry;
@property(nonatomic,strong)NSMutableArray * areaAry;
@property(nonatomic,strong)NSMutableString * pro,*city,*area;
@property(nonatomic,strong)NSString * chosedTime;
@property(nonatomic,strong)NSDate * chosedDate;

@property(nonatomic,strong)NSArray <UIView*>* views;
@end
@implementation STPickerViewController
-(instancetype)initWithDefualtDatePicker
{
    if (self=[super init]) {
        [self initDefualt];
        self.curentView=self.datePicker;
        NSDateFormatter * fomat =[[NSDateFormatter alloc]init];
        [fomat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.chosedTime=[fomat stringFromDate:[NSDate date]];
        self.chosedDate=[NSDate date].localDate;
        
    }
    return self;
}

-(instancetype)initWithDefualtAreaPicker

{
    if (self=[super init]) {
        [self initDefualt];
        self.curentView=self.areaPicker;
    }
    
    return self;
}
-(instancetype)initWithPikcerView:(NSArray<UIView*>*)views

{
    if (self=[super init]) {
        [self initDefualt];
        self.isShowConfirm=NO;
        self.views=views;
        //当不是默认picker的时候，传入view 需要点击空白弹出模态
        UITapGestureRecognizer * re =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(killViews)];
        [self.view addGestureRecognizer:re];
    }
    return self;
}
//加载默认数据
-(void)initDefualt
{
    self.isShowConfirm=YES;
    self.isSpringAnimation=YES;
    self.bottomHeight=260;
    self.modalPresentationStyle=UIModalPresentationOverFullScreen;


}
-(void)killViews
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
//重写maxdate ，datepicker相关函数
-(void)setMaximumDate:(NSDate *)maximumDate
{
    if (maximumDate) {
        if (_datePicker) {
            _datePicker.maximumDate = maximumDate;
        }
    }
    _maximumDate = maximumDate;
}
-(void)setMinimumDate:(NSDate *)minimumDate
{
    if (minimumDate) {
        if (_datePicker) {
            _datePicker.minimumDate = minimumDate;
        }
    }
    _minimumDate = minimumDate;
}
-(void)setDatePickerMode:(UIDatePickerMode)datePickerMode
{
    if (datePickerMode) {
        if (_datePicker) {
             _datePicker.datePickerMode = datePickerMode;
        }
       
    }
    _datePickerMode = datePickerMode;
}
//areapicker 和datepicker 懒加载
-(UIDatePicker*)datePicker
{
    if (!_datePicker) {
        self.datePicker=[[UIDatePicker alloc]init];
        NSDateFormatter * formate=[[NSDateFormatter alloc]init];
        [formate setDateFormat:@"yyyy-MM-dd HH:mm"];
        self.datePicker.datePickerMode=UIDatePickerModeDate;

        self.datePicker.minimumDate=[formate dateFromString:@"1916-01-01 00:00"];
        self.datePicker.maximumDate=[NSDate date];
        self.datePicker.locale= [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [self.datePicker addTarget:self action:@selector(datepickerAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
    
    
}
-(UIPickerView*)areaPicker
{
    if (!_areaPicker) {
        _areaPicker=[[UIPickerView alloc]init];
        _areaPicker.delegate=self;
        _areaPicker.dataSource=self;
        NSString * test =[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _provinceAry =[[NSMutableArray alloc]initWithContentsOfFile:test];
        _cityAry=[NSMutableArray new];
        _areaAry=[NSMutableArray new];
        [self pickerView:self.areaPicker didSelectRow:0 inComponent:0];
        
    }
    return _areaPicker;
}
#pragma mark --vc生命周期

-(void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.curentView==self.datePicker) {
        [self bottomViewWillAppear:self.datePicker];
        return;
    }
    if (self.curentView==self.areaPicker) {
        [self bottomViewWillAppear:self.areaPicker];
        return;
    }
    if (!self.curentView) {
        //直接模态显示一个view，可以适当考虑使用动画;
        for (UIView * view in self.views) {
            [self.view addSubview:view];
        }
        return;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)datepickerAction:(UIDatePicker*)sender
{
    NSDateFormatter * fomat =[[NSDateFormatter alloc]init];
    [fomat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    UIDatePicker *picker=sender;
    self.chosedTime=[fomat stringFromDate:picker.date];
    

    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: picker.date];
    NSDate *localeDate = [picker.date  dateByAddingTimeInterval: interval];
    self.chosedDate=localeDate;
    
}

#pragma mark --弹出一个pickerview，picker都从底部弹出
-(void)bottomViewWillAppear:(UIView*)pickerView
{
    
    if (!self.clearBut) {
        self.clearBut=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-self.bottomHeight)];
        self.clearBut.backgroundColor=[UIColor grayColor];
        self.clearBut.alpha=0.15;
        [self.clearBut addTarget:self action:@selector(ClearAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view.window addSubview:self.clearBut];
    }
    else{
        self.clearBut.hidden=NO;
    }
    self.pickerBack=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.bottomHeight)];
    self.pickerBack.backgroundColor=[UIColor whiteColor];
    
    //完成取消按钮的背景
    if (self.isShowConfirm) {
        
    
    UIView * backview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    backview.backgroundColor=BACKROUND_COLOR;
    self.confirmofBottomView=[[UIButton alloc]initWithFrame:CGRectMake(self.view.right-70, 0, 60, 30)];
    [self.confirmofBottomView setTitle:@"完成" forState:UIControlStateNormal];
    self.confirmofBottomView.backgroundColor=[UIColor clearColor];
    self.confirmofBottomView.layer.cornerRadius=0;
    self.confirmofBottomView.clipsToBounds=YES;
    [self.confirmofBottomView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.confirmofBottomView addTarget:self action:@selector(confimActio) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:self.confirmofBottomView];
    self.cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60, 30)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton.backgroundColor=[UIColor clearColor];
    self.cancelButton.layer.cornerRadius=0;
    self.cancelButton.clipsToBounds=YES;
    [self.cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(bottomViewWillDisapper) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:self.cancelButton];
    [self.pickerBack addSubview:backview];
    
    }
    
    
    
    //加载picker
    if ([pickerView isKindOfClass:[UIPickerView class]]||
        [pickerView isKindOfClass:[UIDatePicker class]]) {
        pickerView.frame=CGRectMake(0, 28, SCREEN_WIDTH, self.bottomHeight-28);
        
        [self.pickerBack addSubview:pickerView];
    }
    else
    {
        [self.pickerBack addSubview:pickerView];
    }
    
    [self.view addSubview:self.pickerBack];
    
    if (self.isSpringAnimation) {
        [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionTransitionNone animations:^{
            self.pickerBack.frame=CGRectMake(0, SCREEN_HEIGHT-self.bottomHeight, SCREEN_HEIGHT, self.bottomHeight);
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.pickerBack.frame=CGRectMake(0, SCREEN_HEIGHT-self.bottomHeight, SCREEN_HEIGHT, self.bottomHeight);
        } completion:nil];
    }
    
    
}
-(void)ClearAction:(id)sender
{
    [self.view endEditing:YES];
    if (!self.clearBut.hidden) {
        self.clearBut.hidden=YES;
    }
    
    [self bottomViewWillDisapper];
}
//取消按钮
-(void)bottomViewWillDisapper
{
    [UIView animateWithDuration:0.4 animations:^{
        self.pickerBack.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_HEIGHT, self.bottomHeight);
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
    self.confirmofBottomView.frame=CGRectMake(self.view.right-70, 0, 60, 40);
    self.cancelButton.frame=CGRectMake(10, 0, 60, 40);
    
    if (!self.clearBut.hidden) {
        self.clearBut.hidden=YES;
    }
    
}
//确定按钮
-(void)confimActio
{
    [UIView animateWithDuration:0.4 animations:^{
        self.pickerBack.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_HEIGHT, self.bottomHeight);
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
    self.confirmofBottomView.frame=CGRectMake(self.view.right-70, 0, 60, 40);
    self.cancelButton.frame=CGRectMake(10, 0, 60, 40);
    if (!self.clearBut.hidden) {
        self.clearBut.hidden=YES;
    }
    
    
    if (self.areaPickerBlock&&_areaPicker) {
        if (!_area) {
            _area = [NSMutableString stringWithString:@""];
        }
        NSMutableString * finsh = [NSMutableString stringWithFormat:@"%@%@%@",_pro,_city,_area];
        _areaPickerBlock(finsh,_city,_pro);
        NSLog(@"%@",finsh);
    }
    if (_datePickerBlock&&_datePicker) {
        
        _datePickerBlock(self.chosedTime,self.chosedDate);
        NSLog(@"%@",self.chosedTime);
    }
    //完成点击事件
    
}
#pragma mark ----areapicker delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==_areaPicker) {
        if (component==0) {
            return _provinceAry.count;
        }
        if (component==1) {
            return _cityAry.count;
        }
        if (component==2) {
            return _areaAry.count;
        }
        
    }
    
    return 0;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView==_areaPicker) {
        if (component==0) {
            return [_provinceAry[row] valueForKey:@"state"];
        }
        if (component==1) {
            if (_cityAry.count>0) {
                return [_cityAry[row] valueForKey:@"city"];
            }
            else{
                return @"";
            }
            
        }
        if (component==2) {
            return _areaAry[row];
        }
        
    }
    
    return @"";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==_areaPicker) {
        if (component==0) {
            _cityAry=[_provinceAry[row] valueForKey:@"cities"];
            _areaAry=[_cityAry[0] valueForKey:@"areas"];
            [self.areaPicker reloadComponent:1];
            [self.areaPicker reloadComponent:2];
            //            [_areaPicker reloadAllComponents];
            //            [_areaPicker selectRow:5 inComponent:1 animated:YES];
            //            [_areaPicker reloadAllComponents];
            //            [_areaPicker selectRow:3 inComponent:2 animated:YES];
            
            
        }
        if (component==1) {
            if (_areaAry.count>0&&[_cityAry[row] valueForKey:@"areas"]) {
                _areaAry=[_cityAry[row] valueForKey:@"areas"];
                //                [_areaPicker reloadAllComponents];
                //                 [_areaPicker selectRow:1 inComponent:2 animated:YES];
                //               [self.areaPicker reloadComponent:1];
                [self.areaPicker reloadComponent:2];
            }
            
            
            
            
        }
        if (component==2) {
            
            
        }
        
        
        if (_areaPickerBlock) {
            
            
            if ([_areaPicker selectedRowInComponent:0]!=-1) {
                _pro=[_provinceAry[[_areaPicker selectedRowInComponent:0]] valueForKey:@"state"];
            }
            if ([_areaPicker selectedRowInComponent:1]!=-1) {
                _city = [_cityAry[[_areaPicker selectedRowInComponent:1]] valueForKey:@"city"];
                
            }
            if (_areaAry.count>0&&[_areaPicker selectedRowInComponent:2]!=-1) {
                _area = _areaAry[[_areaPicker selectedRowInComponent:2]];
            }
            //            NSMutableString * finsh = [NSMutableString stringWithFormat:@"%@%@%@",_pro,_city,_area];
            //            _areaPickerBlock(finsh,_city,_pro);
            //            finsh=nil;
        }
        
    }
    
}


@end
