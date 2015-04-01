//
//  WebViewController2.m
//  BEA
//
//  Created by Joseph on 3/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import "WebViewController2.h"

@interface WebViewController2 ()

@end

@implementation WebViewController2

@synthesize v_rmvc;
@synthesize urlRequest;
@synthesize web_view;
@synthesize v_nav;


- (void)setUrlRequest:(NSURLRequest *)urlrequest setTitle:(NSString *)title{
    urlRequest = [urlrequest retain];
    mTitle = [title retain];
    NSLog(@"debug WebViewController setUrlRequest:%@", urlRequest);
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    web_view.frame = CGRectMake(0, web_view.frame.origin.y + _mTitleLabel.frame.origin.y,  web_view.frame.size.width, web_view.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]-90);
    [[MBKUtil me].queryButton1 setHidden:YES];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
//    if ( screenHeight == 568 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//        web_view.frame = CGRectMake(0, web_view.frame.origin.y + self.mTitleLabel.frame.size.height,  web_view.frame.size.width, web_view.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust] - 110);
//    }
//    if (screenHeight == 480 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)  {
//        web_view.frame = CGRectMake(0, web_view.frame.origin.y + self.mTitleLabel.frame.size.height,  web_view.frame.size.width, web_view.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust] - 20);
//    }
    
//    [self.mTitleLabel setText:mTitle];
//    self.mTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 67, 307, 24)];
    self.mTitleLabel.font = [UIFont systemFontOfSize:15];  //UILabel的字体大小
    self.mTitleLabel.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
    self.mTitleLabel.backgroundColor = [UIColor clearColor];
    self.mTitleLabel.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    //宽度不变，根据字的多少计算label的高度
    CGSize size = [mTitle sizeWithFont:self.mTitleLabel.font constrainedToSize:CGSizeMake(self.mTitleLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    //根据计算结果重新设置UILabel的尺寸
    [self.mTitleLabel setFrame:CGRectMake(7, 66, 307, size.height)];
    self.mTitleLabel.text = mTitle;
    [self.view addSubview:self.mTitleLabel];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 66, 320, self.mTitleLabel.frame.size.height)];
    [self.view addSubview:bgView];
    [self.view bringSubviewToFront:self.mTitleLabel];
    
    CGRect webViewFrame = web_view.frame;
    webViewFrame.origin.y += self.mTitleLabel.frame.size.height + 10;
    webViewFrame.size.height = screenHeight - webViewFrame.origin.y - 20;
    web_view.frame = webViewFrame;
    
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
    if (!urlRequest) {
        [self.web_view removeFromSuperview];
    }
}

-(void)setNav:(UINavigationController*)a_nav
{
    //	NSLog(@"debug WebViewController setNav self.v_rmvc.rmUtil:%@", self.v_rmvc.rmUtil);
    v_nav = [a_nav retain];
    //	NSLog(@"debug WebViewController setNav a_nav:%@", a_nav);

}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [self setMTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [urlRequest release];
    [_mTitleLabel release];
    [super dealloc];
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"debug WebViewController Start load");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"debug WebViewController Finish loaded");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"debug WebViewController fail loaded:%@", error);
    
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
        if (foundRange.location != NSNotFound || foundRange2.location != NSNotFound || foundRange4.location != NSNotFound) {
            NSLog(@"back button show");
            [self.navigationItem setHidesBackButton:NO];
        }else{
            NSLog(@"back button hide");
            [self.navigationItem setHidesBackButton:YES];
        }
    }
    return ret;
}
//-(IBAction)backToHomePressed:(UIButton *)button {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
//- (IBAction)doMenuButtonsPressed:(UIButton *)sender
//{
//    switch (sender.tag) {
//        case 2:
//            NSLog(@"back");
//            [self backToHomePressed:sender];
//            break;
//            
//        default:
//            break;
//    }
//    
//}
@end
