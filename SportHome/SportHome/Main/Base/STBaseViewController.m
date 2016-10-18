//
//  BaseViewController.m
//  lover
//
//  Created by stoneobs on 16/1/18.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface STBaseViewController ()<AVAudioPlayerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController * imageVC;
@property(nonatomic,copy)IMAGEPICKER  imgePickerBlock;
//@property(nonatomic,strong)AVAudioPlayer * audioPlayer;
@end

@implementation STBaseViewController
-(instancetype)init
{
    
    if (self=[super init]) {
        _imageVC=[[UIImagePickerController alloc]init];
        _imageVC.allowsEditing=YES;
        _imageVC.delegate=self;
      

        
    }
   

    return self;
}

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor=BACKROUND_COLOR;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
#pragma mark ----导航栏相关配置
-(void)setLeftTitle:(NSString *)title
{
    UIBarButtonItem * left =[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(leftBarAction:)];
    self.navigationItem.leftBarButtonItem=left;
}
-(void)setLeftImage:(UIImage *)image
{
    UIBarButtonItem * leftImage =[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(leftBarAction:)];
    self.navigationItem.leftBarButtonItem=leftImage;
}
-(void)setLeftImage:(UIImage *)image andwithTitle:(NSString *)title
{
    UIButton * but =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    [but setImage:image forState:UIControlStateNormal];
    [but setTitle:title forState:UIControlStateNormal];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    but.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 25);
    [but addTarget:self action:@selector(rightBarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * left =[[UIBarButtonItem alloc]initWithCustomView:but];
    
    self.navigationItem.leftBarButtonItem=left;
}
-(void)setRightTitle:(NSString *)title
{
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction:)];
    right.tintColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem=right;
}
-(void)setRightTitle:(NSString *)title titleColor:(UIColor*)color
{

    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction:)];
    right.tintColor = color;
    
    self.navigationItem.rightBarButtonItem=right;
}
-(void)setRightImage:(UIImage *)image
{
    UIImage * editimgae = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightImage =[[UIBarButtonItem alloc]initWithImage:editimgae style:UIBarButtonItemStyleDone target:self action:@selector(rightBarAction:)];
    self.navigationItem.rightBarButtonItem=rightImage;
}
-(void)setRightImage:(UIImage *)image andwithTitle:(NSString *)title
{
    UIButton * but =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    [but setImage:image forState:UIControlStateNormal];
    [but setTitle:title forState:UIControlStateNormal];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //but.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 25);
    [but addTarget:self action:@selector(rightBarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem=right;
    
}
-(void)setLeftView:(UIView *)view
{
    UIBarButtonItem * left =[[UIBarButtonItem alloc]initWithCustomView:view];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftBarAction:)];
    [view addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem=left;
    
}

-(void)setRightView:(UIView *)view
{
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:view];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightBarAction:)];
    [view addGestureRecognizer:tap];
    self.navigationItem.rightBarButtonItem=right;
    
}
-(void)rightBarAction:(id)sender
{
    
}
-(void)leftBarAction:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --alert和actionsheet
-(void)showAlert:(NSString*)message
{
    UIAlertController * art =[UIAlertController alertControllerWithTitle:@"注意！" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [art addAction:cancel];
    [self presentViewController:art animated:YES completion:nil];
}
-(void)showAlert:(NSString *)message andWithBlock:(ALERTBLOCK)finsh
{
    UIAlertController * vc =[UIAlertController alertControllerWithTitle:@"请注意" message:message preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (finsh) {
            finsh(@"确认");
        }
    }]];
    [self presentViewController:vc animated:YES completion:nil];
    
}
-(void)showAlertCancelAndConfirm:(NSString*)message andWithBlock:(ALERTBLOCK)finsh
{
    UIAlertController * vc =[UIAlertController alertControllerWithTitle:@"请注意" message:message preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (finsh) {
            finsh(@"取消");
        }
    }]];
    [vc addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (finsh) {
            finsh(@"确认");
        }
    }]];


    [self presentViewController:vc animated:YES completion:nil];


}
-(void)showAlertCustomTitleOne:(NSString *)one Two:(NSString*)two  message:(NSString*)message andWithBlock:(ALERTBLOCK)finsh
{
    UIAlertController * vc =[UIAlertController alertControllerWithTitle:@"请注意" message:message preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:[UIAlertAction actionWithTitle:one style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (finsh) {
            finsh(one);
        }
    }]];
    [vc addAction:[UIAlertAction actionWithTitle:two style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (finsh) {
            finsh(two);
        }
    }]];
    
    
    [self presentViewController:vc animated:YES completion:nil];

}
-(void)showActionSheet:(NSArray<NSString *> *)strArray andWithBlock:(ACTIONBLOCK)test
{
    
    UIAlertController * sheet =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<strArray.count; i++) {
        UIAlertAction * action =[UIAlertAction actionWithTitle:strArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (test) {
                test(i);
            }
            
            
        }];
        [sheet addAction:action];
    }
    
    [self presentViewController:sheet animated:YES completion:^{
        
    }];
}
#pragma mark ----默认image picker 和他的delegate
-(void)showDefultImagePicker:(IMAGEPICKER)pickerBlock
{
    UIAlertController * sheet =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * camer =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!TARGET_OS_SIMULATOR) {
            _imageVC.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_imageVC animated:YES completion:nil];
        }
        
    }];
    [sheet addAction:camer];
    UIAlertAction * photo =[UIAlertAction actionWithTitle:@"从相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imageVC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imageVC animated:YES completion:nil];
    }];
    [sheet addAction:photo];
    UIAlertAction * cancle =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sheet addAction:cancle];
    
    [self presentViewController:sheet animated:YES completion:nil];
    if (pickerBlock) {
        _imgePickerBlock=pickerBlock;
    }
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *   image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
        if (_imgePickerBlock) {
            _imgePickerBlock(image);
        }
    }];
}




#pragma mark --播放声音
//-(AVAudioPlayer *)audioPlayer{
//    if (!_audioPlayer) {
//        NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"composer_open" ofType:@"wav"];
//        NSURL *url=[NSURL fileURLWithPath:urlStr];
//        NSError *error=nil;
//        //初始化播放器，注意这里的Url参数只能时文件路径，不支持HTTP Url
//        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
//        //设置播放器属性
//        _audioPlayer.numberOfLoops=0;//设置为0不循环
//        _audioPlayer.delegate=self;
//        [_audioPlayer prepareToPlay];//加载音频文件到缓存
//        if(error){
//            NSLog(@"初始化播放器过程发生错误,错误信息:%@",error.localizedDescription);
//            return nil;
//        }
//    }
//    return _audioPlayer;
//}
//-(void)playOpenVoice
//{
//    [self.audioPlayer play];
//
//}
-(void)showNavagationbar
{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)hideNavagetionbar
{
    self.navigationController.navigationBar.hidden = YES;

}
@end
