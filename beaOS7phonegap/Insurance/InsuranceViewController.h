//
//  Created by NEO on 03/01/12.
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
#import "InsuranceApplicationViewController.h"
#import "InsuranceUtil.h"


@class MaskViewController;
@class SecuredCachedImageView;
@class InsuranceMenuViewController;

@interface InsuranceViewController : UIViewController
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
    InsuranceMenuViewController* menuVC;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) InsuranceMenuViewController* menuVC;
-(void)goMain;
//-(void) selectTabBarMatchedCurrentView;
//-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;
-(void) welcome;

@end
