//
//  ConsumerLoanApplicationViewController.m
//  BEA
//
//  Created by NEO on 11/14/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "ConsumerLoanApplicationViewController.h"
#import "ConsumerLoanUtil.h"
#import "MBKUtil.h"

@implementation ConsumerLoanApplicationViewController

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
    
    self.view.frame = CGRectMake(0, 0, 320, 326+[[MyScreenUtil me] getScreenHeightAdjust]);
    webView.frame = CGRectMake(0, 0, 320, 326+[[MyScreenUtil me] getScreenHeightAdjust]);

    [self.webView loadRequest:[HttpRequestUtils getPostRequest4ConsumerLoanApplicationView]];
    
   	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"consumerloan.offers.title",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [[MBKUtil me].queryButton1 setHidden:YES];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        WebViewController *webViewController;
        webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        [webViewController setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]]; //To be retested
        
        webViewController.view.frame = CGRectMake(320, 0, 0, 0);
        [self.view addSubview:webViewController.view];
    }
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load ConsumerLoanApplicationViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded ConsumerLoanApplicationViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded ConsumerLoanApplicationViewController:%@", error );
    
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
	[ConsumerLoanUtil me].ConsumerLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",[NSString stringWithFormat:@"%@",request.HTTPBody]);
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0 && [request.mainDocumentURL.relativeString rangeOfString:@"ConsumerLoanPromoInputShow"].location != NSNotFound && !request.HTTPBody) {
        [self.webView loadRequest:[HttpRequestUtils getPostRequest4ConsumerLoanApplicationView]];
        return false;
    }
    NSLog(@"debug shouldStartLoadWithRequest:%@", request.mainDocumentURL.relativeString);
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/backToAppWelcomeOffers"] ) {
        NSLog( @"back to app" );
//        [self.navigationController popViewControllerAnimated:YES];
        [self.webView loadRequest:[HttpRequestUtils getPostRequest4ConsumerLoanApplicationView]];
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
    
    [webViewController setNav:[CoreData sharedCoreData].taxLoan_view_controller.navigationController];
	[[CoreData sharedCoreData].taxLoan_view_controller.navigationController pushViewController:webViewController animated:NO];
    NSLog(@"debug ConsumerLoanApplicationViewController:%@", NSLocalizedString(@"PICStatement_link",nil));
	//[webViewController.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]];
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
@end
