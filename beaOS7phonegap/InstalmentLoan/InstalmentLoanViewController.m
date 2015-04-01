//
//  TaxLoanApplicationViewController.h
//  BEA
//
//  Created by NEO on 01/12/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "InstalmentLoanViewController.h"
#import "InstalmentLoanUtil.h"
#import "InstalmentLoanOffersViewController.h"


@implementation InstalmentLoanViewController

@synthesize navigationController, tabBar,frompage;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[SecuredCachedImageView clearAllCache];
		should_pop = TRUE;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [CoreData sharedCoreData]._InstalmentLoanViewController.frompage=@"";

    [[MyScreenUtil me] adjustView2Screen:self.view];

	tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-49, 320, 49);
	tabBar.delegate = self;
	NSArray *tab_list = [NSLocalizedString(@"instalmentLoan.tab",nil) componentsSeparatedByString:@","];
    
    banner = [[UIWebView alloc] initWithFrame: CGRectMake(0,20,320,63)];
    [banner loadRequest:[HttpRequestUtils getPostRequest_loanBanner]];
    
    [[MyScreenUtil me] adjustNavView:navigationController.view];
	[self.view addSubview:navigationController.view];
	for (int i=0; i<4; i++) {
		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
	}
	[self.view addSubview:tabBar];
    //	[self.view addSubview:banner];	
	NSLog(@"taxloan viewdidload:%@", self);
	
	navigationController.delegate = self;
    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
	[navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded InstalmentLoanViewController.banner" );
    [banner removeFromSuperview];
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

-(void) navigationController:(UINavigationController *)pnavigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"InstalmentLoanViewController didShowViewController:%@--%@", pnavigationController, viewController);
	if ([viewController.navigationController.viewControllers count]==1) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
        //		banner.center = CGPointMake(160, 51);
		banner.center = CGPointMake(160, 51);
		[UIView commitAnimations];
		tabBar.selectedItem = nil;
		tabBar.hidden = YES;
	} 
    else {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
        //		banner.center = CGPointMake(160, -31);
		banner.center = CGPointMake(160, -31);
		[UIView commitAnimations];
		tabBar.hidden = NO;
        if ([[pnavigationController.viewControllers lastObject] class]==[InstalmentLoanOffersViewController class]) {
			tabBar.selectedItem = [tabBar.items objectAtIndex:0];
			return;
		}
//        if ([[pnavigationController.viewControllers lastObject] class] == [TaxLoanApplicationViewController class]) {
//            tabBar.selectedItem = [tabBar.items objectAtIndex:1];
//            return;
//        }
	}
    [MBKUtil me].queryButtonWillShow= @"YES";
    
}
-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"InstalmentLoanViewController: willShowViewController(navigationController:%@, viewController:%@)",pnavigationController,viewController);
    
    if ([viewController class]==[RootViewController class]) {
        if ([[CoreData sharedCoreData]._InstalmentLoanViewController.frompage isEqualToString:@"latestpromot"]){
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [CoreData sharedCoreData]._InstalmentLoanViewController.view.center = [[MyScreenUtil me] getmainScreenRight:self];
            [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            [UIView commitAnimations];
            [CoreData sharedCoreData]._InstalmentLoanViewController.frompage=@"";
        }else{
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [CoreData sharedCoreData]._InstalmentLoanViewController.view.center = [[MyScreenUtil me] getmainScreenRight:self];
            [CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            [UIView commitAnimations];
        }
    }
}

///////////////////
//UITabbarDelegate
///////////////////
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	switch (item.tag) {
		case 0: // Offers TabBar
            [self forwardNextView:NSClassFromString(@"InstalmentLoanOffersViewController") viewName:@"InstalmentLoanOffersViewController"];    
			break;
		case 1: // Application TabBar
            [self forwardNextView:NSClassFromString(@"ConsumerLoanApplicationViewController") viewName:@"ConsumerLoanApplicationViewController"];    
			break;
		case 2:  // Nearby TabBar
            [self forwardNextView:NSClassFromString(@"InstalmentLoanCalculatorViewController") viewName:@"InstalmentLoanCalculatorViewController"];    
			break;
		case 3:  // Enquiries TabBar
            [self forwardNextView:NSClassFromString(@"ConsumerLoanEnquiryViewController") viewName:@"ConsumerLoanEnquiryViewController"];
			break;
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

-(void)goHome{
	[[CoreData sharedCoreData]._InstalmentLoanViewController.navigationController popToRootViewControllerAnimated:YES];
}

-(void) selectTabBarMatchedCurrentView{
    if ([[navigationController.viewControllers lastObject] class]==[TaxLoanOffersViewController class]) {
        tabBar.selectedItem = [tabBar.items objectAtIndex:0];
        return;
    }
    if ([[navigationController.viewControllers lastObject] class] == [TaxLoanApplicationViewController class]) {
        tabBar.selectedItem = [tabBar.items objectAtIndex:1];
        return;
    }
    
}

-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName
{
    NSLog(@"InstalmentLoanViewController: forwardNextView(viewController:%@)",viewController);
    if ([[navigationController.viewControllers lastObject] class] == viewController) {
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:FALSE];
    //    UIViewController *current_view_controller = [viewController new];
    UIViewController *current_view_controller = [[viewController alloc] initWithNibName:viewName bundle:nil];
    
    [self.navigationController pushViewController:current_view_controller animated:TRUE];
    [current_view_controller release];
}

-(void) welcome
{
    NSLog(@"InstalmentLoanViewController: welcome");
    [self forwardNextView:NSClassFromString(@"InstalmentLoanOffersViewController") viewName:@"InstalmentLoanOffersViewController"];    
}

@end
