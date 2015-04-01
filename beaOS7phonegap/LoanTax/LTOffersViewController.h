//
//  LTOffersViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "LTRepaymentTableViewController.h"
#import "LTTNCViewController.h"

@interface LTOffersViewController : UIViewController {
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;
	
	IBOutlet UIButton *btRepaymentTalbe, *btTNC, *btCall;

}
@property(nonatomic, retain) UIWebView *webView;

-(IBAction) btInterestRatePressed;
-(IBAction) btTNCPressed;
-(IBAction) call;

@end
