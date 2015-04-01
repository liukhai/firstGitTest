//
//  LTCalculatorViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "LTCalculatorViewController.h"


@implementation LTCalculatorViewController

@synthesize numberFormatter,scroll_view, contentView;

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
    self.scroll_view.frame = CGRectMake(0, 44, 320, 324+[[MyScreenUtil me] getScreenHeightAdjust]);

    [self.scroll_view addSubview:contentView];
    [self.scroll_view setContentSize:CGSizeMake(scroll_view.frame.size.width, contentView.frame.size.height)];
	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:1];
	[numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
	
	[btLoanPlanGeneralCustomers setTitle:NSLocalizedString(@"General Customers", nil) forState:UIControlStateNormal];
	btLoanPlanGeneralCustomers.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btLoanPlanGeneralCustomers.titleLabel.numberOfLines = 2;
	btLoanPlanGeneralCustomers.titleLabel.textAlignment = NSTextAlignmentCenter;
	btLoanPlanGeneralCustomers.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	btLoanPlanGeneralCustomers.titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	btLoanPlanGeneralCustomers.selected = YES;
	
	[btLoanPlanProfessionals setTitle:NSLocalizedString(@"Privileged Customers", nil) forState:UIControlStateNormal];
	btLoanPlanProfessionals.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btLoanPlanProfessionals.titleLabel.numberOfLines = 2;
	btLoanPlanProfessionals.titleLabel.textAlignment = NSTextAlignmentCenter;
	btLoanPlanProfessionals.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	btLoanPlanProfessionals.titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	btLoanPlanProfessionals.selected = NO;
	
	[btRepaymentPeriod12 setTitle:NSLocalizedString(@"LT12 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod12.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod12.selected = YES;
	
	[btRepaymentPeriod18 setTitle:NSLocalizedString(@"LT18 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod18.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod18.selected = NO;
	
	[btReset setTitle:NSLocalizedString(@"LTReset", nil) forState:UIControlStateNormal];
	[btCall setTitle:NSLocalizedString(@"LTApply", nil) forState:UIControlStateNormal];

	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"LTTax Loan",nil), NSLocalizedString(@"LTCalculator",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	
	lbTag00.text = NSLocalizedString(@"LTTaxLoanCalcTag00",nil);
	lbTag01.text = NSLocalizedString(@"LTLoan amount (HK$):",nil);
	lbTag02.text = NSLocalizedString(@"LTLoan plan:",nil);
	lbTag03.text = NSLocalizedString(@"LTRepayment Period:",nil);
	lbTag04.text = NSLocalizedString(@"LTTaxLoanCalcTag04",nil);
	lbTag05.text = NSLocalizedString(@"LTAPR:",nil);
	lbTag06.text = NSLocalizedString(@"LTTaxLoanCalcTag06",nil);
    remark.text = NSLocalizedString(@"LTremark",nil);
	lbTag06.numberOfLines=2;
	lbTag06.textAlignment = NSTextAlignmentLeft;
	lbTag06.lineBreakMode = NSLineBreakByWordWrapping;
	lbTag07.text = NSLocalizedString(@"LTTaxLoanCalcTag07",nil);
	lbTag07.numberOfLines=2;
	lbTag07.textAlignment = NSTextAlignmentLeft;
	lbTag07.lineBreakMode = NSLineBreakByWordWrapping;
	//	lbTag08.text = NSLocalizedString(@"TaxLoanCalcTag08",nil);
    [[MBKUtil me].queryButton1 addTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
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
    [numberFormatter release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [[MBKUtil me].queryButton1 removeTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
    [super dealloc];

}

-(IBAction)call{
	[[LTUtil new ]callToApply];
}

-(void)calc{
	
	lf_loanAmount = slLoanAmount.value;
	
	lf_roundupadjust = 0.049;
	
	if (btRepaymentPeriod12.selected) {
		lf_month = 12.0;
		lf_ArrangementFee = 1;
	}else {
		lf_month = 18.0;
		lf_ArrangementFee = 1.015;
	}
	
	if (btLoanPlanGeneralCustomers.selected) {
		if (lf_loanAmount>=5000 && lf_loanAmount<30000) {
			lf_IntRatePerMonthFlat = 0.0027;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0609;
			}else {
				lf_APR = 0.0827;
			}
		}else if (lf_loanAmount>=30000 && lf_loanAmount<100000) {
			lf_IntRatePerMonthFlat = 0.0027;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0609;
			}else {
				lf_APR = 0.0827;
			}
		}else if (lf_loanAmount>=100000 && lf_loanAmount<400000) {
			lf_IntRatePerMonthFlat = 0.0022;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0495;
			}else {
				lf_APR = 0.0708;
			}
		}else if (lf_loanAmount>=400000 && lf_loanAmount<800000) {
			lf_IntRatePerMonthFlat = 0.0019;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0426;
			}else {
				lf_APR = 0.0637;
			}
		}else if (lf_loanAmount>=800000 && lf_loanAmount<1000001) {
			lf_IntRatePerMonthFlat = 0.0016;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0358;
			}else {
				lf_APR = 0.0566;
			}
		}
	}else {
		if (lf_loanAmount>=5000 && lf_loanAmount<30000) {
			lf_IntRatePerMonthFlat = 0.0026;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0586;
			}else {
				lf_APR = 0.0804;
			}
		}else if (lf_loanAmount>=30000 && lf_loanAmount<100000) {
			lf_IntRatePerMonthFlat = 0.0026;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0586;
			}else {
				lf_APR = 0.0804;
			}
		}else if (lf_loanAmount>=100000 && lf_loanAmount<400000) {
			lf_IntRatePerMonthFlat = 0.0021;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0472;
			}else {
				lf_APR = 0.0684;
			}
		}else if (lf_loanAmount>=400000 && lf_loanAmount<800000) {
			lf_IntRatePerMonthFlat = 0.0017;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0381;
			}else {
				lf_APR = 0.0589;
			}
		}else if (lf_loanAmount>=800000 && lf_loanAmount<1000001) {
			lf_IntRatePerMonthFlat = 0.0014;
			if (btRepaymentPeriod12.selected) {
				lf_APR = 0.0313;
			}else {
				lf_APR = 0.0518;
			}
		}
	}
	
//	lf_MonthlyRepayment = ((lf_loanAmount*(1+lf_ArrangementFee)) / lf_month) + ((lf_loanAmount*(1+lf_ArrangementFee)) * lf_IntRatePerMonthFlat);
//	lf_TotalRepayment = lf_MonthlyRepayment * lf_month;
	

	lf_TotalRepayment = ((lf_loanAmount*lf_ArrangementFee) + (lf_loanAmount*lf_ArrangementFee) * lf_IntRatePerMonthFlat * lf_month);
	lf_MonthlyRepayment = (lf_TotalRepayment / lf_month);
    NSLog (@"lf_TotalRepayment.beforeadjust:%f", lf_MonthlyRepayment);
	lf_MonthlyRepayment = (lf_TotalRepayment / lf_month)+lf_roundupadjust;
	NSLog (@"lf_MonthlyRepayment.afteradjust:%f", lf_MonthlyRepayment);
	NSLog (@"lf_TotalRepayment.beforeadjust:%f", lf_TotalRepayment);
	lf_TotalRepayment = lf_TotalRepayment+lf_roundupadjust;
//	NSLog (@"lf_TotalRepayment.afteradjust:%f", lf_TotalRepayment);		
	[self updateValue];

}

-(void)updateValue{

//	NSLog (@"lf_MonthlyRepayment.updateValue:%f", lf_MonthlyRepayment);	
//	NSLog (@"lf_TotalRepayment.updateValue:%f", lf_TotalRepayment);	
	
	NSString *StrLoanAmount = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:slLoanAmount.value]];
	NSString *StrMonthlyPay = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:lf_MonthlyRepayment]];
	NSString *StrTotalPay = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:lf_TotalRepayment]];
	
	NSLog (@"StrMonthlyPay:%f", lf_MonthlyRepayment);	
//	NSLog (@"StrTotalPay:%@", StrTotalPay);	
	
	tfLoanAmount.text = StrLoanAmount;
	lbMonthlyRepayment.text = StrMonthlyPay;
	lbTotalRepayment.text = StrTotalPay;
	
	
	//lbArrangementFee.text = [NSString stringWithFormat:@"%0.2f%%", lf_ArrangementFee*100.0];
	lbIntRatePerMonthFlat.text = [NSString stringWithFormat:@"%0.2f%%", lf_IntRatePerMonthFlat*100.0];
	lbAPR.text = [NSString stringWithFormat:@"%0.2f%%", lf_APR*100.0];
    
	lbMonthlyRepayment.text = [NSString stringWithFormat:@"%0.1f0", lf_MonthlyRepayment];
	lbTotalRepayment.text = [NSString stringWithFormat:@"%0.1f0", lf_TotalRepayment];
}

-(IBAction)reset{
	tfLoanAmount.text = @"10,000";
	lbMonthlyRepayment.text = @"856.3";
	lbIntRatePerMonthFlat.text = @"0.27%";
	lbAPR.text = @"8.27%";
	lbTotalRepayment.text = @"";
	btLoanPlanGeneralCustomers.selected = YES;
	btLoanPlanProfessionals.selected = NO;
	btRepaymentPeriod12.selected = YES;
	btRepaymentPeriod18.selected = NO;
	slLoanAmount.maximumValue = 1000000;
	slLoanAmount.minimumValue = 5000;
	slLoanAmount.value = 10000;

	[self calc];
}

-(IBAction)btLoanPlanGeneralCustomersPressed{
    	//NSLog (@"btLoanPlanGeneralCustomersPressed");	
	btLoanPlanGeneralCustomers.selected = YES;
	btLoanPlanProfessionals.selected = NO;
	[self selfInputAmount];
}

-(IBAction)btLoanPlanProfessionalsPressed{
    //NSLog (@"btLoanPlanProfessionalsPressed");	
	btLoanPlanGeneralCustomers.selected = NO;
	btLoanPlanProfessionals.selected = YES;
	[self selfInputAmount];
}

-(IBAction)btRepaymentPeriod12Pressed{
    //NSLog (@"btRepaymentPeriod12Pressed");	
	btRepaymentPeriod12.selected = YES;
	btRepaymentPeriod18.selected = NO;
	[self selfInputAmount];
}

-(IBAction)btRepaymentPeriod18Pressed{
    //NSLog (@"btRepaymentPeriod18Pressed");	
	btRepaymentPeriod12.selected = NO;
	btRepaymentPeriod18.selected = YES;
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
-(void)queryFromKeypad:(UIButton *) btnQuery{
    //    PropertyLoanEnquiryViewController *enquireCtrl = [[PropertyLoanEnquiryViewController alloc] initWithNibName:  @"PropertyLoanEnquiryViewController" bundle:nil]; 
    //    [self.navigationController pushViewController:enquireCtrl animated:TRUE];
    //    [enquireCtrl release];
    [self.view endEditing:TRUE];
}

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
