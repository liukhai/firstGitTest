#import "MPFPromotionViewController.h"


@implementation MPFPromotionViewController


@synthesize bt_detail_mastertrustscheme, bt_detail_contribitionaccount,bt_mastertrustscheme,bt_contribitionaccount,bt_promotiondetails;
@synthesize webView;
@synthesize promotion_type;

- (void) loadWebView:(NSString*) type
              anchor:(NSString*) anchor{
    if ([MBKUtil wifiNetWorkAvailable]) {
        NSLog(@"MPFPromotionViewController: loadWebView.");
        
        //request web page directly
        [self.webView loadRequest:[HttpRequestUtils getPostRequest4MPFPromotion:type anchor:anchor]];
        
        NSLog(@"MPFPromotionViewController: wifi network is ok.");
    }else{
        [[MPFUtil me] alertAndBackToMain:self]; 
        return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = UITextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = UILineBreakModeWordWrap;
	
    [self sendRequest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}

-(void) sendRequest{
    [self bt_schemePressed:bt_mastertrustscheme];  
}

-(IBAction) bt_schemePressed:(UIButton*) button{
    
    if (button.tag==0){
        
        bt_mastertrustscheme.selected=YES;
        bt_contribitionaccount.selected=NO;
        
        [bt_mastertrustscheme setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [bt_contribitionaccount setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        
        promotion_type=@"MTS";
        
    }else if (button.tag==1){
        
        bt_mastertrustscheme.selected=NO;
        bt_contribitionaccount.selected=YES;
        
        [bt_mastertrustscheme setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [bt_contribitionaccount setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        promotion_type=@"SVC";
    }
    
    [self loadWebView:promotion_type anchor:nil];
    
}

-(IBAction) bt_promotiondetailsPressed{
    [self loadWebView:promotion_type anchor:@"detail"];
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	[[CoreData sharedCoreData].mask showMask];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[CoreData sharedCoreData].mask hiddenMask];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"MPFPromotionViewController didFailLoadWithError:%@", error);
    [[CoreData sharedCoreData].mask hiddenMask];

    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
    [alert_view show];
    [alert_view release];
    
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
    NSLog(@"MPFPromotionViewController.requestFinished:%@", reponsedString);
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
    NSLog(@"MPFPromotionViewController.requestFailed:%@", reponsedString);
}

@end
