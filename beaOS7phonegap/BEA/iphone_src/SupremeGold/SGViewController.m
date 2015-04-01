//
//  SGViewController.m
//  BEA
//
//  Created by Ledp944 on 14-9-3.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import "SGViewController.h"


@implementation SGViewController

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
    [[PageUtil pageUtil] changeImageForTheme:self.view];
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
	NSLog(@"taxloan viewdidload:%@", self);
	
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

/*
 -(void) navigationController:(UINavigationController *)pnavigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
 NSLog(@"TaxLoanViewController didShowViewController:%@--%@", pnavigationController, viewController);
 if ([viewController.navigationController.viewControllers count]==1) {
 [UIView beginAnimations:nil context:NULL];
 [UIView setAnimationDuration:0.5];
 //		banner.center = CGPointMake(160, 51);
 //		banner.center = CGPointMake(160, 51);
 [UIView commitAnimations];
 //		tabBar.selectedItem = nil;
 //		tabBar.hidden = YES;
 } else {
 [UIView beginAnimations:nil context:NULL];
 [UIView setAnimationDuration:0.5];
 //		banner.center = CGPointMake(160, -31);
 //		banner.center = CGPointMake(160, -31);
 [UIView commitAnimations];
 //		tabBar.hidden = NO;
 if ([[pnavigationController.viewControllers lastObject] class]==[TaxLoanOffersViewController class]) {
 tabBar.selectedItem = [tabBar.items objectAtIndex:0];
 return;
 }
 if ([[pnavigationController.viewControllers lastObject] class] == [TaxLoanApplicationViewController class]) {
 tabBar.selectedItem = [tabBar.items objectAtIndex:1];
 return;
 }
 }
 
 //	if ([viewController.navigationController.viewControllers count]==2) {
 //		((RootViewController*)[[CoreData sharedCoreData].taxLoan_view_controller.navigationController.viewControllers objectAtIndex:0]).navigationItem.backBarButtonItem = nil;
 //	}
 
 //	if ([viewController class]!=[RootViewController class]) {
 //		viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Home (Tax)", nil) style:UIBarButtonItemStyleBordered target:[CoreData sharedCoreData].taxLoan_view_controller action:@selector(goHome)] autorelease];
 //	}
 
 //	if ([viewController class]!=[RootViewController class]) {
 //		UIButton *home_button = [[UIButton alloc]
 //								 initWithFrame:CGRectMake(0, 0, 80, 30)];
 //		[home_button setBackgroundImage:[UIImage
 //										 imageNamed:@"merchant_button_2.png"] forState:UIControlStateNormal];
 //		home_button.titleLabel.font = [UIFont boldSystemFontOfSize:11];
 //		home_button.contentEdgeInsets = (UIEdgeInsets){0, 0, 6, 0};
 //		[home_button setTitle:NSLocalizedString(@"Home (Tax)",nil)
 //					 forState:UIControlStateNormal];
 //		home_button.backgroundColor = [UIColor clearColor];
 //		[home_button addTarget:self action:@selector(goHome)
 //			  forControlEvents:UIControlEventTouchUpInside];
 //		viewController.navigationItem.rightBarButtonItem =
 //		[[[UIBarButtonItem alloc] initWithCustomView:home_button]
 //		 autorelease];
 //		[home_button release];
 //	}
 
 [MBKUtil me].queryButtonWillShow= @"YES";
 
 }
 */
-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"TaxloanViewController: willShowViewController(navigationController:%@, viewController:%@)",pnavigationController,viewController);
    NSLog(@"TaxloanViewController: willShowViewController(navigationController:%@, viewController:%@)",
          pnavigationController.view,
          viewController.view);
    
    if ([viewController class]==[SGViewController class]) {
        //        [UIView beginAnimations:nil context:NULL];
        //        [UIView setAnimationDuration:0.5];
        /*     [CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
         [CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];              */
        
        //        [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
        //        CGRect frame = [CoreData sharedCoreData].main_view_controller.view.frame;
        //        frame.size.height = [[MyScreenUtil me] getScreenHeight];
        //        [CoreData sharedCoreData].main_view_controller.view.frame = frame;
        [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
        
        
        //        [UIView commitAnimations];
        NSLog(@"debug TaxloanViewController: willShowViewController:%f--%f",
              [CoreData sharedCoreData].main_view_controller.view.center.x,
              [CoreData sharedCoreData].main_view_controller.view.center.y
              );
        NSLog(@"debug main_view_controller.view.frame TaxloanViewController: willShowViewController:%f",
              [CoreData sharedCoreData].main_view_controller.view.frame.origin.y
              );
        /*   [[MyScreenUtil me] adjustView2Top0:[CoreData sharedCoreData].main_view_controller.view];          */
        //        [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    }
}

/*
 -(BOOL) navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
 NSLog(@"Pop");
 if (should_pop) {
 NSLog(@"Should pop:%d",should_pop);
 [navigationController popViewControllerAnimated:TRUE];
 }
 should_pop = !should_pop;
 NSLog(@"Should pop:%d",should_pop);
 return !should_pop;
 }
 */
///////////////////
//UITabbarDelegate
///////////////////
//-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//	switch (item.tag) {
//		case 0: // Offers TabBar
//            [self forwardNextView:NSClassFromString(@"ConsumerLoanListViewController") viewName:@"ConsumerLoanListViewController"];
//			break;
//		case 1: // Application TabBar
//            [self forwardNextView:NSClassFromString(@"ConsumerLoanApplicationViewController") viewName:@"ConsumerLoanApplicationViewController"];
//			break;
//		case 2:  // Nearby TabBar
//            [CoreData sharedCoreData].lastScreen = @"ConsumerLoanViewController";
//            [UIView beginAnimations:nil context:NULL];
//			[UIView setAnimationDuration:0.5];
//			[[CoreData sharedCoreData].root_view_controller setContent:0];
//			[CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//			[CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//			[[CoreData sharedCoreData].atmlocation_view_controller welcome];
//			[UIView commitAnimations];
//			break;
//		case 3:  // Enquiries TabBar
//            [self forwardNextView:NSClassFromString(@"ConsumerLoanEnquiryViewController") viewName:@"ConsumerLoanEnquiryViewController"];
//			break;
//	}
//}

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
	[[CoreData sharedCoreData].sg_view_controller.navigationController popToRootViewControllerAnimated:NO];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    NSLog(@"SGViewController goMain:%@",[CoreData sharedCoreData].bea_view_controller.vc4process);
}

-(void)goMainFaster
{
    NSLog(@"debug goMainFaster:%@", self);
	[[CoreData sharedCoreData].sg_view_controller.navigationController popToRootViewControllerAnimated:NO];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    //    NSLog(@"TaxLoanViewController goMainFaster:%@",[CoreData sharedCoreData].bea_view_controller.vc4process);
}

//-(void) selectTabBarMatchedCurrentView{
//    if ([[navigationController.viewControllers lastObject] class]==[TaxLoanOffersViewController class]) {
//        tabBar.selectedItem = [tabBar.items objectAtIndex:0];
//        return;
//    }
//    if ([[navigationController.viewControllers lastObject] class] == [TaxLoanApplicationViewController class]) {
//        tabBar.selectedItem = [tabBar.items objectAtIndex:1];
//        return;
//    }
//
//}

//-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName
//{
//    NSLog(@"TaxLoanViewController: forwardNextView(viewController:%@)",viewController);
//    if ([[navigationController.viewControllers lastObject] class] == viewController) {
//        return;
//    }
//    [self.navigationController popToRootViewControllerAnimated:FALSE];
//    //    UIViewController *current_view_controller = [viewController new];
//    UIViewController *current_view_controller = [[viewController alloc] initWithNibName:viewName bundle:nil];
//
//    [self.navigationController pushViewController:current_view_controller animated:TRUE];
//    [current_view_controller release];
//}

-(void) welcome
{
    //NSLog(@"debug 20140128 TaxLoanViewController welcome:%@", self.view);
    
    //    [self forwardNextView:NSClassFromString(@"ConsumerLoanListViewController") viewName:@"ConsumerLoanListViewController"];
    menuVC = [[SupremeGoldMenuViewController alloc] initWithNibName:@"SupremeGoldMenuViewController" bundle:nil nav:self.navigationController];
    //    [self.navigationController popToRootViewControllerAnimated:FALSE];
    [self.navigationController pushViewController:menuVC animated:NO];
    
    [menuVC welcome];
}

@end