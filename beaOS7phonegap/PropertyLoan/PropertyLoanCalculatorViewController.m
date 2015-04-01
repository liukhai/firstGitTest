//
//  PropertyLoanCalculatorViewController.m
//  BEA
//
//  Created by YAO JASEN on 28/02/11.
//  Edited by YU ALLAN on 2011-03-14
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "PropertyLoanCalculatorViewController.h"
#define MIN_MORTGAGE_RATIO 10
#define MAX_MORTGAGE_RATIO 90
#define MIN_LOAN_AMOUNT 300000
#define MAX_LOAN_AMOUNT 99999999
#define MIN_PURCHASE_AMOUNT 300000
#define MAX_PURCHASE_AMOUNT 999999999
#define MIN_INTEREST_RATE 0.10
#define MAX_INTEREST_RATE 10.00
#define MIN_LOAN_TENOR 5
#define MAX_LOAN_TENOR 30

@implementation PropertyLoanCalculatorViewController

@synthesize numberFormatter;
@synthesize numberFormatter2;
@synthesize numberFormatter3;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openProperty = YES;
	scroll_view.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitleBackImg];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitle];
        [[MyScreenUtil me] adjustmentcontrolY20:scroll_view];
    }
    
	NSLog(@"PropertyLoanCalculatorViewController viewDidLoad scroll_view pointX:%f Y:%f",scroll_view.frame.origin.x,scroll_view.frame.origin.y);
	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    
    numberFormatter2 = [[NSNumberFormatter alloc] init];
	[numberFormatter2 setNumberStyle: NSNumberFormatterDecimalStyle];
	[numberFormatter2 setMaximumFractionDigits:0];
	[numberFormatter2 setMinimumFractionDigits:0];
	[numberFormatter2 setRoundingMode:NSNumberFormatterRoundDown];
	
    numberFormatter3 = [[NSNumberFormatter alloc] init];
	[numberFormatter3 setNumberStyle: NSNumberFormatterDecimalStyle];
	[numberFormatter3 setMaximumFractionDigits:1];
	[numberFormatter3 setMinimumFractionDigits:1];
	[numberFormatter3 setRoundingMode:NSNumberFormatterRoundUp];
	
    lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"PropertyLoanCalc",nil), NSLocalizedString(@"Calculator",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    
//    tf_purchasePrice_label.accessibilityLabel = NSLocalizedString(@"PropertyLoanPurchasePrice_accessibility",nil);
//    tf_mortagageRatio_label.accessibilityLabel = lb_mortgageRatio.text = NSLocalizedString(@"PropertyLoanMortgageRatio_accessibility",nil);
//    tf_loanAmount_label.accessibilityLabel = NSLocalizedString(@"PropertyLoanLoanAmount_accessibility",nil);
//    tf_interestRate_label.accessibilityLabel = NSLocalizedString(@"PropertyLoanInterestRate_accessibility",nil);
//    tf_loanTenor_label.accessibilityLabel = NSLocalizedString(@"PropertyLoanLoanTenor_accessibility",nil);
//    
//    tf_purchasePrice.accessibilityElementsHidden = YES;
//    tf_mortgageRatio.accessibilityElementsHidden = YES;
//    tf_loanTenor.accessibilityElementsHidden = YES;
//    tf_loanAmount.accessibilityElementsHidden = YES;
//    tf_interestRate.accessibilityElementsHidden = YES;

    tf_purchasePrice.accessibilityLabel = NSLocalizedString(@"PropertyLoanPurchasePrice_accessibility",nil);
    tf_purchasePrice.isAccessibilityElement = YES;
    tf_mortgageRatio.accessibilityLabel = lb_mortgageRatio.text = NSLocalizedString(@"PropertyLoanMortgageRatio_accessibility",nil);
    tf_mortgageRatio.isAccessibilityElement = YES;
    tf_loanAmount.accessibilityLabel = NSLocalizedString(@"PropertyLoanLoanAmount_accessibility",nil);
    tf_loanAmount.isAccessibilityElement = YES;
    tf_interestRate.accessibilityLabel = NSLocalizedString(@"PropertyLoanInterestRate_accessibility",nil);
    tf_interestRate.isAccessibilityElement = YES;
    tf_loanTenor.accessibilityLabel = NSLocalizedString(@"PropertyLoanLoanTenor_accessibility",nil);
    tf_loanTenor.isAccessibilityElement = YES;

	lb_calcTitle.text = NSLocalizedString(@"PropertyLoanCalcTitle",nil);
	lb_purchasePrice.text = NSLocalizedString(@"PropertyLoanPurchasePrice",nil);
	lb_mortgageRatio.text = NSLocalizedString(@"PropertyLoanMortgageRatio",nil);
	lb_loanAmount.text = NSLocalizedString(@"PropertyLoanLoanAmount",nil);
	lb_interestRate.text = NSLocalizedString(@"PropertyLoanInterestRate",nil);
	lb_loanTenor.text = NSLocalizedString(@"PropertyLoanLoanTenor",nil);
	lb_repayment.text	= NSLocalizedString(@"PropertyLoanRepaymentLabel",nil);
	lb_monthRay.text = NSLocalizedString(@"PropertyLoanMonthRepayment",nil);
    
    //    [sl_mortgageRatio setThumbImage: [UIImage imageNamed:@"propLoanSlider.png"] forState:UIControlStateNormal];
    //    [sl_interestRate setThumbImage: [UIImage imageNamed:@"propLoanSlider.png"] forState:UIControlStateNormal];
    //    [sl_loanTenor setThumbImage: [UIImage imageNamed:@"propLoanSlider.png"] forState:UIControlStateNormal];
    
    //    UIImage *sliderMinimum = [[UIImage imageNamed:@"dim.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:0]; 
    //    UIImage *sliderMaximum = [[UIImage imageNamed:@"dim.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:0]; 
    //    [sl_mortgageRatio setMinimumTrackImage:sliderMinimum forState:UIControlStateNormal]; 
    //    [sl_mortgageRatio setMaximumTrackImage:sliderMaximum forState:UIControlStateNormal]; 
    //    [sl_interestRate setMinimumTrackImage:sliderMinimum forState:UIControlStateNormal]; 
    //    [sl_interestRate setMaximumTrackImage:sliderMaximum forState:UIControlStateNormal]; 
    //    [sl_loanTenor setMinimumTrackImage:sliderMinimum forState:UIControlStateNormal]; 
    //    [sl_loanTenor setMaximumTrackImage:sliderMaximum forState:UIControlStateNormal]; 
    
//    btReset.frame = CGRectMake(btReset.frame.origin.x, 50, btReset.frame.size.width, btReset.frame.size.height);
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (screenHeight == 568){
        CGRect frame2 = borderImageView.frame;
        frame2.origin.y = frame2.origin.y;
        frame2.size.height = scroll_view.frame.size.height-30;
        borderImageView.frame = frame2;
    }else {
        CGRect frame2 = borderImageView.frame;
        frame2.origin.y = frame2.origin.y;
        frame2.size.height = scroll_view.frame.size.height+60;
        borderImageView.frame = frame2;
    }
	[btReset setTitle:NSLocalizedString(@"Reset", nil) forState:UIControlStateNormal];
	[btCall setTitle:NSLocalizedString(@"Apply", nil) forState:UIControlStateNormal];
	[self reset];
	
    [[MBKUtil me].queryButton1 addTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [lbTitleBackImg release];
    lbTitleBackImg = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)isAccessibilityElement{
    return NO;
}

- (void)dealloc {
  	[[MBKUtil me].queryButton1 removeTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
	[numberFormatter release];
    [numberFormatter2 release];
    [numberFormatter3 release];
    [lbTitleBackImg release];
    [tf_purchasePrice_label release];
    [tf_mortagageRatio_label release];
    [tf_loanAmount_label release];
    [tf_interestRate_label release];
    [tf_loanTenor_label release];
    [borderImageView release];
    [super dealloc];
}

-(IBAction)call{
	[[PropertyLoanUtil new] callToApply];
}

-(IBAction)reset{
	tf_purchasePrice.text = @"1,000,000";
	
	sl_mortgageRatio.minimumValue = MIN_MORTGAGE_RATIO;
    sl_mortgageRatio.maximumValue = MAX_MORTGAGE_RATIO;
	sl_mortgageRatio.value = 70;
    tf_mortgageRatio.text = @"70";
    sl_mortgageRatio.accessibilityValue = tf_mortgageRatio.text;
	bt_mortgage.selected = YES;
    sl_mortgageRatio.enabled = YES;
    tf_mortgageRatio.alpha = 1.0f;
    tf_purchasePrice.alpha = 1.0f;
	
	tf_loanAmount.text = @"700,000.00";
	bt_loanAmount.selected = FALSE;
    tf_loanAmount.alpha = 0.5f;
	
	sl_interestRate.minimumValue = MIN_INTEREST_RATE;
	sl_interestRate.maximumValue = MAX_INTEREST_RATE;
	sl_interestRate.value = 2.5;
	tf_interestRate.text = @"2.50";
    sl_interestRate.accessibilityValue = tf_interestRate.text;
	
	sl_loanTenor.minimumValue = MIN_LOAN_TENOR;
	sl_loanTenor.maximumValue = MAX_LOAN_TENOR;
	sl_loanTenor.value = 20 ;
	tf_loanTenor.text = @"20";
    sl_loanTenor.accessibilityValue = tf_loanTenor.text;
	[self showMonthlyRepay];
}


-(IBAction) clickLoanAmountButton{
	if (bt_loanAmount.selected == NO) {
		bt_loanAmount.selected = YES;
		tf_loanAmount.enabled = YES;
        tf_loanAmount.alpha = 1.0f;
		
        bt_mortgage.selected = NO;
		tf_mortgageRatio.enabled = NO;
		sl_mortgageRatio.enabled = NO;
        tf_purchasePrice.enabled = NO;
        tf_mortgageRatio.alpha = 0.5f;
        tf_purchasePrice.alpha = 0.5f;
	}
}

-(IBAction) clickMortgageButton{
	if (bt_mortgage.selected == NO) {
		bt_mortgage.selected = YES;
		tf_mortgageRatio.enabled = YES;
		sl_mortgageRatio.enabled = YES;
		tf_purchasePrice.enabled = YES;
        tf_mortgageRatio.alpha = 1.0f;
        tf_purchasePrice.alpha = 1.0f;
        
		bt_loanAmount.selected = NO;
		tf_loanAmount.enabled = NO;
        tf_loanAmount.alpha = 0.5f;
	}
}

-(IBAction) changeSliders:(UISlider *) slider{
	double purchasePrice;
	double mortgageRatio;
	double loanAmount;
	switch (slider.tag) {
        case 1: // mortgageRatio slider
			//sl_mortgageRatio.value = ceil(sl_mortgageRatio.value);
			mortgageRatio = (double)floor(sl_mortgageRatio.value);
			tf_mortgageRatio.text = [NSString stringWithFormat:@"%i" ,(int)floor(sl_mortgageRatio.value)];
            slider.accessibilityValue = [NSString stringWithFormat:@"%i" ,(int)floor(sl_mortgageRatio.value)];
            purchasePrice = [[tf_purchasePrice.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
            loanAmount = (purchasePrice * mortgageRatio/100);
            
            NSLog(@"purchasePrice.text:%f", purchasePrice);
            NSLog(@"mortgageRatio.text:%f", mortgageRatio);
            NSLog(@"loanAmount.text:%f", loanAmount);
            
            tf_loanAmount.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:loanAmount]];
			[self showMonthlyRepay];
			break;
        case 2:
            //			sl_interestRate.value = ceil(sl_interestRate.value/0.01)*0.01;
			tf_interestRate.text = [NSString stringWithFormat:@"%0.2f",floor(sl_interestRate.value/0.01)*0.01];
            slider.accessibilityValue = [NSString stringWithFormat:@"%0.2f",floor(sl_interestRate.value/0.01)*0.01];
			[self showMonthlyRepay];
			break;
		case 3:
			sl_loanTenor.value = floor(sl_loanTenor.value);
			tf_loanTenor.text = [NSString stringWithFormat:@"%i", (int)floor(sl_loanTenor.value)];
            slider.accessibilityValue = [NSString stringWithFormat:@"%i", (int)floor(sl_loanTenor.value)];			[self showMonthlyRepay];
			break;
		default:
			break;
	}
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"PropertyLoan.. textFieldDidBeginEditing");
    [scroll_view setContentOffset:CGPointMake(0, textField.frame.origin.y-50) animated:TRUE];
    if (textField.keyboardType==UIKeyboardTypeNumberPad) {
        [[MBKUtil me].queryButton1 setHidden:NO];
    }else{
        [[MBKUtil me].queryButton1 setHidden:YES];
    }
    switch (textField.tag) {
		case 1:
			tf_purchasePrice.text = [ tf_purchasePrice.text stringByReplacingOccurrencesOfString:@"," withString:@""];
			break;
		case 2:
			tf_mortgageRatio.text = [tf_mortgageRatio.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
		    break;
		case 3:
			tf_loanAmount.text = [tf_loanAmount.text stringByReplacingOccurrencesOfString:@"," withString:@""];
			break;
		case 4:
			tf_interestRate.text = [tf_interestRate.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
			break;
		default:
			break;
	}
    
}

-(void)queryFromKeypad:(UIButton *) btnQuery{
//    PropertyLoanEnquiryViewController *enquireCtrl = [[PropertyLoanEnquiryViewController alloc] initWithNibName:  @"PropertyLoanEnquiryViewController" bundle:nil]; 
//    [self.navigationController pushViewController:enquireCtrl animated:TRUE];
//    [enquireCtrl release];
    [self.view endEditing:TRUE];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    int purchasePrice;
	int mortgageRatio;
	int loanAmount;
    double loanAmountFloat;
	float interestRate;
    double purchasePriceFloat;
    double mortgageRatioFloat;
	int loanTenor;
    NSLog(@"offset.y:%f",scroll_view.contentOffset.y);
    [scroll_view setContentOffset:CGPointMake(0, 0) animated:TRUE];
    
	switch (textField.tag) {
		case 1: // purchasePrice textField
            //            NSLog(@"tf_purchasePrice.text:%@", tf_purchasePrice.text);
            purchasePrice =  floor([tf_purchasePrice.text intValue ]);
            if (purchasePrice > MAX_PURCHASE_AMOUNT) {
                purchasePrice = MAX_PURCHASE_AMOUNT;
            }
            if (purchasePrice < MIN_PURCHASE_AMOUNT) {
                purchasePrice = MIN_PURCHASE_AMOUNT;
            }
            //            NSLog(@"showloanAmount:%f", purchasePrice);
            tf_purchasePrice.text = [numberFormatter2 stringFromNumber:[NSNumber numberWithInt:purchasePrice]];
			if (purchasePrice > 0) {
				mortgageRatio = floor(sl_mortgageRatio.value);
                purchasePriceFloat = (double)purchasePrice;
                purchasePrice = purchasePrice * 1.00;
                mortgageRatioFloat = (double)mortgageRatio;
				loanAmountFloat = (purchasePriceFloat * mortgageRatioFloat / 100);
                //                loanAmount = (int)loanAmountFloat;
                tf_purchasePrice.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:purchasePrice]];
				tf_loanAmount.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:loanAmountFloat]];
			}
			break;
		case 2: // mortgageRatio textField
            mortgageRatio = [self getValidValue:textField];
			tf_mortgageRatio.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInt:mortgageRatio]];	
			sl_mortgageRatio.value = mortgageRatio;
			
			purchasePrice = [[tf_purchasePrice.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
			if (purchasePrice > 0 ) {
                //                NSLog(@"purchasePrice:%i", purchasePrice);
                purchasePriceFloat = (double)purchasePrice;
                mortgageRatioFloat = (double)mortgageRatio;
				loanAmountFloat = (purchasePriceFloat * mortgageRatioFloat / 100);
                //                loanAmount = [[NSNumber numberWithFloat:loanAmountFloat] intValue];
				tf_loanAmount.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:loanAmountFloat]];
			}
            break;
		case 3: // loan Amount textField
            //            loanAmount = [self getValidValue:textField];
            NSLog(@"tf_loanAmount.text1:%@", tf_loanAmount.text);
            
            loanAmount = [tf_loanAmount.text intValue];
            if (loanAmount > MAX_LOAN_AMOUNT) {
                loanAmount = MAX_LOAN_AMOUNT;
            }
            if (loanAmount < MIN_LOAN_AMOUNT) {
                loanAmount = MIN_LOAN_AMOUNT;
            }
            tf_loanAmount.text = [numberFormatter stringFromNumber:[NSNumber numberWithInt:loanAmount]];
			break;
		case 4: // interestRate textField
			interestRate = [self getValidValue:textField];
			tf_interestRate.text = [NSString stringWithFormat:@"%0.2f",interestRate];
			sl_interestRate.value = interestRate;
			break;
		case 5: // loanTenor textField
            loanTenor = (int)[self getValidValue:textField];
            tf_loanTenor.text = [NSString stringWithFormat:@"%d", loanTenor];
			sl_loanTenor.value = loanTenor;
			break;
		default:
			break;
	}
    [self showMonthlyRepay];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
 	[textField resignFirstResponder];
	return YES;
}

#pragma mark -


-(float) getValidValue:(UITextField *) textField{
    float result;
    int intresult;
    switch (textField.tag) {
        case 1:
            NSLog(@"tf_purchasePrice.text:%@", tf_purchasePrice.text);
            result = [tf_purchasePrice.text floatValue ];
            intresult = [tf_purchasePrice.text intValue ];
            //            result = [[tf_purchasePrice.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
            NSLog(@"getValidValue:%f", result);
            NSLog(@"getValidValue:%i", intresult);
            break;
        case 2:
            result = floor([tf_mortgageRatio.text floatValue]); 
			if (result > MAX_MORTGAGE_RATIO) {
                result = MAX_MORTGAGE_RATIO;
            }
            if (result < MIN_MORTGAGE_RATIO) {
                result = MIN_MORTGAGE_RATIO;
            }
            break;
        case 3:
            result = [tf_loanAmount.text floatValue];
            if (result > MAX_LOAN_AMOUNT) {
                result = MAX_LOAN_AMOUNT;
            }
            if (result < MIN_LOAN_AMOUNT) {
                result = MIN_LOAN_AMOUNT;
            }
            break;
        case 4:
            result = [tf_interestRate.text floatValue];
			if (result > MAX_INTEREST_RATE) {
                result = MAX_INTEREST_RATE;
            }
            if (result < MIN_INTEREST_RATE) {
                result = MIN_INTEREST_RATE;
            }
            break;
        case 5:
            result = [tf_loanTenor.text intValue];
			if (result > MAX_LOAN_TENOR) {
                result = MAX_LOAN_TENOR;
            }
            if (result < MIN_LOAN_TENOR) {
                result = MIN_LOAN_TENOR;
            }
            break;
        default:
            break;
    }
    return result;
} 


-(void) showMonthlyRepay{
	double purchasePrice = [[tf_purchasePrice.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    purchasePrice = purchasePrice * 1.00;
    tf_purchasePrice.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:purchasePrice]];
	double mortgageRatio =floor(sl_mortgageRatio.value);
    //	double interestRate = ceil(sl_interestRate.value/0.01)*0.01;
    double interestRate = [tf_interestRate.text doubleValue];
    NSLog(@"showMonthlyRepay.interestRate:%f", interestRate);
	int loanTenor = (int)floor(sl_loanTenor.value);
	
    double mortgagePct = (0.0+mortgageRatio)/100;
	double loanAmount = 0;
    if (bt_loanAmount.selected){
        
        loanAmount=[[tf_loanAmount.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
        NSLog(@"getValidValue:%f", loanAmount);
    }else{
        loanAmount=(purchasePrice * mortgagePct);   
    }
	double monthlyInterest = interestRate / 1200;
	double termMonths = loanTenor*12;
	double numerator = loanAmount*monthlyInterest*pow((1+monthlyInterest), termMonths);
	double denominator = pow((1+monthlyInterest), termMonths) - 1;
	double monthPay = numerator/denominator;
//    monthPay = monthPay - 0.005;
    
//	lb_monthRay.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:monthPay]];
    lb_monthRay.text =[NSString stringWithFormat:@"%@%@",[numberFormatter3 stringFromNumber:[NSNumber numberWithDouble:monthPay]] ,@"0" ];
    NSLog(@"showMonthlyRepay:%f--%f", loanAmount, monthPay);
} 


-(IBAction)screenPressed{
    [tf_purchasePrice resignFirstResponder];
	[tf_mortgageRatio resignFirstResponder];
	[tf_loanAmount resignFirstResponder];
	[tf_interestRate resignFirstResponder];
	[tf_loanTenor resignFirstResponder];
}


@end
