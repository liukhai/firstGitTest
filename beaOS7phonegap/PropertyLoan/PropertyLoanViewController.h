//
//  PropertyLoanApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 28/02/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
//#import "CachedImageView.h"
#import "MBKUtil.h"
#import "PlistOperator.h"
#import "HomeViewController.h"
#import "EMailViewController.h"
#import "PropertyLoanCalculatorViewController.h"
#import "PropertyLoanEnquiryViewController.h"
#import "ATMNearBySearchListViewController.h"
#import "PropertyLoanMenuViewController.h"
#import "SecuredCachedImageView.h"

@class MaskViewController;
@class SecuredCachedImageView;
@class PropertyLoanMenuViewController;

@interface PropertyLoanViewController : UIViewController <UINavigationControllerDelegate, UITabBarDelegate, UIAlertViewDelegate, UINavigationBarDelegate,RotateMenuDelegate2> {
//	UINavigationController *navigationController;
	UITabBar *tabBar;
//	UIImageView *banner;
    int tabIndex;
    BOOL should_pop;
    PropertyLoanMenuViewController* menuVC;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
//@property (retain, nonatomic) IBOutlet UIImageView *navigationImage;
//@property (retain, nonatomic) IBOutlet UIButton *backBtn;
//@property (retain, nonatomic) IBOutlet UIView *backgroundView;
@property (nonatomic, retain) PropertyLoanMenuViewController* menuVC;

-(void)goMain;
-(void)welcome;
//-(void) selectTabBarMatchedCurrentView;
//-(void)setTexts;
//- (IBAction)backBtnClick:(id)sender;

@end
