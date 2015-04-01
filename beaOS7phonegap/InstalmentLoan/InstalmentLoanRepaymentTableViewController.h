//
//  InstalmentLoanRepaymentTableViewController.h
//  BEA
//
//  Created by NEO on 01/12/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "LTUtil.h"
#import "LTOffersViewController.h"

@interface InstalmentLoanRepaymentTableViewController : UIViewController {
	IBOutlet UILabel *lbTitle, *lbText3;
	IBOutlet UIButton *btLoanOffers, *btTNC, *btCall;//, *btGeneralCustomers, *btPrivilegedCustomers;
	
	IBOutlet UIWebView *webView;
}

@property(nonatomic, retain) UIWebView *webView;

-(IBAction)btLoanHightlightsPressed;
-(IBAction)btTNCPressed;
-(IBAction)call;

//-(IBAction)btGeneralCustomersPressed;
//-(IBAction)btPrivilegedCustomersPressed;

@end
