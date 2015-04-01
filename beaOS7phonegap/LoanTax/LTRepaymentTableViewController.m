//
//  LTRepaymentTableViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "LTRepaymentTableViewController.h"


@implementation LTRepaymentTableViewController

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
    btLoanOffers.frame = CGRectMake(0, 330, 106, 40+[[MyScreenUtil me] getScreenHeightAdjust]);
    btTNC.frame = CGRectMake(107, 330, 106, 40+[[MyScreenUtil me] getScreenHeightAdjust]);
    btCall.frame = CGRectMake(214, 330, 106, 40+[[MyScreenUtil me] getScreenHeightAdjust]);

	[webView loadRequest:[HttpRequestUtils getPostRequest4LTrepay]];
	
	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"LTTax Loan",nil), NSLocalizedString(@"LTRepayment Table",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
/*
	[btGeneralCustomers setTitle:NSLocalizedString(@"General Customers", nil) forState:UIControlStateNormal] ;
	[btGeneralCustomers setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	btGeneralCustomers.titleLabel.font = [UIFont boldSystemFontOfSize:12];

	[btPrivilegedCustomers setTitle:NSLocalizedString(@"Privileged Customers", nil) forState:UIControlStateNormal] ;
	[btPrivilegedCustomers setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
	btPrivilegedCustomers.titleLabel.font = [UIFont boldSystemFontOfSize:12];
*/	
	lbText3.textColor = [UIColor brownColor];
	lbText3.font = [UIFont boldSystemFontOfSize:10];
	if (![MBKUtil isLangOfChi]) {
		lbText3.center = CGPointMake(305, 10);
	}else {
		lbText3.center = CGPointMake(270, 10);
	}
	
	[btLoanOffers setTitle:NSLocalizedString(@"LTLoan Offers", nil) forState:UIControlStateNormal] ;
	
	[btTNC setTitle:NSLocalizedString(@"T&C", nil) forState:UIControlStateNormal] ;

	[btCall setTitle:NSLocalizedString(@"LTApply", nil) forState:UIControlStateNormal] ;

}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load LTRepaymentTableViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded LTRepaymentTableViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded LTRepaymentTableViewController:%@", error );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[CoreData sharedCoreData]._LTViewController goHome];
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


-(IBAction)btLoanHightlightsPressed{
	[LTUtil showLoanOffers];
}

-(IBAction)btTNCPressed{
	[LTUtil showTNC];
}

-(IBAction)call{

	[[LTUtil new] callToApply];
}
/*
-(IBAction)btGeneralCustomersPressed{
	[btGeneralCustomers setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[btPrivilegedCustomers setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
	lbText3.textColor = [UIColor brownColor];

	NSString *path = [[NSBundle mainBundle] pathForResource:@"LTIntRate_GC_chi" ofType:@"htm"];
	if ([[MBKUtil getLangPref] isEqualToString:@"en"]) {
		path = [[NSBundle mainBundle] pathForResource:@"LTIntRate_GC_eng" ofType:@"htm"];
	}
	NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]]; 
	[webView loadRequest:req];
}

-(IBAction)btPrivilegedCustomersPressed{
	[btGeneralCustomers setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
	[btPrivilegedCustomers setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	lbText3.textColor = [UIColor blueColor];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"LTIntRate_PC_chi" ofType:@"htm"];
	if ([[MBKUtil getLangPref] isEqualToString:@"en"]) {
		path = [[NSBundle mainBundle] pathForResource:@"LTIntRate_PC_eng" ofType:@"htm"];
	}
	NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]]; 
	[webView loadRequest:req];
}
*/

@end
