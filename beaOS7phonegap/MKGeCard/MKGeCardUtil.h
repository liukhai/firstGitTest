#import <Foundation/Foundation.h>
#import "MKGeCardViewController.h"

@interface MKGeCardUtil : NSObject <ASIHTTPRequestDelegate>{
    MKGeCardViewController *MKGeCardViewController;
}
@property (nonatomic, retain) MKGeCardViewController *MKGeCardViewController;

+ (MKGeCardUtil *)me;
+ (BOOL) isValidUtil;
+ (void)showeCard;

@end
