//
//  LTUtil.m
//  BEA
//
//  Created by YAO JASEN on 10/20/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "LTUtil.h"


@implementation LTUtil

@synthesize lTViewController;

+ (LTUtil *)me
{
	static LTUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[LTUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"lTViewController init");
    self = [super init];
    if (self) {
        self.lTViewController = nil;
    }
    
    return self;
}


+(void)showTNC{
	UIViewController *view_controller;
//	[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
	view_controller = [[LTTNCViewController alloc] initWithNibName:@"LTTNCViewController" bundle:nil];
	[[CoreData sharedCoreData]._LTViewController.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
}

+(void)showLoanOffers{
	UIViewController *view_controller;
//	[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
	view_controller = [[LTOffersViewController alloc] initWithNibName:@"LTOffersViewController" bundle:nil];
	[[CoreData sharedCoreData]._LTViewController.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
} 
+(void)showRepaymentTable{
	UIViewController *view_controller;
//	[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
	view_controller = [[LTRepaymentTableViewController alloc] initWithNibName:@"LTRepaymentTableViewController" bundle:nil];
	[[CoreData sharedCoreData]._LTViewController.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
}

-(void)callToApply{
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TaxLoanCallApply",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==1) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(@"TaxLoanApplyHotline",nil)]];
	}
}
 
@end
