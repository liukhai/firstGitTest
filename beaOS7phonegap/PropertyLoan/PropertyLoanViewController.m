//
//  PropertyLoanApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 28/02/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "PropertyLoanViewController.h"


@implementation PropertyLoanViewController

@synthesize tabBar,menuVC;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
//		[CachedImageView clearAllCache];
        [SecuredCachedImageView clearAllCache];
        should_pop = TRUE;
    }
    return self;
}


//-(void)setTexts {
//    
//    
//	NSArray *tab_list = [NSLocalizedString(@"PropertyLoanTab",nil) componentsSeparatedByString:@","];
//	if ([MBKUtil isLangOfChi]) {
//		banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PropertyLoan_banner_zh.png"]];
//	}else {
//		banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PropertyLoan_banner_en.png"]];
//	}
//	for (int i=0; i<4; i++) {
//		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
//	}
//}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [CoreData sharedCoreData].main_view_controller.delegate = nil;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openProperty = YES;
//    backBtn.accessibilityLabel = NSLocalizedString(@"Back_accessibility",nil);
    
//    if ([[CoreData sharedCoreData].lang hasPrefix:@"e"]) {
//        NSLog(@"e");
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//            _backgroundView.frame = CGRectMake(0, 44, 320, 475);
//            _navigationImage.image = [UIImage imageNamed:@"navigation.png"];
//        } else {
//            _navigationImage.image = [UIImage imageNamed:@"navigation6.1.png"];
//        }
//        _backgroundView.clipsToBounds = YES;
//        [self.view addSubview:_backgroundView];
//    }
//    if ([[CoreData sharedCoreData].lang hasPrefix:@"zh_TW"]) {
//        NSLog(@"中文");
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//            _backgroundView.frame = CGRectMake(0, 44, 320, 475);
//            _navigationImage.image = [UIImage imageNamed:@"navigationCN.png"];
//        } else {
//            _navigationImage.image = [UIImage imageNamed:@"navigationCN6.1.png"];
//        }
//        _backgroundView.clipsToBounds = YES;
//        [self.view addSubview:_backgroundView];
//    }
//    [[MyScreenUtil me] adjustView2Screen:self.view];

//	tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-69, 320, 49);
//    NSLog(@"L209_Insurance Loan  PropertyLoanViewController.m -- tabber掉下去20");
//	tabBar.delegate = self;
//	NSArray *tab_list = [NSLocalizedString(@"PropertyLoanTab",nil) componentsSeparatedByString:@","];
//	if ([MBKUtil isLangOfChi]) {
//		banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PropertyLoan_banner_zh.png"]];
//	}else {
//		banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PropertyLoan_banner_en.png"]];
//	}
//	banner.frame = CGRectMake(0, 20, 320, 63);
    
//    [[MyScreenUtil me] adjustNavView:navigationController.view];
//	[self.view addSubview:navigationController.view];
//	for (int i=0; i<4; i++) {
//		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
//	}
//	[self.view addSubview:tabBar];
//	[self.view addSubview:banner];
//	tabBar.selectedItem = [tabBar.items objectAtIndex:2];
//    tabIndex = 2;
//    [self forwardNextView:NSClassFromString(@"PropertyLoanCalculatorViewController") viewName:@"PropertyLoanCalculatorViewController"];
//	NSLog(@"PropertyLoan viewdidload:%@", self);
	
	self.navigationController.delegate = self;
//    if (![[MyScreenUtil me] adjustNavBackground:self.navigationController])
//        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguage" object:nil];
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
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


#pragma mark UINavigationControllerDelegate
//-(void) navigationController:(UINavigationController *)pnavigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//	NSLog(@"PropertyLoanViewController didShowViewController:%@--%@--%d", pnavigationController, viewController, [viewController.navigationController.viewControllers count]);
//	if ([viewController.navigationController.viewControllers count]==1) {
////		[UIView beginAnimations:nil context:NULL];
////		[UIView setAnimationDuration:0.5];
//		banner.center = CGPointMake(160, 51);
////		[UIView commitAnimations];
//		tabBar.selectedItem = nil;
//		tabBar.hidden = YES;
//        return;
//	} else {
////		[UIView beginAnimations:nil context:NULL];
////		[UIView setAnimationDuration:0.5];
//		banner.center = CGPointMake(160, -31);
////		[UIView commitAnimations];
//		tabBar.hidden = NO;
//		if ([[pnavigationController.viewControllers lastObject] class]==[PropertyLoanCalculatorViewController class]) {
//			tabBar.selectedItem = [tabBar.items objectAtIndex:2];
//			return;
//		}
//        if ([[pnavigationController.viewControllers lastObject] class]==[PropertyLoanEnquiryViewController class]) {
//			tabBar.selectedItem = [tabBar.items objectAtIndex:3];
//			return;
//		}
//
//	}
//	
//}

/*
 * Implement method of UINavigationControllerDelegate Protocal 
 */
- (void)navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//	NSLog(@"PropertyLoanViewController willShowViewController:%@--%@--%d", pnavigationController, viewController, [viewController.navigationController.viewControllers count]);

//	if ([viewController.navigationController.viewControllers count]==1) {
//		[self goMain];
//	}
    if ([viewController class]==[PropertyLoanViewController class]) {
        [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
    }
//    NSLog(@"%d",[viewController.navigationController.viewControllers count]);
//    if ([viewController class]==[PropertyLoanCalculatorViewController class]) {
//        [MBKUtil me].queryButtonWillShow=@"YES";
//    }else {
//        [MBKUtil me].queryButtonWillShow=@"NO";
//        if ([viewController.navigationController.viewControllers count]==2) {
//        [[CoreData sharedCoreData].taxLoan_view_controller.navigationController popViewControllerAnimated:NO];
//        }
//        
//        if ([viewController.navigationController.viewControllers count]==4 && viewController !=   [CoreData sharedCoreData]._PropertyLoanViewController) {
//            [[CoreData sharedCoreData].taxLoan_view_controller.navigationController popToRootViewControllerAnimated:NO];
//        }
    
}

#pragma mark -

-(void)goMain{
	NSLog(@"PropertyLoanViewController goMain");
	
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
//	[CoreData sharedCoreData]._PropertyLoanViewController.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[CoreData sharedCoreData]._PropertyLoanViewController.navigationController popToRootViewControllerAnimated:NO];
    //    [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
//    NSLog(@"Navigation Revamp - Property Loan - PropertyLoanViewController.m");
//	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//	[UIView commitAnimations];
}

-(void)goMainFaster
{
    NSLog(@"debug goMainFaster:%@", self);
    [[CoreData sharedCoreData]._PropertyLoanViewController.navigationController popToRootViewControllerAnimated:NO];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    //    NSLog(@"TaxLoanViewController goMainFaster:%@",[CoreData sharedCoreData].bea_view_controller.vc4process);
}
/*
 * Implements method of UITabBarDelegate Protocal
 */
//-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//	
//	UIViewController *current_view_controller;
//	switch (item.tag) {
//		case 0:
//			[UIView beginAnimations:nil context:NULL];
//			[UIView setAnimationDuration:0.5];
//			[[CoreData sharedCoreData].root_view_controller setContent:0];
//			[CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//			[CoreData sharedCoreData]._PropertyLoanViewController.view.center = [[MyScreenUtil me] getmainScreenLeft_20:self];
//			 [[CoreData sharedCoreData].atmlocation_view_controller welcomeToindex:3];
//            [CoreData sharedCoreData].bea_view_controller.vc4process = [CoreData sharedCoreData].atmlocation_view_controller;
//			[UIView commitAnimations];
//            ATMLocationViewController *atm_location = [[ATMLocationViewController alloc] initWithNibName:@"ATMLocationView" bundle:nil];
//            atm_location.menuIndex = 3;
//            [self.navigationController pushViewController:atm_location animated:NO];
//			break;
//		case 1:
//            tabIndex = 1;
//			[[PropertyLoanUtil new] callToApply];
//			break;
//		case 2:
//            tabIndex = 2;
//			if ([[self.navigationController.viewControllers lastObject] class]==[PropertyLoanCalculatorViewController class]) {
//				return;
//			}
//            [self forwardNextView:NSClassFromString(@"PropertyLoanCalculatorViewController") viewName:@"PropertyLoanCalculatorViewController"];
//			[self.navigationController popToRootViewControllerAnimated:FALSE];
//			current_view_controller = [[PropertyLoanCalculatorViewController alloc] initWithNibName:@"PropertyLoanCalculatorViewController" bundle:nil];
//			[self.navigationController pushViewController:current_view_controller animated:NO];
//			[current_view_controller release];
//			break;
//		case 3:
//            tabIndex = 3;
//			if ([[self.navigationController.viewControllers lastObject] class]==[PropertyLoanEnquiryViewController class]) {
//				return;
//			}
//            [self forwardNextView:NSClassFromString(@"PropertyLoanEnquiryViewController") viewName:@"PropertyLoanEnquiryViewController"];
//			[self.navigationController popToRootViewControllerAnimated:FALSE];
//			current_view_controller = [[PropertyLoanEnquiryViewController alloc] initWithNibName:@"PropertyLoanEnquiryViewController" bundle:nil];
//			[self.navigationController pushViewController:current_view_controller animated:NO];
//			[current_view_controller release];
//			break;
//	}
//}

//-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName {
//    NSLog(@"PropertyLoanViewController: forwardNextView(viewController:%@)",viewController);
//    if ([[self.navigationController.viewControllers lastObject] class] == viewController) {
//        return;
//    }
//    UIViewController *current_view_controller = [[viewController alloc] initWithNibName:viewName bundle:nil];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        current_view_controller.view.frame = CGRectMake(0, -20, 320, 475);
//    }
//    for (UIView *subView in _backgroundView.subviews) {
//        [subView removeFromSuperview];
//    }
//    for (UIViewController *childView in self.childViewControllers) {
//        [childView removeFromParentViewController];
//    }
//    [_backgroundView addSubview:current_view_controller.view];
//    [self addChildViewController:current_view_controller];
//    
//    NSLog(@"current_view_controller : %@",current_view_controller);
//    [current_view_controller release];
//}

//-(void) selectTabBarMatchedCurrentView{
//    if ([[self.navigationController.viewControllers lastObject] class] == [PropertyLoanCalculatorViewController class] ) {
//        tabBar.selectedItem = [tabBar.items objectAtIndex:2];
//    }else if([[self.navigationController.viewControllers lastObject] class]== [PropertyLoanEnquiryViewController class]){
//        tabBar.selectedItem = [tabBar.items objectAtIndex:3];
//    }
//}

//////////////////////
//UIAlertViewDelegate
//////////////////////
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==0) {
        [[CoreData sharedCoreData].email createComposerWithSubject:NSLocalizedString(@"Check out",nil) Message:NSLocalizedString(@"Main share app",nil)];		
	}
}

-(void)welcome{
	NSLog(@"PropertyLoanViewController welcome");
//	UIViewController *current_view_controller;
//	[self.navigationController popToRootViewControllerAnimated:FALSE];
//	current_view_controller = [[PropertyLoanCalculatorViewController alloc] initWithNibName:@"PropertyLoanCalculatorViewController" bundle:nil];
//	[self.navigationController pushViewController:current_view_controller animated:NO];
//	[current_view_controller release];
//    self.tabBar.selectedItem=(UITabBarItem *)[tabBar.items objectAtIndex:2];
    menuVC = [[PropertyLoanMenuViewController alloc] initWithNibName:@"PropertyLoanMenuViewController" bundle:nil nav:self.navigationController];
    //    [self.navigationController popToRootViewControllerAnimated:FALSE];
    [self.navigationController pushViewController:menuVC animated:NO];
    
    [menuVC welcome];
}

//- (void)changeLanguage:(NSNotification *)notification {
//    [self setTexts];
//}
//
//- (IBAction)backBtnClick:(id)sender {
//    if ([[self.childViewControllers lastObject] class] == [PropertyLoanCalculatorViewController class]) {
//        [self.childViewControllers.lastObject removeFromParentViewController];
//        [_backgroundView.subviews.lastObject removeFromSuperview];
//        [self.navigationController popViewControllerAnimated:NO];
//    }
//    if ([[self.childViewControllers lastObject] class] == [PropertyLoanEnquiryViewController class]) {
//        [self.childViewControllers.lastObject removeFromParentViewController];
//        [_backgroundView.subviews.lastObject removeFromSuperview];
//        [self.navigationController popViewControllerAnimated:NO];
//        
//    }
//}


@end
