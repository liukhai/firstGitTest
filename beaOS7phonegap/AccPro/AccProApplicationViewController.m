//
//  AccProApplicationViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "AccProApplicationViewController.h"
#import "AccProUtil.h"
#import "MBKUtil.h"

//edit by chu
@interface AccProApplicationViewController () {
}

@end

@implementation AccProApplicationViewController

@synthesize webView;

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
    //edit by chu 20150217
    [self refreshViewContent];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect frame = webView.frame;
        frame.size.height = frame.size.height -20;
        webView.frame = frame;
    }
    
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load AccProApplicationViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded AccProApplicationViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded AccProApplicationViewController:%@", error );

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}

//-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [self goHome];
//}

- (void)goHome{
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
//	[AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[AccProUtil me].AccPro_view_controller.navigationController popToRootViewControllerAnimated:NO];
	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//	[UIView commitAnimations];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"debug shouldStartLoadWithRequest:%@", request.mainDocumentURL.relativeString);
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0 && [request.mainDocumentURL.relativeString rangeOfString:@"LatestPromoInputShow"].location != NSNotFound && !request.HTTPBody) {
        [self.webView loadRequest:[HttpRequestUtils getPostRequest4AccProApplicationView]];
        return false;
    }
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/backToAppWelcomeOffers"] ) {    
        NSLog( @"back to app" );
        [[AccProUtil me].AccPro_view_controller welcome];
        return false; 
    } else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/directToStatement"] ) {  
        NSLog( @"direct to statement" );
        [self btInterestRatePressed];
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
    [webViewController setNav:[AccProUtil me].AccPro_view_controller.navigationController];
	[[AccProUtil me].AccPro_view_controller.navigationController pushViewController:webViewController animated:TRUE];
    NSLog(@"debug AccProApplicationViewController:%@", NSLocalizedString(@"PICStatement_link",nil));
//	[webViewController.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]];

	[webViewController release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *targetURL = [NSString stringWithFormat:@"tel:%@", [alertView title],nil];

    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:targetURL]];
    }

}

- (void)doMenuButtonsPressed:(id)sender {
    if (((UIView *)sender).tag != 2) {
        return;
    }
    if (self.isShow && [webView.request.mainDocumentURL.relativeString rangeOfString:@"PromoPickShow"].location != NSNotFound) {
        [webView goBack];
    }else {
        [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
    }
}

//edit chu
-(void) refreshViewContent{
    
    //    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    webView.frame = CGRectMake(0, 45, 320, 322+[[MyScreenUtil me] getScreenHeightAdjust]);
    
    //	NSString *path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_chi" ofType:@"htm"];
    //	if (![MBKUtil isLangOfChi]) {
    //		path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_eng" ofType:@"htm"];
    //	}
    //	NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]];
    //	[webView loadRequest:req];
    
    [self.webView loadRequest:[HttpRequestUtils getPostRequest4AccProApplicationView]];
    
   	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"accpro.common.title",nil)];
    lbTitle.font = [UIFont boldSystemFontOfSize:17];
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.numberOfLines = 2;
    lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [[MBKUtil me].queryButton1 setHidden:YES];
}
@end
