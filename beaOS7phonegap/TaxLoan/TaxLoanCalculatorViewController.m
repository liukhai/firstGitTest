//
//  TaxLoanCalculatorViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "TaxLoanCalculatorViewController.h"


@implementation TaxLoanCalculatorViewController

@synthesize numberFormatter;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);

	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
//	[numberFormatter setFormat:@"0.00;0.00;-0.00"];
	
	/*	[btLoanPlanGeneralCustomers setTitle:NSLocalizedString(@"General Customers", nil) forState:UIControlStateNormal];
	 btLoanPlanGeneralCustomers.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	 btLoanPlanGeneralCustomers.titleLabel.numberOfLines = 2;
	 btLoanPlanGeneralCustomers.titleLabel.textAlignment = NSTextAlignmentCenter;
	 btLoanPlanGeneralCustomers.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	 btLoanPlanGeneralCustomers.titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	 btLoanPlanGeneralCustomers.selected = YES;
	 
	 [btLoanPlanProfessionals setTitle:NSLocalizedString(@"Privileged Customers", nil) forState:UIControlStateNormal];
	 btLoanPlanProfessionals.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	 btLoanPlanProfessionals.titleLabel.numberOfLines = 2;
	 btLoanPlanProfessionals.titleLabel.textAlignment = NSTextAlignmentCenter;
	 btLoanPlanProfessionals.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	 btLoanPlanProfessionals.titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	 btLoanPlanProfessionals.selected = NO;
	 */	
	[btRepaymentPeriod12 setTitle:NSLocalizedString(@"12 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod12.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod12.selected = YES;
	
	[btRepaymentPeriod24 setTitle:NSLocalizedString(@"24 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod24.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod24.selected = NO;
	
	[btRepaymentPeriod36 setTitle:NSLocalizedString(@"36 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod36.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod36.selected = NO;
	
	[btRepaymentPeriod48 setTitle:NSLocalizedString(@"48 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod48.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod48.selected = NO;
	
	[btReset setTitle:NSLocalizedString(@"Reset", nil) forState:UIControlStateNormal];
	[btCall setTitle:NSLocalizedString(@"Apply", nil) forState:UIControlStateNormal];
	
	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"Tax Loan",nil), NSLocalizedString(@"Calculator",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	
	lbTag00.text = NSLocalizedString(@"TaxLoanCalcTag00",nil);
	lbTag01.text = NSLocalizedString(@"Loan amount (HK$):",nil);
	lbTag02.text = NSLocalizedString(@"Loan plan:",nil);
	lbTag03.text = NSLocalizedString(@"Repayment Period:",nil);
	lbTag04.text = NSLocalizedString(@"TaxLoanCalcTag04",nil);
	lbTag05.text = NSLocalizedString(@"APR:",nil);
	lbTag06.text = NSLocalizedString(@"TaxLoanCalcTag06",nil);
	lbTag06.numberOfLines=2;
	lbTag06.textAlignment = NSTextAlignmentLeft;
	lbTag06.lineBreakMode = NSLineBreakByWordWrapping;
	lbTag07.text = NSLocalizedString(@"TaxLoanCalcTag07",nil);
	lbTag07.numberOfLines=2;
	lbTag07.textAlignment = NSTextAlignmentLeft;
	lbTag07.lineBreakMode = NSLineBreakByWordWrapping;
	//	lbTag08.text = NSLocalizedString(@"TaxLoanCalcTag08",nil);
	
	[self reset];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[numberFormatter release];
}

-(IBAction)call{
	[[TaxLoanUtil new] callToApply];
}

-(void)calc{
	
	lf_loanAmount = slLoanAmount.value;
	
	lf_roundupadjust = 0.004999;
	
	if (btRepaymentPeriod12.selected) {
		lf_month = 12.0;
		lf_ArrangementFee = 1;
	}else if (btRepaymentPeriod24.selected) {
		lf_month = 24.0;
		lf_ArrangementFee = 1;
	}else if (btRepaymentPeriod36.selected) {
		lf_month = 36.0;
		lf_ArrangementFee = 1;
	}else if (btRepaymentPeriod48.selected) {
		lf_month = 48.0;
		lf_ArrangementFee = 1;
	}
	
	//	if (btLoanPlanGeneralCustomers.selected) {
	if (lf_loanAmount>=5000 && lf_loanAmount<20000) {
		lf_IntRatePerMonthFlat = 0.006012;
		if (btRepaymentPeriod12.selected) {
			lf_APR = 0.1188;
		}else if (btRepaymentPeriod24.selected){
			lf_APR = 0.1298;
		}else if (btRepaymentPeriod36.selected){
			lf_APR = 0.1321;
		}else if (btRepaymentPeriod48.selected){
			lf_APR = 0.1322;
		}
	}else if (lf_loanAmount>=20000 && lf_loanAmount<50000) {
		lf_IntRatePerMonthFlat = 0.004012;
		if (btRepaymentPeriod12.selected) {
			lf_APR = 0.0785;
		}else if (btRepaymentPeriod24.selected){
			lf_APR = 0.0862;
		}else if (btRepaymentPeriod36.selected){
			lf_APR = 0.0884;
		}else if (btRepaymentPeriod48.selected){
			lf_APR = 0.0889;
		}
	}else if (lf_loanAmount>=50000 && lf_loanAmount<100000) {
		lf_IntRatePerMonthFlat = 0.002913;
		if (btRepaymentPeriod12.selected) {
			lf_APR = 0.0567;
		}else if (btRepaymentPeriod24.selected){
			lf_APR = 0.0625;
		}else if (btRepaymentPeriod36.selected){
			lf_APR = 0.0642;
		}else if (btRepaymentPeriod48.selected){
			lf_APR = 0.0648;
		}
	}else if (lf_loanAmount>=100000 && lf_loanAmount<200000) {
		lf_IntRatePerMonthFlat = 0.002807;
		if (btRepaymentPeriod12.selected) {
			lf_APR = 0.0546;
		}else if (btRepaymentPeriod24.selected){
			lf_APR = 0.0602;
		}else if (btRepaymentPeriod36.selected){
			lf_APR = 0.0619;
		}else if (btRepaymentPeriod48.selected){
			lf_APR = 0.0625;
		}
	}else if (lf_loanAmount>=200000 && lf_loanAmount<450000) {
		lf_IntRatePerMonthFlat = 0.002319;
		if (btRepaymentPeriod12.selected) {
			lf_APR = 0.0450;
		}else if (btRepaymentPeriod24.selected){
			lf_APR = 0.0497;
		}else if (btRepaymentPeriod36.selected){
			lf_APR = 0.0512;
		}else if (btRepaymentPeriod48.selected){
			lf_APR = 0.0518;
		}
	}else if (lf_loanAmount>=450000 && lf_loanAmount<700000) {
		lf_IntRatePerMonthFlat = 0.001927;
		if (btRepaymentPeriod12.selected) {
			lf_APR = 0.0373;
		}else if (btRepaymentPeriod24.selected){
			lf_APR = 0.0413;
		}else if (btRepaymentPeriod36.selected){
			lf_APR = 0.0426;
		}else if (btRepaymentPeriod48.selected){
			lf_APR = 0.0431;
		}
	}else if (lf_loanAmount>=700000 && lf_loanAmount<1000001) {
		lf_IntRatePerMonthFlat = 0.001696;
		if (btRepaymentPeriod12.selected) {
			lf_APR = 0.0328;
		}else if (btRepaymentPeriod24.selected){
			lf_APR = 0.0363;
		}else if (btRepaymentPeriod36.selected){
			lf_APR = 0.0375;
		}else if (btRepaymentPeriod48.selected){
			lf_APR = 0.0380;
		}
	}
	/*	}else {
	 if (lf_loanAmount>=5000 && lf_loanAmount<50000) {
	 lf_IntRatePerMonthFlat = 0.002217;
	 if (btRepaymentPeriod12.selected) {
	 lf_APR = 0.0499;
	 }else {
	 lf_APR = 0.0712;
	 }
	 }else if (lf_loanAmount>=50000 && lf_loanAmount<100000) {
	 lf_IntRatePerMonthFlat = 0.001734;
	 if (btRepaymentPeriod12.selected) {
	 lf_APR = 0.0389;
	 }else {
	 lf_APR = 0.0597;
	 }
	 }else if (lf_loanAmount>=100000 && lf_loanAmount<200000) {
	 lf_IntRatePerMonthFlat = 0.001531;
	 if (btRepaymentPeriod12.selected) {
	 lf_APR = 0.0343;
	 }else {
	 lf_APR = 0.0549;
	 }
	 }else if (lf_loanAmount>=200000 && lf_loanAmount<400000) {
	 lf_IntRatePerMonthFlat = 0.001376;
	 if (btRepaymentPeriod12.selected) {
	 lf_APR = 0.0308;
	 }else {
	 lf_APR = 0.0513;
	 }
	 }else if (lf_loanAmount>=400000 && lf_loanAmount<700000) {
	 lf_IntRatePerMonthFlat = 0.001109;
	 if (btRepaymentPeriod12.selected) {
	 lf_APR = 0.0248;
	 }else {
	 lf_APR = 0.045;
	 }
	 }else if (lf_loanAmount>=700000 && lf_loanAmount<1000001) {
	 lf_IntRatePerMonthFlat = 0.00102;
	 if (btRepaymentPeriod12.selected) {
	 lf_APR = 0.0228;
	 }else {
	 lf_APR = 0.0429;
	 }
	 }
	 }
	 */	
	//	lf_MonthlyRepayment = ((lf_loanAmount*(1+lf_ArrangementFee)) / lf_month) + ((lf_loanAmount*(1+lf_ArrangementFee)) * lf_IntRatePerMonthFlat);
	//	lf_TotalRepayment = lf_MonthlyRepayment * lf_month;
	
	
	lf_TotalRepayment = ((lf_loanAmount*lf_ArrangementFee) + (lf_loanAmount*lf_ArrangementFee) * lf_IntRatePerMonthFlat * lf_month);
	//	NSLog (@"lf_TotalRepayment.beforeadjust:%f", lf_TotalRepayment);
	lf_MonthlyRepayment = (lf_TotalRepayment / lf_month)-lf_roundupadjust;
	//	NSLog (@"lf_MonthlyRepayment.afteradjust:%f", lf_TotalRepayment);
	//	NSLog (@"lf_TotalRepayment.beforeadjust:%f", lf_TotalRepayment);
	lf_TotalRepayment = lf_TotalRepayment-lf_roundupadjust;
	//	NSLog (@"lf_TotalRepayment.afteradjust:%f", lf_TotalRepayment);		
	[self updateValue];
	
}

-(void)updateValue{
	
		NSLog (@"lf_MonthlyRepayment.updateValue:%f", lf_MonthlyRepayment);	
		NSLog (@"lf_TotalRepayment.updateValue:%f", lf_TotalRepayment);	
	
	NSString *StrLoanAmount = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:slLoanAmount.value]];
	NSString *StrMonthlyPay = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:lf_MonthlyRepayment]];
	NSString *StrTotalPay = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:lf_TotalRepayment]];
	
		NSLog (@"StrMonthlyPay:%@", StrMonthlyPay);	
		NSLog (@"StrTotalPay:%@", StrTotalPay);	
	
	tfLoanAmount.text = StrLoanAmount;
	lbMonthlyRepayment.text = StrMonthlyPay;
	lbTotalRepayment.text = StrTotalPay;
	
	
	//lbArrangementFee.text = [NSString stringWithFormat:@"%0.2f%%", lf_ArrangementFee*100.0];
	lbIntRatePerMonthFlat.text = [NSString stringWithFormat:@"%0.4f%%", lf_IntRatePerMonthFlat*100.0];
	lbAPR.text = [NSString stringWithFormat:@"%0.2f%%", lf_APR*100.0];
	
	//lbMonthlyRepayment.text = [NSString stringWithFormat:@"%0.2f", lf_MonthlyRepayment];
	//lbTotalRepayment.text = [NSString stringWithFormat:@"%0.2f", lf_TotalRepayment];
}

-(IBAction)reset{
	tfLoanAmount.text = @"5,000";
	lbMonthlyRepayment.text = @"893.45";
	lbIntRatePerMonthFlat.text = @"0.6012%";
	lbAPR.text = @"11.88%";
	lbTotalRepayment.text = @"";
	//	btLoanPlanGeneralCustomers.selected = YES;
	//	btLoanPlanProfessionals.selected = NO;
	btRepaymentPeriod12.selected = YES;
	btRepaymentPeriod24.selected = NO;
	btRepaymentPeriod36.selected = NO;
	btRepaymentPeriod48.selected = NO;
	slLoanAmount.maximumValue = 1000000;
	slLoanAmount.minimumValue = 5000;
	slLoanAmount.value = 5000;
	
	[self calc];
}
/*
 -(IBAction)btLoanPlanGeneralCustomersPressed{
 btLoanPlanGeneralCustomers.selected = YES;
 btLoanPlanProfessionals.selected = NO;
 [self selfInputAmount];
 }
 
 -(IBAction)btLoanPlanProfessionalsPressed{
 btLoanPlanGeneralCustomers.selected = NO;
 btLoanPlanProfessionals.selected = YES;
 [self selfInputAmount];
 }
 */
-(IBAction)btRepaymentPeriod12Pressed{
	btRepaymentPeriod12.selected = YES;
	btRepaymentPeriod24.selected = NO;
	btRepaymentPeriod36.selected = NO;
	btRepaymentPeriod48.selected = NO;
	[self selfInputAmount];
}

-(IBAction)btRepaymentPeriod24Pressed{
	btRepaymentPeriod12.selected = NO;
	btRepaymentPeriod24.selected = YES;
	btRepaymentPeriod36.selected = NO;
	btRepaymentPeriod48.selected = NO;
	[self selfInputAmount];
}

-(IBAction)btRepaymentPeriod36Pressed{
	btRepaymentPeriod12.selected = NO;
	btRepaymentPeriod24.selected = NO;
	btRepaymentPeriod36.selected = YES;
	btRepaymentPeriod48.selected = NO;
	[self selfInputAmount];
}

-(IBAction)btRepaymentPeriod48Pressed{
	btRepaymentPeriod12.selected = NO;
	btRepaymentPeriod24.selected = NO;
	btRepaymentPeriod36.selected = NO;
	btRepaymentPeriod48.selected = YES;
	[self selfInputAmount];
}

-(IBAction)slLoanAmountValueChanged{
	slLoanAmount.value = ceil(slLoanAmount.value/5000) * 5000 ;
	[self calc];
}

-(IBAction)screenPressed{
	NSLog(@"screenPressed");
	[tfLoanAmount resignFirstResponder];
	
	slLoanAmount.value=[[tfLoanAmount.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
	
	[self selfInputAmount];
}
/*
 -(BOOL) textFieldShouldReturn:(UITextField *)textField {
 [self screenPressed];
 return TRUE;
 }
 */

-(void)selfInputAmount{
	//	NSLog (@"selfInputAmount");	
	
	NSNumber *amount = [numberFormatter numberFromString: tfLoanAmount.text];
	
	slLoanAmount.value= [amount floatValue];
	
	//	NSLog (@"slLoanAmount.value:%f", slLoanAmount.value);	
	
	[self calc];
	
}

-(IBAction)setAmount{
	tfLoanAmount.text = [ tfLoanAmount.text stringByReplacingOccurrencesOfString:@"," withString:@""];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	//	NSLog (@"textFieldShouldReturn:%@", textField);	
	
	[self screenPressed];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	//	NSLog (@"textFieldDidEndEditing:%@", textField);	
	
	[self screenPressed];
}


@end
