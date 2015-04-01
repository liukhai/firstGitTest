//
//  InstalmentLoanOffersViewController.m
//  BEA
//
//  Created by NEO on 01/12/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "InstalmentLoanOffersViewController.h"
#import "InstalmentLoanUtil.h"


@implementation InstalmentLoanOffersViewController

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
    NSLog(@"InstalmentLoanOffersViewController");
    [super viewDidLoad];

//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 00, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    webView.frame = CGRectMake(0, 44, 320, 280+[[MyScreenUtil me] getScreenHeightAdjust]);
    btRepaymentTalbe.frame = CGRectMake(0, 330+[[MyScreenUtil me] getScreenHeightAdjust], 106, 40);
    btTNC.frame = CGRectMake(107, 330+[[MyScreenUtil me] getScreenHeightAdjust], 106, 40);
    btCall.frame = CGRectMake(214, 330+[[MyScreenUtil me] getScreenHeightAdjust], 106, 40);

	[webView loadRequest:[HttpRequestUtils getPostRequest4InstalmentLoanOffers]];

	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"instalmentLoan.title",nil), NSLocalizedString(@"LTLoan Offers",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	
	[btRepaymentTalbe setTitle:NSLocalizedString(@"LTRepayment Table", nil) forState:UIControlStateNormal] ;
	
	[btTNC setTitle:NSLocalizedString(@"T&C", nil) forState:UIControlStateNormal] ;
	
	[btCall setTitle:NSLocalizedString(@"LTApply", nil) forState:UIControlStateNormal] ;
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load InstalmentLoanOffersViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded InstalmentLoanOffersViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded InstalmentLoanOffersViewController:%@", error );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}
- (BOOL)webView:(UIWebView *)local_webview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{ 
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/show_repay_table_en"]) { 
        NSLog(@"Show tax loan repay table english");
        [InstalmentLoanUtil showRepaymentTable];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/show_repay_table_zh"]){
    NSLog(@"Show tax loan repay table chinese");
        [InstalmentLoanUtil showRepaymentTable];
        return false;
    } 
    return true; 
} 
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[CoreData sharedCoreData]._InstalmentLoanViewController goHome];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


-(IBAction) btInterestRatePressed{
	[InstalmentLoanUtil showRepaymentTable];
}

-(IBAction) btTNCPressed{
	[InstalmentLoanUtil showTNC];
}

-(IBAction)call{
	[[InstalmentLoanUtil new ] callToApply];
}


@end
