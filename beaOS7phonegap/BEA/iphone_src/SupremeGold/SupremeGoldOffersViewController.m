//
//  SupremeGoldOffersViewController.m
//  BEA
//
//  Created by Ledp944 on 14-9-4.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import "SupremeGoldOffersViewController.h"
#import "ConsumerLoanUtil.h"
#import "HotlineUtil.h"
#import "AccProUtil.h"
#import "WebViewController2.h"
#import "SupremeGoldMenuViewController.h"
#import "SGViewController.h"

#define AlertActionShare	3
#define AlertActionCall     1
#define AlertActionBookmark	2

@implementation SupremeGoldOffersViewController

@synthesize webView;
@synthesize consumerLoanPromoUrl, consumerLoanPromoHotline, consumerLoanBtnLabel, tnc_label;
@synthesize consumerLoanTNCUrl;
//@synthesize callwebView;
@synthesize url2, url2label, btnGotoURL;
@synthesize merchant_info;

@synthesize functionName, submenuName,title, fromType;

//- (id) initWithNibName:(NSString *)nibNameOrNil
//                bundle:(NSBundle *)nibBundleOrNil
//                   url:(NSString*)url
//               hotline:(NSString *)hotline
//              btnLabel:(NSString*)btnLabel
//                   tnc:(NSString*)TNCurl
//                  url2:(NSString*)a_url2
//             url2label:(NSString*)a_url2label
//{
//    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    self.consumerLoanPromoUrl = url;
//    self.consumerLoanPromoHotline = hotline;
//    self.consumerLoanBtnLabel = btnLabel;
//    self.consumerLoanTNCUrl = TNCurl;
//    self.url2 = a_url2;
//    self.url2label = a_url2label;
//    NSLog(@"ConsumerLoanOffersViewController initWithNibName:\n[%@]\n[%@]\n[%@]\n[%@]\n[%@]\n[%@]\n[%@]",
//          self,
//          self.consumerLoanPromoUrl,
//          self.consumerLoanPromoHotline,
//          self.consumerLoanBtnLabel,
//          self.consumerLoanTNCUrl,
//          self.url2,
//          self.url2label);
//    return self;
//}

- (id) initWithNibName:(NSString *)nibNameOrNil
                bundle:(NSBundle *)nibBundleOrNil
              merchant:(NSDictionary*)merchant
{
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    merchant_info = merchant;
    consumerLoanPromoUrl = [merchant objectForKey:@"image"];
    consumerLoanPromoHotline = [merchant objectForKey:@"tel"];
    consumerLoanBtnLabel = [merchant objectForKey:@"tel_label"];
    consumerLoanTNCUrl = [merchant objectForKey:@"pdf_url"];
    url2 = [merchant objectForKey:@"url"];
    tnc_label = [merchant objectForKey:@"tnc_label"];
    tnc = [merchant objectForKey:@"tnc"];
    self.url2label = [merchant objectForKey:@"url_label"];
    self.url2label = [self.url2label stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.url2label = [self.url2label stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    self.url2label = [self.url2label stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    title = [merchant objectForKey:@"title"];
    NSLog(@"ConsumerLoanOffersViewController initWithNibName:\n[%@]\n[%@]",
          self,
          merchant);
    return self;
}

- (void) hideBookmark
{
    [btnBookmark setHidden:YES];
}

- (void)setViewControllerPushType:(NSInteger)type {
    pushType = type;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    NSLog(@"btnTC.ImageName = %@, %@", btnTC.orangeImageName, btnTC.redImageName);
//    [[PageUtil pageUtil] changeImageForTheme:self.view];
    NSLog(@"%s被调用！", __PRETTY_FUNCTION__);
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    
    _contentScroll.frame = CGRectMake(_contentScroll.frame.origin.x, _contentScroll.frame.origin.y, _contentScroll.frame.size.width, _contentScroll.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    btnBookmark.frame = CGRectMake(btnBookmark.frame.origin, 75, 25, 25);
    btnTC.frame = CGRectMake(btnTC.frame.origin.x, btnTC.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], btnTC.frame.size.width, btnTC.frame.size.height);
    btnTC.titleLabel.numberOfLines = 0;
    btnTC.titleLabel.textAlignment = NSTextAlignmentCenter;
    callButton.frame = CGRectMake(callButton.frame.origin.x, callButton.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], callButton.frame.size.width, callButton.frame.size.height);
    callButton.titleLabel.numberOfLines = 0;
    callButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnShare.frame = CGRectMake(btnShare.frame.origin.x, btnShare.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], btnShare.frame.size.width, btnShare.frame.size.height);
    btnShare.titleLabel.numberOfLines = 0;
    btnShare.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnGotoURL.frame = CGRectMake(btnGotoURL.frame.origin.x, btnGotoURL.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], btnGotoURL.frame.size.width, btnGotoURL.frame.size.height);
    btnGotoURL.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    btnGotoURL.titleLabel.numberOfLines = 0;
    btnGotoURL.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //	NSString *path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_chi" ofType:@"htm"];
    //	if (![MBKUtil isLangOfChi]) {
    //		path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_eng" ofType:@"htm"];
    //	}
    //	NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]];
    //	[webView loadRequest:req];
    
    NSURL *url= [NSURL URLWithString:self.consumerLoanPromoUrl];
    
//    NSLog(@"getPostRequest4AccProDefaultPage url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [self.webView loadRequest:request];
    //    [self.callwebView loadRequest:[HttpRequestUtils getPostRequest4ConsumerLoanOffersCall]];
    //tag.1.TNC
    [btnTC setTitle:NSLocalizedString(@"T&C",nil) forState:UIControlStateNormal];
    if (self.tnc_label && self.tnc_label.length > 0) {
        [btnTC setTitle:self.tnc_label forState:UIControlStateNormal];
    }
    //tag.2.share app
    if ([fromType isEqualToString:@"Pri"]) {
        [btnShare setTitle:NSLocalizedString(@"Share App_Privileges",nil) forState:UIControlStateNormal];
    }
    else {
        [btnShare setTitle:NSLocalizedString(@"Share App_Privileges",nil) forState:UIControlStateNormal];
    }
    if (submenuName!=nil && [submenuName isEqualToString:NSLocalizedString(@"tag_offers",nil)]) {
        [btnShare setTitle:NSLocalizedString(@"tag_moremenu_shareapp",nil) forState:UIControlStateNormal];
    }
    //tag.3.查詢, tel_label
	[callButton setTitle:self.consumerLoanBtnLabel forState:UIControlStateNormal];
    //tag.4.開始遊戲,url_label
    [self.btnGotoURL setTitle:self.url2label forState:UIControlStateNormal];
    
    //setup the places of the buttons
    [btnTC setHidden:YES];
    [btnShare setHidden:YES];
    [callButton setHidden:YES];
    [btnGotoURL setHidden:YES];
    
    NSMutableArray* buttons4showing = [NSMutableArray new];
    NSString* pdf_url = [self.merchant_info objectForKey:@"pdf_url"];
    NSLog(@"ConsumerLoanOffersViewController viewDidLoad pdf_url:[%@]--%d", pdf_url, pdf_url.length);
    if ((pdf_url && pdf_url.length>0) || (tnc && tnc.length>0)) {
        [buttons4showing addObject:btnTC];
    }
    [buttons4showing addObject:btnShare];
    NSString* tel = [self.merchant_info objectForKey:@"tel"];
    tel = [tel stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    tel = [tel stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSLog(@"ConsumerLoanOffersViewController viewDidLoad tel:[%@]--%d", tel, tel.length);
    if (tel && tel.length>0 ) {
        [buttons4showing addObject:callButton];
    }
    NSString* url_label = [self.merchant_info objectForKey:@"url_label"];
    url_label = [url_label stringByReplacingOccurrencesOfString:@" " withString:@""];
    url_label = [url_label stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    url_label = [url_label stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSLog(@"url_label is %@", url_label);
    NSLog(@"ConsumerLoanOffersViewController viewDidLoad url_label:[%@]--%d", url_label, url_label.length);
    if (url_label && url_label.length>0) {
        [buttons4showing addObject:btnGotoURL];
    }
    float leftNrightMargin = 10.0;
    float marginBetweenButtons = 5.0;
    float btnWidth = (self.view.frame.size.width - leftNrightMargin - ([buttons4showing count]-1)*marginBetweenButtons )/ [buttons4showing count];
    UIImage *image;
    if ([buttons4showing count]==3 || [buttons4showing count]==2){
        image = [UIImage imageNamed:@"btn_blank_02.png"];
    }else if ([buttons4showing count]==4){
        image = [UIImage imageNamed:@"btn_blank_03.png"];
    }else{
        image = [UIImage imageNamed:@"btn_blank_01.png"];
    }
    for (int i=0; i<[buttons4showing count]; i++) {
        UIButton *btnCurr = [buttons4showing objectAtIndex:i];
        CGRect frame = btnCurr.frame;
        frame.origin.x = leftNrightMargin/2 + i*(btnWidth+marginBetweenButtons);
        frame.size.width = btnWidth;
        btnCurr.frame = frame;
        [btnCurr setHidden:NO];
        [btnCurr setBackgroundImage:image forState:UIControlStateNormal];
    }
    [buttons4showing removeAllObjects];
    [buttons4showing release];
    
   	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"consumerloan.offers.title",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [[MBKUtil me].queryButton1 setHidden:YES];
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    [request release];
    //    CallNowbtn.
    
    Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([pageTheme isEqualToString:@"1"]) {
        if ([bookmark_data isOfferExist:merchant_info InGroup:1] && [fromType isEqualToString:@"Pri"]) {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
        }
        else if([bookmark_data isOfferExist:merchant_info InGroup:9] && [fromType isEqualToString:@"SG"]) {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
        }
    } else {
        if ([bookmark_data isOfferExist:merchant_info InGroup:1] && [fromType isEqualToString:@"Pri"]) {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
        }
        else if([bookmark_data isOfferExist:merchant_info InGroup:9] && [fromType isEqualToString:@"SG"]) {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
        }
    }
    [bookmark_data release];
    
    //    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    //    [v_rmvc.rmUtil setNav:self.navigationController];
    //    [self.view addSubview:v_rmvc.contentView];
    UIView *mmenuv0 = [[UIView alloc] init];
    UIView *mmenuv1 = [[UIView alloc] init];
    UIView *mmenuv2 = [[UIView alloc] init];
    UIView *mmenuv3 = [[UIView alloc] init];
    
    if (pushType == 1) {
        btnBookmark.hidden = YES;
        [self setMenuBar1];
        CGRect frame1 = _contentScroll.frame;
        frame1.origin.y -= 31;
        frame1.size.height += 31;
        _contentScroll.frame = frame1;
    }
    else {
        
        RotateMenu2ViewController* v_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
        v_rmvc.rmUtil.caller = self;
        
        [self.view addSubview:v_rmvc.contentView];
        
        NSArray* a_texts = [NSArray arrayWithObjects:NSLocalizedString(@"tag_offers", nil),
                            NSLocalizedString(@"tag_applications", nil),
                            NSLocalizedString(@"Nearby", nil),
                            NSLocalizedString(@"tag_enquiries", nil),
                            nil];
        [v_rmvc.rmUtil setTextArray:a_texts];
        
        NSArray* a_views = [NSArray arrayWithObjects:mmenuv0,mmenuv1,mmenuv2,mmenuv3, nil];
        //            NSArray* a_views = [NSArray arrayWithObjects:mmenuv0,mmenuv1,mmenuv2, nil];
        
        [v_rmvc.rmUtil setViewArray:a_views];
        
        [v_rmvc.rmUtil setNav:self.navigationController];
        [v_rmvc.rmUtil setShowIndex:0];
        [v_rmvc.rmUtil showMenu];
    }
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 && self.consumerLoanTNCUrl) {
        WebViewController *banking_controller;
        banking_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        NSURL *TNCUrl=[NSURL URLWithString:self.consumerLoanTNCUrl];
        [banking_controller setUrlRequest:[NSURLRequest requestWithURL:TNCUrl]]; //To be retested
        banking_controller.view.frame = CGRectMake(320, 0, 0, 0);
        [self.view addSubview:banking_controller.view];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

-(void)setMenuBar1
{
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
}

-(void)setMenuBar2
{
    RotateMenu2ViewController* v_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
    v_rmvc.rmUtil.caller = self;
    
    [self.view addSubview:v_rmvc.contentView];
    
	NSArray *a_texts = [NSLocalizedString(@"tag_creditCardTitle",nil) componentsSeparatedByString:@","];
    [v_rmvc.rmUtil setTextArray:a_texts];
    UIView* view_temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    NSArray* a_views = [NSArray arrayWithObjects:view_temp,view_temp,view_temp,view_temp,view_temp,view_temp, nil];
    [v_rmvc.rmUtil setViewArray:a_views];
    
    [v_rmvc.rmUtil setNav:self.navigationController];
    [v_rmvc.rmUtil setShowIndex:0];
    [v_rmvc.rmUtil showMenu];
}

-(void)showMenu:(int)show
{
    if (mfirst) {
        if ([fromType isEqualToString:@"SG"]) {
            NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[[CoreData sharedCoreData].sg_view_controller.navigationController viewControllers]];
            [viewControllers removeLastObject];
            if ([[viewControllers lastObject] isKindOfClass:[SupremeGoldMenuViewController class]]) {
                [[CoreData sharedCoreData].sg_view_controller.navigationController popViewControllerAnimated:NO];
                [(SupremeGoldMenuViewController *)[viewControllers lastObject] welcome:show+1];
            }
        }
        else if ([fromType isEqualToString:@"Pri"]) {
            [self.navigationController popViewControllerAnimated:NO];
            
            [CoreData sharedCoreData].lastScreen = @"AccProViewController";
            [AccProUtil me].AccPro_view_controller = [[AccProViewController alloc] initWithNibName:@"AccProViewController" bundle:nil];
            //            [UIView beginAnimations:nil context:NULL];
            //            [UIView setAnimationDuration:0.5];
            //                [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            [[CoreData sharedCoreData].main_view_controller pushViewController:[AccProUtil me].AccPro_view_controller animated:NO];
            NSLog(@"ConsumerLoanOffersViewController.m -- L209");
            //                [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
            //            [UIView commitAnimations];
            [[AccProUtil me].AccPro_view_controller welcome2:show];
            //                [CoreData sharedCoreData].bea_view_controller.vc4process  = [AccProUtil me].AccPro_view_controller;
            //        [[AccProUtil me].AccPro_view_controller.menuVC.mv_rmvc.rmUtil showMenu:show];
            NSLog(@"debug showMenu in:%@", [AccProUtil me].AccPro_view_controller);
            NSLog(@"debug showMenu in:%@", [AccProUtil me].AccPro_view_controller.menuVC);
        }
    }
    mfirst = true;
    
    //    NSLog(@"debug showMenu in:%d", show);
    //    if (show == 3) {
    //        [[CoreData sharedCoreData].root_view_controller setContent:0];
    //        [CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    //        [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
    //        [[CoreData sharedCoreData].atmlocation_view_controller welcome];
    //        [CoreData sharedCoreData].bea_view_controller.vc4process  =  [CoreData sharedCoreData].atmlocation_view_controller;
    //    }else if(show == 0){
    //
    //    }else if(show == 1){
    //
    //    }else if(show == 2){
    //
    //    }
}
-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load ConsumerLoanOffersViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded ConsumerLoanOffersViewController");
    CGSize size = webView.scrollView.contentSize;
    CGRect frame = webView.frame;
    frame.size = size;
    webView.frame = frame;
    _contentScroll.contentSize = size;
    if (![[merchant_info objectForKey:@"desc"] isEqualToString:@""]) {
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, size.height + 10, _contentScroll.frame.size.width - 20, 200)];
        descLabel.text = [merchant_info objectForKey:@"desc"];
        //        descLabel.text = @"Should add space between words according to what we enter in CMS";
        descLabel.numberOfLines = 0;
//        _contentScroll.contentSize = CGSizeMake(_contentScroll.frame.size.width, [self fitHeight:descLabel] + 10) ;
        descLabel.font = [UIFont fontWithName:@".Helvetica NeueUI" size:14];
//        CGSize size1 = CGSizeMake(320,2000);
//        CGSize labelsize = [descLabel.text sizeWithFont:descLabel.font constrainedToSize:size1 lineBreakMode:UILineBreakModeCharacterWrap];
//        [descLabel setFrame:CGRectMake(10.0, size.height + 10, _contentScroll.frame.size.width - 20, labelsize.height)];
        CGSize maxSize = CGSizeMake(descLabel.frame.size.width, MAXFLOAT);
        CGSize text_area = [descLabel.text sizeWithFont:descLabel.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        descLabel.frame = CGRectMake(descLabel.frame.origin.x, descLabel.frame.origin.y, descLabel.frame.size.width, text_area.height);
        _contentScroll.contentSize = CGSizeMake(_contentScroll.frame.size.width, webView.frame.size.height + descLabel.frame.size.height+10) ;
        [_contentScroll addSubview:descLabel];
    }
    
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded ConsumerLoanOffersViewController:%@", error );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}

//-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [[ConsumerLoanUtil me].ConsumerLoan_view_controller.navigationController popToRootViewControllerAnimated:YES];
//}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"list clicked");
    if (alert_action==AlertActionShare) {
        if (buttonIndex==0) {
            
            EMailViewController* email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
            NSString *appString, *subject, *heading, *body, *oldSubject;
            appString = NSLocalizedString(@"tag_email_appstring", nil);
            
            //jasen's note: email's subject=CMS(emailsubject)/function name + submenuname + (via BEA iPhone app)
            if ([fromType isEqualToString:@"Pri"]) {
//                functionName = NSLocalizedString(@"tag_fav_privileges", nil);
//                subject = [NSString stringWithFormat:@"%@ %@", functionName, appString];
                subject = [merchant_info objectForKey:@"emailsubject"];
                if (subject == nil || [subject isEqualToString:@""]) {
                    subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"supremegold.offers.EmailTitle", nil)];

                }

                NSLog(@"subject is %@", subject);
            }
            else {
                oldSubject = [merchant_info objectForKey:@"emailsubject"];
                subject = [oldSubject stringByReplacingOccurrencesOfString:@"BEA Consumer Loan" withString:@"BEA Consumer Loans"];
                NSLog(@"oldSubject is %@", oldSubject);
//                if ([fromType isEqualToString:@""] || fromType == nil) {
                    //                functionName = NSLocalizedString(@"tag_fav_privileges", nil);
                    //                subject = [NSString stringWithFormat:@"%@ %@", functionName, appString];
//                    subject = [merchant_info objectForKey:@"emailsubject"];
                if (oldSubject == nil || [oldSubject isEqualToString:@""] || [oldSubject isEqualToString:@"\n\t\t\t"]) {
                    oldSubject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"supremegold.offers.EmailTitle", nil)];
                    subject = [oldSubject stringByReplacingOccurrencesOfString:@"BEA Consumer Loan" withString:@"BEA Consumer Loans"];
                    
                }
//                    oldSubject = NSLocalizedString(@"supremegold.offers.EmailTitle", nil);
                
//                    NSLog(@"subject is %@", subject);
//                }
                //                subject_test = [oldSubject stringByReplacingOccurrencesOfString:@" " withString:@""];
                //                subject_test = [subject_test stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                //                subject_test = [subject_test stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//                subject = [oldSubject stringByReplacingOccurrencesOfString:@"BEA Consumer Loan" withString:@"BEA Consumer Loans"];
            }
            
            //jasen's note: email's body=heading+body=CMS(title)+CMS(emailbody);
            heading = [merchant_info objectForKey:@"title"];
            body = [merchant_info objectForKey:@"emailbody"];
            body = [NSString stringWithFormat:@"%@\n\n%@", heading, body];
            
            NSLog(@"debug email:[subject]:[%@]---[body]:[%@]", subject, body);
            
            [email createComposerWithSubject:subject
                                     Message:body];
            [self.view addSubview:email.view];
        }
    } else if (alert_action==AlertActionCall) {
        if (buttonIndex==1) {
            
            NSURL *telno = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[self.consumerLoanPromoHotline stringByReplacingOccurrencesOfString:@" " withString:@""]]];
            NSLog(@"Call %@",telno);
            [[UIApplication sharedApplication] openURL:telno];
        }
        //	} else if (alert_action==AlertActionBookmark) {
        //        Bookmark *bookmark_data = [[Bookmark alloc] init];
        //        [bookmark_data addBookmark:merchant_info ToGroup:7];
        //        [bookmark_data release];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        //        [alert show];
        //        [alert release];
    }
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [self setBtnGotoURL:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) call {
	if (![self.consumerLoanPromoHotline isEqualToString:@"NULL" ]) {
        alert_action=AlertActionCall;
        
        self.consumerLoanPromoHotline = [self.consumerLoanPromoHotline stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        self.consumerLoanPromoHotline = [self.consumerLoanPromoHotline stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        UIAlertView *alert_view = [[UIAlertView alloc]
                                   initWithTitle:self.consumerLoanPromoHotline
                                   message:nil
                                   delegate:self
                                   cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                   otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
        [alert_view show];
        [alert_view release];
	}
}

-(void) openTNC {
    if (tnc && tnc.length>0) {
        WebViewController2 *banking_controller= [[WebViewController2 alloc] initWithNibName:@"WebViewController2" bundle:nil];
        
        [banking_controller setUrlRequest:nil setTitle:tnc]; //To be retested
        [banking_controller setNav:self.navigationController];
        [self.navigationController pushViewController:banking_controller animated:NO];
        
        [banking_controller release];
    } else {
        WebViewController *banking_controller;
        banking_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        NSURL *url=[NSURL URLWithString:self.consumerLoanTNCUrl];
        [banking_controller setUrlRequest:[NSURLRequest requestWithURL:url]]; //To be retested
        [banking_controller setNav:self.navigationController];
        [self.navigationController pushViewController:banking_controller animated:NO];
        
        NSLog(@"ConsumerLoanOffersViewController openTNC:%@--%@--%@", self, self.consumerLoanTNCUrl, url);
        // [banking_controller.web_view loadRequest:[NSURLRequest requestWithURL:url]];
        [banking_controller release];
    }
}

- (void)dealloc {
    [self.btnGotoURL release];
    fromType = nil;
    [_bookButton release];
    [_contentScroll release];
    [super dealloc];
}

- (void)doShare{
    alert_action=AlertActionShare;
	UIAlertView *share_prompt = [[[UIAlertView alloc] init] retain];
	[share_prompt setDelegate:self];
	[share_prompt setTitle:NSLocalizedString(@"Share to Friends",nil)];
	[share_prompt setMessage:NSLocalizedString(@"Share App with Friends by Email",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"OK",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"Back",nil)];
	[share_prompt show];
	[share_prompt release];
}

- (void)doBookmark{
    alert_action=AlertActionBookmark;
    
    Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([fromType isEqualToString:@"Pri"]) {
        if ([bookmark_data isOfferExist:merchant_info InGroup:1]) {
            [bookmark_data removeBookmark:merchant_info InGroup:1];
            if ([pageTheme isEqualToString:@"1"]) {
                [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark.png"] forState:UIControlStateNormal];
            } else {
                [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_new.png"] forState:UIControlStateNormal];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Delete from Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
            [alert show];
            [alert release];
        } else {
            [bookmark_data addBookmark:merchant_info ToGroup:1];
            if ([pageTheme isEqualToString:@"1"]) {
                [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
            } else {
                [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else {
        if ([bookmark_data isOfferExist:merchant_info InGroup:9]) {
            [bookmark_data removeBookmark:merchant_info InGroup:9];
            if ([pageTheme isEqualToString:@"1"]) {
                [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark.png"] forState:UIControlStateNormal];
            } else {
                [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_new.png"] forState:UIControlStateNormal];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Delete from Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
            [alert show];
            [alert release];
        } else {
            [bookmark_data addBookmark:merchant_info ToGroup:9];
            if ([pageTheme isEqualToString:@"1"]) {
                [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
            } else {
                [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    
    [bookmark_data release];
}

-(void) gotoURL {
    WebViewController2 *banking_controller= [[WebViewController2 alloc] initWithNibName:@"WebViewController2" bundle:nil];
    
    NSURL *url=[NSURL URLWithString:self.url2];
    [banking_controller setUrlRequest:[NSURLRequest requestWithURL:url] setTitle:title]; //To be retested
    [banking_controller setNav:self.navigationController];
    [self.navigationController pushViewController:banking_controller animated:TRUE];
    
	NSLog(@"ConsumerLoanOffersViewController openTNC:%@--%@--%@", self, self.url2, url);
    //    [banking_controller.web_view loadRequest:[NSURLRequest requestWithURL:url]];
    
    [banking_controller release];
}

- (IBAction)doButtonsPressed:(UIButton*)sender {
    switch (sender.tag) {
        case 0://bookmark
            [self doBookmark];
            break;
            
        case 1://TNC
            [self openTNC];
            break;
            
        case 2://share app
            [self doShare];
            break;
            
        case 3://tel
            [self call];
            break;
            
        case 4://goto url
            [self gotoURL];
            break;
            
        default:
            break;
    }
}

- (int) fitHeight:(UILabel*)sender
{
    
    CGSize maxSize = CGSizeMake(sender.frame.size.width, MAXFLOAT);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height);
    int height = sender.frame.origin.y + sender.frame.size.height;
    return height;
}
@end