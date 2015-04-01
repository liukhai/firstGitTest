//
//  LTRepaymentTableViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "LTUtil.h"
#import "LTOffersViewController.h"

@interface LTRepaymentTableViewController : UIViewController {
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
