//
//  LTApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/15/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "LTHomeViewController.h"


@implementation LTHomeViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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

	NSArray *title_list = [NSLocalizedString(@"LTConsumerLoanIconTitle",nil) componentsSeparatedByString:@","];
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
	NSLog(@"LTHomeViewController dealloc");
    [super dealloc];
}

-(IBAction)buttonPressed:(UIButton *)button {
	UIViewController *view_controller;
	switch (button.tag) {
		case 0:
			if ([[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers lastObject] class]==[LTApplicationViewController class]) {
				return;
			}
			[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
			view_controller = [[LTApplicationViewController alloc] initWithNibName:@"LTApplicationViewController" bundle:nil];
			[[CoreData sharedCoreData]._LTViewController.navigationController pushViewController:view_controller animated:TRUE];
			[view_controller release];
			break;
		case 1:
			if ([[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers lastObject] class]==[LTOffersViewController class]) {
				return;
			}
			[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
			view_controller = [[LTOffersViewController alloc] initWithNibName:@"LTOffersViewController" bundle:nil];
			[[CoreData sharedCoreData]._LTViewController.navigationController pushViewController:view_controller animated:TRUE];
			[view_controller release];
			break;

		case 2:
			if ([[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers lastObject] class]==[LTRepaymentTableViewController class]) {
				return;
			}
			[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
			view_controller = [[LTRepaymentTableViewController alloc] initWithNibName:@"LTRepaymentTableViewController" bundle:nil];
			[[CoreData sharedCoreData]._LTViewController.navigationController pushViewController:view_controller animated:TRUE];
			[view_controller release];
			break;
		case 3:
			if ([[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers lastObject] class]==[LTCalculatorViewController class]) {
				return;
			}
			[[CoreData sharedCoreData]._LTViewController.navigationController popToRootViewControllerAnimated:FALSE];
			view_controller = [[LTCalculatorViewController alloc] initWithNibName:@"LTCalculatorViewController" bundle:nil];
			[[CoreData sharedCoreData]._LTViewController.navigationController pushViewController:view_controller animated:TRUE];
			[view_controller release];
			break;
	}
}

-(IBAction)backToHomePressed:(UIButton *)button {
	NSLog(@"LTHomeViewController backToHomePressed:%@", button);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenRight:self];
	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
	[UIView commitAnimations];
	
}


@end
