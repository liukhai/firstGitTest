//
//  CouponUseViewController.m
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import "CouponUseViewController.h"
#import "ICouponCompleteViewController.h"
#import "SKSTableViewCell.h"
#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7
@interface CouponUseViewController (){
    RotateMenu4ViewController* v_rmvc;
    NSDictionary *itemDetails;
    ZBarReaderViewController * reader;
    NSArray *stepContent;
    NSArray *importantContent;
    ICouponUseStatus status;
    NSString *scannedQRString;
    
    BOOL isExpanded1;
    BOOL isExpanded2;
}
@property (nonatomic, strong) RCLabel *rclbl_notes;
@property (nonatomic, strong) RCLabel *rclbl_steps;
@end

@implementation CouponUseViewController

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
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.
//    _sktbv_stepNotes.frame = CGRectMake(0, 61, 280, 85);
    
    [self setMenuBar3];
    [self.view addSubview:self.view_notes];
    [self showNoteView];
    self.view_notes.frame = self.view.frame;
    
    [self getCouponDetail];
    
    
    [self.btn_back setTitle:NSLocalizedString(@"iCoupon.myWallet.back", nil) forState:UIControlStateNormal];
    [self.btn_useNow setTitle:NSLocalizedString(@"iCoupon.myWallet.useNow", nil) forState:UIControlStateNormal];
    [self.btn_close setTitle:NSLocalizedString(@"iCoupon.myWallet.importantNote.close", nil) forState:UIControlStateNormal];
    
    if([[self.data valueForKey:@"method"] intValue] == ICouponUseMethodOne){ //Method 1
//        [self setupCamera];
        stepContent = [[NSArray alloc] initWithObjects:NSLocalizedString(@"iCoupon.myWallet.steps2.one", nil),NSLocalizedString(@"iCoupon.myWallet.steps2.two", nil),NSLocalizedString(@"iCoupon.myWallet.steps2.three", nil),NSLocalizedString(@"iCoupon.myWallet.steps2.four", nil),NSLocalizedString(@"iCoupon.myWallet.steps2.five", nil), nil];
    }else if([[self.data valueForKey:@"method"] intValue] == ICouponUseMethodTwo){//Method 2
//        [self setupCamera];
        stepContent = [[NSArray alloc] initWithObjects:NSLocalizedString(@"iCoupon.myWallet.steps2.one", nil),NSLocalizedString(@"iCoupon.myWallet.steps2.two", nil),NSLocalizedString(@"iCoupon.myWallet.steps2.three", nil),NSLocalizedString(@"iCoupon.myWallet.steps2.four", nil),NSLocalizedString(@"iCoupon.myWallet.steps2.five", nil), nil];
    }else if([[self.data valueForKey:@"method"] intValue] == ICouponUseMethodThree){//Method 3
//        [self preUseCoupon];
        stepContent = [[NSArray alloc] initWithObjects:NSLocalizedString(@"iCoupon.myWallet.steps.one", nil),NSLocalizedString(@"iCoupon.myWallet.steps.two", nil),NSLocalizedString(@"iCoupon.myWallet.steps.three", nil),NSLocalizedString(@"iCoupon.myWallet.steps.four", nil), nil];
    }
    importantContent = [[NSArray alloc] initWithObjects:NSLocalizedString(@"iCoupon.myWallet.importantNote.one", nil),NSLocalizedString(@"iCoupon.myWallet.importantNote.two", nil), nil];


    if ([[self.data valueForKey:@"method"] intValue] == ICouponUseMethodTwo) {
        importantContent = [[NSArray alloc] initWithObjects:NSLocalizedString(@"iCoupon.myWallet.importantNote.one", nil),NSLocalizedString(@"iCoupon.myWallet.importantNote.two", nil), nil];
    }else if ([[self.data valueForKey:@"method"] intValue] == ICouponUseMethodThree){
        importantContent = [[NSArray alloc] initWithObjects:NSLocalizedString(@"iCoupon.myWallet.importantNote.one_1", nil),NSLocalizedString(@"iCoupon.myWallet.importantNote.two", nil), nil];

    }
    [self.wv_notes.scrollView setBounces:NO];

//    importantContent = [[NSArray alloc] initWithObjects:NSLocalizedString(@"iCoupon.myWallet.importantNote.one", nil),NSLocalizedString(@"iCoupon.myWallet.importantNote.two", nil), nil];
    
//    importantContent.textAlignment = NSTextAlignmentLeft;
    self.sktbv_stepNotes.scrollEnabled = NO;
    self.sktbv_stepNotes.SKSTableViewDelegate = self;
    
    [MBKUtil me].queryButtonWillShow = @"NO";
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
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

#pragma mark - Delegate method
// RTLabel
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSString*)url {
    if(rtLabel == self.rclbl_steps){
        [self showNoteView];
    }else{
        [self showNoteView];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNoteView{
    [UIView animateWithDuration:0.5 animations:^(void){
        self.view_notes.alpha = 0;
        self.view_notes.alpha = 1;
    }completion:nil];
}

- (IBAction)close_onTouch:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(void){
        self.view_notes.alpha = 1;
        self.view_notes.alpha = 0;
    }completion:nil];
}


- (void)dealloc {
    [_view_notes release];
    [_lbl_title release];
    [_lbl_subTitle release];
    [_lbl_expiryDate release];
    [_rclbl_steps release];
    [_rclbl_notes release];
    [_view_remark release];
    [_btn_back release];
    [_btn_useNow release];
    [_btn_close release];
    [_wv_notes release];
    [_sktbv_stepNotes release];
    [_wv_backgroundLogin release];
    [_scv_noteContent release];
    [super dealloc];
}


-(void)setupCamera
{
    if(IOS7)
    {
        
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        QRCodeScannerViewController * rt = [[QRCodeScannerViewController alloc]init];
        rt.delegate = self;
        
        [self.view addSubview:rt.view];
    }
    else
    {
        [self scanBtnAction];
    }
}
-(void)scanBtnAction
{
    num = 0;
    upOrdown = NO;
    //初始话ZBar
    reader = [ZBarReaderViewController new];
    //设置代理
    reader.readerDelegate = self;
    //支持界面旋转
//    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.showsHelpOnFail = NO;
    reader.showsCameraControls = NO;
    reader.showsZBarControls=NO;
    reader.scanCrop = CGRectMake(0.1, 0.2, 0.8, 0.8);//扫描的感应框
    ZBarImageScanner * scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25
                   config:ZBAR_CFG_ENABLE
                       to:0];
    UIView * view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor clearColor];
    reader.cameraOverlayView = view;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 380, 280, 40)];
    label.text = NSLocalizedString(@"iCoupon.myWalle.qrFocus", nil);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.lineBreakMode = 0;
    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_bg.png"]];
    image.contentMode = UIViewContentModeScaleToFill;
    image.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+20);
    [view addSubview:image];
    
    
    
    
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton setTitle:NSLocalizedString(@"iCoupon.myWallet.cancelNBack", nil) forState:UIControlStateNormal];
    [scanButton setBackgroundImage:[UIImage imageNamed:@"btn_orange.png"] forState:UIControlStateNormal];
    
    scanButton.frame = CGRectMake(self.view.frame.size.width/2-60, self.view.frame.size.height- 25, 140, 40);
    [scanButton addTarget:self action:@selector(dismissPicker) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:scanButton];
    
    
    [self presentViewController:reader animated:YES completion:^{
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
    }];
    
    UITapGestureRecognizer* tapScanner = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusAtPoint:)];
    [view addGestureRecognizer:tapScanner];

    
    
    
    
}




- (void)focusAtPoint:(id) sender{
    CGPoint touchPoint = [(UITapGestureRecognizer*)sender locationInView:reader.cameraOverlayView];
    double focus_x = touchPoint.x/reader.cameraOverlayView.frame.size.width;
    double focus_y = (touchPoint.y+66)/reader.cameraOverlayView.frame.size.height;
    NSError *error;
    NSArray *devices = [AVCaptureDevice devices];
    for (AVCaptureDevice *device in devices){
        NSLog(@"Device name: %@", [device localizedName]);
        if ([device hasMediaType:AVMediaTypeVideo]) {
            if ([device position] == AVCaptureDevicePositionBack) {
                NSLog(@"Device position : back");
                CGPoint point = CGPointMake(focus_y, 1-focus_x);
                if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus] && [device lockForConfiguration:&error]){
                    [device setFocusPointOfInterest:point];

                    [device setFocusMode:AVCaptureFocusModeAutoFocus];
                    [device unlockForConfiguration];
                }
            }
        }
    }
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{

    num = 0;
    upOrdown = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
    }];
}

-(void)dismissPicker{
    num = 0;
    upOrdown = NO;
    [reader dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    num = 0;
    upOrdown = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //初始化
        ZBarReaderController * read = [ZBarReaderController new];
        //设置代理
        read.readerDelegate = self;
        CGImageRef cgImageRef = image.CGImage;
        ZBarSymbol * symbol = nil;
        id <NSFastEnumeration> results = [read scanImage:cgImageRef];
        for (symbol in results)
        {
            break;
        }
        NSString * result;
        if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
            
        {
            result = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        else
        {
            result = symbol.data;
        }
        
        
        NSLog(@"%@",result);
        [self goToThanksPage:result];
    }];
}


- (IBAction)useNow_onTouch:(id)sender {

    
    NSLog(@"Check Login");
    
    status = ICouponUseStatusUseCoupon;
    [self checkLogin];

    

}

- (IBAction)back_onTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)doMenuButtonsPressed:(UIButton *)sender{
    
}



- (void)didQRScanned:(id) scannerValue {
//    [self goToThanksPage:scannerValue];
    if(scannerValue){
        scannedQRString = [[NSString alloc] initWithString: scannerValue];
        [self preUseCoupon];
    }
}

- (IBAction)goToThanksPage:(NSDictionary *)couponUseResult {
    //Get pervious view controller
    ICouponCompleteViewController * v_comCoupon = [[ICouponCompleteViewController alloc] initWithNibName:@"ICouponCompleteViewController" bundle:nil];
    v_comCoupon.style = [[self.data valueForKey:@"method"] intValue];
    v_comCoupon.data_couponDetails = itemDetails;
    v_comCoupon.data_response = couponUseResult;
    [[CoreData sharedCoreData].root_view_controller setContent:0];
    
    v_comCoupon.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    //    [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
    
    
    
    //    [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
    //    [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:v_comCoupon animated:YES];
    //    [self.navigationController popViewControllerAnimated:YES];
    //    [self.navigationController pushViewController:v_comCoupon animated:YES];
    
    
    UINavigationController *navController = self.navigationController;
    
    //Get all view controllers in navigation controller currently
    NSMutableArray *controllers=[[NSMutableArray alloc] initWithArray:navController.viewControllers] ;
    
    //Remove the last view controller
    [controllers removeLastObject];
    
    //set the new set of view controllers
    [navController setViewControllers:controllers];
    
    //Push a new view controller
    [navController pushViewController:v_comCoupon animated:NO];
    
    [v_comCoupon release];
}




#pragma API Part
-(void)getCouponDetail{
    NSLog(@"Get Coupon Detail");
	[[CoreData sharedCoreData].mask showMask];

	asi_request_detail = [[ASIHTTPRequest alloc] initWithURL:
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
	asi_request_detail.delegate = self;
    [asi_request_detail setValidatesSecureCertificate:NO];
	[[CoreData sharedCoreData].queue addOperation:asi_request_detail];
	
    
	NSLog(@"debug CouponUseViewController url:%@", asi_request_detail.url);
    
}

-(void)preUseCoupon{
    NSLog(@"Pre Use Coupon");
	[[CoreData sharedCoreData].mask showMask];
    
    if(scannedQRString == nil){
        scannedQRString = @"";
    }
    NSString *urlAddress = [NSString stringWithFormat:@"%@?TxType=3&CpnId=%@&Metd=%@&Qcd=%@",
                            [CoreData sharedCoreData].iCouponServerURL,
                            [self.data valueForKey:@"id"],
                            [self.data valueForKey:@"method"],
                            scannedQRString];

    
    
    
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [self.wv_backgroundLogin loadRequest:requestObj];
    status = ICouponUseStatusQRConfirmUse;
}

-(void)confirmUseCoupon{
    NSLog(@"Confirm Use Coupon");
	[[CoreData sharedCoreData].mask showMask];
    
    if(scannedQRString == nil){
        scannedQRString = @"";
    }
    NSString *urlAddress = [NSString stringWithFormat:@"%@?TxType=4&CpnId=%@&Metd=%@&Qcd=%@",
                            [CoreData sharedCoreData].iCouponServerURL,
                            [self.data valueForKey:@"id"],
                            [self.data valueForKey:@"method"],
                            scannedQRString];
    
    
    
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [self.wv_backgroundLogin loadRequest:requestObj];
    status = IcouponUseStatusFinishUse;

}

- (void)checkLogin{
    [[CoreData sharedCoreData].mask showMask];
    
    NSString *urlAddress = [NSString stringWithFormat:@"%@?Lang=%@&TxType=6",
                            [CoreData sharedCoreData].iCouponServerURL,
                            [[CoreData sharedCoreData] couponLang]];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [self.wv_backgroundLogin loadRequest:requestObj];
}

- (void)setupUI{
    [self.imv_icon loadImageWithURL: [[itemDetails valueForKey:@"image_l"] stringByAddingPercentEscapesUsingEncoding:
                                      NSASCIIStringEncoding]];
    [self.imv_icon2 loadImageWithURL:[[itemDetails valueForKey:@"image_s"] stringByAddingPercentEscapesUsingEncoding:
                                      NSASCIIStringEncoding]];
    self.lbl_title.text = [itemDetails valueForKey:@"merchant_name"];
    self.lbl_subTitle.text = [itemDetails valueForKey:@"item_desc_l"];
    
    NSDateFormatter *apiFormatter = [[NSDateFormatter alloc] init];
    [apiFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [apiFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    [displayFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [displayFormatter setDateFormat:NSLocalizedString(@"iCoupon.myWallet.displayFormat", nil)];
    NSString *expireDateString = [NSString stringWithFormat:@"%@", [displayFormatter stringFromDate:[apiFormatter dateFromString:[self.data valueForKey:@"effective_end"]]]];

    
    self.lbl_expiryDate.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"iCoupon.myWallet.expiryDate", nil),expireDateString];
    
    [self.lbl_remark setText:[NSString stringWithFormat:@"%@:",NSLocalizedString(@"iCoupon.fullList.remark", nil)]];
    [self.txv_remark setText:[itemDetails valueForKey:@"tnc"]];
    if(IOS7){
        [self.txv_remark sizeToFit];
        [self.txv_remark setFrame:CGRectMake(self.txv_remark.frame.origin.x, self.lbl_remark.frame.origin.y+self.lbl_remark.frame.size.height + 4, self.txv_remark.frame.size.width, self.txv_remark.frame.size.height) ];
        
    }else{
        [self.txv_remark setFrame:CGRectMake(self.txv_remark.frame.origin.x, self.lbl_remark.frame.origin.y+self.lbl_remark.frame.size.height + 4, self.txv_remark.frame.size.width, self.txv_remark.contentSize.height) ];
        
    }
    //Adjust position remark .
    [self resizeNote:nil indexPathWithIsExpanded:NO];
    
    
    [self setupNotes:1];
}

- (void)resizeNote:(NSIndexPath *)indexPath indexPathWithIsExpanded:(BOOL)expanded{
//    CGRect tbvFram = self
    
    CGRect frame = self.sktbv_stepNotes.frame ;
    frame.origin.y =self.txv_remark.frame.origin.y + self.txv_remark.frame.size.height + 5;
//    frame.size.height = self.sktbv_stepNotes.contentSize.height;

    
    CGSize contentSize = self.scv_noteContent.contentSize;
//    CGSize contentSize = CGSizeMake(self.scv_noteContent.contentSize.width, 150);
    frame.size.height = 1024;
    self.sktbv_stepNotes.frame = frame;
    
    
    float height = 80;
//    if(isExpanded1){
        if(isExpanded1){
            height += [stepContent count] *70;
        }
//    }
//    if(isExpanded2){
        if(isExpanded2){
//            frame.size.height -= [importantContent count] *70;
            height += [importantContent count] *70;
        }
//    }
    if(height < 140){
        height = 140;
    }
    
    contentSize.height = height+frame.origin.y;
    self.scv_noteContent.contentSize = contentSize;
}

- (void)setupNotes:(NSInteger)type{
    NSString *html = @"<div style='color:red; font-size:13px;'><b style='font-size:18px'>Steps to use i-coupon</b><ol style='margin-left: 10px;padding-left: 10px;'><!-- Step Content --></ol><b style='font-size:18px'>Important notes</b><ul style='margin-left: 10px;padding-left: 10px;'><!-- Important Content --></ul></div>";
    NSString *stepHTML = [NSString stringWithFormat:@""];
    

    for(NSString *stepString in stepContent){
        stepHTML = [stepHTML stringByAppendingFormat:@"<li>%@</li>",stepString];
    }
    
    NSString *importantHTML = [NSString stringWithFormat:@""];
    
    for(NSString *stepString in importantContent){
        importantHTML = [importantHTML stringByAppendingFormat:@"<li>%@</li>",stepString];
    }
    
    
    html = [html stringByReplacingOccurrencesOfString:@"Steps to use i-coupon" withString:NSLocalizedString(@"iCoupon.myWallet.steps.title", nil)];
    html = [html stringByReplacingOccurrencesOfString:@"Important notes" withString:NSLocalizedString(@"iCoupon.myWallet.importantNotes", nil)];
    html = [html stringByReplacingOccurrencesOfString:@"<!-- Step Content -->" withString:stepHTML];
    html = [html stringByReplacingOccurrencesOfString:@"<!-- Important Content -->" withString:importantHTML];
    
    [self.wv_notes loadHTMLString:html baseURL:nil];
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return [stepContent count];
    }
    return [importantContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.11];
    cell.backgroundColor = [UIColor clearColor];
    NSString *contentString =  @"";
    if(indexPath.row == 0){
        contentString = [NSString stringWithFormat:@"%@ %@",isExpanded1?@"-":@"+", NSLocalizedString(@"iCoupon.myWallet.steps.title", nil) ];
    }else{
        contentString =[NSString stringWithFormat:@"%@ %@",isExpanded2?@"-":@"+", NSLocalizedString(@"iCoupon.myWallet.importantNotes", nil)];
    }
    
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    
    cell.textLabel.text = contentString;
//    cell.isExpandable = YES;
    [self resizeNote:indexPath indexPathWithIsExpanded:!cell.isExpanded];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    __block SKSTableViewCell *cell = (SKSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.row == 0){
        isExpanded1 = !isExpanded1;
    }else{
        isExpanded2 = !isExpanded2;
    }
//    if([cell isKindOfClass:[SKSTableViewCell class]]){
//        cell.textLabel.text = [cell.textLabel.text stringByReplacingOccurrencesOfString:cell.isExpanded?@"-":@"+" withString:cell.isExpanded?@"+":@"-"];

    [tableView reloadData];
//        if(indexPath.row == 0){
//            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",!cell.isExpanded?@"+":@"-", NSLocalizedString(@"iCoupon.myWallet.steps.title", nil) ];
//            [self resizeNote:indexPath indexPathWithIsExpanded:!cell.isExpanded];
//        }else{
//        
//            if([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[SKSTableViewCell class]]){
//                cell.textLabel.text =[NSString stringWithFormat:@"%@ %@",!cell.isExpanded?@"+":@"-", NSLocalizedString(@"iCoupon.myWallet.importantNotes", nil)];
//                [self resizeNote:indexPath indexPathWithIsExpanded:!cell.isExpanded];
//            }
//        }
//        [self resizeNote:indexPath indexPathWithIsExpanded:!cell.isExpanded];
//    }

}
- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    if(indexPath.row == 0)
        label.text = [NSString stringWithFormat:@"%i. %@",indexPath.subRow, stepContent[indexPath.subRow-1]];
    else
       label.text = [NSString stringWithFormat:@"● %@", importantContent[indexPath.subRow-1]];
    //    cell.textLabel.font = [UIFont fontWithName:@"Arial Black" size:5];
    [label setFont:[UIFont systemFontOfSize:11]];
    label.center =CGPointMake(-50, label.center.y);

    
    if (label.text)
    {
        
        // calculate text view height (works but not efficient :( )
        UIView *v = [[UIView alloc] init];
        UITextView *txv_content = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 210, 20)];
        txv_content.font = [UIFont systemFontOfSize:12];
        txv_content.textColor = [UIColor darkGrayColor];
        txv_content.text = label.text;
        [v addSubview:txv_content];
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
            [txv_content sizeToFit];
        }
        CGSize stringSize = txv_content.frame.size;
//        DEBUGMSG(@"Content Height 1: %f", txv_content.contentSize.height);
        if(stringSize.height < txv_content.contentSize.height)
            stringSize.height = txv_content.contentSize.height;
        [txv_content release];
        [v release];
        
        //CGSize stringSize = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(210, 9999) lineBreakMode:UILineBreakModeWordWrap];
        return stringSize.height;
    }
    
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor = [UIColor clearColor];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

//    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.11];
    [cell.textLabel setFont:[UIFont systemFontOfSize:11]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    
    cell.textLabel.center =CGPointMake(-50, cell.center.y);
//    cell.textLabel.frame  =CGRectMake(-40, 0, 280, 85);
    
    cell.backgroundColor = [UIColor clearColor];
    if(indexPath.row == 0)
        cell.textLabel.text = [NSString stringWithFormat:@"%i. %@",indexPath.subRow, stepContent[indexPath.subRow-1]];
    else
        cell.textLabel.text = [NSString stringWithFormat:@"● %@", importantContent[indexPath.subRow-1]];
//    cell.textLabel.font = [UIFont fontWithName:@"Arial Black" size:5];

    cell.textLabel.numberOfLines = 3;
    [cell.textLabel sizeToFit];
//    [self resizeNote];
    return cell;
}



#pragma UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    [[CoreData sharedCoreData].mask hiddenMask];
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:
                      @"document.body.innerHTML"];
    
    if([html length] <= 8){
        [self popupErrorMessageWithMessage:nil];
        return;
    }
    NSString *xmlString = [html substringFromIndex:8];
    //    NSString *xmlString = [[request responseString] substringFromIndex:8] ;
    
    NSData* xmlData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    //Format End
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLParser:xml_parser];
    
//    NSRange isRange = [html rangeOfString:@"sessionid" options:NSCaseInsensitiveSearch];
    NSString *sessionId = [xmlDoc valueForKey:@"sessionid"];
    
    //Session found!
    if(sessionId) {
        
        self.wv_backgroundLogin.hidden = YES;
        
        if(status == ICouponUseStatusUseCoupon){
            if([[self.data valueForKey:@"method"] intValue] == ICouponUseMethodOne){ //Method 1
                [self setupCamera];
            }else if([[self.data valueForKey:@"method"] intValue] == ICouponUseMethodTwo){//Method 2
                [self setupCamera];
            }else if([[self.data valueForKey:@"method"] intValue] == ICouponUseMethodThree){//Method 3
                [self preUseCoupon];
            }
        }else if(status == ICouponUseStatusQRConfirmUse){
            if([[xmlDoc valueForKey:@"result"] isEqualToString:@"00"]){
                [self confirmUseCoupon];
            }else{
                [self popupErrorMessage];
            }
        }else if(status == IcouponUseStatusFinishUse){
            
            if([[xmlDoc valueForKey:@"result"] isEqualToString:@"00"]){
                [self goToThanksPage:xmlDoc];
            }else{
                if([xmlDoc valueForKeyPath:@"couponid.data.result.message"])
                    [self popupErrorMessageWithMessage:[xmlDoc valueForKeyPath:@"couponid.data.result.message"]];
                else
                    [self popupErrorMessage];
            }
        }
        
        
    }else{//Session Timeout
        status = ICouponUseStatusUseCoupon;
        self.wv_backgroundLogin.hidden = NO;
        
    }
    
    NSLog(@"ICouponListViewController: webViewDidFinishLoad %@" ,html);

}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"ICouponListViewController: didFailLoadWithError error:%@", [error description] );
    [[CoreData sharedCoreData].mask hiddenMask];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
- (void)popupErrorMessage{
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"iCoupon.myWallet.qrError.title", nil) message:@"Use coupon error, please contact admin." delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:nil,nil];
	[alert_view show];
	[alert_view release];
}

- (void)popupErrorMessageWithMessage:(NSString *)message{
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"iCoupon.myWallet.qrError.title", nil) message:NSLocalizedString(@"iCoupon.myWallet.qrError.msg", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil,nil];
    alert_view.delegate = self;
	[alert_view show];
	[alert_view release];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self dismissPicker];
}
///////////////////
//ASIHTTPRequest
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {

    NSLog(@"debug CouponsUseViewController requestFinished:%@",[request responseString]);
    
    //Get Coupon Detail Finished.
    if(request == asi_request_detail){
        //Format Data
        NSString *xmlString = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] substringFromIndex:8];
        
        NSData* xmlData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
        //Format End
        
        NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:xmlData];
        
        NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLParser:xml_parser];
        itemDetails = [[xmlDoc arrayValueForKeyPath:@"Coupons.coupon"][0] copy];
        
        
        [[CoreData sharedCoreData].mask hiddenMask];
        
        
        [self setupUI];
    }

}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"PBConcertsListViewController requestFailed:%@", request.error);
    
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"iCoupon.myWallet.warning",nil) message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
    [alert_view show];
    [alert_view release];
    
	[[CoreData sharedCoreData].mask hiddenMask];
}




- (void)viewDidUnload {
    [self setImv_icon2:nil];
    [self setBtn_back:nil];
    [self setBtn_useNow:nil];
    [self setBtn_close:nil];
    [self setWv_notes:nil];
    [self setSktbv_stepNotes:nil];
    [self setWv_backgroundLogin:nil];
    [self setScv_noteContent:nil];
    [super viewDidUnload];
}
@end
