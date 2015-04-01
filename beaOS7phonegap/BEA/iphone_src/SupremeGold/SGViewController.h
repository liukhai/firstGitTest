//
//  SGViewController.h
//  BEA
//
//  Created by Ledp944 on 14-9-3.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "MBKUtil.h"
#import "MigrationSetting.h"
#import "SecuredCachedImageView.h"
#import "PlistOperator.h"
#import "HomeViewController.h"
#import "EMailViewController.h"
#import "SupremeGoldApplicationViewController.h"
#import "TaxLoanCalculatorViewController.h"
#import "SupremeGoldViewController.h"
#import "SupremeGoldMenuViewController.h"

@class MaskViewController;
@class SecuredCachedImageView;

@interface SGViewController : UIViewController
<UINavigationControllerDelegate,
UITabBarDelegate,
UIAlertViewDelegate,
UINavigationBarDelegate,
UIWebViewDelegate,
RotateMenuDelegate2>
{
	MaskViewController *mask;
	EMailViewController *email;
    //	UINavigationController *navigationController;
	UITabBar *tabBar;
    //UIImageView *banner;
    //SecuredCachedImageView *banner;
	UIWebView *banner;
    BOOL should_pop;
    SupremeGoldMenuViewController* menuVC;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) SupremeGoldMenuViewController* menuVC;
-(void)goMain;
//-(void) selectTabBarMatchedCurrentView;
//-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;
-(void) welcome;

@end
