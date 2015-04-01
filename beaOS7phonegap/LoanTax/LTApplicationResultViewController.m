//
//  LTApplicationResultViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "LTApplicationResultViewController.h"


@implementation LTApplicationResultViewController

@synthesize temp_record;

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

	if (temp_record!=nil) {
		if([[temp_record objectForKey:@"Result"] isEqualToString:@"SUCCESS"]){
			lbRefno.text = [temp_record objectForKey:@"refno"];
			lbName.text = [temp_record objectForKey:@"name"];
			lbMobileno.text = [temp_record objectForKey:@"mobileno"];
			lbEmail.text = [temp_record objectForKey:@"email"];
			lbLoanDetail.text = [temp_record objectForKey:@"loandetail"];
			lbTimestamp.text = [temp_record objectForKey:@"Timestamp"];
		}
	}
	
	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"LTTax Loan",nil), NSLocalizedString(@"LTApplication",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	
	lbTag00.text = NSLocalizedString(@"LTTaxLoanApplicationResultTag00",nil);
	lbTag01.text = NSLocalizedString(@"LTTaxLoanApplicationResultTag01",nil);
	lbTag02.text = NSLocalizedString(@"LTTaxLoanApplicationResultTag02",nil);
	lbTag03.text = NSLocalizedString(@"LTName:",nil);
	lbTag04.text = NSLocalizedString(@"LTMobile no.:",nil);
	lbTag05.text = NSLocalizedString(@"LTEmail address:",nil);
	lbTag06.text = NSLocalizedString(@"LTLoan details :",nil);
	if ([[temp_record objectForKey:@"msg"] isEqualToString:@"1"]) {
		lbTag07.text = NSLocalizedString(@"LTTaxLoanApplicationResultMsg02",nil);
	}else{
		lbTag07.text = NSLocalizedString(@"LTTaxLoanApplicationResultMsg01",nil);
	}
	
	[btOK setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
	
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
}

-(IBAction)btOKPressed{
	[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:YES];
}

@end