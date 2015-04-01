//
//  AccProOffersViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "AccProDefaultPageViewController.h"
#import "AccProUtil.h"

#define MAX_SALARY_AMOUNT 130000.00
#define MIN_SALARY_AMOUNT  10000.00

#define MAX_REWARD_AMOUNT 3800.00
#define MIN_REWARD_AMOUNT  300.00

@implementation AccProDefaultPageViewController

@synthesize webView,topwebView,callwebView;
@synthesize contentView;
@synthesize scroll_view;
@synthesize numberFormatter;
@synthesize numberFormatter2;
@synthesize lbTitle,lbReward,lbSimulator;
@synthesize queryButton1;
@synthesize tfSalary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[CachedImageView clearAllCache];
    }
    
    return self;
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scroll_view addSubview:contentView];
    [self.scroll_view setContentSize:CGSizeMake(scroll_view.frame.size.width, contentView.frame.size.height)];
    
    numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:0];
	[numberFormatter setMinimumFractionDigits:0];
	[numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];

    numberFormatter2 = [[NSNumberFormatter alloc] init];
	[numberFormatter2 setNumberStyle: NSNumberFormatterDecimalStyle];
	[numberFormatter2 setMaximumFractionDigits:2];
	[numberFormatter2 setMinimumFractionDigits:2];
	[numberFormatter2 setRoundingMode:NSNumberFormatterRoundHalfUp];

    //NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"htm"];
	//if (![MBKUtil isLangOfChi]) {
	//	path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"htm"];
	//}
    
	//NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]];
	//[webView loadRequest:req];
    if ([MBKUtil wifiNetWorkAvailable]) {
        NSLog(@"AccProDefaultPageViewController: loadWebView.");
        
    [self.webView loadRequest:[HttpRequestUtils getPostRequest4AccProOffersView]];
    [self.topwebView loadRequest:[HttpRequestUtils getPostRequest4AccProDefaultPage]];
    [self.callwebView loadRequest:[HttpRequestUtils getPostRequest4LatestOfferCall]];
//        [[CoreData sharedCoreData].mask showMask];

        NSLog(@"AccProDefaultPageViewController: wifi network is ok.");
    }else{

        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];

        NSLog(@"AccProDefaultPageViewController: wifi network is fail.");
    }
    

	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"accpro.common.title",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    lbReward.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
    lbSimulator.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
    
    self.tfSalary.text = @"25,000.00";

    [self updateRewardBySalary];
    
    [[MBKUtil me].queryButton1 addTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
      [[AccProUtil me].AccPro_view_controller goHome2];
}

- (void)goHome{
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
//	[AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[AccProUtil me].AccPro_view_controller.navigationController popViewControllerAnimated:NO];
	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    
    
//	[UIView commitAnimations];
}

-(void)queryFromKeypad:(UIButton *) btnQuery{
    //    PropertyLoanEnquiryViewController *enquireCtrl = [[PropertyLoanEnquiryViewController alloc] initWithNibName:  @"PropertyLoanEnquiryViewController" bundle:nil]; 
    //    [self.navigationController pushViewController:enquireCtrl animated:TRUE];
    //    [enquireCtrl release];
    [self.view endEditing:TRUE];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"AccProDefault.. textFieldDidBeginEditing");
    self.tfSalary.text = @"";
    CGRect frame = self.scroll_view.frame;
    frame.origin.y = self.tfSalary.frame.origin.y;
    [self.scroll_view scrollRectToVisible:frame animated:YES];
    
}

-(void)updateRewardBySalary{
    double salary = [[self.tfSalary.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    
    double dreward = salary*0.03;
    if (dreward<MIN_REWARD_AMOUNT) dreward = MIN_REWARD_AMOUNT;
    if (dreward>MAX_REWARD_AMOUNT) dreward = MAX_REWARD_AMOUNT;

    lbReward.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"HK$",nil), [numberFormatter stringFromNumber:[NSNumber numberWithDouble:dreward]]];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"AccProDefault.. textFieldDidEndEditing");
    double salary = [[self.tfSalary.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    if (salary<MIN_SALARY_AMOUNT) salary = MIN_SALARY_AMOUNT;
    if (salary>MAX_SALARY_AMOUNT) salary = MAX_SALARY_AMOUNT;
    
    self.tfSalary.text = [numberFormatter2 stringFromNumber:[NSNumber numberWithDouble:salary]];

    [self updateRewardBySalary];

    sl_salary.value = salary;
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
    [numberFormatter release];
    [numberFormatter2 release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    [[MBKUtil me].queryButton1 removeTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
}


-(IBAction) bt_TNCPressed{
    WebViewController *webViewController;
	webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
    [webViewController setUrlRequest:[HttpRequestUtils getPostRequest4AccProOffersTNC]]; //To be retested
	[self.navigationController pushViewController:webViewController animated:TRUE];
//	[webViewController.web_view loadRequest:[HttpRequestUtils getPostRequest4AccProOffersTNC]];
	[webViewController release];
}
-(IBAction) bt_NotesPressed{
    WebViewController *webViewController;
	webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
   [webViewController setUrlRequest:[HttpRequestUtils getPostRequest4AccProOffersNotes]]; //To be retested
	[self.navigationController pushViewController:webViewController animated:TRUE];
//	[webViewController.web_view loadRequest:[HttpRequestUtils getPostRequest4AccProOffersNotes]];
	[webViewController release];
}


-(IBAction)changeSliders:(UISlider *)slider{
    double salary = (double)floor(sl_salary.value);
    self.tfSalary.text  = [numberFormatter2 stringFromNumber:[NSNumber numberWithDouble:salary]];
    [self updateRewardBySalary];
}

-(IBAction)screenPressed{
	[self.tfSalary resignFirstResponder];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{ 
    //    NSLog(@"MH_WebViewController shouldStartLoadWithRequest:%@", request.mainDocumentURL.relativePath);
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/acc_pro/TNC_c.html"]||[request.mainDocumentURL.relativePath isEqualToString:@"/acc_pro/TNC_e.html"]) {    
        WebViewController *webViewController;
        webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        [webViewController setUrlRequest:[HttpRequestUtils getPostRequest4AccProOffersTNC]]; //To be retested
        [self.navigationController pushViewController:webViewController animated:TRUE];
//        [webViewController.web_view loadRequest:[HttpRequestUtils getPostRequest4AccProOffersTNC]];
        [webViewController release];
        return false;

    }else if ([request.mainDocumentURL.relativePath isEqualToString:@"/acc_pro/important_notes_c.html"]||[request.mainDocumentURL.relativePath isEqualToString:@"/acc_pro/important_notes_e.html"]){
        WebViewController *webViewController;
        webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        [webViewController setUrlRequest:[HttpRequestUtils getPostRequest4AccProOffersNotes]]; //To be retested
        [self.navigationController pushViewController:webViewController animated:TRUE];
//        [webViewController.web_view loadRequest:[HttpRequestUtils getPostRequest4AccProOffersNotes]];
        [webViewController release];
        return false;
    } 
    return true; 
}

@end
