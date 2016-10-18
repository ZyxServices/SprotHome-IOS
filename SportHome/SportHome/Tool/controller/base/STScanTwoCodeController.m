//
//  LVScanTwoCodeController.m
//  lover
//
//  Created by stoneobs on 16/4/8.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STScanTwoCodeController.h"
#import <AVFoundation/AVFoundation.h>

@interface STScanTwoCodeController ()<AVCaptureMetadataOutputObjectsDelegate,AVAudioPlayerDelegate>
@property(nonatomic,strong)AVCaptureSession * session;
@property(nonatomic,strong)AVCaptureDevice * device;
@property(nonatomic,strong)AVAudioPlayer * audioPlayer;
@property(nonatomic,strong)UIImageView * scrollImage;
@property(nonatomic)BOOL isLight;

@end

@implementation STScanTwoCodeController
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"shake_match" ofType:@"wav"];
        NSURL *url=[NSURL fileURLWithPath:urlStr];
        NSError *error=nil;
        //初始化播放器，注意这里的Url参数只能时文件路径，不支持HTTP Url
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        //设置播放器属性
        _audioPlayer.numberOfLoops=0;//设置为0不循环
        _audioPlayer.delegate=self;
        [_audioPlayer prepareToPlay];//加载音频文件到缓存
        if(error){
            NSLog(@"初始化播放器过程发生错误,错误信息:%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * scanView =[[UIImageView alloc]init];
    scanView.center=self.view.center;
    scanView.bounds=CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_WIDTH/2);
    scanView.image=[UIImage imageNamed:@"scanscanBg"];
    [self.view addSubview:scanView];
    _scrollImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, scanView.width, 10)];
    _scrollImage.image=[UIImage imageNamed:@"scanLine"];
    [scanView addSubview:_scrollImage];
    [self startAnimation];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    output.rectOfInterest=CGRectMake((self.view.center.y-SCREEN_WIDTH/4)/SCREEN_HEIGHT, (self.view.center.x-SCREEN_WIDTH/4)/SCREEN_WIDTH, SCREEN_WIDTH/2/SCREEN_HEIGHT, SCREEN_WIDTH/2/SCREEN_WIDTH);
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if (input) {
        [_session addInput:input];
    }
    if (output) {
        [_session addOutput:output];
    }
    
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
    [self setRightTitle:@"开灯"];
}
-(void)RightBarAction:(id)sender
{
    self.isLight=!self.isLight;
    if (self.isLight) {
        if ([_device hasFlash] && [_device hasTorch]) {
            [_device lockForConfiguration:nil];
            [_device setFlashMode:AVCaptureFlashModeOn];
            [_device setTorchMode:AVCaptureTorchModeOn];
            [_device unlockForConfiguration];
        }
    }
    else{
        if ([_device hasFlash] && [_device hasTorch]) {
            [_device lockForConfiguration:nil];
            [_device setFlashMode:AVCaptureFlashModeOff];
            [_device setTorchMode:AVCaptureTorchModeOff];
            [_device unlockForConfiguration];
        }
    }
    
    
}
-(void)startAnimation
{
    __weak STScanTwoCodeController * weakSelf =self;
    [UIView animateWithDuration:1.5 animations:^{
        self.scrollImage.top=SCREEN_WIDTH/2-10;
    } completion:^(BOOL finished) {
        [weakSelf cicleAnimation];
    }];
}
-(void)cicleAnimation
{
    self.scrollImage.top=0;
    __weak STScanTwoCodeController * weakSelf =self;
    [UIView animateWithDuration:1.5 animations:^{
        self.scrollImage.top=SCREEN_WIDTH/2-10;
    } completion:^(BOOL finished) {
        [weakSelf startAnimation];
    }];
}
-(void)setResultBlock:(TWOCODERESULT)resultBlock
{
    if (resultBlock) {
        _resultBlock=resultBlock;
    }
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [_session stopRunning];
        [self.audioPlayer play];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        NSString * result =metadataObject.stringValue;
        if (self.resultBlock) {
            self.resultBlock(result);
        }
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideNavagetionbar];
    [_session startRunning];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showNavagationbar];
    self.tabBarController.tabBar.hidden=NO;
}

@end
