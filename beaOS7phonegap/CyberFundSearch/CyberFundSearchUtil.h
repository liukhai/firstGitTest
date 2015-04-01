//  Amended by yaojzy on 3/7/12.

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "CyberFundSearchViewController.h"
#import "CyberFundSearchImportantNoticeViewController.h"

@class CyberFundSearchImportantNoticeViewController;
@class CyberFundSearchViewController;

@interface CyberFundSearchUtil : NSObject <UIWebViewDelegate, ASIHTTPRequestDelegate>
{
    CyberFundSearchImportantNoticeViewController* _CyberFundSearchImportantNoticeViewController;
    CyberFundSearchViewController *CyberFundSearch_view_controller;
    NSString *serviceFlag;
}

@property(nonatomic, retain) CyberFundSearchImportantNoticeViewController* _CyberFundSearchImportantNoticeViewController;
@property (nonatomic, retain) CyberFundSearchViewController *CyberFundSearch_view_controller;
@property (nonatomic, retain) NSString *serviceFlag;
+ (CyberFundSearchUtil*) me;

+ (BOOL) isValidUtil;

-(void)alertAndBackToMain;
-(void)alertAndBackToMain:(UIViewController*)outViewController;

- (void)goHome;

@end
