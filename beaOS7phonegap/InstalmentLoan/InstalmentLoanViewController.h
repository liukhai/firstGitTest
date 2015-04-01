//
//  TaxLoanApplicationViewController.h
//  BEA
//
//  Created by NEO on 01/12/12.
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
#import "InstalmentLoanOffersViewController.h"
#import "InstalmentLoanRepaymentTableViewController.h"
#import "InstalmentLoanCalculatorViewController.h"
#import "InstalmentLoanTNCViewController.h"

@class MaskViewController;
@class SecuredCachedImageView;
@interface InstalmentLoanViewController : UIViewController <UINavigationControllerDelegate, UITabBarDelegate, UIAlertViewDelegate, UINavigationBarDelegate, UIWebViewDelegate> {
	MaskViewController *mask;
	EMailViewController *email;
	UINavigationController *navigationController;
	UITabBar *tabBar;
    //UIImageView *banner;
    //SecuredCachedImageView *banner;
	UIWebView *banner;
    BOOL should_pop;
    NSString* frompage;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) NSString* frompage;

-(void)goHome;
//-(void) selectTabBarMatchedCurrentView;
-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;
-(void) welcome;

@end
