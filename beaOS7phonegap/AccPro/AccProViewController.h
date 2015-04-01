//
//  Created by NEO on 06/16/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "AccProUtil.h"
#import "AccProDefaultPageViewController.h"
#import "AccProApplicationViewController.h"
#import "AccProOffersViewController.h"
#import "AccProListViewController.h"
#import "RotateMenuUtil.h"
#import "AccProMenuViewController.h"
@class AccProListViewController;
@class AccProMenuViewController;
@interface AccProViewController : UIViewController
<UINavigationControllerDelegate,
UITabBarDelegate,
UINavigationBarDelegate,
RotateMenuDelegate2>
{
//	UINavigationController *navigationController;
	UITabBar *tabBar;
    AccProListViewController* _AccProListViewController;
    AccProMenuViewController* menuVC;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) AccProListViewController* _AccProListViewController;
@property (nonatomic, retain) AccProMenuViewController* menuVC;
-(void)goHome;
-(void) selectTabBarMatchedCurrentView;
-(void) welcome;
-(void) showWelcomeOffer;
-(void)goHome2;

@end
