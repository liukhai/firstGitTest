//
//  ATMLocationViewController.m
//  BEA
//
//  Created by Algebra Lo on 10Âπ¥6Êúà25Êó•.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMLocationViewController.h"
#import "ATMNearBySearchListViewController.h"
#import "ATMAdvanceSearchViewController.h"
#import "ATMFavouriteListViewController.h"
#import "AccProViewController.h"
#import "ATMNearBySearchDistCMSViewController.h"

@class ATMNearBySearchListViewController;
@class ATMAdvanceSearchViewController;
@class ATMFavouriteListViewController;
@class AccProViewController;

@implementation ATMLocationViewController

@synthesize tabBar;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[CachedImageView clearAllCache];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[MyScreenUtil me] adjustView2Screen:self.view];
//    
//	tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-49, 320, 49);
//	tabBar.delegate = self;
//	NSArray *tab_list = [NSLocalizedString(@"Tab",nil) componentsSeparatedByString:@","];
//    [[MyScreenUtil me] adjustNavView:navigationController.view];
//	[self.view addSubview:navigationController.view];
//	for (int i=0; i<4; i++) {
//		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
//	}
    //	[self.view addSubview:tabBar];
	
//    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
//        [navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
    
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    
    switch (self.menuIndex) {
        case -10:
            [self welcome];
            break;
        case 0:
            [self welcome2];
            break;
            
        default:
            [self welcomeToindex:self.menuIndex];
    }
	
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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

-(void) navigationController:(UINavigationController *)nav didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"ATMLocationViewController didShowViewController:%@%@--%d", nav, viewController, [viewController.navigationController.viewControllers count]);
	
//	if (tabBar.selectedItem.tag==2 && [viewController.navigationController.viewControllers count]==2) {
//		Bookmark *bookmark_data = [[Bookmark alloc] init];
//		if ([[bookmark_data listOfferIdInGroup:6] length]>0) {
//			viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit",nil) style:UIBarButtonItemStyleBordered target:viewController action:@selector(enableEdit)] autorelease];
//		}
//		[bookmark_data release];
//	}
	
}
- (void)navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([[pnavigationController.viewControllers lastObject] class] == [ATMLocationViewController class]) {
		[self goMain];
	}
//
}

-(void)goMainFaster
{
    NSLog(@"debug ATMLocationViewController goMainFaster:%@", self);
//	[CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	if ([[CoreData sharedCoreData].lastScreen isEqualToString:@"_PropertyLoanViewController"]) {//added by jasen
////        [[CoreData sharedCoreData].taxLoan_view_controller.navigationController popToViewController:[CoreData sharedCoreData].bea_view_controller animated:NO];
//        [[CoreData sharedCoreData]._PropertyLoanViewController.navigationController popViewControllerAnimated:NO];
//        [CoreData setMainViewFrame];
//        //		[CoreData sharedCoreData]._PropertyLoanViewController.view.center = [[MyScreenUtil me] getmainScreenCenter_20:self];
//        //        [[CoreData sharedCoreData]._PropertyLoanViewController selectTabBarMatchedCurrentView];
//        //        [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
//        //	} else if ([[CoreData sharedCoreData].lastScreen isEqualToString:@"HotlineViewController"]) {
//        //		[CoreData sharedCoreData].hotline_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self]; // -- added by yelong on 2011.03.07
//        //		[CoreData sharedCoreData].hotline_view_controller.tabBar.selectedItem = nil; // -- added by yelong on 2011.03.07
//        //        [CoreData sharedCoreData].bea_view_controller.vc4process = [CoreData sharedCoreData].hotline_view_controller;
//    }else if([[CoreData sharedCoreData].lastScreen isEqualToString:@"ConsumerLoanViewController"]){
////        [[CoreData sharedCoreData].taxLoan_view_controller.navigationController popToViewController:[CoreData sharedCoreData].bea_view_controller animated:NO];
//        [CoreData setMainViewFrame];
//        //        [CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        //        [[CoreData sharedCoreData].bea_view_controller selectTabBarMatchedCurrentView];
//    }else if([[CoreData sharedCoreData].lastScreen isEqualToString:@"AccProViewController"]){
//        [[AccProUtil me].AccPro_view_controller.navigationController popToRootViewControllerAnimated:NO];
//        [CoreData setMainViewFrame];
//        //        [[AccProUtil me].AccPro_view_controller.menuVC.mv_rmvc.rmUtil showMenu:0];
//        //        [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        //        [CoreData sharedCoreData].bea_view_controller.vc4process = [AccProUtil me].AccPro_view_controller;
//    }else if([[CoreData sharedCoreData].lastScreen isEqualToString:@"RateViewController"]){
//        [RateUtil me].Rate_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [[RateUtil me].Rate_view_controller selectTabBarMatchedCurrentView];
//        [CoreData sharedCoreData].bea_view_controller.vc4process = [RateUtil me].Rate_view_controller;
//    }else if([[CoreData sharedCoreData].lastScreen isEqualToString:@"ConsumerLoanRevamp"]){//added by jasen on 20111118
//        [ConsumerLoanUtil me].ConsumerLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [CoreData sharedCoreData].bea_view_controller.vc4process = [ConsumerLoanUtil me].ConsumerLoan_view_controller;
//    }else if([[CoreData sharedCoreData].lastScreen isEqualToString:@"_PropertyLoanViewController"]){
//        [CoreData sharedCoreData]._PropertyLoanViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [CoreData sharedCoreData].bea_view_controller.vc4process = [CoreData sharedCoreData]._PropertyLoanViewController;
//    }else {
//		[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [[MyScreenUtil me] adjustView2Top0:[CoreData sharedCoreData].main_view_controller.view];
//        [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
//	}
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)goMain {
	NSLog(@"ATMLocationViewController goMain");
    //	[UIView beginAnimations:nil context:NULL];
    //	[UIView setAnimationDuration:0.3];
    [self goMainFaster];
    //	[UIView commitAnimations];
}

-(void)welcome{
	NSLog(@"ATMLocationViewController welcome");
    
    //    [self stepone];
    
	UIViewController *current_view_controller;
//	[navigationController popToRootViewControllerAnimated:FALSE];
	current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
    [self.navigationController pushViewController:current_view_controller animated:FALSE];
	[current_view_controller release];
	self.tabBar.selectedItem = nil;
    
}
-(void)welcome2{
	NSLog(@"ATMLocationViewController welcome2");
    
    //    [self stepone];
    
	ATMNearBySearchListViewController *current_view_controller;
	[navigationController popToRootViewControllerAnimated:FALSE];
	current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
    current_view_controller.menuID = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showFlag" object:nil];
    NSLog(@"post a notification");
	[navigationController pushViewController:current_view_controller animated:FALSE];
    [current_view_controller release];
	self.tabBar.selectedItem = nil;
    
}
-(void)welcomeToindex:(int) index{
	NSLog(@"ATMLocationViewController welcome2");
    
    //    [self stepone];
    
	ATMNearBySearchListViewController *current_view_controller;
//	[navigationController popToRootViewControllerAnimated:FALSE];
	current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
    current_view_controller.menuID = index;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showFlag" object:nil];
    NSLog(@"post a notification");
	[self.navigationController pushViewController:current_view_controller animated:FALSE];
    [current_view_controller release];
	self.tabBar.selectedItem = nil;
    
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
	NSLog(@"ATMLocationViewController didSelectItem:%@", item);
	UIViewController *current_view_controller;
	UIAlertView *share_alert;
	switch (item.tag) {
		case 0:
			if ([[navigationController.viewControllers lastObject] class]==[ATMNearBySearchListViewController class]) {
				return;
			}
			[navigationController popToRootViewControllerAnimated:FALSE];
			current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
			[navigationController pushViewController:current_view_controller animated:TRUE];
			[current_view_controller release];
			break;
		case 1:
			if ([[navigationController.viewControllers lastObject] class]==[ATMNearBySearchDistCMSViewController class]) {
				return;
			}
			[navigationController popToRootViewControllerAnimated:FALSE];
			current_view_controller = [[ATMNearBySearchDistCMSViewController alloc] initWithNibName:@"ATMNearBySearchDistCMSView" bundle:nil];
			[navigationController pushViewController:current_view_controller animated:TRUE];
			[current_view_controller release];
			break;
		case 2:
			if ([[navigationController.viewControllers lastObject] class]==[ATMFavouriteListViewController class]) {
				return;
			}
			[navigationController popToRootViewControllerAnimated:FALSE];
			current_view_controller = [[ATMFavouriteListViewController alloc] initWithNibName:@"ATMFavouriteListView" bundle:nil];
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

//////////////////////
//UIAlertViewDelegate
//////////////////////
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==0) {
		MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
		if (![MFMailComposeViewController canSendMail]) {
			[mail_controller release];
			return;
		}
		mail_controller.mailComposeDelegate = self;
		NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"Check out",nil)];
		NSString* body = [NSString stringWithFormat:@"%@", NSLocalizedString(@"Main share app",nil)];
		[mail_controller setSubject:subject];
		[mail_controller setMessageBody:body isHTML:FALSE];
		[self presentViewController:mail_controller animated:YES completion:nil];
		[[MBKUtil me].queryButton1 setHidden:YES];
		[mail_controller release];
	}
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	switch (result) {
		case MFMailComposeResultCancelled:
			
			break;
		case MFMailComposeResultSaved:
			
			break;
		case MFMailComposeResultSent:
			NSLog(@"Sent");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Fail");
			break;
	}
	[self dismissViewControllerAnimated:YES completion:nil];
	[[MyScreenUtil me] adjustView2Screen:self.view];
    
}
//-(void)stepone{
//    NSLog(@"ATMLocationViewController.stepone begin");
//	request_type = @"stepone";
//    ASIFormDataRequest *request = [HttpRequestUtils getPostRequest4stepone:self];
//
//    [[CoreData sharedCoreData].queue addOperation:request];
//}

//////////////////
//DataUpdaterDelegate
//////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
	NSLog(@"ATMLocationViewController.requestFinished rsp:%d", [reponsedString length]);
    //	NSLog(@"ATMUtil.requestFinished rsp:%@", reponsedString);
    //	if ([request_type isEqualToString:@"stepone"]) {
    //		request_type = @"steptwo";
    //		[self checkATMListDelta:[request responseData]];
    //	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	
	NSLog(@"ATMLocationViewController.requestFailed:%@", [request error]);
	
}

- (void) checkATMListDelta:(NSData*)datas{
	NSString *ns_temp_file = [MBKUtil getDocTempFilePath];
    //	NSLog(@"ATMUtil.checkATMListDelta:<rsp>%@</rsp>", datas);
	[datas writeToFile:ns_temp_file atomically:YES];
	
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:ns_temp_file];
    //	NSLog(@"ATMUtil.dict:%d", [md_temp count]);
	NSString * atmlist_sn = [md_temp objectForKey:@"SN"];
	NSLog(@"ATMLocationViewController.checkATMListDelta:<new>%@</new>--<old>%@</old>", atmlist_sn, [[MBKUtil me] getATMListSNFromLocal]);
	if (atmlist_sn==nil || [atmlist_sn isEqualToString:@""] || [atmlist_sn isEqualToString:[[MBKUtil me] getATMListSNFromLocal]]){
	}else {
		NSArray *rsp_atmlist = [md_temp objectForKey:@"atmlist"];
		NSDictionary *rsp_item;
		NSString *expire;
		NSString *item_id;
		NSString *item_id_old;
		if (atmlist_sn!=nil && ![atmlist_sn isEqualToString:@""]){
			NSMutableDictionary *old_atmplist = [NSMutableDictionary dictionaryWithContentsOfFile:[[MBKUtil me] getDocATMplistPath]];
			NSMutableArray *old_atmlist = [old_atmplist objectForKey:@"atmlist"];
			if (old_atmlist==nil || [old_atmlist count]<=0) {
				old_atmlist = [NSMutableArray new];
			}
            //			NSLog(@"delta all:%@--<rsp>%d---<old>%d", [[MBKUtil me] getDocATMplistPath], [rsp_atmlist count], [old_atmlist count]);
			
			NSDictionary *old_item;
			BOOL isExistRecord = FALSE;
			int index_process = 0;
			
			for (int i=0; i<[rsp_atmlist count]; i++) {
				rsp_item = [rsp_atmlist objectAtIndex:i];
				expire = [rsp_item objectForKey:@"expire"];
				item_id = [rsp_item objectForKey:@"id"];
				isExistRecord = FALSE;
				//index_process = 0;
				old_item = nil;
				item_id_old = nil;
				
                //				NSLog(@"ATMUtil.searching...:%@--%@", [rsp_item objectForKey:@"id"], [rsp_item objectForKey:@"title"]);
				
				for (index_process=0; index_process<[old_atmlist count]; index_process++) {
					old_item = [old_atmlist objectAtIndex:index_process];
					item_id_old = [old_item objectForKey:@"id"];
					if ([item_id isEqualToString:item_id_old]){
						isExistRecord = TRUE;
						break;
					}
				}
				
                //				NSLog(@"ATMUtil.searched:%d--%d", index_process, isExistRecord);
				
				if (isExistRecord) {
					[old_atmlist removeObjectAtIndex:index_process];
                    //					NSLog(@"ATMUtil.delete:%d", index_process);
					if (![expire isEqualToString:@"1"]){//edit
						[old_atmlist insertObject:rsp_item atIndex:index_process];
                        //						NSLog(@"ATMUtil.add:%d--%@", [old_atmlist count], rsp_item);
					}else {//delete
					}
				}else {
					[old_atmlist insertObject:rsp_item atIndex:index_process];
                    //					NSLog(@"ATMUtil.add:%d--%@", [old_atmlist count], rsp_item);
				}
				
			}
			
            //			NSLog(@"ATMUtil.delta old:%d", [old_atmlist count]);
			
            //			if ([old_atmlist count]<1) {
            //				old_item = [NSDictionary dictionaryWithObject:@"0" forKey:@"id"];
            //				[old_atmlist insertObject:old_item atIndex:0];
            //			}
			
			NSMutableDictionary *updated_atm_plist = [NSMutableDictionary new];
			[updated_atm_plist setObject:atmlist_sn forKey:@"SN"];
			[updated_atm_plist setObject:old_atmlist forKey:@"atmlist"];
			[updated_atm_plist writeToFile:[[MBKUtil me] getDocATMplistPath] atomically:YES];
            [updated_atm_plist release];
		}
	}
	[[NSFileManager defaultManager] removeItemAtPath:ns_temp_file error:nil];
}
@end
