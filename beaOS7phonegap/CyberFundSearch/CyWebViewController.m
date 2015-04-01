//
//  CyWebViewController.m
//  BEA
//
//  Created by Joseph on 4/21/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import "CyWebViewController.h"
#import "MyScreenUtil.h"
#import "CoreData.h"


@interface CyWebViewController ()

@end

@implementation CyWebViewController

@synthesize webView;
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
    self.navigationController.navigationItem.backBarButtonItem.tintColor = [UIColor redColor];

    // Do any additional setup after loading the view from its nib.
    NSLog(@"debug CyWebViewController viewDidLoad h1:%f",self.webView.frame.size.height);
     NSLog(@"debug CyWebViewController viewDidLoad h2:%f",self.view.frame.size.height);
    webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y-20, webView.frame.size.width, webView.frame.size.height);
    }
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width,[[MyScreenUtil me] getScreenHeight_IOS7_20]);
    NSLog(@"debug CyWebViewController viewDidLoad urlRequest:%@",urlRequest);
    
    
    UIWebView *loadWebView = [[UIWebView alloc] initWithFrame:CGRectMake(320, 100, 100, 100)];
    [loadWebView loadRequest:urlRequest];
    [self.view addSubview:loadWebView];
    loadWebView.delegate = self;
    
    
    NSLog(@"debug CyWebViewController viewDidLoad h1:%f",self.webView.frame.size.height);
     NSLog(@"debug CyWebViewController viewDidLoad h2:%f",self.view.frame.size.height);
}

//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [[CoreData sharedCoreData].mask showMask];
//}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [[CoreData sharedCoreData].mask hiddenMask];
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView loadRequest:urlRequest];
//    [[CoreData sharedCoreData].mask hiddenMask];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [webView release];
    [super dealloc];
}
- (void)setUrlRequest:(NSURLRequest *)urlrequest{
    urlRequest = [urlrequest retain];
    NSLog(@"debug WebViewController setUrlRequest:%@", urlRequest);
}
@end
