//
//  LTApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/15/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "PlistOperator.h"
#import "HomeViewController.h"
#import "EMailViewController.h"
#import "LTApplicationViewController.h"
#import "LTCalculatorViewController.h"
#import "LTEnquiryViewController.h"

@class MaskViewController;

@interface LTViewController : UIViewController <UINavigationControllerDelegate, UITabBarDelegate, UIAlertViewDelegate, UINavigationBarDelegate> {
	MaskViewController *mask;
	EMailViewController *email;
	UINavigationController *navigationController;
	UITabBar *tabBar;
	UIImageView *banner;
	BOOL should_pop;
    NSString* frompage;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) NSString* frompage;

-(void)goHome;
-(void) welcome;
-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;
@end
