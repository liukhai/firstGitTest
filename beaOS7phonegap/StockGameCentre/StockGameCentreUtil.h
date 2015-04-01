//  Amended by yaojzy on 201309.

#import <Foundation/Foundation.h>
#import "StockGameCentreViewController.h"

@interface StockGameCentreUtil : NSObject <ASIHTTPRequestDelegate>{
    StockGameCentreViewController *stockGameCentreViewController;
    NSMutableArray *items_data;
	NSArray *key, *key_sub;
    NSString *currentElementName;
    NSMutableDictionary *temp_record;
    NSString* onoff;
    NSString* url;
}

@property (nonatomic, retain) StockGameCentreViewController *stockGameCentreViewController;

+ (StockGameCentreUtil *)me;
+ (BOOL) isValidUtil;
-(void)requestAPIDatas;
- (BOOL) isGameOn;
- (NSString*) getGameURL;

@end
