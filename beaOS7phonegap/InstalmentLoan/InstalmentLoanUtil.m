//
//  InstalmentLoanUtil.m
//  BEA
//
//  Created by NEO on 01/12/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "InstalmentLoanUtil.h"
#import "InstalmentLoanOffersViewController.h"
#import "InstalmentLoanTNCViewController.h"
#import "InstalmentLoanRepaymentTableViewController.h"

@implementation InstalmentLoanUtil


@synthesize strSend,_InstalmentLoanViewController;

+ (InstalmentLoanUtil *)me
{
	static InstalmentLoanUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[InstalmentLoanUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"ppp init");
    self = [super init];
    if (self) {
        self._InstalmentLoanViewController = nil;
        self.strSend = nil;
    }
    
    return self;
}


-(void)callToApply{
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"instalmentLoan.CallApply",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==1) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(@"instalmentLoan.ApplyHotline",nil)]];
	}
}

+ (BOOL) isValidUtil
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
	NSDate *now_date = [NSDate date];
	
	NSDate *start_date = [df dateFromString:@"20110101"];
	NSDate *end_date = [df dateFromString:@"20110901"];
	
	BOOL retValue=NO;
	if ([now_date isEqualToDate:start_date] 
		|| [now_date isEqualToDate:end_date] 
		|| ( (NSOrderedDescending == [now_date compare:start_date]) && (NSOrderedAscending == [now_date compare:end_date]) )
		)
	{
		retValue=YES;
	}
	
	NSLog(@"InstalmentLoanUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);
	[df release];
	return retValue;
}

+(void)showTNC{
	UIViewController *view_controller;
    //	[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
	view_controller = [[InstalmentLoanTNCViewController alloc] initWithNibName:@"InstalmentLoanTNCViewController" bundle:nil];
    [[CoreData sharedCoreData]._InstalmentLoanViewController.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
}

+(void)showLoanOffers{
	UIViewController *view_controller;
    //	[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
	view_controller = [[InstalmentLoanOffersViewController alloc] initWithNibName:@"InstalmentLoanOffersViewController" bundle:nil];
	[[CoreData sharedCoreData]._InstalmentLoanViewController.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
} 
+(void)showRepaymentTable{
	UIViewController *view_controller;
    //	[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
	view_controller = [[InstalmentLoanRepaymentTableViewController alloc] initWithNibName:@"InstalmentLoanRepaymentTableViewController" bundle:nil];
	[[CoreData sharedCoreData]._InstalmentLoanViewController.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
}



-(BOOL)isSend
{
    return ([self.strSend isEqualToString:@"YES"]);
}

@end
