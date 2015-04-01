#import "MKGeCardUtil.h"

@implementation MKGeCardUtil

@synthesize MKGeCardViewController;

+ (MKGeCardUtil *)me
{
	static MKGeCardUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[MKGeCardUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"MKGeCardUtil init");
    self = [super init];
    if (self) {
        self.MKGeCardViewController = nil;
    }
    
    return self;
}

+ (BOOL) isValidUtil
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
	NSDate *now_date = [NSDate date];
	
	NSDate *start_date = [df dateFromString:@"20111101"];
	NSDate *end_date = [df dateFromString:@"20120131"];

	[df release];
    
	BOOL retValue=NO;
	if ([now_date isEqualToDate:start_date] 
		|| [now_date isEqualToDate:end_date] 
		|| ( (NSOrderedDescending == [now_date compare:start_date]) && (NSOrderedAscending == [now_date compare:end_date]) )
		)
	{
		retValue=YES;
	}
	
	NSLog(@"MKGeCardUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);
	
	return retValue;
}

+ (void)showeCard
{
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfMKGeCard_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfMKGeCard_e];
    }
    [[UIApplication sharedApplication] openURL:url];
    return;
}

@end
