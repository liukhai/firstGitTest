//
//  FacebookViewController.m
//  BEA
//
//  Created by Helen on 14-8-25.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import "FacebookViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController
@synthesize v_rmvc;
@synthesize urlRequest;
@synthesize webView;
@synthesize v_nav;

- (void)setUrlRequest:(NSURLRequest *)urlrequest setTitle:(NSString *)title{
    urlRequest = [urlrequest retain];
    NSLog(@"debug FacebookViewController setUrlRequest:%@", urlRequest);
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _contentScroll.frame = CGRectMake(_contentScroll.frame.origin.x, _contentScroll.frame.origin.y, _contentScroll.frame.size.width, _contentScroll.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, webView.frame.origin.y,  webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]-20)];
    webView.delegate = self;
    [_contentScroll addSubview:webView];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (screenHeight == 480 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        webView.frame = CGRectMake(0, webView.frame.origin.y -20 ,  webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    }
    if ( screenHeight == 568 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        webView.frame = CGRectMake(0, webView.frame.origin.y,  webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust] - 88);
    }if ( screenHeight == 568 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ) {
        webView.frame = CGRectMake(0, webView.frame.origin.y-20,  webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust] - 88);
    }
    if (screenHeight == 480 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)  {
        webView.frame = CGRectMake(0, webView.frame.origin.y,  webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    }
    [webView setScalesPageToFit:YES];
    self.v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    [self.view addSubview:self.v_rmvc.contentView];

    if (!v_nav) {
        [self.v_rmvc.rmUtil setNav:[CoreData sharedCoreData].bea_view_controller.navigationController];
    } else {
        [self.v_rmvc.rmUtil setNav:v_nav];
    }
    
    NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"%@",[MigrationSetting me].URLOfFacebook_fun]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [self.webView loadRequest:request];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanCache:) name:@"CleanCache" object:nil];
}

-(void)setNav:(UINavigationController*)a_nav
{
    v_nav = [a_nav retain];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load FacebookViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded FacebookViewController");
//    CGSize size = webView.scrollView.contentSize;
//    CGRect frame = webView.frame;
//    frame.size = size;
//    webView.frame = frame;
//    _contentScroll.contentSize = size;
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[CoreData sharedCoreData].mask hiddenMask];
    NSLog(@"fail loaded FacebookViewController:%@", error );
    if ([error code] != NSURLErrorCancelled
        && [error code] != 101) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"FacebookViewController mainDocumentURL:%@", request.mainDocumentURL );
    return YES;
}

- (void)cleanCache:(NSNotification *)notification {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    [webView loadRequest:urlRequest];
}

- (void)dealloc {
    [contentScroll release];
    [_contentScroll release];
    [webView release];
    [super dealloc];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
}
@end
