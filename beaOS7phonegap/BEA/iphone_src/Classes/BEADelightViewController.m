//
//  BEADelightViewController.m
//  BEA
//
//  Created by Algebra Lo on 10年6月25日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BEADelightViewController.h"


@implementation BEADelightViewController

@synthesize tabBar;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[CachedImageView clearAllCache];
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
    
    [[MyScreenUtil me] adjustView2Screen:self.view];

//	ecoupon = [[ECouponViewController alloc] initWithNibName:@"ECouponView" bundle:nil];
//	ecoupon.view.center = CGPointMake(160, 1.5*[[MyScreenUtil me] getScreenHeight]);
//	[CoreData sharedCoreData].ecoupon = ecoupon;
//	
//	email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
//	email.view.center = CGPointMake(160, 1.5*[[MyScreenUtil me] getScreenHeight]);
//	[CoreData sharedCoreData].email = email;
	
//	tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-49, 320, 49);
//    NSLog(@"debug BEADelightViewController tabBar:%@", tabBar);
//	tabBar.delegate = self;
//	NSArray *tab_list = [NSLocalizedString(@"Tab",nil) componentsSeparatedByString:@","];
//	banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3cards.png"]];
//	banner.frame = CGRectMake(0, 20, 320, 63);
//    [[MyScreenUtil me] adjustNavView:navigationController.view];
//	[self.view addSubview:navigationController.view];
//	for (int i=0; i<4; i++) {
//		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
//	}
//	[self.view addSubview:tabBar];
//	[self.view addSubview:banner];
//	[self.view addSubview:ecoupon.view];
//	[self.view addSubview:email.view];
	
     NSLog(@"delightViewController viewdidload:%@", self);
    self.navigationController.delegate = self;
//    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
//	[navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
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

-(void) navigationController:(UINavigationController *)pnavigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"debug BEADelightViewController didShowViewController:%@--%@--%d", pnavigationController, viewController, [viewController.navigationController.viewControllers count]);
//	if ([viewController.navigationController.viewControllers count]==1) {
//		[UIView beginAnimations:nil context:NULL];
//		[UIView setAnimationDuration:0.5];
//		banner.center = CGPointMake(160, 51);
//		[UIView commitAnimations];
//		tabBar.selectedItem = nil;
//	} else {
//		[UIView beginAnimations:nil context:NULL];
//		[UIView setAnimationDuration:0.5];
//		banner.center = CGPointMake(160, -31);
//		[UIView commitAnimations];
//	}

//	if ([viewController.navigationController.viewControllers count]>2) {
//		/*UIButton *home_button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
//		 home_button.titleLabel.font = [UIFont systemFontOfSize:12];
//		 [home_button setTitle:NSLocalizedString(@"Home",nil) forState:UIControlStateNormal];
//		 [home_button addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
//		 viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:home_button] autorelease];*/
//		viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_home.png"] style:UIBarButtonItemStyleBordered target:[CoreData sharedCoreData].root_view_controller action:@selector(goHome)] autorelease];
//		//viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Home",nil) style:UIBarButtonItemStyleBordered target:[CoreData sharedCoreData].root_view_controller action:@selector(goHome)] autorelease];
//	} else if (tabBar.selectedItem.tag==2 && [viewController.navigationController.viewControllers count]==2) {
//		viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit",nil) style:UIBarButtonItemStyleBordered target:viewController action:@selector(enableEdit)] autorelease];
//	}
}

-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"debug BEADelightViewController willShowViewController:%@--%@--%d--%d",
          pnavigationController,
          viewController,
          [pnavigationController.viewControllers count],
          [[CoreData sharedCoreData].bea_view_controller isPass1]);

    if([pnavigationController.viewControllers count] == 1){
        if ([[CoreData sharedCoreData].bea_view_controller isPass1]) {
            [[CoreData sharedCoreData].bea_view_controller setPass1:NO];
            [(HomeViewController*)([CoreData sharedCoreData].root_view_controller.current_view_controller) backToHomePressed:nil];
        }
    }
    if ([viewController class] == [BEADelightViewController class]) {
//        [[CoreData sharedCoreData].delight_view_controller.navigationController popViewControllerAnimated:NO];
        if ([CoreData sharedCoreData].home_view_controller) {
            [[CoreData sharedCoreData].home_view_controller release];
            [CoreData sharedCoreData].home_view_controller = nil;
        }
        [CoreData sharedCoreData].home_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
        [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].home_view_controller animated:NO];
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
	UIViewController *current_view_controller;
	UIAlertView *share_alert;
	switch (item.tag) {
		case 0:
			if ([[self.navigationController.viewControllers lastObject] class]==[NearBySearchListViewController class]) {
				return;
			}
			[self.navigationController popToRootViewControllerAnimated:FALSE];
			current_view_controller = [[NearBySearchListViewController alloc] initWithNibName:@"NearBySearchListView" bundle:nil];
			[self.navigationController pushViewController:current_view_controller animated:TRUE];
			[current_view_controller release];
			break;
		case 1:
			if ([[self.navigationController.viewControllers lastObject] class]==[AdvanceSearchViewController class]) {
				return;
			}
			[self.navigationController popToRootViewControllerAnimated:FALSE];
			current_view_controller = [[AdvanceSearchViewController alloc] initWithNibName:@"AdvanceSearchView" bundle:nil];
			[self.navigationController pushViewController:current_view_controller animated:TRUE];
			[current_view_controller release];
			break;
		case 2:
			if ([[self.navigationController.viewControllers lastObject] class]==[FavouriteListViewController class]) {
				return;
			}
			[self.navigationController popToRootViewControllerAnimated:FALSE];
			current_view_controller = [[FavouriteListViewController alloc] initWithNibName:@"FavouriteListView" bundle:nil];
			[self.navigationController pushViewController:current_view_controller animated:TRUE];
			[current_view_controller release];
			break;
		case 3:
			share_alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Share to Friends",nil) message:NSLocalizedString(@"Share App with Friends by Email",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Back",nil),nil];
			share_alert.delegate = self;
			[share_alert show];
			[share_alert release];
			self.tabBar.selectedItem = nil;
			break;
	}
}

- (void)goMain{
    [[CoreData sharedCoreData].delight_view_controller.navigationController popToRootViewControllerAnimated:NO];
    //    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    NSLog(@"BEADelightViewController goMain:%@",[CoreData sharedCoreData].bea_view_controller.vc4process);
}


-(void)goMainFaster
{
    NSLog(@"debug goMainFaster:%@", self);
//    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
//	[CoreData sharedCoreData].delight_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[CoreData sharedCoreData].delight_view_controller.navigationController popToRootViewControllerAnimated:NO];
	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
}

//////////////////////
//UIAlertViewDelegate
//////////////////////
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==0) {
		[[CoreData sharedCoreData].email createComposerWithSubject:NSLocalizedString(@"Check out",nil) Message:NSLocalizedString(@"Main share app",nil)];
        [self.view addSubview:[CoreData sharedCoreData].email.view];
	}
}

@end
