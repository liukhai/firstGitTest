//
//  PropertyLoanCalculatorViewController.h
//  BEA
//
//  Created by YAO JASEN on 28/02/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyLoanUtil.h"

@interface PropertyLoanCalculatorViewController : UIViewController {
	
	IBOutlet UIScrollView *scroll_view;
    IBOutlet UITextField *tf_purchasePrice, *tf_mortgageRatio, *tf_loanAmount,*tf_interestRate, *tf_loanTenor;
    IBOutlet UILabel *tf_purchasePrice_label;
    IBOutlet UILabel *tf_mortagageRatio_label;
    IBOutlet UILabel *tf_loanAmount_label;
    IBOutlet UILabel *tf_interestRate_label;
    IBOutlet UILabel *tf_loanTenor_label;
	IBOutlet UISlider *sl_mortgageRatio, *sl_interestRate, *sl_loanTenor;
	IBOutlet UIButton *bt_mortgage,*bt_loanAmount,*btReset, *btCall;
	IBOutlet UILabel *lbTitle, *lb_calcTitle,*lb_purchasePrice,*lb_mortgageRatio,*lb_loanAmount,*lb_interestRate, *lb_loanTenor, *lb_repayment, *lb_monthRay;
    IBOutlet UIImageView *lbTitleBackImg;
    NSNumberFormatter *numberFormatter;
    NSNumberFormatter *numberFormatter2;
    NSNumberFormatter *numberFormatter3;
    IBOutlet UIImageView *borderImageView;
}

@property(nonatomic, retain) NSNumberFormatter *numberFormatter;
@property(nonatomic, retain) NSNumberFormatter *numberFormatter2;
@property(nonatomic, retain) NSNumberFormatter *numberFormatter3;

-(IBAction) call;
-(IBAction) reset;
-(IBAction) clickLoanAmountButton;
-(IBAction) clickMortgageButton;

-(IBAction) changeSliders:(UISlider *) slider;

-(void) showMonthlyRepay;
-(IBAction)screenPressed;
-(float) getValidValue:(UITextField *) textField;
@end
