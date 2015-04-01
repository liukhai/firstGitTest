#import "AccProTNCViewController.h"

@implementation AccProTNCViewController
@synthesize webView,btnTag;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil buttonTag:(NSInteger) tag{
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    btnTag = tag;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 00, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    webView.frame = CGRectMake(0, 43, 320, 324+[[MyScreenUtil me] getScreenHeightAdjust]);

    NSString *path =nil;
    path = [[NSBundle mainBundle] pathForResource:@"MPF_en" ofType:@"htm"];
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
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}


@end
