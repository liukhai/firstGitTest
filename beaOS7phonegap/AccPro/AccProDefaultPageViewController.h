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

@interface AccProDefaultPageViewController : UIViewController <UIWebViewDelegate>{
	IBOutlet UIWebView *webView;
    IBOutlet UIWebView *topwebView;
    IBOutlet UIWebView *callwebView;
	
	IBOutlet UILabel *lbTitle,*lbReward,*lbSimulator;
    IBOutlet UITextField *tfSalary;
    IBOutlet UIScrollView *scroll_view;
    IBOutlet UIView *contentView;
    IBOutlet UISlider *sl_salary;
    NSNumberFormatter *numberFormatter;
    NSNumberFormatter *numberFormatter2;
    UIButton *queryButton1;
}
@property(nonatomic, retain) UILabel *lbTitle,*lbReward,*lbSimulator;
@property(nonatomic, retain) UIButton *queryButton1;
@property(nonatomic, retain) UIView *contentView;
@property(nonatomic, retain) IBOutlet UIScrollView *scroll_view;
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) UIWebView *topwebView;
@property(nonatomic, retain) UIWebView *callwebView;
@property(nonatomic, retain) NSNumberFormatter *numberFormatter;
@property(nonatomic, retain) NSNumberFormatter *numberFormatter2;
@property(nonatomic, retain) UITextField *tfSalary;

//-(IBAction) btInterestRatePressed;

-(IBAction) changeSliders:(UISlider *) slider;
-(void)queryFromKeypad:(UIButton *) btnQuery;
-(void)updateRewardBySalary;
-(IBAction)screenPressed;
- (void)goHome;

@end
