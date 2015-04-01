//added by Jasen on 20120821

#import "MPFRateUtil.h"

@implementation MPFRateUtil

@synthesize queue;

+ (MPFRateUtil *)me
{
	static MPFRateUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[MPFRateUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"MPFRateUtil init");
    self = [super init];
    if (self) {
        self.queue = [[NSOperationQueue alloc] init];
		[self.queue setMaxConcurrentOperationCount:4];
    }
    
    return self;
}

-(void) sendRequestMPFRate:(NSString*) function
{
    NSLog(@"MPFRateUtil: sendRequestMPFRate=========:%@", function);
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForMPFRate:self function:function];
    [self.queue addOperation:request];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"MPFRateUtil: request finish=============:%@", [NSString stringWithFormat:@"%@", [request responseString]]);
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"MPFRateUtil: request requestFailed======:%@", request.error);
}

@end
