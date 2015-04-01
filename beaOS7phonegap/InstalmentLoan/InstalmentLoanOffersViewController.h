//
//  InstalmentLoanOffersViewController.h
//  BEA
//
//  Created by NEO on 01/12/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "InstalmentLoanRepaymentTableViewController.h"
#import "InstalmentLoanTNCViewController.h"

@interface InstalmentLoanOffersViewController : UIViewController {
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;
	
	IBOutlet UIButton *btRepaymentTalbe, *btTNC, *btCall;

}
@property(nonatomic, retain) UIWebView *webView;

-(IBAction) btInterestRatePressed;
-(IBAction) btTNCPressed;
-(IBAction) call;

@end
