//
//  TaxLoanApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/15/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "MBKUtil.h"
#import "MigrationSetting.h"
#import "SecuredCachedImageView.h"
#import "PlistOperator.h"
#import "HomeViewController.h"
#import "EMailViewController.h"
#import "TaxLoanApplicationViewController.h"
#import "TaxLoanCalculatorViewController.h"
#import "TaxLoanEnquiryViewController.h"
#import "ConsumerLoanMenuViewController.h"

@class MaskViewController;
@class SecuredCachedImageView;
@class ConsumerLoanMenuViewController;

@interface TaxLoanViewController : UIViewController
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
    ConsumerLoanMenuViewController* menuVC;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) ConsumerLoanMenuViewController* menuVC;
-(void)goMain;
//-(void) selectTabBarMatchedCurrentView;
//-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;
-(void) welcome;

@end
