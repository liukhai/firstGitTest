//
//  BEA_SurpriseAppDelegate.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月12日.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CoreData.h"
#import "CachedImageView.h"
#import "PlistOperator.h"
#import "HomeViewController.h"
#import "EMailViewController.h"

@interface BEA_SurpriseAppDelegate : NSObject <UIApplicationDelegate, UINavigationControllerDelegate, UITabBarDelegate, UIAlertViewDelegate> {
    
    UIWindow *window;
	MaskViewController *mask;
	ECouponViewController *ecoupon;
	EMailViewController *email;
    UINavigationController *navigationController;
	UITabBar *tabBar;
	UIImageView *banner;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;

@end

