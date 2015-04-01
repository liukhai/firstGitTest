//
//  BEA_SurpriseAppDelegate.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月12日.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BEA_SurpriseAppDelegate.h"
#import "RootViewController.h"


@implementation BEA_SurpriseAppDelegate

@synthesize window;
@synthesize navigationController, tabBar;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch
	//[Bookmark removeExpiredBookmark];
	[CachedImageView clearAllCache];

	/*[[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
	[UIApplication sharedApplication].applicationIconBadgeNumber = 5;*/
	
	ecoupon = [[ECouponViewController alloc] initWithNibName:@"ECouponView" bundle:nil];
	ecoupon.view.center = CGPointMake(160, 720);
	[CoreData sharedCoreData].ecoupon = ecoupon;
	
	email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
	email.view.center = CGPointMake(160, 720);
	[CoreData sharedCoreData].email = email;
	
	mask = [[MaskViewController alloc] initWithNibName:@"MaskView" bundle:nil];
	mask.view.center = CGPointMake(160, mask.view.frame.size.height/2 + 20);
	tabBar.frame = CGRectMake(0, 480-49, 320, 49);
	tabBar.delegate = self;
	[mask hiddenMask];
	NSArray *tab_list = [NSLocalizedString(@"Tab",nil) componentsSeparatedByString:@","];
	banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3cards.png"]];
	banner.frame = CGRectMake(0, 20, 320, 63);
	[CoreData sharedCoreData].mask = mask;
	[window addSubview:[navigationController view]];
	for (int i=0; i<4; i++) {
		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
	}
	[window addSubview:tabBar];
	[window addSubview:banner];
	[window addSubview:ecoupon.view];
	[window addSubview:email.view];
	[window addSubview:mask.view];
	
    [window makeKeyAndVisible];
	navigationController.delegate = self;
    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
	[navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

-(void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	if ([viewController.navigationController.viewControllers count]==1) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		banner.center = CGPointMake(160, 51);
		[UIView commitAnimations];
		tabBar.selectedItem = nil;
//		banner.hidden = FALSE;
	} else {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		banner.center = CGPointMake(160, -31);
		[UIView commitAnimations];
//		banner.hidden = TRUE;
	}

	if ([viewController.navigationController.viewControllers count]>2) {
		/*UIButton *home_button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
		home_button.titleLabel.font = [UIFont systemFontOfSize:12];
		[home_button setTitle:NSLocalizedString(@"Home",nil) forState:UIControlStateNormal];
		[home_button addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
		viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:home_button] autorelease];*/
		viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_home.png"] style:UIBarButtonItemStyleBordered target:[CoreData sharedCoreData].root_view_controller action:@selector(goHome)] autorelease];
		//viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Home",nil) style:UIBarButtonItemStyleBordered target:[CoreData sharedCoreData].root_view_controller action:@selector(goHome)] autorelease];
	} else if (tabBar.selectedItem.tag==2 && [viewController.navigationController.viewControllers count]==2) {
		viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit",nil) style:UIBarButtonItemStyleBordered target:viewController action:@selector(enableEdit)] autorelease];
	}

}

///////////////////
//UITabbarDelegate
///////////////////
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	UIViewController *current_view_controller;
	UIAlertView *share_alert;
	switch (item.tag) {
		case 0:
			if ([[navigationController.viewControllers lastObject] class]==[NearBySearchListViewController class]) {
				return;
			}
			[navigationController popToRootViewControllerAnimated:FALSE];
			current_view_controller = [[NearBySearchListViewController alloc] initWithNibName:@"NearBySearchListView" bundle:nil];
			[navigationController pushViewController:current_view_controller animated:TRUE];
			[current_view_controller release];
			break;
		case 1:
			if ([[navigationController.viewControllers lastObject] class]==[AdvanceSearchViewController class]) {
				return;
			}
			[navigationController popToRootViewControllerAnimated:FALSE];
			current_view_controller = [[AdvanceSearchViewController alloc] initWithNibName:@"AdvanceSearchView" bundle:nil];
			[navigationController pushViewController:current_view_controller animated:TRUE];
			[current_view_controller release];
			break;
		case 2:
			if ([[navigationController.viewControllers lastObject] class]==[FavouriteListViewController class]) {
				return;
			}
			[navigationController popToRootViewControllerAnimated:FALSE];
			current_view_controller = [[FavouriteListViewController alloc] initWithNibName:@"FavouriteListView" bundle:nil];
			[navigationController pushViewController:current_view_controller animated:TRUE];
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

///////////////////////
//PushRegister Delegate
///////////////////////
-(void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	NSLog(@"%@",deviceToken);
}

-(void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	NSLog(@"%@",error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
}

-(BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	NSLog(@"Got notifications");
	[self applicationDidFinishLaunching:application];
	return TRUE;
}

//////////////////////
//UIAlertViewDelegate
//////////////////////
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==0) {
			[[CoreData sharedCoreData].email createComposerWithSubject:NSLocalizedString(@"Check out",nil) Message:NSLocalizedString(@"Main share app",nil)];
	}
}

@end

