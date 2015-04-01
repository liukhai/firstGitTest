//  Amended by yaojzy on 201309.

#import "StockGameCentreViewController.h"
#import "StockGameCentreUtil.h"

@implementation StockGameCentreViewController

@synthesize webView;
@synthesize lbTitle;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
 
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 416+[[MyScreenUtil me] getScreenHeightAdjust]);
//    self.view.frame = CGRectMake(0, 64, 320, 416+[[MyScreenUtil me] getScreenHeightAdjust]);
//    self.webView.frame = CGRectMake(0, 42, 320, 374+[[MyScreenUtil me] getScreenHeightAdjust]);
    [[StockGameCentreUtil me] requestAPIDatas];
    NSURL *url= [NSURL URLWithString:[[StockGameCentreUtil me] getGameURL]];
    NSLog(@"debug open game:[%@]", [[StockGameCentreUtil me] getGameURL]);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
   	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"StockGameCentre.title",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [[MBKUtil me].queryButton1 setHidden:YES];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    if (screenHeight == 480 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 20)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        
        self.webView.frame = CGRectMake(0, 53, 320, 374+[[MyScreenUtil me] getScreenHeightAdjust]+20);
    }else {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 20)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        
        self.webView.frame = CGRectMake(0, 53, 320, 374+[[MyScreenUtil me] getScreenHeightAdjust]-70);
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        self.webView.frame = CGRectMake(0, 73, 320, 374+[[MyScreenUtil me] getScreenHeightAdjust]);
    }
    
    [self setMenuBar1];

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

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load StockGameCentreViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded StockGameCentreViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	//[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded StockGameCentreViewController:%@", error );
    if ([error code] != NSURLErrorCancelled) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];        
    }	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self goHome];
}

- (void)goHome{
    [[CoreData sharedCoreData].bea_view_controller.navigationController popViewControllerAnimated:YES];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"host:%@", request.mainDocumentURL.host );
//	NSDateFormatter *df = [[NSDateFormatter alloc] init];
//	[df setDateFormat:@"yyyyMMdd"];	NSDate *now_date = [NSDate date];
	
//	NSDate *start_date = [df dateFromString:@"20121224"];
//    if ((NSOrderedDescending == [now_date compare:start_date])){
    
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/drink_fun/index.php"]) {
//    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/quiz_fun/index.php"]) {
        [[UIApplication sharedApplication] openURL:request.mainDocumentURL];
        return NO;
    }else{
        return YES;
    }
//    }
//    return YES;
}


@end
