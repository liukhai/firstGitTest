//
//  TaxLoanOffersViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
//#import "TaxLoanRepaymentTableViewController.h"
#import "TaxLoanTNCViewController.h"

@interface TaxLoanOffersViewController : UIViewController<UIWebViewDelegate>{
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;
	
	IBOutlet UIButton  *btTNC, *btCall;

}
@property(nonatomic, retain) UIWebView *webView;

//-(IBAction) btInterestRatePressed;
-(IBAction) btTNCPressed;
- (void)goHome;
-(IBAction) call;

@end
