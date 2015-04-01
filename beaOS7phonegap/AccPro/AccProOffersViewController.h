//
//  AccProOffersViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
//#import "AccProRepaymentTableViewController.h"
//#import "AccProTNCViewController.h"

@interface AccProOffersViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;
    NSString *latestpromoUrl;
    NSString *latestpromoHotline;
    NSString *buttonLabel;
//    IBOutlet UIWebView *callwebView;
    IBOutlet UIButton *callButton;


}
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) NSString *latestpromoUrl;
@property(nonatomic, retain) NSString *latestpromoHotline;
@property(nonatomic, retain) NSString *buttonLabel;
//@property(nonatomic, retain) UIWebView *callwebView;

//-(IBAction) btInterestRatePressed;
- (IBAction) call;
- (void)goHome;
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil latestpromoUrl:(NSString *) url latestpromoHotline:(NSString *) hotline btnLabel:(NSString*)btnLabel;
@end
