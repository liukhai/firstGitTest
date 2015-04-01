//
//  TaxLoanApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/15/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "TaxLoanHomeViewController.h"


@implementation TaxLoanHomeViewController

@synthesize tabBar;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
	NSLog(@"initWithNibName:%@", self);
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"viewDidLoad:%@", self);
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 416+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 64, 320, 416+[[MyScreenUtil me] getScreenHeightAdjust]);

	[back_to_home setTitle:NSLocalizedString(@"Back to Home",nil) forState:UIControlStateNormal];

	NSArray *title_list = [NSLocalizedString(@"ConsumerLoanIconTitle",nil) componentsSeparatedByString:@","];
	label0.text = [title_list objectAtIndex:0];
	label1.text = [title_list objectAtIndex:1];
	label2.text = [title_list objectAtIndex:2];
	label3.text = [title_list objectAtIndex:3];
    


    
	
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	NSLog(@"TaxLoanHomeViewController dealloc");
    [super dealloc];
}

-(IBAction)buttonPressed:(UIButton *)button {
	UIViewController *view_controller;
	switch (button.tag) {
		
		case 0: // Offers Button
			if ([[[CoreData sharedCoreData].taxLoan_view_controller.navigationController.viewControllers lastObject] class]==[TaxLoanOffersViewController class]) {
				return;
			}
			[[CoreData sharedCoreData].taxLoan_view_controller.navigationController popToRootViewControllerAnimated:FALSE];
			view_controller = [[TaxLoanOffersViewController alloc] initWithNibName:@"TaxLoanOffersViewController" bundle:nil];
			[[CoreData sharedCoreData].taxLoan_view_controller.navigationController pushViewController:view_controller animated:TRUE];
			[view_controller release];
			break;
        case 1: // Application Button
			if ([[[CoreData sharedCoreData].taxLoan_view_controller.navigationController.viewControllers lastObject] class]==[TaxLoanApplicationViewController class]) {
				return;
			}
			[[CoreData sharedCoreData].taxLoan_view_controller.navigationController popToRootViewControllerAnimated:FALSE];
			view_controller = [[TaxLoanApplicationViewController alloc] initWithNibName:@"TaxLoanApplicationViewController" bundle:nil];
			[[CoreData sharedCoreData].taxLoan_view_controller.navigationController pushViewController:view_controller animated:TRUE];
			[view_controller release];
			break;
		case 2:  // CallNow Button
            	[[TaxLoanUtil new ]callToApply];
			break;
		case 3: // BEA Nearby Button
	/*		[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.5];
			[[CoreData sharedCoreData].root_view_controller setContent:0];
			[CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];           */
//			[CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
            [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].taxLoan_view_controller animated:NO];
            NSLog(@"Navigation Revamp - Consumer Loan - TaxLoanHomeViewController.m");
			[[CoreData sharedCoreData].atmlocation_view_controller welcome];
	/*		[UIView commitAnimations];      */
        break;
	}
}

-(IBAction)backToHomePressed:(UIButton *)button {
	NSLog(@"TaxLoanHomeViewController backToHomePressed:%@", button);
/*	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];          */
//	[CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].taxLoan_view_controller animated:NO];
    NSLog(@"Navigation Revamp - Consumer Loan - TaxLoanHomeViewController.m");
/*	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
	[UIView commitAnimations];          */
	
}
@end
