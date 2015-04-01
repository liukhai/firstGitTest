//
//  HotlineViewController.m
//  BEA
//
//  Created by yelong on 3/1/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "HotlineViewController.h"
#import "HotlineCallViewController.h"
#import "ATMNearBySearchListViewController.h"
#import "MPFUtil.h"

@implementation HotlineViewController

@synthesize navigationController, tabBar, ns_service;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [CachedImageView clearAllCache];
    }
    return self;
}


- (void)viewDidLoad {
    NSLog(@"debug HotlineViewController:%@", self);
	[super viewDidLoad];
    
//    [[MyScreenUtil me] adjustView2Screen:self.view];

//	tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-49, 320, 49);
//	tabBar.delegate = self;
//	NSArray *tab_list = [NSLocalizedString(@"HotlineTabBarTag",nil) componentsSeparatedByString:@","];
//
//    [[MyScreenUtil me] adjustNavView:navigationController.view];
//	[self.view addSubview:navigationController.view];
//	for (int i=0; i<[tab_list count]; i++) {
//		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
//	}
//	[self.view addSubview:tabBar];

//	navigationController.delegate = self;
//    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
//	[navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

-(void)welcome{
	NSLog(@"HotlineViewController welcome");
	UIViewController *current_view_controller;
//	[navigationController popToRootViewControllerAnimated:FALSE];
	current_view_controller = [[HotlineCallViewController alloc] initWithNibName:@"HotlineCallView" bundle:nil];
	[[CoreData sharedCoreData].main_view_controller pushViewController:current_view_controller animated:FALSE];
	[current_view_controller release];
	self.tabBar.selectedItem = nil;
}

-(void)goMainFaster
{
//    NSLog(@"debug goMainFaster:%@", self);
//    [CoreData sharedCoreData].hotline_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//    if([[CoreData sharedCoreData].lastScreen isEqualToString:@"RateViewController"]){
//        [RateUtil me].Rate_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [[RateUtil me].Rate_view_controller selectTabBarMatchedCurrentView];
//    }else{
//        [CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//    }
//    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    
    [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
}

- (void)navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	NSLog(@"HotlineViewController willShowViewController:%@--%@--%d", pnavigationController, viewController, [viewController.navigationController.viewControllers count]);
	if ([viewController.navigationController.viewControllers count]==1) {
//			[UIView beginAnimations:nil context:NULL];
//			[UIView setAnimationDuration:0.5];
            [self goMainFaster];
//			[UIView commitAnimations];
	}else if ([viewController.navigationController.viewControllers count]>2) {//added by jasen at 20110311
//		self.tabBar.hidden = YES;
	} else {
//		self.tabBar.hidden = NO;
	}
}
/*
- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	UIAlertView *share_alert;
	NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	SettingViewController *setting_controller;
	switch (item.tag) {
		case 0://added by jasen at 20110311
			ns_service = @"banking";
			if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
				[self checkMBKRegStatus];
			} else {
				setting_controller = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
				[self.navigationController pushViewController:setting_controller animated:TRUE];
				[setting_controller release];
				break;
			}
			
			break;
		case 1:
			ns_service = @"nearby";
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.5];
			[[CoreData sharedCoreData].root_view_controller setContent:0];
			[CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
			[CoreData sharedCoreData].hotline_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
			[[CoreData sharedCoreData].atmlocation_view_controller welcome];
			[UIView commitAnimations];
			break;
		case 2:
			ns_service = @"email";
			share_alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Share to Friends",nil) message:NSLocalizedString(@"Share App with Friends by Email",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
			share_alert.delegate = self;
			[share_alert show];
			[share_alert release];
			self.tabBar.selectedItem = nil;
			break;
			
	}
}
*/
-(void)checkMBKRegStatus{//added by jasen at 20110311
	NSLog(@"HotlineViewController checkMBKRegStatus");
//	NSData *banking;
	NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
//		banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
//		[MBKUtil transform:banking];
        /*
         NSURL *url = [NSURL URLWithString:[MBKUtil getCheckRegStatusURL]];
         asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
         NSLog(@"HotlineViewController checkMBKRegStatus url:%@",asi_request.url);
         [asi_request setUsername:@"iphone"];
         [asi_request setPassword:@"iphone"];
         [asi_request setValidatesSecureCertificate:NO];
         asi_request.delegate = self;
         [[CoreData sharedCoreData].queue addOperation:asi_request];
         */
        ASIFormDataRequest *request = [HttpRequestUtils getPostRequest4checkMBKRegStatus:self];
        
		[[CoreData sharedCoreData].queue addOperation:request];
		[[CoreData sharedCoreData].mask showMask];
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request {//added by jasen at 20110311
	[[CoreData sharedCoreData].mask hiddenMask];
	
	NSLog(@"HotlineViewController requestFinished:%@",[request responseString]);
	NSString * regStatus = [NSString stringWithFormat:@"%@", [request responseString]];
    NSString * CyberbankingDomain = [[MigrationSetting me] CYBDomain];
	
	if (NSOrderedSame == [regStatus compare:@"1"]){
		WebViewController *banking_controller;
//		NSData *banking;
		NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
		if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
			banking_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
//			banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
//			[MBKUtil transform:banking];
			//NSLog(@"%@",[[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding]);
            NSURL *url=
            [NSURL URLWithString:
             [NSString stringWithFormat:@"%@%@%@%@",
              CyberbankingDomain,
              NSLocalizedString(@"mobilebanking",nil),
//              [[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding],
              [MBKUtil decryption:[user_setting objectForKey:@"encryted_banking"]],
              [[MPFUtil me] getReqParam]]
             ];
            [banking_controller setUrlRequest:[NSURLRequest requestWithURL:url]]; //To be retested
			[self.navigationController pushViewController:banking_controller animated:TRUE];

	//		[banking_controller.web_view loadRequest:[NSURLRequest requestWithURL:url]];
	//		NSLog(@"HotlineViewController banking:%@",url);
			[banking_controller release];
		}
		
	}else if (NSOrderedSame == [regStatus compare:@"0"]){
		
		UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Pop Up Notice for Register",nil) message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Continue",nil),nil];
		[alert_view show];
		[alert_view release];
		
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"HotlineViewController >> requestFailed error:%@", [request error]);
	
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];

}

//////////////////////
//UIAlertViewDelegate
//////////////////////
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (![ns_service isEqualToString:@"email"]) {
        NSURL *url = [MBKUtil getURLCYBMBKREG];
        NSLog(@"HotlineViewController continue to url:%@", url);
        
        [[UIApplication sharedApplication] openURL:url];

		return;
	}

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


@end
