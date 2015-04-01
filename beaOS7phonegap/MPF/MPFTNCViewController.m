#import "MPFTNCViewController.h"

@implementation MPFTNCViewController
@synthesize webView,btnTag;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil buttonTag:(NSInteger) tag{
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    btnTag = tag;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitle];
        [[MyScreenUtil me] adjustmentcontrolY20:webView];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitleBackImg];
    }
    
    NSString *path =nil;
	if(btnTag == 1){
        path = [[NSBundle mainBundle] pathForResource:@"TNC_zh" ofType:@"htm"];
        if (![MBKUtil isLangOfChi]) {
            path = [[NSBundle mainBundle] pathForResource:@"TNC_en" ofType:@"htm"];
        }
    }
    if(btnTag == 2){
        path = [[NSBundle mainBundle] pathForResource:@"TNC_SVC_zh" ofType:@"htm"];
        if (![MBKUtil isLangOfChi]) {
            path = [[NSBundle mainBundle] pathForResource:@"TNC_SVC_en" ofType:@"htm"];
        }
    }
	NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]]; 
	[webView loadRequest:req];
	
	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"Terms and Conditions",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	
}


- (void)didReceiveMemoryWarning {
  
    [super didReceiveMemoryWarning];
  }

- (void)viewDidUnload {
    [lbTitleBackImg release];
    lbTitleBackImg = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    [lbTitleBackImg release];
    [super dealloc];
}


@end
