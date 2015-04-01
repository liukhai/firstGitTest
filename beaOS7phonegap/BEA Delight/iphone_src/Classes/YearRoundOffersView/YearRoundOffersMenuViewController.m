//
//  YearRoundOffersMenuViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月18日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YearRoundOffersMenuViewController.h"


@implementation YearRoundOffersMenuViewController
@synthesize delegate;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		dining_mode = TRUE;
    }
    return self;
}

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

-(IBAction)menuItemPressed:(UIButton *)button {
	[delegate menuItemPressed:button.tag];
}

-(void)setDiningMode:(BOOL)diningMode {
	dining_mode = diningMode;
}

////////////////////
//TableViewDelegate
////////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return 4;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell==nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_cell_bg.png"]];
		bg.contentMode = UIViewContentModeScaleToFill;
		bg.frame = CGRectMake(0, 0, 320, 81);
		[cell.contentView addSubview:bg];
	}
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.textLabel.textColor = [UIColor blackColor];
	NSString *name;
	if (dining_mode) {
		switch (indexPath.row) {
			case 0:
				name = NSLocalizedString(@"Top Merchants Highlights",nil);
				break;
			case 1:
				name = NSLocalizedString(@"Hotel",nil);
				break;
			case 2:
				name = NSLocalizedString(@"Chain Restaurants",nil);
				break;
			case 3:
				name = NSLocalizedString(@"District",nil);
				break;
		}
	} else {
		switch (indexPath.row) {
			case 0:
				name = NSLocalizedString(@"Apparel",nil);
				break;
			case 1:
				name = NSLocalizedString(@"Beauty",nil);
				break;
			case 2:
				name = NSLocalizedString(@"Jewellery & Watches",nil);
				break;
			case 3:
				name = NSLocalizedString(@"Lifestyle",nil);
				break;
		}
	}

	cell.textLabel.text = [NSString stringWithFormat:@"   %@",name];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	if (dining_mode) {
		[delegate menuItemPressed:indexPath.row];
	} else {
		[delegate menuItemPressed:indexPath.row + 12];
	}

}
@end
