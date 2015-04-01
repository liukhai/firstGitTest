//
//  HotlineViewController.h
//  BEA
//
//  Created by yelong on 3/1/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"

@interface HotlineViewController : UIViewController
<UINavigationControllerDelegate,
UITabBarDelegate,
UIAlertViewDelegate,
UINavigationBarDelegate,
MFMailComposeViewControllerDelegate,
ASIHTTPRequestDelegate,
RotateMenuDelegate2>
{
	UINavigationController *navigationController;
	UITabBar *tabBar;
	NSString *ns_service;
    
}


@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) NSString *ns_service;//added by jasen at 20110311

-(void)welcome;
-(void)checkMBKRegStatus;//added by jasen at 20110311
-(void)goMainFaster;

@end
