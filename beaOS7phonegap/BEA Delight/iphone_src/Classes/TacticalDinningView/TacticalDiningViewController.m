//
//  TacticalDinningViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月30日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TacticalDiningViewController.h"


@implementation TacticalDiningViewController
@synthesize items_data;

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

-(void)setSelectShop:(int)shop {
	current_shop_index = shop;
	title_label.text = [[items_data objectAtIndex:shop] objectForKey:@"title"];
	[cached_image_view loadImageWithURL:[[items_data objectAtIndex:shop] objectForKey:@"image"]];
	description.text = [[items_data objectAtIndex:shop] objectForKey:@"description"];
	description.font = [UIFont systemFontOfSize:14];
	[coupon_image_view loadImageWithURL:[[items_data objectAtIndex:shop] objectForKey:@"coupon"]];
	if (current_shop_index==0) {
		prev.enabled = FALSE;
	} else {
		prev.enabled = TRUE;
	}
	if (current_shop_index==[items_data count]-1) {
		next.enabled = FALSE;
	} else {
		next.enabled = TRUE;
	}
}

-(IBAction)backButtonPressed:(UIBarButtonItem *)button {
	[self.navigationController popViewControllerAnimated:TRUE];
}

-(IBAction)homeButtonPressed:(UIBarButtonItem *)button {
	[self.navigationController popViewControllerAnimated:TRUE];
	[(RootViewController *)[CoreData sharedCoreData].root_view_controller setContent:-1];
}

-(IBAction)couponButtonPressed:(UIButton *)button {
	coupon_view.frame = CGRectMake(0, 43, 320, 220);
}

-(IBAction)couponCloseButtonPressed:(UIButton *)button {
	coupon_view.frame = CGRectMake(0, 43, 320, 20);
}

-(IBAction)prevButtonPressed:(UIButton *)button {
	if (current_shop_index>0) {
		current_shop_index--;
		[self setSelectShop:current_shop_index];
	}

}

-(IBAction)nextButtonPressed:(UIButton *)button {
	if (current_shop_index<[items_data count]-1) {
		current_shop_index++;
		[self setSelectShop:current_shop_index];
	}
}

-(IBAction)tncButtonPressed:(UIButton *)button {
}

-(IBAction)detailButtonPressed:(UIButton *)button {
}

-(IBAction)outletButtonPressed:(UIButton *)button {
}

-(IBAction)shareButtonPressed:(UIButton *)button {
}

-(IBAction)bookmarkButtonPressed:(UIButton *)button {
}

@end
