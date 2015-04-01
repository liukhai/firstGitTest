//
//  TaxLoanOffersViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "TaxLoanOffersViewController.h"


@implementation TaxLoanOffersViewController

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

//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    webView.frame = CGRectMake(0, 43, 320, 281+[[MyScreenUtil me] getScreenHeightAdjust]);
    btTNC.frame = CGRectMake(2, 329+[[MyScreenUtil me] getScreenHeightAdjust], 156, 37);
    btCall.frame = CGRectMake(162, 329+[[MyScreenUtil me] getScreenHeightAdjust], 156, 37);

	//NSString *path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_chi" ofType:@"htm"];
	//if (![MBKUtil isLangOfChi]) {
	//	path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_eng" ofType:@"htm"];
	//}
	//NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]]; 
	//[webView loadRequest:req];
    [self.webView loadRequest:[HttpRequestUtils getPostRequest_loanOffer]];
	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"Tax Loan",nil), NSLocalizedString(@"Loan Offers",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	
	[btTNC setTitle:NSLocalizedString(@"T&C", nil) forState:UIControlStateNormal] ;
	
	[btCall setTitle:NSLocalizedString(@"Apply", nil) forState:UIControlStateNormal] ;
	
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

/*
-(IBAction) btInterestRatePressed{
	[TaxLoanUtil showRepaymentTable];
}
*/
-(IBAction) btTNCPressed{
	[TaxLoanUtil showTNC];
}

-(IBAction)call{
	[[TaxLoanUtil new ]callToApply];
}


-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load TaxLoanOffersViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded TaxLoanOffersViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded TaxLoanOffersViewController" );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[CoreData sharedCoreData].taxLoan_view_controller goMain];
}

- (void)goHome{
/*	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];          */
//	[CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].taxLoan_view_controller animated:NO];
    NSLog(@"Navigation Revamp - Consumer Loan - TaxLoanOffersViewController.m");
/*	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];


	[UIView commitAnimations];                  */
}


@end
