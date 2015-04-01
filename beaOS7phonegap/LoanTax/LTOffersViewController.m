//
//  LTOffersViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "LTOffersViewController.h"


@implementation LTOffersViewController

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
    btRepaymentTalbe.frame = CGRectMake(0, 330+[[MyScreenUtil me] getScreenHeightAdjust], 106, 40);
    btTNC.frame = CGRectMake(107, 330+[[MyScreenUtil me] getScreenHeightAdjust], 106, 40);
    btCall.frame = CGRectMake(214, 330+[[MyScreenUtil me] getScreenHeightAdjust], 106, 40);

	[webView loadRequest:[HttpRequestUtils getPostRequest4LToffer]];

//Special version for press con.
/*    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_chi" ofType:@"htm"];
    if (![MBKUtil isLangOfChi]) {
        path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_eng" ofType:@"htm"];
    }
    NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]]; 
    [webView loadRequest:req];    
    
*/    
	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"LTTax Loan",nil), NSLocalizedString(@"LTLoan Offers",nil)];
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
	NSLog(@"Start load LTOffersViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded LTOffersViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded LTOffersViewController:%@", error );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}
- (BOOL)webView:(UIWebView *)local_webview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{ 
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/show_repay_table_en"]) { 
        NSLog(@"Show tax loan repay table english");
        [LTUtil showRepaymentTable];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/show_repay_table_zh"]){
    NSLog(@"Show tax loan repay table chinese");
        [LTUtil showRepaymentTable];
        return false;
    } 
    return true; 
} 
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[CoreData sharedCoreData]._LTViewController goHome];
}

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


-(IBAction) btInterestRatePressed{
	[LTUtil showRepaymentTable];
}

-(IBAction) btTNCPressed{
	[LTUtil showTNC];
}

-(IBAction)call{
	[[LTUtil new ] callToApply];
}


@end
