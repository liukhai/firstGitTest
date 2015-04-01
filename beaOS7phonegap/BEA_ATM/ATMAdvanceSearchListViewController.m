//
//  NearBySearchListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMAdvanceSearchListViewController.h"
#import "ATMOutletMapViewController.h"
#import "ATMUtil.h"

@implementation ATMAdvanceSearchListViewController

@synthesize selected_type, selected_district;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"ATMAdvanceSearchListViewController initWithNibName:%@", nibBundleOrNil);
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		show_no = 100;
		[self defineDefaultTable];
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		lang = [CoreData sharedCoreData].lang;
		items_data = [NSMutableArray new];
		
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
    table_view.frame = CGRectMake(0, 45, 320, 322+[[MyScreenUtil me] getScreenHeightAdjust]);

	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
	title_label.text = NSLocalizedString(@"Branch & ATM Search",nil);
	
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
	[items_data release];
    [super dealloc];
}

-(void)defineDefaultTable {
	cell_height = 81;
	default_title_font_size = 14;
	default_description_font_size = 12;
	default_date_font_size = 12;
	default_image_source_type = @"url";
	default_image_alignment = @"left";
	items_data = [NSMutableArray new];
	distance_list = [NSMutableArray new];
}

-(void) selecteTypes{
	if ([items_data count]<=0) {
		return;
	}
	NSLog(@"selecteTypes begin: items count, type, district:%d--%@--%@", [items_data count], selected_type, selected_district);
	int total_record = [items_data count];
	if ([selected_type length]<1 && [selected_district length]<1) {
	}else{
		if ([selected_type length]>0) {
			if (NSOrderedSame == [selected_type compare:@"SupremeGold Centre"]) {
				selected_type = @"S";
			}else if (NSOrderedSame == [selected_type compare:@"ATM"]) {
				selected_type = @"A";
			}else if (NSOrderedSame == [selected_type compare:@"Branch"]) {
				selected_type = @"B";
			}
		}
		
		NSMutableArray* selected_items_data = [NSMutableArray new];
		BOOL pass_type = FALSE;
		BOOL pass_district = FALSE;
        BOOL pass_expire = FALSE;
		for (int i=0; i<total_record; i++) {
			pass_type = FALSE;
			pass_district = FALSE;
            pass_expire = FALSE;
			id obj = [items_data objectAtIndex:i];
			NSString *item_gategory = [obj objectForKey:@"category"];
			NSString *item_district = [obj objectForKey:@"district"];
            NSString *item_expire = [obj objectForKey:@"expire"];
			if(  ([selected_type length]<1)  ||
			   ([selected_type length]>0 && NSOrderedSame == [selected_type compare:item_gategory])  ) {
				pass_type = TRUE;
			}else {
				pass_type = FALSE;
			}
			
			if(  ([selected_district length]<1)  ||
			   ([selected_district length]>0 && NSOrderedSame == [selected_district compare:item_district])  ) {
				pass_district = TRUE;
			}else {
				pass_district = FALSE;
			}
			
            if ([item_expire isEqualToString:@"0"]) {
                pass_expire = TRUE;
            }

            
			if (pass_type && pass_district && pass_expire) {
				[selected_items_data addObject:[items_data objectAtIndex:i]];
			}
		}
		items_data = selected_items_data;
		
		total_page = ceil([items_data count]/(float)current_page_size);
		if (current_page==1) {
			prev.hidden = TRUE;
		} else {
			prev.hidden = FALSE;
		}
		
		if (current_page==total_page || total_page<=1) {
			next.hidden = TRUE;
		} else {
			next.hidden = FALSE;
		}
		
	}
	
	NSLog(@"selecteTypes end: items count:%d", [items_data count]);
}

-(void)sortTableItem {
	NSLog(@"sortTableItem begin");
	if ([items_data count]<1) {
		NSLog(@"sortTableItem temp");
		return;
	} else {
        [[ATMUtil me] sortItemsAlphabetically:items_data];
        
        [ATMUtil moveForwardItemsByKey:items_data];
		
		total_page = ceil([items_data count]/(float)current_page_size);
		if (current_page==1) {
			prev.hidden = TRUE;
		} else {
			prev.hidden = FALSE;
		}
		
		if (current_page==total_page || total_page==0) {
			next.hidden = TRUE;
		} else {
			next.hidden = FALSE;
		}		
		
		NSLog(@"sortTableItem end:%d", [items_data count]);
	}
}

-(void)getItemsListCuisine:(NSString *)cuisine Location:(NSString *)location Keywords:(NSString *)keywords {
	searching_type = @"dining";
	NSLog(@"ATMAdvanceSearchListViewController getItemsListCuisine:%@--%@", cuisine, location);
	if ([cuisine isEqualToString:NSLocalizedString(@"All",nil)]) {
		cuisine = @"";
	}
	selected_type = location;
	selected_district = cuisine;
	
	[self parseFromFile];
}

- (void)parseFromFile {
	
	items_data = nil;
	current_page = 1;
	
	NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[MBKUtil me] getDocATMplistPath]];
	items_data = [md_temp objectForKey:@"atmlist"];
	NSLog(@"parseFromFile count:%d", [items_data count]);
	
	if ([items_data count]>0) {
		total_page = ceil([items_data count]/(float)current_page_size);
		if (current_page==1) {
			prev.hidden = TRUE;
		} else {
			prev.hidden = FALSE;
		}
		
		if (current_page==total_page || total_page<=1) {
			next.hidden = TRUE;
		} else {
			next.hidden = FALSE;
		}
	}else {
		total_page = 0;
		current_page = 0;
		prev.hidden = TRUE;
		next.hidden = TRUE;
		items_data = nil;
	}

	NSLog(@"parseFromFile begin sort:items:%d", [items_data count]);

	if ([items_data count]<=0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Cannot find offer for the search",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		[self selecteTypes];
		[self sortTableItem];
		[table_view reloadData];
	}
	
	[[CoreData sharedCoreData].mask hiddenMask];
	
}

-(IBAction)prevButtonPressed:(UIButton *)button {
	if (current_page>1) {
		current_page--;
		next.hidden = FALSE;
		if (current_page==1) {
			prev.hidden = TRUE;
		}
		[table_view reloadData];
		table_view.contentOffset = CGPointMake(0, 0);
	}
}

-(IBAction)nextButtonPressed:(UIButton *)button {
	if (current_page<total_page) {
		current_page++;
		prev.hidden = FALSE;
		if (current_page==total_page) {
			next.hidden = TRUE;
		}
		[table_view reloadData];
		table_view.contentOffset = CGPointMake(0, 0);
	}
}

///////////////////
//ASIHTTP Delegate
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
	//NSLog(@"%@",[request responseString]);
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[[CoreData sharedCoreData].mask hiddenMask];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"ATMAdvanceSearchListViewController requestFailed:%@", [request responseString]);

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
	
}

///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	if ([items_data count]<=0) {
		return 0;
	}
	int total_record = [items_data count];
	if (total_record - (current_page-1) * current_page_size > current_page_size) {
		return current_page_size;
	} else {
		return total_record - (current_page-1) * current_page_size;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//	NSLog(@"ATMAdvanceSearchListViewController cellForRowAtIndexPath:%@--%d", indexPath, [items_data count]);
	
	NSUInteger index = indexPath.row + (current_page-1) * current_page_size;
	id obj = [items_data objectAtIndex:index];
	
	NSString *identifier = @"ATMCustomCell";
	//	ATMCustomCell *cell = (ATMCustomCell *)[table_view dequeueReusableCellWithIdentifier:identifier];
	//	if (cell==nil) {
	ATMCustomCell *cell = [[ATMCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:2];
	//	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.title_label.text = [obj objectForKey:@"title"];
	cell.address_label.text = [obj objectForKey:@"address"];
	[cell.tel setTitle:[obj objectForKey:@"tel"] forState:UIControlStateNormal];
	[cell showTel];
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"ATMAdvanceSearchListViewController didSelectRowAtIndexPath:%@", indexPath);
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
	if ([items_data count]>0) {
		ATMOutletMapViewController *outlet_map_controller = [[ATMOutletMapViewController alloc] initWithNibName:@"ATMOutletMapView" bundle:nil];
		[outlet_map_controller addAnnotations:items_data];
		[outlet_map_controller setSelectedAnnotation:indexPath.row + (current_page-1) * current_page_size Delta:0.005];
        outlet_map_controller.isNeedBox = YES;
		[self.navigationController pushViewController:outlet_map_controller animated:TRUE];
		[outlet_map_controller release];
	}
	
}

@end
