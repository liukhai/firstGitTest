//
//  ICouponDetailViewController.m
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import "ICouponDetailViewController.h"
#import "RotateMenu4ViewController.h"
@interface ICouponDetailViewController (){
    RotateMenu4ViewController* v_rmvc;
    NSDictionary *itemDetails;
}

@end

@implementation ICouponDetailViewController

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
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setMenuBar3];
    [self getCouponDetail];
//    [self.wv_remark setOpaque:NO];
//    self.wv_remark.scrollView.bounces = NO;
//    self.wv_remark.delegate = self;
    [self.btn_back setTitle:NSLocalizedString(@"iCoupon.fullList.back", nil) forState:UIControlStateNormal];
    [self.btn_redeem setTitle:NSLocalizedString(@"iCoupon.fullList.redeem", nil) forState:UIControlStateNormal];
//    view_webContent.backgroundColor = [UIColor whiteColor]
//    self.txv_remark.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMenuBar3
{
//    v_rmvc = [[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] ;
//    CGRect frame3 = v_rmvc.contentView.frame;
//    frame3.origin.x =0;
//    frame3.origin.y =0;
//    v_rmvc.view.frame = frame3;
//    v_rmvc.vc_caller = self;
//    [v_rmvc setStyle: RotateMenu3Style2];
//    [self.view addSubview:v_rmvc.contentView];
//    [v_rmvc.rmUtil setNav:self.navigationController];
    
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
#pragma mark - RotateMenu4ViewControllerDelegate
-(void)doMenuButtonsPressed:(UIButton *)sender {
    
}

- (IBAction)back_onTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)redeem_onTouch:(id)sender {
    //Get pervious view controller
    ICouponListViewController *perviousCTR = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    perviousCTR.status = ICouponListStatusRedeemCoupon;
    [perviousCTR goToLoginPage:[self.data valueForKey:@"id"]];
    [self back_onTouch:nil];
}

- (void)setupUI{
    

    
    
    NSString* bigImageEncodeURL = [[itemDetails valueForKey:@"image_l"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [self.imv_bigIcon loadImageWithURL:bigImageEncodeURL];
    
//    [self.imv_bigIcon loadImageWithURL:[itemDetails valueForKey:@"image_l"]];
    
    NSString* smallImageEncodeURL = [[itemDetails valueForKey:@"image_s"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [self.imv_smallIcon loadImageWithURL:smallImageEncodeURL];
    
//    [self.imv_smallIcon loadImageWithURL:[itemDetails valueForKey:@"image_s"]];
    
    self.lbl_title.text = [NSString stringWithFormat:@"%@",[itemDetails valueForKey:@"merchant_name"]];
    self.lbl_subTitle.text = [itemDetails valueForKey:@"item_desc_l"];

//    self.lbl_title.adjustsFontSizeToFitWidth = YES;

//    [self.lbl_subTitle setMinimumFontSize:10];
//    self.lbl_subTitle.adjustsFontSizeToFitWidth = YES;
    self.lbl_bonus.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"iCoupon.fullList.bonusPoints", nil),[itemDetails valueForKey:@"required_point"]];
    if([itemDetails valueForKey:@"item_code"]){
        self.lbl_itemNo.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"iCoupon.fullList.itemNo", nil),[itemDetails valueForKey:@"item_code"]];
    }else{
        self.lbl_itemNo.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"iCoupon.fullList.itemNo", nil),@""];
    }
    
    self.lbl_remark.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"iCoupon.fullList.remark", nil)];
//    [self.wv_remark loadHTMLString:[itemDetails valueForKey:@"tnc"] baseURL:nil];
    self.txv_remark.text = [itemDetails valueForKey:@"tnc"];
    self.view_remark.hidden = [itemDetails valueForKey:@"tnc"] == nil | [[itemDetails valueForKey:@"tnc"] length] ==0;
}

#pragma API Part
-(void)getCouponDetail{
    NSLog(@"Get Coupon Detail");
	[[CoreData sharedCoreData].mask showMask];
	asi_request = [[ASIHTTPRequest alloc] initWithURL:
                   [NSURL URLWithString:
                    [NSString stringWithFormat:@"%@?Lang=%@&TxType=5&CpnId=%@",
                     [CoreData sharedCoreData].iCouponServerURL,
                     [[CoreData sharedCoreData] couponLang],
                     [self.data valueForKey:@"id"]]]
                   ];
    NSLog(@"url : %@  ",[NSString stringWithFormat:@"%@?Lang=%@&TxType=5&CpnId=%@",
                         [CoreData sharedCoreData].iCouponServerURL,
                         [[CoreData sharedCoreData] couponLang],
                         [self.data valueForKey:@"id"]]);
	asi_request.delegate = self;
    [asi_request setValidatesSecureCertificate:NO];
	[[CoreData sharedCoreData].queue addOperation:asi_request];
	
    
	NSLog(@"debug ICouponDetailViewController url:%@", asi_request.url);
    
}


-(void)redeemCoupon{
    NSLog(@"Redeem coupon");
    [[CoreData sharedCoreData].mask showMask];
    asi_request_redeem = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@couponredeem.api?user_id=%@&coupon_id=%@",
                                                                            [CoreData sharedCoreData].iCouponServerURL,
                                                                            @"user_id",
                                                                            [self.data valueForKey:@"id"]]]];
    [asi_request setValidatesSecureCertificate:NO];
    asi_request_redeem.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request_redeem];
	
    
	NSLog(@"debug ICouponDetailViewController url:%@", asi_request.url);
}



- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    
    if(frame.size.height > self.view.frame.size.height){
        frame.size.height = self.view.frame.size.height;
    }
    
    aWebView.frame = frame;
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
}


///////////////////
//ASIHTTPRequest
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	
    if(request == asi_request){
    
//        NSLog(@"debug PBConcertsListViewController requestFinished:%@",[request responseString]);
        //Format Data
        NSString *xmlString = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] substringFromIndex:8];
        //    NSString *xmlString = [[request responseString] substringFromIndex:8] ;
        
        NSData* xmlData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
        //Format End
        
        NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:xmlData];
        
        NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLParser:xml_parser];
        itemDetails = [xmlDoc arrayValueForKeyPath:@"Coupons.coupon"][0];;
        
        
        [[CoreData sharedCoreData].mask hiddenMask];
        
        [self setupUI];
    }else if(request == asi_request_redeem){
        
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"PBConcertsListViewController requestFailed:%@", request.error);
    
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"iCoupon.myWallet.warning",nil) message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
    [alert_view show];
//    [alert_view release];
    
	[[CoreData sharedCoreData].mask hiddenMask];
}



- (void)dealloc {
    [_imv_bigIcon release];
    [_imv_smallIcon release];
    [_lbl_title release];
    [_lbl_subTitle release];
    [_lbl_bonus release];
    [_lbl_itemNo release];
    [_view_webContent release];
    [_btn_back release];
    [_btn_redeem release];
    [_txv_remark release];
    [_view_remark release];
    [_lbl_remark release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImv_bigIcon:nil];
    [self setImv_smallIcon:nil];
    [self setLbl_title:nil];
    [self setLbl_subTitle:nil];
    [self setLbl_bonus:nil];
    [self setLbl_itemNo:nil];
    [self setView_webContent:nil];
    [self setBtn_back:nil];
    [self setBtn_redeem:nil];
    [self setTxv_remark:nil];
    [self setView_remark:nil];
    [self setLbl_remark:nil];
    [super viewDidUnload];
}
@end
