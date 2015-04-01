//
//  BEADelightViewController.h
//  BEA
//
//  Created by Algebra Lo on 10年6月25日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "PlistOperator.h"
#import "HomeViewController.h"
#import "EMailViewController.h"
#import "RotateMenuUtil.h"

@class MaskViewController;
@class ECouponViewController;
@interface BEADelightViewController : UIViewController
<UINavigationControllerDelegate,
UITabBarDelegate,
UIAlertViewDelegate,
UINavigationBarDelegate,
RotateMenuDelegate2>
{
	MaskViewController *mask;
	ECouponViewController *ecoupon;
	EMailViewController *email;
//	UINavigationController *navigationController;
	UITabBar *tabBar;
	UIImageView *banner;
	BOOL should_pop;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
-(void)goMainFaster;

@end
