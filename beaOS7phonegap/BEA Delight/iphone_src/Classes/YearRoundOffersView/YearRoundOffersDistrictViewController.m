//
//  YearRoundOffersDistrictViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YearRoundOffersDistrictViewController.h"


@implementation YearRoundOffersDistrictViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		location_list = [[NSLocalizedString(@"location_list",nil) componentsSeparatedByString:@","] retain];
		location_id_list = [[NSLocalizedString(@"location_id_list",nil) componentsSeparatedByString:@","] retain];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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

-(IBAction)searchButtonPressed:(UIButton *)button {
	YearRoundOffersListViewController *current_view_controller = [[YearRoundOffersListViewController alloc] initWithNibName:@"YearRoundOffersListView" bundle:nil];
	[self.navigationController pushViewController:current_view_controller animated:TRUE];
	[(YearRoundOffersListViewController *)current_view_controller getItemsDistrict:search.tag];
	[current_view_controller release];
}

//////////////////////
//Picker delegate
//////////////////////
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [location_list count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [location_list objectAtIndex:row];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	search.tag = row;
}

@end
