//  Created by yaojzy on 21/6/12.

#import "CyberFundSearchWebViewController.h"
#import "CyWebViewController.h"
@interface CyberFundSearchWebViewController ()

@end

@implementation CyberFundSearchWebViewController

@synthesize webView;
@synthesize url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString*) a_url
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        url = [a_url mutableCopy];
        NSLog(@"CyberFundSearchWebViewController initWithNibName:url %@",url  );
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 40);
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width,[[MyScreenUtil me] getScreenHeight_IOS7_20]);
    NSLog(@"debug CyberFundSearchWebViewController viewDidLoad h1:%f",webView.frame.size.height);
    webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y-20, webView.frame.size.width, webView.frame.size.height + 64);
    }
    // Do any additional setup after loading the view from its nib.
    NSLog(@"CyberFundSearchWebViewController :url %@",url );
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: url]];
    
    [request setHTTPMethod:@"POST"];
//    webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, 2000);
    NSLog(@"debug CyberFundSearchWebViewController viewDidLoad h1:%f",webView.frame.size.height);
    [webView loadRequest:request];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"didFailLoadWithError:%@", error );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog( @"shouldStartLoadWithRequest:%@", request.mainDocumentURL.absoluteString);
    NSRange foundRange;
    foundRange = [request.mainDocumentURL.absoluteString rangeOfString:@"myapp:viewpdf:"];
    if (foundRange.location != NSNotFound) {
       
        NSString *target = [request.mainDocumentURL.absoluteString substringFromIndex:foundRange.location+foundRange.length];
        
        NSURL* target_url;
        foundRange = [target rangeOfString:@"http://"];
        if (foundRange.location == NSNotFound) {
            target_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",target]];
        }else{
            target_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",target]];
        }
        NSLog( @"openInApp 1:%@", target);
        NSLog( @"openInApp 2:%@", target_url);

//        [CyberFundSearchUtil me].CyberFundSearch_view_controller.showBack = @"YES";
        CyWebViewController *webViewController;
        webViewController = [CyWebViewController alloc];
        [webViewController setUrlRequest:[NSURLRequest requestWithURL:target_url]];
        if ([self.parentViewController respondsToSelector:@selector(changeBanner:)]) {
            [self.parentViewController performSelector:@selector(changeBanner:) withObject:webViewController];

        }
//         self.navigationController.navigationBar.tintColor=[UIColor redColor];
//        [self.navigationController pushViewController:webViewController animated:NO];
        return false;
    }
    return YES;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [[CyberFundSearchUtil me].CyberFundSearch_view_controller goHome];
    
}

@end
