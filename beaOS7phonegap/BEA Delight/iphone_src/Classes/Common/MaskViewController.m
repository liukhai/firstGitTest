//
//  MaskViewController.m
//  PIPTrade
//
//  Created by Algebra Lo on 10年1月16日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MaskViewController.h"
#import "MyScreenUtil.h"

@implementation MaskViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, 320, 480+[[MyScreenUtil me] getScreenHeightAdjust]);
    loading.frame = CGRectMake(142, 222+[[MyScreenUtil me] getScreenHeightAdjust]/2, 37, 37);
    
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
    [super dealloc];
}

-(void)showMask {
	self.view.userInteractionEnabled = TRUE;
	self.view.hidden = FALSE;
	[loading startAnimating];
}

-(void)hiddenMask {
	self.view.userInteractionEnabled = FALSE;
	self.view.hidden = TRUE;
	[loading stopAnimating];
}

@end
