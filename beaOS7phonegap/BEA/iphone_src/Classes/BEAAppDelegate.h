//
//  BEAAppDelegate.h
//  BEA
//
//  Created by Algebra Lo on 10年6月25日.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CoreData.h"
#import "BEADelightViewController.h"
#import "ATMLocationViewController.h"
//#import "TVOutManager.h"

@class BEAViewController;

@interface BEAAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigationController;
	BOOL got_new_request;
    IBOutlet UIScrollView* menu_view;
//    BOOL notification_onOroff; //true == on
    UIView *hiddenView;
    NSDate *enterBackground;
    NSDate *enterForeground;
    int alert_action;
    AccProListViewController* plistvc1;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property BOOL isClick;
@property (nonatomic,retain) NSDate *enterBackground;
@property (nonatomic,retain) NSDate *enterForeground;
//@property BOOL notification_onOroff;
@property BOOL openSideMenu;
@property BOOL openProperty;
@property BOOL openImportant;


-(void)readToSetup;
- (void)registerFirstNotification;

@end

