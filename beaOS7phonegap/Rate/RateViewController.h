#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "RateUtil.h"
#import "RateNoteViewController.h"
#import "RateTTViewController.h"
#import "RatePrimeViewController.h"

#import "RateMenuViewController.h"

@class RateMenuViewController;

//  Created by NEO on 06/16/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//
@interface RateViewController : UIViewController
<UINavigationControllerDelegate,
UITabBarDelegate,
UINavigationBarDelegate,
RotateMenuDelegate2>
{
//	UINavigationController *navigationController;
	UITabBar *tabBar;

    RateMenuViewController* menuVC;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;

@property (nonatomic, retain) RateMenuViewController* menuVC;

-(void)goMainFaster;
-(void)goMain;
-(void) selectTabBarMatchedCurrentView;
-(void) welcome;
-(void) welcome:(int)tag;

@end
