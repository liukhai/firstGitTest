//
//  PropertyLoanUtil.m
//  BEA
//
//  Created by YAO JASEN on 28/02/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "PropertyLoanUtil.h"


@implementation PropertyLoanUtil

+(PropertyLoanUtil *) me{
    static PropertyLoanUtil *me;
    @synchronized(self){
        if (!me) {
            me = [[PropertyLoanUtil alloc] init];
        }
    }
    return me;
}

-(id) init{
    NSLog(@"PropertyLoanUtil init ......");
    self = [super init];
    if(self){
    }
    return self;
}

-(void)callToApply{
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"PropertyLoanCallApply",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==1) {
        NSURL *telno = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[NSLocalizedString(@"PropertyLoanCallApply",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]]];
		NSLog(@"PropertyLoanUtil Call %@",telno);
		[[UIApplication sharedApplication] openURL:telno];
	}
}

+ (BOOL) isValidUtil
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
	NSDate *now_date = [NSDate date];
	
	NSDate *start_date = [df dateFromString:@"20110101"];
	NSDate *end_date = [df dateFromString:@"20110328"];
	
	BOOL retValue=NO;
	if ([now_date isEqualToDate:start_date] 
		|| [now_date isEqualToDate:end_date] 
		|| ( (NSOrderedDescending == [now_date compare:start_date]) && (NSOrderedAscending == [now_date compare:end_date]) )
		)
	{
		retValue=YES;
	}
	
	NSLog(@"PropertyLoanUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);
	
	return retValue;
}

@end
