//
//  NearBySearchListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMFavouriteListViewController.h"
#import "ATMOutletMapViewController.h"
#import "ATMUtil.h"

@implementation ATMFavouriteListViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		all_items_data = [NSMutableDictionary new];
		[all_items_data setValue:[NSMutableArray new] forKey:@"ATM"];
		items_data = [NSMutableArray new];
		/*current_type = @"OfferId";
		 current_category = [[CoreData sharedCoreData].bookmark listOfferId];*/
		
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
    table_view.frame = CGRectMake(0, 72, 320, 295+[[MyScreenUtil me] getScreenHeightAdjust]);
    
	title_label.text = NSLocalizedString(@"Bookmark",nil);
	[self generateBookmark];
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
	[all_items_data release];
	[items_data release];
    [super dealloc];
}

-(void)generateBookmark {
	Bookmark *bookmark_data = [[Bookmark alloc] init];
	int no_record = TRUE;
	if ([[bookmark_data listOfferIdInGroup:6] length]>0) {
		no_record = FALSE;
	}
	if (no_record) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No bookmark stored",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
		result.text = @"";
		[table_view reloadData];
		self.navigationItem.rightBarButtonItem = nil;
	}
	if ([[bookmark_data listOfferIdInGroup:6] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:6]);
		[self parseFromFile];
	}
    
	int total_result = 0;
	total_result += [[all_items_data objectForKey:@"ATM"] count];
	result.text = [NSString stringWithFormat:@"%@ %d",NSLocalizedString(@"ATMBookmark1",nil), total_result];
	
	[bookmark_data release];
}

- (void)parseFromFile {
	
	items_data = nil;
	
	NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[MBKUtil me] getDocATMplistPath]];
	items_data = [md_temp objectForKey:@"atmlist"];
	
	if ([items_data count]>0) {
		total_page = ceil([items_data count]/(float)current_page_size);
	}else {
		total_page = 0;
	}
    
	/*	if (current_page==1) {
	 prev.hidden = TRUE;
	 } else {
	 prev.hidden = FALSE;
	 }
	 
	 if (current_page==total_page) {
	 next.hidden = TRUE;
	 } else {
	 next.hidden = FALSE;
	 }*/
	NSLog(@"parseFromFile all items:%d",[items_data count]);//items_data count must be bigger then id_list
	Bookmark *bookmark_data = [[Bookmark alloc] init];
	NSArray *id_list = [[bookmark_data listOfferIdInGroup:6] componentsSeparatedByString:@","];
	int i, j;
	NSMutableArray *bookmark_items_data = [NSMutableArray new];
	
	for (i=[id_list count]-1; i>=0; i--) {
		BOOL found = FALSE;
		for (j=0; j<[items_data count]; j++) {
			if ([[[items_data objectAtIndex:j] objectForKey:@"id"] isEqualToString:[id_list objectAtIndex:i]]) {
				if ([[[items_data objectAtIndex:j] objectForKey:@"expire"] isEqualToString:@"0"]) {
					found = TRUE;
					NSLog(@"Found id:%@",[id_list objectAtIndex:i]);
					[bookmark_items_data addObject:[items_data objectAtIndex:j]];
				}
			}
		}
		if (!found) {
			NSLog(@"Remove outdated bookmark id:%@",[id_list objectAtIndex:i]);
			[bookmark_data removeBookmark:[NSDictionary dictionaryWithObject:[id_list objectAtIndex:i] forKey:@"id"] InGroup:0];
		}
	}
	
	items_data = bookmark_items_data;
	//	[bookmark_items_data release];
	NSLog(@"parseFromFile selected items:%d",[items_data count]);
	
    
    [[ATMUtil me] sortItemsAlphabetically:items_data];
    
    [ATMUtil moveForwardItemsByKey:items_data];
    
    
	if ([items_data count]>0) {
		
		if ([all_items_data objectForKey:@"ATM"]!=nil) {
			[all_items_data removeObjectForKey:@"ATM"];
		}
		[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"ATM"];
		[table_view reloadData];
        
	}
	
    
	[[CoreData sharedCoreData].mask hiddenMask];
	
}

-(void)enableEdit {
	table_view.editing = TRUE;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(disableEdit)] autorelease];
}

-(void)disableEdit {
	table_view.editing = FALSE;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(enableEdit)] autorelease];
}

///////////////////
//ASIHTTP Delegate
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
	NSLog(@"ATMFavouriteListViewController requestFinished:%@",[request responseString]);
	parsing_type = 6;
	NSLog(@"parsing_type: %d",parsing_type);
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[[CoreData sharedCoreData].mask hiddenMask];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"ATMFavouriteListViewController requestFailed:%@", [request responseString]);

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
	
}

///////////////////
//UITableDelegate
///////////////////
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 30;
}

//-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//	return NSLocalizedString(@"Branch, SupremeGold Centre & ATM",nil);
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	UILabel *header_label;
//	header_label = [[UILabel alloc] initWithFrame:CGRectMake(5, 11, 250, 60)];
//	header_label.font = [UIFont systemFontOfSize:16];
//	header_label.textColor = [UIColor blackColor];
//	header_label.numberOfLines = 2;
//	header_label.backgroundColor = [UIColor clearColor];
//	header_label.lineBreakMode = UILineBreakModeWordWrap;
//	header_label.text = NSLocalizedString(@"Branch, SupremeGold Centre & ATM",nil);
//	return header_label;
//}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [[all_items_data objectForKey:@"ATM"] count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *temp_items_data;
	temp_items_data = [all_items_data objectForKey:@"ATM"];
	
	NSUInteger index = indexPath.row + (current_page-1) * current_page_size;
	id obj = [temp_items_data objectAtIndex:index];
	
	NSString *identifier = @"ATMCustomCell";
	//	ATMCustomCell *cell = (ATMCustomCell *)[table_view dequeueReusableCellWithIdentifier:identifier];
	//	if (cell==nil) {
	ATMCustomCell *cell = [[ATMCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:2];
	//	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.title_label.text = [obj objectForKey:@"title"];
	cell.address_label.text = [obj objectForKey:@"address"];
	cell.distance_label.text = @"";
	[cell.tel setTitle:[obj objectForKey:@"tel"] forState:UIControlStateNormal];
	[cell showTel];
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"ATMFavouriteListViewController didSelectRowAtIndexPath:%@", indexPath);
	
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
	ATMOutletMapViewController *outlet_map_controller = [[ATMOutletMapViewController alloc] initWithNibName:@"ATMOutletMapView" bundle:nil];
    outlet_map_controller.isNear = NO;
	[outlet_map_controller addAnnotations:items_data];
	[outlet_map_controller setSelectedAnnotation:indexPath.row + (current_page-1) * current_page_size Delta:0.005];
    outlet_map_controller.isNeedBox = YES;
	[self.navigationController pushViewController:outlet_map_controller animated:TRUE];
	[outlet_map_controller release];
}

-(NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return NSLocalizedString(@"Delete",nil);
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSLog(@"Delete section:%d row:%d",indexPath.section, indexPath.row);
		Bookmark *bookmark_data = [[Bookmark alloc] init];
		[bookmark_data removeBookmark:[[all_items_data objectForKey:@"ATM"] objectAtIndex:indexPath.row] InGroup:0];
		[[all_items_data objectForKey:@"ATM"] removeObjectAtIndex:indexPath.row];
		[table_view deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:TRUE];
		[self generateBookmark];
	}
}

@end
