//
//  InstalmentLoanCalculatorViewController.h
//  BEA
//
//  Created by NEO on 01/12/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstalmentLoanCalculatorViewController : UIViewController {
	double lf_loanAmount;
	double lf_ArrangementFee;
	double lf_IntRatePerMonthFlat;
	double lf_APR;
	double lf_month;
	double lf_MonthlyRepayment;
	double lf_TotalRepayment;
	double lf_roundupadjust;
	
	IBOutlet UITextField *tfLoanAmount;
	IBOutlet UISlider *slLoanAmount;
	IBOutlet UIButton *btRepaymentPeriod12, *btRepaymentPeriod24;
	IBOutlet UIButton *btRepaymentPeriod36, *btRepaymentPeriod48;
//	IBOutlet UIButton *btLoanPlanGeneralCustomers, *btLoanPlanProfessionals, *btRepaymentPeriod12, *btRepaymentPeriod24;
	IBOutlet UILabel *lbIntRatePerMonthFlat, *lbAPR, *lbTotalRepayment, *lbMonthlyRepayment;//, *lbArrangementFee;
	
	IBOutlet UILabel *lbTitle;
	
	IBOutlet UIButton *btReset, *btCall;

	IBOutlet UILabel *lbTag00, *lbTag01, *lbTag02, *lbTag03, *lbTag04, *lbTag05, *lbTag06, *lbTag07;//, *lbTag08;

	NSNumberFormatter *numberFormatter;
}

@property(nonatomic, retain) NSNumberFormatter *numberFormatter;

-(IBAction)call;
-(IBAction)reset;

//-(IBAction)btLoanPlanGeneralCustomersPressed;
//-(IBAction)btLoanPlanProfessionalsPressed;
-(IBAction)btRepaymentPeriod12Pressed;
-(IBAction)btRepaymentPeriod24Pressed;

-(IBAction)btRepaymentPeriod36Pressed;
-(IBAction)btRepaymentPeriod48Pressed;

-(IBAction)slLoanAmountValueChanged;

-(IBAction)screenPressed;

-(IBAction)setAmount;

-(void)selfInputAmount;

-(void)updateValue;

@end
