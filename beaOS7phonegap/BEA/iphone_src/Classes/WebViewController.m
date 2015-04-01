//
//  WebViewController.m
//  BEA
//
//  Created by Algebra Lo on 10年6月27日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController
@synthesize v_rmvc;
@synthesize urlRequest;
@synthesize web_view;
@synthesize v_nav;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
// - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
// if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
// // Custom initialization
//     web_view = [[MyWebView alloc] init];
//     web_view.caller = self;
// }
// return self;
// }

- (void)setUrlRequest:(NSURLRequest *)urlrequest{
    urlRequest = [urlrequest retain];
    NSLog(@"debug WebViewController setUrlRequest:%@", urlRequest);
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.frame = CGRectMake(0, 20, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    web_view.frame = CGRectMake(0, web_view.frame.origin.y,  web_view.frame.size.width, web_view.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust_20]);
    [[MBKUtil me].queryButton1 setHidden:YES];
    
    self.v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    [self.view addSubview:self.v_rmvc.contentView];
    NSLog(@"debug WebViewController viewDidLoad v_nav:%@",v_nav);
    if (!v_nav) {
        [self.v_rmvc.rmUtil setNav:[CoreData sharedCoreData].bea_view_controller.navigationController];
    } else {
//        NSLog(@"debug WebViewController viewDidLoad setNav v_nav:%@",v_nav);
        [self.v_rmvc.rmUtil setNav:v_nav];
//        NSLog(@"debug WebViewController viewDidLoad setNav rmUtil.nav4process:%@",self.v_rmvc.rmUtil.nav4process);
    }
        
//	NSLog(@"debug WebViewController viewDidLoad urlRequest:%@",urlRequest);
//	NSLog(@"debug WebViewController viewDidLoad rmUtil setNav:%@",self.v_rmvc.rmUtil.nav4process);
    
  //  [i_web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]];
    NSLog(@"debug WebViewController viewDidLoad urlRequest:%@",urlRequest);
    [web_view loadRequest:urlRequest];
    NSLog(@"[urlRequest retainCount] is %d", [urlRequest retainCount]);
//	NSLog(@"debug WebViewController viewDidLoad loadRequest after:%@", i_web_view);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanCache:) name:@"CleanCache" object:nil];
    
    if ( ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) && ([[UIScreen mainScreen] bounds].size.height > 480) ) {
        
        CGRect rect = [CoreData sharedCoreData]._BEAAppDelegate.window.frame;
        rect.origin.y = 20;
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame = rect;
    } else {
        CGRect rect = [CoreData sharedCoreData]._BEAAppDelegate.window.frame;
        rect.origin.y = 00;
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame = rect;
    }
    
    
}

- (void)cleanCache:(NSNotification *)notification {
    NSLog(@"%i",[urlRequest.URL.description rangeOfString:@"/servlet/MELogonShow"].location);
    if ([urlRequest.URL.description rangeOfString:@"/servlet/MBAIOLogonShow"].location != NSNotFound || [urlRequest.URL.description rangeOfString:@"/servlet/MELogonShow"].location != NSNotFound || [urlRequest.URL.description rangeOfString:@"/servlet/MBLogonShow"].location != NSNotFound ) {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            [storage deleteCookie:cookie];
        }
        [web_view loadRequest:urlRequest];
    }

}

-(void)setNav:(UINavigationController*)a_nav
{
//	NSLog(@"debug WebViewController setNav self.v_rmvc.rmUtil:%@", self.v_rmvc.rmUtil);
    v_nav = a_nav;
//	NSLog(@"debug WebViewController setNav a_nav:%@", a_nav);
//	NSLog(@"debug WebViewController setNav rmUtil.nav4process:%@", self.v_rmvc.rmUtil.nav4process);
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
    [urlRequest release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
    
    if ( ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ) {
        
        CGRect rect = [CoreData sharedCoreData]._BEAAppDelegate.window.frame;
        rect.origin.y = 20;
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame = rect;
    } else {
        CGRect rect = [CoreData sharedCoreData]._BEAAppDelegate.window.frame;
        rect.origin.y = 00;
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame = rect;
    }
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"debug WebViewController Start load");
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"debug WebViewController Finish loaded");
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
    NSLog(@"debug WebViewController fail loaded:%@", error);
    
    if([error code] == NSURLErrorCancelled){
        return;
    }
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
 	NSLog(@"debug WebViewController shouldStartLoadWithRequest:%@", request.mainDocumentURL.absoluteString);

    BOOL ret = YES;
    NSRange foundRange3;
    foundRange3 = [request.mainDocumentURL.absoluteString rangeOfString:[MigrationSetting me].CYBDomain];
    if (foundRange3.location != NSNotFound) {
        NSRange foundRange;
        NSRange foundRange2;
        NSRange foundRange4;
        foundRange = [request.mainDocumentURL.absoluteString rangeOfString:@"Logon"];
        foundRange2 = [request.mainDocumentURL.absoluteString rangeOfString:@"Logout"];
        foundRange4 = [request.mainDocumentURL.absoluteString rangeOfString:@"App_Important_Notice"];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        if (foundRange.location != NSNotFound || foundRange2.location != NSNotFound || foundRange4.location != NSNotFound) {
            NSLog(@"back button show");
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            [self.navigationItem setHidesBackButton:NO];
        }else{
            NSLog(@"back button hide");
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            [self.navigationItem setHidesBackButton:YES];
        }
    }
    return ret;
}

@end
