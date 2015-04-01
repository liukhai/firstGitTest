//
//  LTApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/15/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "LTOffersViewController.h"
#import "LTRepaymentTableViewController.h"
#import "LTApplicationViewController.h"
#import "LTCalculatorViewController.h"

@interface LTHomeViewController : UIViewController {
	IBOutlet UIButton *back_to_home;
	IBOutlet UIButton *button0, *button1, *button2, *button3;
	IBOutlet UILabel *label0, *label1, *label2, *label3;
}

-(IBAction)buttonPressed:(UIButton *)button;
-(IBAction)backToHomePressed:(UIButton *)button;

@end
