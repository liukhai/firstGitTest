//added by Jasen on 20120821

#import <Foundation/Foundation.h>
#import "CoreData.h"

@interface MPFRateUtil : NSObject
<ASIHTTPRequestDelegate>
{
	NSOperationQueue *queue;
}

+ (MPFRateUtil*) me;
@property (nonatomic, retain) NSOperationQueue *queue;

-(void) sendRequestMPFRate:(NSString*) function;

@end
