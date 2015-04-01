//
//  MKGeCardViewController.h
//  BEA
//
//  Created by NEO on 11/07/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface MKGeCardViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
    UILabel *lbTitle;
}

@property(nonatomic, retain) UIWebView *webView;

//-(void) btInterestRatePressed;
- (void)goHome;
@end
