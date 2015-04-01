//
//  QRCodeScannerViewController.m
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import "QRCodeScannerViewController.h"
#import "RotateMenu4ViewController.h"
@interface QRCodeScannerViewController (){
    RotateMenu4ViewController* v_rmvc;
}

@end

@implementation QRCodeScannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setMenuBar4
{
    v_rmvc = [[RotateMenu4ViewController alloc] initWithNibName:@"RotateMenu4ViewController" bundle:nil] ;
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    //    v_rmvc.vc_caller = self;
    [v_rmvc.view_features setHidden:YES];
    [v_rmvc.btnSidemenu setHidden:YES];
    [v_rmvc.btnBack setHidden:YES];
    [v_rmvc.btnMore setHidden:YES];
    [v_rmvc.lbl_coupon setHidden:NO ];
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMenuBar4];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [UIColor whiteColor];
//	UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [scanButton setTitle:@"Cancel & Back" forState:UIControlStateNormal];
//    [scanButton setBackgroundImage:[UIImage imageNamed:@"btn_back_grey.png"] forState:UIControlStateNormal];
//    
//    scanButton.frame = CGRectMake(self.view.frame.size.width-60, self.view.frame.size.height- 25, 120, 40);
//    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:scanButton];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 380, 280, 40)];
    label.text = NSLocalizedString(@"iCoupon.myWalle.qrFocus", nil);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.lineBreakMode = 0;
    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    [self.btn_cancel setTitle:NSLocalizedString(@"iCoupon.myWallet.cancelNBack", nil) forState:UIControlStateNormal];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image =   [UIImage imageNamed:@"scan_bg.png"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
//    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110, 220, 2)];
//    _line.image = [UIImage imageNamed:@"line.png"];
//    [self.view addSubview:_line];
    
//    
//    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];

}
- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // for iOS7
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(50, 110+2*num, 220, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(50, 110+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)backAction
{
    
    [self dismissViewControllerAnimated:NO completion:^{
        [timer invalidate];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[PageUtil pageUtil] changeImageForTheme:self.view];
    [self setupCamera];
}
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+20);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [self cancel_onTouch:nil];
    [self.delegate didQRScanned:stringValue];
    NSLog(@"%@",stringValue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel_onTouch:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:^
//     {
//         [timer invalidate];
//     }];
    [self.view removeFromSuperview];
}
//- (void)dealloc {
//    [_btn_cancel release];
//    [super dealloc];
//}
- (void)viewDidUnload {
    [self setBtn_cancel:nil];
    [super viewDidUnload];
}



@end
