//
//  TaxLoanApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/15/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "TaxLoanOffersViewController.h"
//#import "TaxLoanRepaymentTableViewController.h"

@interface TaxLoanHomeViewController : UIViewController <UIWebViewDelegate> {
	IBOutlet UIButton *back_to_home;
	IBOutlet UIButton *bt_offers, *bt_application, *bt_callnow, *bt_nearby;
	IBOutlet UILabel *label0, *label1, *label2, *label3;
    UITabBar *tabBar;
}

@property (nonatomic, retain) IBOutlet UITabBar *tabBar;

-(IBAction)buttonPressed:(UIButton *)button;
-(IBAction)backToHomePressed:(UIButton *)button;

@end
