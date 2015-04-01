//
//  InsuranceApplicationViewController.m
//  BEA
//
//  Created by NEO on 03/01/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "InsuranceApplicationViewController.h"
#import "InsuranceUtil.h"
#import "MBKUtil.h"

@implementation InsuranceApplicationViewController

@synthesize webView, scrollView;
@synthesize pop_webView;
@synthesize closeButton;
@synthesize webviewindex;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    closeButton.hidden = YES;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        closeButton.frame = CGRectMake(279, 27, 36, 32);
    }
    NSLog(@"insurance application closebutton:%f--%f__%f-%f-%f-%f",
          screenHeight,
          [[UIDevice currentDevice].systemVersion doubleValue],
          closeButton.frame.origin.x,
          closeButton.frame.origin.y,
          closeButton.frame.size.width,
          closeButton.frame.size.height);
    webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    pop_webView.frame = CGRectMake(pop_webView.frame.origin.x, pop_webView.frame.origin.y, pop_webView.frame.size.width, pop_webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[MyScreenUtil me] adjustmentcontrolY20:webView];
        [[MyScreenUtil me] adjustmentcontrolY20:pop_webView];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitle];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitleBackImg];
    }
    
    NSMutableURLRequest *request = nil;
    
    if ([[InsuranceUtil me].quoteAndApply isEqualToString:@"YES"]){
        [InsuranceUtil me].quoteAndApply = @"";
        request = [HttpRequestUtils getPostRequest4InsuranceApplicationView];
    }else {
        request = [HttpRequestUtils getPostRequest4InsuranceApplicationLanding];
    }
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    [self.webView loadRequest:request];
    NSLog(@"insurance : url : %@", [request URL].relativeString);
    NSLog(@"insurance : webView : %@", webView);

   	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"insurance.title.application",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [[MBKUtil me].queryButton1 setHidden:YES];
    
    UIView *testview;
    for(int i=0; i<[self.webView.subviews count]; i++) {
        testview = [self.webView.subviews objectAtIndex:i];
        NSLog(@"debug 1, %@", testview);
        NSRange foundRange;
        foundRange = [[testview description] rangeOfString:@"ScrollView"];
        if (foundRange.location != NSNotFound) {
            self.scrollView = (UIScrollView*)testview;
        }
    }
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    [InsuranceUtil me].animate = @"YES";
    [AccProUtil me].animate = @"YES";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanCache:) name:@"CleanCache" object:nil];
}

- (void)cleanCache:(NSNotification *)notification {
    if ([self.webView.request.URL.description rangeOfString:@"/servlet/MBPubInsWel"].location == NSNotFound) {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            [storage deleteCookie:cookie];
        }
        [self.webView loadRequest:[HttpRequestUtils getPostRequest4InsuranceApplicationView]];
    }
   
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load InsuranceApplicationViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded InsuranceApplicationViewController");

	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded InsuranceApplicationViewController:%@", error );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}

//-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [self goHome];
//}

- (void)goHome{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
//	[InsuranceUtil me].Insurance_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
    NSLog(@"L209-Insurance 20140702 InsuranceApplicationViewController.m");
	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
	[UIView commitAnimations];
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
    [lbTitleBackImg release];
    lbTitleBackImg = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [lbTitleBackImg release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }

   
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog( @"shouldStartLoadWithRequest:%@", request.mainDocumentURL);
    if ([self.webviewindex isEqualToString:@"pop"]){
        return true;
    }
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/servlet/MBPubInsWel"] ) {
        [self.scrollView setScrollEnabled:NO];
    }else {
        [self.scrollView setScrollEnabled:YES];
    }
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/backToAppWelcomeOffers"] ) {
        NSLog( @"back to app" );
        [self.navigationController popViewControllerAnimated:YES];
        return false;
    } else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/directToStatement"] ) {
        NSLog( @"direct to statement" );
        [self btInterestRatePressed];
        return false;
    } else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToDetails"] ) {
        NSLog( @"go to details" );
        [self btDetailsPressed];
        return false;
    } else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/openInApp"] ) {
        NSRange foundRange;
        foundRange = [request.mainDocumentURL.absoluteString rangeOfString:@"/openInApp?"];
        if (foundRange.location != NSNotFound) {
            NSString *target = [request.mainDocumentURL.absoluteString substringFromIndex:foundRange.location+foundRange.length];
            NSLog( @"openInApp:%@", target);
            [self btopenInApp:target];
        }
        return false;
    }
    if ( [request.mainDocumentURL.relativeString hasPrefix:@"tel:"]) {
        NSLog(@"Make a phone call:%@", [request.mainDocumentURL.relativeString substringFromIndex:4]);
        
        [self webcallToEnquiry:[request.mainDocumentURL.relativeString substringFromIndex:4]];
        return false;
    }
    
    return true;
}

-(void)webcallToEnquiry:(NSString *)enq_number {
    
	
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:enq_number message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}
-(void) btInterestRatePressed{
    WebViewController *webViewController;
	webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
   [webViewController setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]]; //To be retested
	[self.navigationController pushViewController:webViewController animated:TRUE];
//	[webViewController.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]];
	[webViewController release];
}

-(void) btopenInApp:(NSString*)target{
    NSLog( @"btopenInApp:%@", target);
    self.webviewindex = @"pop";
    [self.pop_webView setHidden:NO];
    [self.closeButton setHidden:NO];
    [self.pop_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:target]]];
}

-(IBAction) close_pop_webView {
    NSLog( @"close_pop_webView");
    self.webviewindex = @"";
    [self.pop_webView stopLoading];
    [self.pop_webView setHidden:YES];
    [self.closeButton setHidden:YES];
}

-(void) btDetailsPressed{
    NSString  *targeturl = nil;
    NSString *hotline = @"QuoteAndApply";
    NSString *caption = NSLocalizedString(@"insurance.detail.caption",nil);
    
    if([InsuranceUtil isLangOfChi]){
        targeturl = [MigrationSetting me].URLOfInsuranceDetail_c;
    }else{
        targeturl = [MigrationSetting me].URLOfInsuranceDetail_e;
    }
    InsuranceOffersViewController *insuranceOffersViewController =nil;
	insuranceOffersViewController = [[InsuranceOffersViewController alloc] initWithNibName:@"InsuranceOffersViewController" bundle:nil url:targeturl hotline:hotline caption:caption];
//    [self.view.superview addSubview:insuranceOffersViewController.view];
//    [self.parentViewController addChildViewController:insuranceOffersViewController];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        insuranceOffersViewController.view.frame = CGRectMake(0, -20, 320, 475);
//    }
    [[CoreData sharedCoreData].main_view_controller pushViewController:insuranceOffersViewController animated:false];
    NSLog(@"L209-Insurance 20140702 InsuranceApplicationViewController.m");
	[insuranceOffersViewController release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *targetURL = [NSString stringWithFormat:@"tel:%@", [alertView title],nil];
    
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:targetURL]];
    }
    
}

@end
