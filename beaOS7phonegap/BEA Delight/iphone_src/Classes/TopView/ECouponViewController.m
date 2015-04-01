//
//  ECouponViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月29日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ECouponViewController.h"


@implementation ECouponViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(void)loadImageWithURL:(NSString *)url {
	ecoupon.image = nil;
	ecoupon.current_url = @"";
	[ecoupon loadImageWithURL:url];
}

-(void)showCoupon {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:content_view cache:TRUE];
	self.view.center = CGPointMake(160, [[MyScreenUtil me] getScreenHeight]/2+10);
	[UIView commitAnimations];
}

-(void)hiddenCoupon {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:content_view cache:TRUE];
	self.view.center = CGPointMake(160, 1.5*[[MyScreenUtil me] getScreenHeight]);
	[UIView commitAnimations];
}

-(IBAction)closeButtonPressed:(UIButton *)button {
	[self hiddenCoupon];
}

@end
