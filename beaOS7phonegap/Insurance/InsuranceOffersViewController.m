//
//  InsuranceOffersViewController.m
//  BEA
//
//  Created by NEO on 03/01/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "InsuranceOffersViewController.h"
#import "InsuranceUtil.h"
#import "HotlineUtil.h"
#import "LangUtil.h"
#import "InsuranceMenuViewController.h"

@implementation InsuranceOffersViewController

@synthesize webView, pop_webView;
@synthesize InsurancePromoUrl;
@synthesize InsuranceHotline;//@synthesize callwebView;
@synthesize buttonCaption;//@synthesize callwebView;
@synthesize callButton, closeButton;
@synthesize webviewindex;


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString*)url{
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    InsurancePromoUrl = url;
    InsuranceHotline = @"36082988";
    buttonCaption = [NSString stringWithFormat:@"%@", NSLocalizedString(@"Apply Now",nil)];
    
    NSLog(@"InsuranceOffersViewController initWithNibName:%@", url);
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString*)url hotline:(NSString*) hotline caption:(NSString*)caption{
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    InsurancePromoUrl = url;
    InsuranceHotline = hotline;
    buttonCaption = caption;
    NSLog(@"InsuranceOffersViewController initWithNibName:%@", url);
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
   _contentScroll.frame = CGRectMake(_contentScroll.frame.origin.x, _contentScroll.frame.origin.y, _contentScroll.frame.size.width, _contentScroll.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    
    applyButton.frame = CGRectMake(applyButton.frame.origin.x, applyButton.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], applyButton.frame.size.width, applyButton.frame.size.height);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ||
        ( [[[UIDevice currentDevice] systemVersion] floatValue] == 6.0 && [[UIScreen mainScreen] bounds].size.height > 480)
        ) {
        [[MyScreenUtil me] adjustmentcontrolY20:webView];
        [[MyScreenUtil me] adjustmentcontrolY20:pop_webView];
        [[MyScreenUtil me] adjustmentcontrolY20:callButton];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitle];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitleBackImg];
    }
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (screenHeight == 568 && [[UIDevice currentDevice].systemVersion doubleValue] >= 6.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 7.0) {
        self.view.frame = CGRectMake(0, 0, 320, 475);
        webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
        pop_webView.frame = CGRectMake(pop_webView.frame.origin.x, pop_webView.frame.origin.y, pop_webView.frame.size.width, pop_webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]+100);
        callButton.frame = CGRectMake(callButton.frame.origin.x, callButton.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], callButton.frame.size.width, callButton.frame.size.height);
    }else {
        webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
        pop_webView.frame = CGRectMake(pop_webView.frame.origin.x, pop_webView.frame.origin.y, pop_webView.frame.size.width, pop_webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
        callButton.frame = CGRectMake(callButton.frame.origin.x, callButton.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], callButton.frame.size.width, callButton.frame.size.height);
    }
    NSURL *url= [NSURL URLWithString:self.InsurancePromoUrl];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [self.webView loadRequest:request];
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    if ([[InsuranceUtil me].frompage isEqualToString:@"accpro"]) {
        //[InsuranceUtil me].frompage = @"";
        lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"insurance.title.news",nil)];
        [InsuranceUtil me].Insurance_view_controller.tabBar.selectedItem =[[InsuranceUtil me].Insurance_view_controller.tabBar.items objectAtIndex:1];
    }else{
        if ([InsuranceUtil me].Insurance_view_controller.tabBar.selectedItem == [[InsuranceUtil me].Insurance_view_controller.tabBar.items objectAtIndex:1]){
            lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"insurance.title.news",nil)];
        }else {
            lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"insurance.title.products",nil)];
            
        }
    }
//    [applyButton setTitle:NSLocalizedString(@"insurance.detail.caption",nil) forState:UIControlStateNormal];
    [applyButton setTitle:buttonCaption forState:UIControlStateNormal];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	[callButton setTitle:buttonCaption forState:UIControlStateNormal];
    if ([InsuranceHotline isEqualToString:@"QuoteAndApply"]){
        [callButton setBackgroundImage:[UIImage imageNamed:@"merchant_button_4.png"] forState:UIControlStateNormal];
    }
    [request release];
    
    UIView *mmenuv0 = [[UIView alloc] init];
    UIView *mmenuv1 = [[UIView alloc] init];
    UIView *mmenuv2 = [[UIView alloc] init];
    UIView *mmenuv3 = [[UIView alloc] init];
    

        
        v_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
        v_rmvc.rmUtil.caller = self;
        
        [self.view addSubview:v_rmvc.contentView];
        
        NSArray* a_texts = [NSArray arrayWithObjects:NSLocalizedString(@"tag_insurance_products", nil),
                            NSLocalizedString(@"tag_insurance_news", nil),
                            NSLocalizedString(@"tag_insurance_enquiries", nil),
                            NSLocalizedString(@"tag_insurance_applications", nil),
                            nil];
        [v_rmvc.rmUtil setTextArray:a_texts];
        
        NSArray* a_views = [NSArray arrayWithObjects:mmenuv0,mmenuv1,mmenuv2,mmenuv3, nil];
        //            NSArray* a_views = [NSArray arrayWithObjects:mmenuv0,mmenuv1,mmenuv2, nil];
        
        [v_rmvc.rmUtil setViewArray:a_views];
        
        [v_rmvc.rmUtil setNav:self.navigationController];
        [v_rmvc.rmUtil setShowIndex:self.show];
        [v_rmvc.rmUtil showMenu];
    
	
}

-(void)showMenu:(int)show
{
    if (notFirst) {
        [self.navigationController popViewControllerAnimated:NO];
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[[InsuranceUtil me].Insurance_view_controller.navigationController viewControllers]];
//        [viewControllers removeLastObject];
        if ([[viewControllers lastObject] isKindOfClass:[InsuranceMenuViewController class]]) {
            //[[CoreData sharedCoreData]._InsuranceViewController.navigationController popViewControllerAnimated:NO];
            [(InsuranceMenuViewController *)[viewControllers lastObject] welcome:show];
        }
    }
    notFirst = YES;
    
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load InsuranceOffersViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded InsuranceOffersViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded InsuranceOffersViewController:%@", error );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[InsuranceUtil me].Insurance_view_controller.navigationController popToRootViewControllerAnimated:YES];
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
    [lbTitleBackImg release];
    lbTitleBackImg = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction) call {
	NSLog(@"Start call");
    if ([InsuranceHotline isEqualToString:@"QuoteAndApply"]){
        [InsuranceUtil me].frompage = @"list";
        [InsuranceUtil me].quoteAndApply = @"YES";
////        [[InsuranceUtil me].Insurance_view_controller forwardNextView:NSClassFromString(@"InsuranceApplicationViewController") viewName:@"InsuranceApplicationViewController"];
//        [v_rmvc.rmUtil setShowIndex:3];
//        [v_rmvc.rmUtil showMenu];
        InsuranceApplicationViewController *application = [[InsuranceApplicationViewController alloc]initWithNibName:@"InsuranceApplicationViewController" bundle:nil];
        CGRect frame = self.view.frame;
        frame.origin.y = 95;
        frame.size.height -= 95;
        application.view.frame = frame;
        [self.view addSubview:application.view];
    	NSLog(@"Start Application");
    }else{
		[[HotlineUtil new] call: InsuranceHotline];
		[HotlineUtil release];
        NSLog(@"Start callHotline");
    }
}


- (void)dealloc {
    [lbTitleBackImg release];
    [super dealloc];
}

// Amended by Jasen on 20120330
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([self.webviewindex isEqualToString:@"pop"]){
        return true;
    }
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToEnquiry"] ) {
        [InsuranceUtil me].frompage = @"list";
        [[InsuranceUtil me].Insurance_view_controller forwardNextView:NSClassFromString(@"InsuranceEnquiryViewController") viewName:@"InsuranceEnquiryViewController"];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToApply"] ) {
        [InsuranceUtil me].frompage = @"list";
        [InsuranceUtil me].quoteAndApply = @"YES";
        [[InsuranceUtil me].Insurance_view_controller forwardNextView:NSClassFromString(@"InsuranceApplicationViewController") viewName:@"InsuranceApplicationViewController"];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToPromo"] ) {
        [InsuranceUtil me].frompage = @"list";
        [[InsuranceUtil me].Insurance_view_controller forwardNextView:NSClassFromString(@"InsuranceNewsViewController") viewName:@"InsuranceNewsViewController"];
        return false;
    } else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/openInApp"] ) {
        NSRange foundRange;
        foundRange = [request.mainDocumentURL.absoluteString rangeOfString:@"/openInApp?"];
        NSLog( @"openInApp:%u--%u--%@", foundRange.location, foundRange.length, request.mainDocumentURL.absoluteString);
        if (foundRange.location != NSNotFound) {
            NSString *target = [request.mainDocumentURL.absoluteString substringFromIndex:foundRange.location+foundRange.length];
            NSLog( @"openInApp:%@", target);
            [self btopenInApp:target];
        }
        return false;
    }
    return true;
}

-(void) btopenInApp:(NSString*)target{
    NSLog( @"btopenInApp:%@", target);
    self.webviewindex = @"pop";
    [self.pop_webView setHidden:NO];
    [self.closeButton setHidden:NO];
    [self.pop_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:target]]];
}

-(IBAction) close_pop_webView {
    NSLog( @"close_pop_webView");
    self.webviewindex = @"";
    [self.pop_webView stopLoading];
    [self.pop_webView setHidden:YES];
    [self.closeButton setHidden:YES];
}

@end
