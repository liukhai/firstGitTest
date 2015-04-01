//
//  LatestPromotionContactInfoViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月30日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LatestPromotionContactInfoViewController.h"


@implementation LatestPromotionContactInfoViewController
@synthesize merchant_info;

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
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);

	NSLog(@"%@",[merchant_info objectForKey:@"etitle"]);
//	title_label.text = NSLocalizedString(@"Contact Info",nil);
	outlet_list_controller = [[OutletListViewController alloc] initWithNibName:@"OutletListView" bundle:nil];
	
	[prev setTitle:NSLocalizedString(@"Prev", nil) forState:UIControlStateNormal];
	[next setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
	//jeff
	outlet_list_controller.prev = prev;
	outlet_list_controller.next = next;
	
	//
	outlet_list_controller.scrollable = TRUE;
	outlet_list_controller.is_show_distance = FALSE;
	outlet_list_controller.view.frame = CGRectMake(0, 63, 320, 397+[[MyScreenUtil me] getScreenHeightAdjust]);
	[outlet_list_controller getLatestPromotionOutlet:[merchant_info objectForKey:@"id"]];
	[self.view insertSubview:outlet_list_controller.view atIndex:1];

    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
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

#pragma mark -
#pragma mark handle button event
-(IBAction)prevButtonPressed:(UIButton *)button {
	[outlet_list_controller prevButtonPressed:button];
}

-(IBAction)nextButtonPressed:(UIButton *)button {
	[outlet_list_controller nextButtonPressed:button];
}

@end
