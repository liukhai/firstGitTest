//
//  AccProWebViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//
//  Amended by Jasen on 201210

#import <UIKit/UIKit.h>
#import "CoreData.h"
//#import "AccProRepaymentTableViewController.h"
//#import "AccProTNCViewController.h"

@interface AccProWebViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;
    NSString *latestpromoUrl;
    NSString *latestpromoHotline;
    NSString *buttonLabel;
//    IBOutlet UIWebView *callwebView;
//    IBOutlet UIButton *callButton;
    NSString *level;

}
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) NSString *latestpromoUrl;
@property(nonatomic, retain) NSString *latestpromoHotline;
@property(nonatomic, retain) NSString *buttonLabel;
//@property(nonatomic, retain) UIWebView *callwebView;
@property(nonatomic, retain) NSString *level;

//-(IBAction) btInterestRatePressed;
//- (IBAction) call;
- (void)goHome;
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil latestpromoUrl:(NSString *) url latestpromoHotline:(NSString *) hotline btnLabel:(NSString*)btnLabel;
@end
