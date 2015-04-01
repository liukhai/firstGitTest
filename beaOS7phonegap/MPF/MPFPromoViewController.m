#import "MPFPromoViewController.h"

@implementation MPFPromoViewController

@synthesize webView;
@synthesize latestpromoUrl;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil latestpromoUrl:(NSString*)url
{
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    latestpromoUrl = url;
    NSLog(@"initWithNibName:%@", url);
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[MyScreenUtil me] adjustmentcontrolY20:webView];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitle];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitleBackImg];
        [[MyScreenUtil me] adjustmentcontrolY20:callButton];
    }

    webView.frame = CGRectMake(0, webView.frame.origin.y, webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    CGRect mFrame;
    mFrame = callButton.frame;
    mFrame.origin.y = mFrame.origin.y + [[MyScreenUtil me] getScreenHeightAdjust];
    callButton.frame = mFrame;
    self.view.frame = CGRectMake(0, 0, 320, 475);
//    callButton.frame = CGRectMake(callButton.frame.origin.x, callButton.frame.origin.y +[[MyScreenUtil me] getScreenHeightAdjust],  callButton.frame.size.width, callButton.frame.size.height);

    NSURL *url= [NSURL URLWithString:self.latestpromoUrl];
    NSLog(@"MPFPromoViewController  : %@" , url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [self.webView loadRequest:request];
    [request release];
    
   	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"mpf.promotic.title",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;

    [callButton setTitle:NSLocalizedString(@"mpf.promotic.details", nil) forState:UIControlStateNormal];
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load MPFPromoViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded MPFPromoViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded MPFPromoViewController:%@", error );

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
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
    [self.webView stopLoading];
    
    NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"%@#detail", self.latestpromoUrl]];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [self.webView loadRequest:request];
    [request release];

}

- (void)dealloc {
    [lbTitleBackImg release];
    [super dealloc];
}

@end
