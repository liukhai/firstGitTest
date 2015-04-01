//
//  ATMLocationViewController.h
//  BEA
//
//  Created by Algebra Lo on 10年6月25日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "PlistOperator.h"
#import "HttpRequestUtils.h"
#import "RotateMenuUtil.h"

@interface ATMLocationViewController : UIViewController
<UINavigationControllerDelegate,
UITabBarDelegate,
UIAlertViewDelegate,
UINavigationBarDelegate,
MFMailComposeViewControllerDelegate,
ASIHTTPRequestDelegate,
RotateMenuDelegate2>
{
	MaskViewController *mask;
	UINavigationController *navigationController;
	UITabBar *tabBar;
    NSString* request_type;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, assign) int menuIndex;

-(void)goMain;
-(void)welcome;
-(void)welcomeToindex:(int) index;
- (void) checkATMListDelta:(NSData*)datas;
//-(void)stepone;
-(void)goMainFaster;

@end
