//
//  SGGPIViewController.h
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface SGGPIViewController : UIViewController <UIWebViewDelegate, UITabBarDelegate, MFMailComposeViewControllerDelegate> {
	IBOutlet UIWebView *webView;
    UILabel *lbTitle;
	IBOutlet UITabBar *tabBar;
    NSString *serverFlag;
}

@property(nonatomic, retain) UIWebView *webView;

//-(void) btInterestRatePressed;
- (void)goHome;
@end
