//
//  ATMAdvanceSearchViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月24日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMAdvanceSearchViewController.h"
#import "ATMAdvanceSearchListViewController.h"

@class ATMAdvanceSearchListViewController;

@implementation ATMAdvanceSearchViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		cuisine_list = [[NSLocalizedString(@"division_list",nil) componentsSeparatedByString:@","] retain];
		cuisine_index_list = [[NSLocalizedString(@"division_index_list",nil) componentsSeparatedByString:@","] retain];
		category_list = [[NSLocalizedString(@"place_type_list",nil) componentsSeparatedByString:@","] retain];
		category_index_list = [[NSLocalizedString(@"place_type_id_list",nil) componentsSeparatedByString:@","] retain];
		location_list = [[NSLocalizedString(@"place_type_list",nil) componentsSeparatedByString:@","] retain];
		location_index_list = [[NSLocalizedString(@"place_type_id_list",nil) componentsSeparatedByString:@","] retain];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    branch_btn.frame = CGRectMake(45, 90+[[MyScreenUtil me] getScreenHeightAdjust]/2, 230, 37);
    dining_offers.frame = CGRectMake(45, 160+[[MyScreenUtil me] getScreenHeightAdjust]/2, 230, 37);
    shopping_offers.frame = CGRectMake(45, 230+[[MyScreenUtil me] getScreenHeightAdjust]/2, 230, 37);
    
	//	table_view.backgroundColor = [UIColor clearColor];
	dining_offers.selected = TRUE;
	//	NSArray *offers_list = [NSLocalizedString(@"Offer types",nil) componentsSeparatedByString:@","];
	title_label.text = NSLocalizedString(@"Branch & ATM Search",nil);
	//	NSLog(@"ATMAdvanceSearchViewController viewDidLoad offers_list:%@", offers_list);
	//	[dining_offers setTitle:[offers_list objectAtIndex:0] forState:UIControlStateNormal];
	//	[shopping_offers setTitle:[offers_list objectAtIndex:1] forState:UIControlStateNormal];
	[dining_offers setTitle:NSLocalizedString(@"SupremeGold",nil) forState:UIControlStateNormal];
	[shopping_offers setTitle:NSLocalizedString(@"ATM",nil) forState:UIControlStateNormal];
	[branch_btn setTitle:NSLocalizedString(@"Branch",nil) forState:UIControlStateNormal];
	keywords.text = NSLocalizedString(@"Enter your keywords",nil);
	location_label.text = NSLocalizedString(@"Categories",nil);
	cuisine_label.text = NSLocalizedString(@"District",nil);
	//	[search setTitle:NSLocalizedString(@"Search",nil) forState:UIControlStateNormal];
	[location setTitle:@"" forState:UIControlStateNormal];
	[cuisine setTitle:@"" forState:UIControlStateNormal];
	/*[location setTitle:[location_list objectAtIndex:selected_location] forState:UIControlStateNormal];
	 [cuisine setTitle:[cuisine_list objectAtIndex:selected_cuisine] forState:UIControlStateNormal];*/
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
	[cuisine_list release];
	[location_list release];
    [super dealloc];
}

-(IBAction)diningButtonPressed:(UIButton *)button {
    //	NSLog(@"ATMAdvanceSearchViewController diningButtonPressed:%d",button);
	
	current_cuisine = 0;
	current_location = 0;
	dining_offers.selected = TRUE;
	shopping_offers.selected = FALSE;
	cuisine_label.text = NSLocalizedString(@"District",nil);
	keywords.text = NSLocalizedString(@"Enter your keywords",nil);
	[location setTitle:@"" forState:UIControlStateNormal];
	[cuisine setTitle:@"" forState:UIControlStateNormal];
	//[location setTitle:[location_list objectAtIndex:selected_location] forState:UIControlStateNormal];
	//[cuisine setTitle:[cuisine_list objectAtIndex:selected_cuisine] forState:UIControlStateNormal];
	//	[table_view reloadData];
}

-(IBAction)shoppingButtonPressed:(UIButton *)button {
    //	NSLog(@"ATMAdvanceSearchViewController shoppingButtonPressed:%d",button);
	
	current_category = 0;
	dining_offers.selected = FALSE;
	shopping_offers.selected = TRUE;
	cuisine_label.text = NSLocalizedString(@"Categories",nil);
	keywords.text = NSLocalizedString(@"Enter your keywords",nil);
	[cuisine setTitle:@"" forState:UIControlStateNormal];
	//	[table_view reloadData];
}

-(IBAction)cuisineButtonPressed:(UIButton *)button {
	
}

-(IBAction)searchButtonPressed:(UIButton *)button {
    //	NSLog(@"ATMAdvanceSearchViewController searchButtonPressed keywords:%@", keywords.text);
	
	ATMAdvanceSearchListViewController *search_result = [[ATMAdvanceSearchListViewController alloc] initWithNibName:@"ATMAdvanceSearchListView" bundle:nil];
	[self.navigationController pushViewController:search_result animated:TRUE];
	//	if (dining_offers.selected) {
	[search_result getItemsListCuisine:[cuisine_list objectAtIndex:current_cuisine] Location:[location_index_list objectAtIndex:current_location] Keywords:keywords.text];
	[search_result release];
}

/////////////////////
//UITextFieldDelegate
/////////////////////
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	textField.textColor = [UIColor blackColor];
	return TRUE;
}

// >>>>>>>>>>>>>>>>> Start: UIPickerViewDelegate <<<<<<<<<<<<<<<<
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	if (dining_offers.selected) {
		return 2;
	} else {
		return 1;
	}
	
	
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (dining_offers.selected) {
		switch (component) {
			case 0:
				return [location_list count];
				break;
			case 1:
				return [cuisine_list count];
				break;
		}
	} else {
		return [category_list count];
	}
	
	return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (dining_offers.selected) {
		switch (component) {
			case 0:
				return [location_list objectAtIndex:row];
				break;
			case 1:
				return [cuisine_list objectAtIndex:row];
				break;
		}
	} else {
		return [category_list objectAtIndex:row];
	}
	
	return @"";
}
// >>>>>>>>>>>> End: UIPickerViewDelegate <<<<<<<<<<<<<


// >>>>>>>>>>>> Start: UIActionSheetDelegate <<<<<<<<<<
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //	NSLog(@"ATMAdvanceSearchViewController clickedButtonAtIndex:%d",buttonIndex);
	
	if (buttonIndex==0) {
		NSLog(@"ATMAdvanceSearchViewController clickedButtonAtIndex OK");
		//		NSLog(@"OK");
		//		if (dining_offers.selected) {
		current_location = [pickerView selectedRowInComponent:0];
		current_cuisine = [pickerView selectedRowInComponent:1];
		[location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
		[cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
		//		} else {
		//			current_category = [pickerView selectedRowInComponent:0];
		//			[cuisine setTitle:[category_list objectAtIndex:current_category] forState:UIControlStateNormal];
		//		}
		
	} else {
		NSLog(@"ATMAdvanceSearchViewController clickedButtonAtIndex Cancel");
		//		NSLog(@"Cancel");
		//		if (dining_offers.selected) {
		//			[location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
		//			[cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
		//		} else {
		//			[cuisine setTitle:[category_list objectAtIndex:current_category] forState:UIControlStateNormal];
		//		}
	}
	[pickerView release];
	
	if (buttonIndex==0) {
		[self searchButtonPressed:nil];
	}
	
}
// >>>>>>>>>>>>> End: UIActionSheetDelegate <<<<<<<<<<<<<

/////////////////////
//ASIHTTPRequest delegate
/////////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *responseString = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
	NSLog(@"ATMAdvanceSearchViewController requestFinished:%@",responseString);
	cuisine_list = [[[NSString stringWithFormat:@"All,%@",responseString] componentsSeparatedByString:@","] retain];
	[cuisine setTitle:[cuisine_list objectAtIndex:0] forState:UIControlStateNormal];
	[location setTitle:[location_list objectAtIndex:0] forState:UIControlStateNormal];
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"ATMAdvanceSearchViewController requestFailed:%@", [request responseString]);
	[[CoreData sharedCoreData].mask hiddenMask];
}

///////////////////
//UITableView delegate
///////////////////
-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	if (dining_offers.selected) {
		return 3;
	} else {
		return 2;
	}
	
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (dining_offers.selected) {
		switch (indexPath.row) {
			case 0:
				return keywords_cell;
				break;
			case 1:
				return district_cell;
				break;
			case 2:
				return cuisine_cell;
				break;
		}
	} else {
		switch (indexPath.row) {
			case 0:
				return keywords_cell;
				break;
			case 1:
                return cuisine_cell;
				break;
		}
		
	}
	
	return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"ATMAdvanceSearchViewController didSelectRowAtIndexPath:%@",indexPath);
	
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	if (indexPath.row>0) {
		UIActionSheet *menu;
        //		NSLog(@"ATMAdvanceSearchViewController didSelectRowAtIndexPath self.view.frame:%@",self.view.frame);
		menu = [[UIActionSheet alloc] initWithTitle:nil
										   delegate:self
								  cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
							 destructiveButtonTitle:NSLocalizedString(@"Done",nil)
								  otherButtonTitles:nil];
		
		// Add the picker
		pickerView = [[UIPickerView alloc] init];
		pickerView.showsSelectionIndicator = TRUE;
		pickerView.delegate = self;
		pickerView.dataSource = self;
		[menu addSubview:pickerView];
		[menu showInView:self.view];
		[menu setBounds:CGRectMake(0, 0, 320, 480)];
		[pickerView setFrame:CGRectMake(0, 140, 320, 216)];
		//[pickerView setFrame:CGRectMake(0, 80, 320, 216)];
		UIButton *done_button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
		[menu addSubview:done_button];
		if (dining_offers.selected) {
			[pickerView selectRow:current_location inComponent:0 animated:FALSE];
			[pickerView selectRow:current_cuisine inComponent:1 animated:FALSE];
			[cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
			[location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
		} else {
			[pickerView selectRow:current_category inComponent:0 animated:FALSE];
			[cuisine setTitle:[category_list objectAtIndex:current_category] forState:UIControlStateNormal];
		}
		
		[menu release];
	}
}
// >>>>>>>>>>>>>>>>>> End: UITableViewDelegate <<<<<<<<<<<<<<<<<<<<<<


-(IBAction)popupMenuPicker{
	UIActionSheet *menu;
	menu = [[UIActionSheet alloc] initWithTitle:nil
									   delegate:self
							  cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
						 destructiveButtonTitle:NSLocalizedString(@"Search",nil)
							  otherButtonTitles:nil];
	
	// Add the picker
	pickerView = [[UIPickerView alloc] init];
	pickerView.showsSelectionIndicator = TRUE;
	pickerView.delegate = self;
	pickerView.dataSource = self;
	[menu addSubview:pickerView];
	[menu showInView:self.view];
	[menu setBounds:CGRectMake(0, 0, 320, 480)];
	[pickerView setFrame:CGRectMake(0, 140, 320, 216)];
    
	UIButton *done_button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
	[menu addSubview:done_button];
    
	[pickerView selectRow:current_location inComponent:0 animated:FALSE];
	[pickerView selectRow:current_cuisine inComponent:1 animated:FALSE];
	[cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
	[location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
	
	[menu release];
}

-(IBAction)branchButtonPressed{
	current_location=0;
	[self popupMenuPicker];
}

-(IBAction)supremeGoldButtonPressed{
	current_location=1;
	[self popupMenuPicker];
}

-(IBAction)atmButtonPressed{
	current_location=2;
	[self popupMenuPicker];
}

@end
