//
//  LTCalculatorViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTUtil.h"

@interface LTCalculatorViewController : UIViewController {
	double lf_loanAmount;
	double lf_ArrangementFee;
	double lf_IntRatePerMonthFlat;
	double lf_APR;
	double lf_month;
	double lf_MonthlyRepayment;
	double lf_TotalRepayment;
	double lf_roundupadjust;
	IBOutlet UIScrollView *scroll_view;
	IBOutlet UITextField *tfLoanAmount;
	IBOutlet UISlider *slLoanAmount;
	IBOutlet UIButton *btRepaymentPeriod12, *btRepaymentPeriod18;
	IBOutlet UIButton *btLoanPlanGeneralCustomers, *btLoanPlanProfessionals;
	IBOutlet UILabel *lbIntRatePerMonthFlat, *lbAPR, *lbTotalRepayment, *lbMonthlyRepayment, *remark;//, *lbArrangementFee;
    IBOutlet UIView *contentView;
	IBOutlet UILabel *lbTitle;
	
	IBOutlet UIButton *btReset, *btCall;

	IBOutlet UILabel *lbTag00, *lbTag01, *lbTag02, *lbTag03, *lbTag04, *lbTag05, *lbTag06, *lbTag07;//, *lbTag08;
 

	NSNumberFormatter *numberFormatter;
}
@property(nonatomic, retain) UIView *contentView;
@property(nonatomic, retain) NSNumberFormatter *numberFormatter;
@property(nonatomic, retain) IBOutlet UIScrollView *scroll_view;
-(IBAction)call;
-(IBAction)reset;

-(IBAction)btLoanPlanGeneralCustomersPressed;
-(IBAction)btLoanPlanProfessionalsPressed;
-(IBAction)btRepaymentPeriod12Pressed;
-(IBAction)btRepaymentPeriod18Pressed;

-(IBAction)slLoanAmountValueChanged;

-(IBAction)screenPressed;

-(IBAction)setAmount;

-(void)selfInputAmount;
-(void)updateValue;
-(void)queryFromKeypad:(UIButton *) btnQuery;
@end
