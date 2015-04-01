//
//  AccProOffersViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "AccProOffersViewController.h"
#import "AccProUtil.h"
#import "HotlineUtil.h"

@implementation AccProOffersViewController

@synthesize webView;
@synthesize latestpromoUrl;
@synthesize latestpromoHotline;
@synthesize buttonLabel;
//@synthesize callwebView;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil latestpromoUrl:(NSString*)url latestpromoHotline:(NSString *) hotline btnLabel:(NSString*)btnLabel{
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    latestpromoUrl = url;
    latestpromoHotline=hotline;
    buttonLabel = btnLabel;
    NSLog(@"initWithNibName:%@", url);
    NSLog(@"hotline:%@", hotline);
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
//    bgv.frame = CGRectMake(0, 44, 320, 322+[[MyScreenUtil me] getScreenHeightAdjust]);
    webView.frame = CGRectMake(0, 45, 320, 278+[[MyScreenUtil me] getScreenHeightAdjust]);
    callButton.frame = CGRectMake(40, 328+[[MyScreenUtil me] getScreenHeightAdjust], 240, 37);
    
    //	NSString *path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_chi" ofType:@"htm"];
    //	if (![MBKUtil isLangOfChi]) {
    //		path = [[NSBundle mainBundle] pathForResource:@"TaxLoanOffers_eng" ofType:@"htm"];
    //	}
    //	NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]];
    //	[webView loadRequest:req];
    
    NSURL *url= [NSURL URLWithString:self.latestpromoUrl];
    
    //    NSLog(@"getPostRequest4AccProDefaultPage url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [self.webView loadRequest:request];
    //    [self.callwebView loadRequest:[HttpRequestUtils getPostRequest4LatestOfferCall]];
	[callButton setTitle:buttonLabel forState:UIControlStateNormal];
    
   	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"accpro.common.title",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [request release];
    //    CallNowbtn.
	
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load AccProOffersViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded AccProOffersViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded AccProOffersViewController:%@", error );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self goHome];
}

- (void)goHome{
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
//	[AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].taxLoan_view_controller animated:NO];
//	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
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

-(IBAction) call {
	if (![latestpromoHotline isEqualToString:@"NULL" ]) {
		[[HotlineUtil new] call: latestpromoHotline];
		[HotlineUtil release];
	}
}

- (void)dealloc {
    [super dealloc];
}

@end
