//  Amended by yaojzy on 3/7/12.

#import "CyberFundSearchUtil.h"

@implementation CyberFundSearchUtil

@synthesize _CyberFundSearchImportantNoticeViewController;
@synthesize CyberFundSearch_view_controller,serviceFlag;

+ (CyberFundSearchUtil *)me
{
	static CyberFundSearchUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[CyberFundSearchUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"CyberFundSearchUtil init");
    self = [super init];
    if (self) {
		
        self._CyberFundSearchImportantNoticeViewController = [[CyberFundSearchImportantNoticeViewController alloc] initWithNibName:@"CyberFundSearchImportantNoticeViewController" bundle:nil];
        
        self.CyberFundSearch_view_controller = nil;
        
    }
    
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"CyberFundSearchUtil webViewDidFinishLoad");
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([serviceFlag isEqualToString:@"backtomain"]){
        [self goHome];
    }
}

+ (BOOL) isValidUtil
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
	NSDate *now_date = [NSDate date];
	
	NSDate *start_date = [df dateFromString:@"20110101"];
	NSDate *end_date = [df dateFromString:@"20121231"];
	
	BOOL retValue=NO;
	if ([now_date isEqualToDate:start_date] 
		|| [now_date isEqualToDate:end_date] 
		|| ( (NSOrderedDescending == [now_date compare:start_date]) && (NSOrderedAscending == [now_date compare:end_date]) )
		)
	{
		retValue=YES;
	}
	
	NSLog(@"CyberFundSearchUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);
	
	return retValue;
}

-(void)alertAndBackToMain{
    self.serviceFlag = @"backtomain";
 
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
}

-(void)alertAndBackToMain:(UIViewController*)outViewController{
	[self alertAndBackToMain];
    if(!outViewController) [outViewController dealloc];
}

- (void)goHome{
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
//	[CyberFundSearchUtil me].CyberFundSearch_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//	[UIView commitAnimations];
    [[CoreData sharedCoreData].main_view_controller popToRootViewControllerAnimated:NO];
}


@end
