#import "MPFNewsViewController.h"
#import "WebViewController.h"

@implementation MPFNewsViewController

@synthesize labTitle,webView;
@synthesize url;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSURL*)aurl
{
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.url = aurl;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.frame = CGRectMake(0, 20, 320, 411+[[MyScreenUtil me] getScreenHeightAdjust]);
    webView.frame = CGRectMake(0, webView.frame.origin.y, webView.frame.size.width, webView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[MyScreenUtil me] adjustmentcontrolY20:labTitle];
        [[MyScreenUtil me] adjustmentcontrolY20:webView];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitleBackImg];
    }
    
    self.labTitle.text = NSLocalizedString(@"mpf.news.title", nil);
    if ([MBKUtil wifiNetWorkAvailable]) {
        [self sendRequest];
        NSLog(@"MPFNewsViewController: wifi network is ok.");
    }else{
        [[MPFUtil me] alertAndBackToMain:self];
        return;
    }
    level_count = 0;
    
    self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back",nil)
                                      style: UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [lbTitleBackImg release];
    lbTitleBackImg = nil;
    [super viewDidUnload];
    //    [self.webView release];
}

- (void)dealloc {
    
    [lbTitleBackImg release];
    [super dealloc];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[CoreData sharedCoreData].mask hiddenMask];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"MPFNewsViewController didFailLoadWithError:%@", error);
    [[CoreData sharedCoreData].mask hiddenMask];
    
}

-(void) sendRequest{
    if (self.url){
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }else{
        [self.webView loadRequest:[HttpRequestUtils getPostRequest4MPFNews]];
        NSLog(@"%@",url);
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (level_count==0){
        level_count = 1;
        return YES;
    }else{
        [[MPFUtil me].MPF_view_controller openNewsViewController:[request mainDocumentURL]];
        return NO;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"MPFNewsViewController webViewDidStartLoad");
    [[CoreData sharedCoreData].mask showMask];
}

@end
