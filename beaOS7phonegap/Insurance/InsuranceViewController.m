//
//  Created by NEO on 03/01/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "InsuranceViewController.h"



@implementation InsuranceViewController

@synthesize tabBar, menuVC;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        [SecuredCachedImageView clearAllCache];
        should_pop = TRUE;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [[MyScreenUtil me] adjustView2Screen:self.view];
    
    //	email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
    //	email.view.center = CGPointMake(160, 720);
    //	[CoreData sharedCoreData].email = email;
    
    //	tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-49, 320, 49);
    //	tabBar.delegate = self;
    //	NSArray *tab_list = [NSLocalizedString(@"TaxLoanTab",nil) componentsSeparatedByString:@","];
    
    //    banner = [[UIWebView alloc] initWithFrame: CGRectMake(0,20,320,63)];
    //    banner.contentMode = UIViewContentModeScaleAspectFit;
    //    banner.backgroundColor = [UIColor whiteColor];
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"CLbanner_zh" ofType:@"htm"];
    //	if (![MBKUtil isLangOfChi]) {
    //		path = [[NSBundle mainBundle] pathForResource:@"CLbanner_en" ofType:@"htm"];
    //	}
    //	NSURLRequest *req = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:path]];
    //	[banner loadRequest:req];
    
    //    [banner loadRequest:[HttpRequestUtils getPostRequest_loanBanner]];
    //    [self.view addSubview:banner];
    
    //Add ImageView using UIImageView initWithImage
    /*    if ([MBKUtil isLangOfChi]) {
     banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ploan_banner_zh.png"]];
     }else {
     banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ploan_banner_en.png"]];
     }
     banner.frame = CGRectMake(0, 20, 320, 63);
     */
    
    //Add ImageView using UIImageView initWithFrame
    
    //    [[MyScreenUtil me] adjustNavView:navigationController.view];
    //	[self.view addSubview:navigationController.view];
    //	for (int i=0; i<4; i++) {
    //		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
    //	}
    //	[self.view addSubview:tabBar];
    //	[self.view addSubview:banner];
    NSLog(@"Insurance viewdidload:%@", self);
    
    self.navigationController.delegate = self;
    //    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
    //	[navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[CoreData sharedCoreData].mask hiddenMask];
    //	NSLog(@"fail loaded TaxLoanViewController.banner" );
    //    [banner removeFromSuperview];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"InsuranceViewController: willShowViewController(navigationController:%@, viewController:%@)",pnavigationController,viewController);
    NSLog(@"InsuranceViewController: willShowViewController(navigationController:%@, viewController:%@)",
          pnavigationController.view,
          viewController.view);
    
    if ([viewController class]==[InsuranceViewController class]) {
        
        [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
        
    
        NSLog(@"debug InsuranceViewController: willShowViewController:%f--%f",
              [CoreData sharedCoreData].main_view_controller.view.center.x,
              [CoreData sharedCoreData].main_view_controller.view.center.y
              );
        NSLog(@"debug main_view_controller.view.frame InsuranceViewController: willShowViewController:%f",
              [CoreData sharedCoreData].main_view_controller.view.frame.origin.y
              );
        /*   [[MyScreenUtil me] adjustView2Top0:[CoreData sharedCoreData].main_view_controller.view];          */
        //        [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    }
}


//////////////////////
//UIAlertViewDelegate
//////////////////////
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [[CoreData sharedCoreData].email createComposerWithSubject:NSLocalizedString(@"Check out",nil) Message:NSLocalizedString(@"Main share app",nil)];
    }
}

-(void)goMain
{
    [[InsuranceUtil me].Insurance_view_controller.navigationController popToRootViewControllerAnimated:NO];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    NSLog(@"InsuranceViewController goMain:%@",[CoreData sharedCoreData].bea_view_controller.vc4process);
}

-(void)goMainFaster
{
    NSLog(@"debug goMainFaster:%@", self);
    [[InsuranceUtil me].Insurance_view_controller.navigationController popToRootViewControllerAnimated:NO];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    //    NSLog(@"TaxLoanViewController goMainFaster:%@",[CoreData sharedCoreData].bea_view_controller.vc4process);
}


-(void) welcome
{
    //NSLog(@"debug 20140128 TaxLoanViewController welcome:%@", self.view);
    
    //    [self forwardNextView:NSClassFromString(@"ConsumerLoanListViewController") viewName:@"ConsumerLoanListViewController"];
    menuVC = [[InsuranceMenuViewController alloc] initWithNibName:@"InsuranceMenuViewController" bundle:nil nav:self.navigationController];
    //    [self.navigationController popToRootViewControllerAnimated:FALSE];
    [self.navigationController pushViewController:menuVC animated:NO];
    
    [menuVC welcome];
}

@end
