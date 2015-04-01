//
//  iCouponCompleteViewController.m
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import "ICouponCompleteViewController.h"
#import "CachedImageView.h"
#import "UIImage+animatedGIF.h"
#import <ZXingObjC.h>
@interface ICouponCompleteViewController ()<CountdownDelegate>
@property (strong, nonatomic) JBCountdownLabel *countdownLabel;
@property (nonatomic, assign) float   brightNess;
@end
@implementation ICouponCompleteViewController
@synthesize v_rmvc;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scv_container.backgroundColor = [UIColor whiteColor];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.

     _brightNess = [[UIScreen mainScreen] brightness];
    [self setMenuBar3];
    

    if([[self.data_response valueForKey:@"coupon_use"]valueForKey:@"show_code_methed"]){
        self.codeType = [[self.data_response valueForKey:@"coupon_use"]valueForKey:@"show_code_methed"];
    }
    
    if(self.style == THANKYOU_STYLE_METHOD1){
        [self setupView1];
    }else if(self.style == THANKYOU_STYLE_METHOD2){
        [self setupView2];
    }else{
        [self setupView3];
    }
//    [self setupView3];
    [self setupUI];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

- (void)setupUI{
    
    //Method 1 UI
//    if(![[self.data_response valueForKey:@"coupon_use"]valueForKey:@"show_code_methed"]){
    if([[[self.data_response valueForKey:@"coupon_use"] valueForKey:@"method"] intValue] == 1){
        self.view_method1.hidden = NO;
        self.scv_container.hidden = YES;
        self.lbl_tranId1.text = [NSString stringWithFormat:@"Transaction ID: %@",[[self.data_response valueForKey:@"coupon_use"] valueForKey:@"transaction_id"]];
        if([[self.data_response valueForKey:@"coupon_use"] valueForKey:@"coupon_code"]){
            self.lbl_couponId1.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"iCoupon.myWallet.couponID",nil),[[self.data_response valueForKey:@"coupon_use"] valueForKey:@"coupon_code"]];

            
                                         
        }else{
            self.lbl_couponId1.text = @"";
            self.lbl_couponTitle.text = @"";
        }
        self.lbl_couponId.hidden = YES;
        
        

        [self.imv_icon1 loadImageWithURL:[self.data_couponDetails valueForKey:@"image_l"]];
        self.lbl_title1.text = [NSString stringWithFormat:@"%@",[self.data_couponDetails valueForKey:@"merchant_name"]];
        //    self.lbl_title.adjustsFontSizeToFitWidth = YES;
        self.lbl_subTitle1.text = [NSString stringWithFormat:@"%@",[self.data_couponDetails valueForKey:@"item_desc_l"]];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:NSLocalizedString(@"iCoupon.myWalle.thanksGIF", nil) withExtension:@"gif"];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage animatedImageWithAnimatedGIFURL:url]];
        imageView.frame = self.imv_thanks1.frame;
        [self.view_method1 addSubview:imageView];
        
    }else{
        self.view_method1.hidden = YES;
        self.scv_container.hidden = NO;
        
//        self.lbl_tranId.text = [NSString stringWithFormat:@"Transaction ID: %@",[[self.data_response valueForKey:@"coupon_use"] valueForKey:@"transaction_id"]];
//        self.lbl_couponId.text = [NSString stringWithFormat:@"Coupon ID: %@",[[self.data_response valueForKey:@"coupon_use"] valueForKey:@"coupon_code"]];

        self.lbl_tranId.text   = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"iCoupon.myWallet.transactionID",nil),[[self.data_response valueForKey:@"coupon_use"] valueForKey:@"transaction_id"]];
        self.lbl_couponTitle.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"iCoupon.myWallet.couponID", nil)];
        self.lbl_couponId.text = [NSString stringWithFormat:@"%@", [[self.data_response valueForKey:@"coupon_use"] valueForKey:@"coupon_code"]];
        [self.lbl_couponId adjustFontSizeToFillItsContents];

        

        if([[self.data_response valueForKey:@"coupon_use"]valueForKey:@"show_code_methed"]){
            self.codeType = [[self.data_response valueForKey:@"coupon_use"]valueForKey:@"show_code_methed"];
        }
        [self.imv_icon loadImageWithURL:[self.data_couponDetails valueForKey:@"image_s"]];
        self.lbl_title.text = [NSString stringWithFormat:@"%@",[self.data_couponDetails valueForKey:@"merchant_name"]];
        //    self.lbl_title.adjustsFontSizeToFitWidth = YES;
        self.lbl_subTitle.text = [NSString stringWithFormat:@"%@",[self.data_couponDetails valueForKey:@"item_desc_l"]];
    
        
//        [self.lbl_couponId sizeToFit];
        [self genCode];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:NSLocalizedString(@"iCoupon.myWalle.thanksGIF", nil) withExtension:@"gif"];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage animatedImageWithAnimatedGIFURL:url]];
        
//        UIImageView *imageView = [AnimatedGif getAnimationForGifAtUrl:[[NSBundle mainBundle] URLForResource:NSLocalizedString(@"iCoupon.myWalle.thanksGIF", nil) withExtension:@"gif"]];
        imageView.frame = self.imv_thanks.frame;
        [self.scv_container addSubview:imageView];
        
        
        
    }
    
    self.lbl_presentLabel.text =NSLocalizedString(@"iCoupon.myWalle.present", nil);
    self.lbl_presentLabel2.text =NSLocalizedString(@"iCoupon.myWalle.present", nil);
    self.lbl_presentLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    self.lbl_presentLabel2.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    [self.btn_done setTitle:NSLocalizedString(@"iCoupon.myWallet.doneNBack",nil) forState:UIControlStateNormal];
    [self.btn_done setTitle:NSLocalizedString(@"iCoupon.myWallet.doneNBack",nil) forState:UIControlStateNormal];
    self.scv_container.contentSize = CGSizeMake(self.scv_container.contentSize.width, 680);
}

- (void)setupView1{
    self.view_QR.hidden = YES;
    CGRect transLabelFrame = self.lbl_tranId.frame;
    transLabelFrame.origin.y = transLabelFrame.origin.y - self.view_QR.frame.size.height;
    
    self.lbl_tranId.frame = transLabelFrame;
    
    
    int time = 5 * 60;
    if(self.remainTime){
        time = [self.remainTime intValue];
    }
    
    self.countdownLabel = [[JBCountdownLabel alloc] initWithFrame:CGRectMake(0, 0, self.view_timerContent.frame.size.width, self.view_timerContent.frame.size.height) format:@"%@" time:time delegate:self];
    self.countdownLabel.textColor = [UIColor redColor];
    self.countdownLabel.font = [UIFont systemFontOfSize:50];
    [self.view_timerContent addSubview:self.countdownLabel];
    self.countdownLabel.hidden = YES;
}


- (void)setupView2{
    CGRect qrFrame = self.imv_qrCode.frame;
    qrFrame.origin.y +=15;
    self.imv_qrCode.frame = qrFrame;
    
    
    int time = 5 * 60;
    if(self.remainTime){
        time = [self.remainTime intValue];
    }
    
    self.countdownLabel = [[JBCountdownLabel alloc] initWithFrame:CGRectMake(0, 0, self.view_timerContent.frame.size.width, self.view_timerContent.frame.size.height) format:@"%@" time:time delegate:self];
    self.countdownLabel.textColor = [UIColor redColor];
    self.countdownLabel.font = [UIFont systemFontOfSize:50];
    [self.view_timerContent addSubview:self.countdownLabel];
    self.countdownLabel.hidden = YES;
    
}

- (void)setupView3{
    
    
    if([[self.data_response valueForKey:@"coupon_use"] valueForKey:@"show_code_time"] || [self.remainTime intValue]){
        int time = [[[self.data_response valueForKey:@"coupon_use"] valueForKey:@"show_code_time"] integerValue] * 60;
        if(self.remainTime){
            time = [self.remainTime intValue];
        }
        
        self.countdownLabel = [[JBCountdownLabel alloc] initWithFrame:CGRectMake(0, 0, self.view_timerContent.frame.size.width, self.view_timerContent.frame.size.height) format:@"%@" time:time delegate:self];
        self.countdownLabel.textColor = [UIColor redColor];
        self.countdownLabel.font = [UIFont systemFontOfSize:50];
        [self.view_timerContent addSubview:self.countdownLabel];
    }else{
        CGRect qrFrame = self.imv_qrCode.frame;
        qrFrame.origin.y +=15;
        self.imv_qrCode.frame = qrFrame;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if(self.data_couponDetails)
        [dic setObject:self.data_couponDetails forKey:@"data_couponDetails"];
    if(self.data_response)
        [dic setObject:self.data_response forKey:@"data_response"];
    if(self.codeType)
        [dic setObject:self.codeType forKey:@"codeType"];
    if(self.style)
        [dic setObject:[NSNumber numberWithInt: self.style] forKey:@"style"];
    if(self.remainTime == nil){
        [dic setObject:[NSDate date] forKey:@"date"];
    }else{
        [dic setObject:[[defaults valueForKey:@"couponTimer"] valueForKey:@"date"] forKey:@"date"];
    }
    [defaults setObject:dic forKey:@"couponTimer"];
    
    [defaults synchronize];
    
    
}


- (void)genCode{
    NSString *qrCodeString = [[self.data_response valueForKey:@"coupon_use"] valueForKey:@"coupon_code"];
    
    
    if([self.codeType isEqualToString:CODE_STYLE_BAR] && qrCodeString){
//        [self.imv_qrCode setFrame:self.view_qrFrame.frame];
//        NKDCode128Barcode * code = [[NKDCode128Barcode alloc] initWithContent:qrCodeString];
//        UIImage * generatedImage = [UIImage imageFromBarcode:code]; // ..or as a less accurate UIImage
        
        //Keith 18-3-2015
        ZXMultiFormatWriter *writer = [[ZXMultiFormatWriter alloc] init];
        ZXBitMatrix *result = [writer encode:qrCodeString
                                      format:kBarcodeFormatCode128
                                       width: self.imv_qrCode.frame.size.width
                                      height: self.imv_qrCode.frame.size.height
                                       error:nil];
        ZXImage *image = [ZXImage imageWithMatrix:result];
        self.imv_qrCode.image = [UIImage imageWithCGImage:image.cgimage];
        [self.imv_qrCode setFrame:self.view_qrFrame.frame];

    }else{
        if( qrCodeString){
            self.imv_qrCode.image = [UIImage mdQRCodeForString:qrCodeString size:self.imv_qrCode.bounds.size.width fillColor:[UIColor blackColor]];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [self brightScreen];
}
- (void)viewDidDisappear:(BOOL)animated{
    [self recoverScreen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back_onTouch:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"iCoupon.myWallet.warning",nil) message:NSLocalizedString(@"iCoupon.myWallet.confirmBack",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
    
	[alert_view show];
    
    

}


-(void)setMenuBar3
{
    v_rmvc = [[RotateMenu4ViewController alloc] initWithNibName:@"RotateMenu4ViewController" bundle:nil] ;
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    //    v_rmvc.vc_caller = self;
    [v_rmvc.view_features setHidden:YES];
    //    [v_rmvc.btnSidemenu setHidden:YES];
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
    
}

-(void)doMenuButtonsPressed:(UIButton *)sender{
    
}

-(void)closeQRAnimation{
    CGRect basketTopFrame = self.view_QR.frame;
    basketTopFrame.origin.y = self.view_QR_lineup.frame.origin.y+basketTopFrame.size.height/2-2;
    
    CGRect basketDownFrame = self.view_QR.frame;
    basketDownFrame.origin.y =self.view_QR_linedown.frame.origin.y-basketDownFrame.size.height/2+2;
    
    CGRect transLabelFrame = self.lbl_tranId.frame;
    transLabelFrame.origin.y =transLabelFrame.origin.y - (self.view_QR_linedown.frame.origin.y-basketDownFrame.size.height/2+2);
    
    

    
    [UIView animateWithDuration:2
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.view_QR_lineup.frame = basketTopFrame;
                         self.view_QR_linedown.frame = basketDownFrame;
                         self.lbl_tranId.frame = transLabelFrame;
                     }
                     completion:^(BOOL finished){
                         self.view_QR_lineup.frame = basketTopFrame;
                         self.view_QR_linedown.frame = basketDownFrame;
                         self.lbl_tranId.frame = transLabelFrame;
                        
//                         [UIView animateWithDuration:1
//                                               delay:0
//                                             options: UIViewAnimationCurveEaseOut
//                                          animations:^{
//                                              self.view_QR.alpha = 0;
//                                              
//                                          }
//                                          completion:^(BOOL finished){
//                                              NSLog(@"Done!");
//                                          }];
                     }];
}


#pragma mark - Countdown delegate

- (void)countdownFinnishIn:(JBCountdownLabel *)countdown
{
//    [self closeQRAnimation];
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"iCoupon.myWallet.qrError.title", nil) message:NSLocalizedString(@"iCoupon.myWallet.qrExpired.msg",nil) delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK",nil),nil];
    
	[alert_view show];
//	[alert_view release];
}

//iCoupon.myWallet.qrExpired.msg
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if((buttonIndex = alertView.cancelButtonIndex)){
//
//            [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
//
//        }else{
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults removeObjectForKey:@"couponTimer"];
//            [defaults synchronize];
//            if(self && self.remainTime){
//                [self dismissModalViewControllerAnimated:YES];
//                [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
//        }
//}
////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    [defaults removeObjectForKey:@"couponTimer"];
////    [defaults synchronize];
////    [self back_onTouch:nil];
//}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"Cancel Button Pressed");
            //            [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
            if(self && self.remainTime){
                                [self dismissModalViewControllerAnimated:YES];
//                                [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
            }

            break;
        case 1:
            NSLog(@"Button 1 Pressed");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"couponTimer"];
            [defaults synchronize];
            if(self && self.remainTime){
                [self dismissModalViewControllerAnimated:YES];
                [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
            }
            break;
    }
    
}
#pragma mark - Actions

- (IBAction)restartCountdown:(id)sender
{
    [self.countdownLabel restartCountdown];
}

- (IBAction)cancelCountdown:(id)sender
{
    [self.countdownLabel cancelCountdown];
}


- (void)brightScreen {
    _brightNess = [[UIScreen mainScreen] brightness];
    
    [[UIScreen mainScreen] setBrightness:1.0];
}
- (void)recoverScreen {
    [[UIScreen mainScreen] setBrightness:_brightNess];
}

- (void)refundCoupon{
    NSLog(@"Refund Coupon");
	[[CoreData sharedCoreData].mask showMask];
	asi_request = [[ASIHTTPRequest alloc] initWithURL:
                   [NSURL URLWithString:
                    [NSString stringWithFormat:@"%@usecoupon.api?user_id=%@&method=%@&coupon_id=%@",
                     [CoreData sharedCoreData].iCouponServerURL,
                     @"user_id",
                     @"method",
                     [self.data_couponDetails valueForKey:@"id"]]]
                   ];
	asi_request.delegate = self;
	[[CoreData sharedCoreData].queue addOperation:asi_request];
}

///////////////////
//ASIHTTPRequest
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	
//    NSLog(@"debug PBConcertsListViewController requestFinished:%@",[request responseString]);
    
//	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
    
//    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLParser:xml_parser];
//    itemDetails = [xmlDoc arrayValueForKeyPath:@"coupons.coupon"][0];;
    
    
	[[CoreData sharedCoreData].mask hiddenMask];
    
//	[self setupUI];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"PBConcertsListViewController requestFailed:%@", request.error);
    
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"iCoupon.myWallet.warning",nil) message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
    [alert_view show];
//    [alert_view release];
    
	[[CoreData sharedCoreData].mask hiddenMask];
}





- (void)dealloc {
    [_imv_qrCode release];
    [_view_QR release];
    [_view_QR_linedown release];
    [_view_QR_lineup release];
    [_lbl_tranId release];
    [_view_timerContent release];
    [self recoverScreen];
    [_imv_thanks release];
    [_imv_icon release];
    [_view_qrFrame release];
    [_lbl_presentLabel release];
    [_lbl_presentLabel2 release];
    [_lbl_couponTitle release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setView_QR:nil];
    [self setView_QR_linedown:nil];
    [self setView_QR_lineup:nil];
    [self setLbl_tranId:nil];
    [self setView_timerContent:nil];
    [self setImv_thanks:nil];
    [self setImv_icon:nil];
    [self setLbl_couponId:nil];
    [self setScv_container:nil];
    [self setView_method1:nil];
    [self setImv_icon1:nil];
    [self setLbl_title:nil];
    [self setLbl_title1:nil];
    [self setLbl_subTitle1:nil];
    [self setLbl_subTitle:nil];
    [self setLbl_description:nil];
    [self setLbl_description:nil];
    [self setImv_thanks1:nil];
    [self setLbl_tranId1:nil];
    [self setBtn_done:nil];
    [self setBtn_done1:nil];
    [self setView_qrFrame:nil];
    [self setLbl_presentLabel:nil];
    [self setLbl_presentLabel2:nil];
    [super viewDidUnload];
}

@end
