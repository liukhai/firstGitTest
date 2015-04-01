//
//  SGGUtil.h
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import "SGGUtil.h"
#import "HttpRequestUtils.h"

@implementation SGGUtil

@synthesize _SGGViewController, serverFlag, inModule;

+ (SGGUtil *)me
{
	static SGGUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[SGGUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"SGGUtil init");
    self = [super init];
    if (self) {
        self._SGGViewController = [[SGGViewController alloc] initWithNibName:@"SGGViewController" bundle:nil];
        self._SGGViewController.view.center = CGPointMake(480, 240);
        self.inModule = @"N";
    }
    
    return self;
}

+ (BOOL) isValidUtil
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
	NSDate *now_date = [NSDate date];
	
	NSDate *start_date = [df dateFromString:@"20120301"];
	NSDate *end_date = [df dateFromString:@"20120501"];

	[df release];
    
	BOOL retValue=NO;
	if ([now_date isEqualToDate:start_date] 
		|| [now_date isEqualToDate:end_date] 
		|| ( (NSOrderedDescending == [now_date compare:start_date]) && (NSOrderedAscending == [now_date compare:end_date]) )
		)
	{
		retValue=YES;
	}
	
	NSLog(@"SGGUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);
	
	return retValue;
}

+ (void) setInModule
{
 	NSLog(@"SGGUtil setInModule");
   [SGGUtil me].inModule = @"Y";
}

+ (void) setOutModule
{
 	NSLog(@"SGGUtil setOutModule");
    [SGGUtil me].inModule = @"N";
}

+ (BOOL) isInModule
{
 	NSLog(@"SGGUtil isInModule:%d", [[SGGUtil me].inModule isEqualToString:@"Y"]);
    return [[SGGUtil me].inModule isEqualToString:@"Y"];
}

-(void)goHome{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[SGGUtil me]._SGGViewController.view.center = CGPointMake(480, 240);
	[CoreData sharedCoreData].main_view_controller.view.center = CGPointMake(160, 240);
	[UIView commitAnimations];
    
    [SGGUtil setOutModule];
}

-(void)goOut{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[SGGUtil me]._SGGViewController.view.center = CGPointMake(-160, 240);
	[UIView commitAnimations];
}

-(void)goIn{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[SGGUtil me]._SGGViewController.view.center = CGPointMake(160, 240);
	[UIView commitAnimations];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([serverFlag isEqualToString:@"phone"]){
        if (buttonIndex==1) {
            NSString* telString = [NSString stringWithFormat:
                                   @"tel:%@",[NSLocalizedString(@"Rate.application.call",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                                   ];
            NSLog(@"call:%@", telString);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
        }
    }else if([serverFlag isEqualToString:@"backtomain"]){
        [self goHome];
    }
}

-(void)alertAndBackToMain{
	self.serverFlag = @"backtomain";
    
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
}

-(void)showMainViewController
{
    [CoreData sharedCoreData].lastScreen = @"SGGViewController";
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [SGGUtil me]._SGGViewController.view.center = CGPointMake(160, 240);
    [CoreData sharedCoreData].main_view_controller.view.center = CGPointMake(-160, 240);
    [[SGGUtil me]._SGGViewController welcome];
    [UIView commitAnimations];

    [SGGUtil setInModule];
}

@end
