//
//  LTApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/15/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "LTViewController.h"


@implementation LTViewController

@synthesize navigationController, tabBar, frompage;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[CachedImageView clearAllCache];
		should_pop = TRUE;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    [[MyScreenUtil me] adjustView2Screen:self.view];
    
//	email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
//	email.view.center = CGPointMake(160, 720);
//	[CoreData sharedCoreData].email = email;
    [CoreData sharedCoreData]._LTViewController.frompage=@"";
    
    navigationController.delegate = self;
    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
	[navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
    
    [[MyScreenUtil me] adjustNavView:navigationController.view];
    [self.view addSubview:navigationController.view];
	
	tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-49, 320, 49);
	tabBar.delegate = self;
	NSArray *tab_list = [NSLocalizedString(@"LTTaxLoanTab",nil) componentsSeparatedByString:@","];
	
	for (int i=0; i<4; i++) {
		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
	}
	[self.view addSubview:tabBar];
//	[self.view addSubview:email.view];
	
	NSLog(@"taxloan viewdidload:%@", self);
	
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

-(void) navigationController:(UINavigationController *)navigation_controller didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"LTViewController didShowViewController:%@--%@", navigationController, viewController);
	if ([viewController.navigationController.viewControllers count]==1) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		banner.center = CGPointMake(160, 51);
		[UIView commitAnimations];
		tabBar.selectedItem = nil;
		tabBar.hidden = YES;
	} else {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		banner.center = CGPointMake(160, -31);
		[UIView commitAnimations];
		tabBar.hidden = NO;
	}
	
//	if ([viewController.navigationController.viewControllers count]==2) {
//		((RootViewController*)[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers objectAtIndex:0]).navigationItem.backBarButtonItem = nil;
//	}
	
//	if ([viewController class]!=[RootViewController class]) {
//		viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Home (Tax)", nil) style:UIBarButtonItemStyleBordered target:[CoreData sharedCoreData]._LTViewController action:@selector(goHome)] autorelease];
//	}

}

-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"LTViewController: willShowViewController(navigationController:%@, viewController:%@)",pnavigationController,viewController);
    
    
    if ([viewController class]==[RootViewController class]) {
        if ([[CoreData sharedCoreData]._LTViewController.frompage isEqualToString:@"latestpromot"]){
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenRight:self];
            [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            [UIView commitAnimations];
            [CoreData sharedCoreData]._LTViewController.frompage=@"";
        }else{
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenRight:self];
            [CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            [UIView commitAnimations];
        }
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
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	switch (item.tag) {
		case 0:
            [self forwardNextView:NSClassFromString(@"LTOffersViewController") viewName:@"LTOffersViewController"];    
			break;
		case 1:
            if([MBKUtil isLangOfChi]){
                [self forwardNextView:NSClassFromString(@"LTApplicationViewController") viewName:@"LTApplicationViewController_zh"];    
            }else{
                [self forwardNextView:NSClassFromString(@"LTApplicationViewController") viewName:@"LTApplicationViewController_en"];    
            }
			break;
		case 2:
            [self forwardNextView:NSClassFromString(@"LTCalculatorViewController") viewName:@"LTCalculatorViewController"];    
			break;
		case 3:
            [self forwardNextView:NSClassFromString(@"LTEnquiryViewController") viewName:@"LTEnquiryViewController"];    
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
	[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:YES];
}

-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName{
    NSLog(@"LTViewController: forwardNextView(viewController:%@)",viewController);
    if ([[navigationController.viewControllers lastObject] class] == viewController) {
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:FALSE];
    //    UIViewController *current_view_controller = [viewController new];
    UIViewController *current_view_controller = [[viewController alloc] initWithNibName:viewName bundle:nil];
    
    [self.navigationController pushViewController:current_view_controller animated:TRUE];
    [current_view_controller release];
}

-(void) welcome{
    NSLog(@"LTViewController: welcome");
    [self forwardNextView:NSClassFromString(@"LTOffersViewController") viewName:@"LTOffersViewController"];    
}

@end
