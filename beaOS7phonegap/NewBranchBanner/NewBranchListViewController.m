#import "NewBranchListViewController.h"
#import "NewBranchOutletMapViewController.h"
#import "ATMUtil.h"
#import "NewBranchBannerUtil.h"
#import "NewBranchCell.h"

@implementation NewBranchListViewController

@synthesize selected_type, selected_district;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
            shownData:(NSMutableArray*)data
{
	NSLog(@"NewBranchListViewController initWithNibName:%@", nibBundleOrNil);
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		show_no = 100;
		[self defineDefaultTable];
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		lang = [CoreData sharedCoreData].lang;
		items_data = data;
		
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
    
    title_label.text = NSLocalizedString(@"New Opening",nil);
    
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
		
		NSMutableArray* selected_items_data = [NSMutableArray new];
        
		for (int i=0; i<total_record; i++) {
			[selected_items_data addObject:[items_data objectAtIndex:i]];
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
	NSLog(@"NewBranchListViewController getItemsListCuisine:%@--%@", cuisine, location);
	if ([cuisine isEqualToString:NSLocalizedString(@"All",nil)]) {
		cuisine = @"";
	}
	selected_type = location;
	selected_district = cuisine;
	
	[self parseFromFile];
}

- (void)parseFromFile{
	
	current_page = 1;
	   
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
    
	if ([items_data count]>0) {
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
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 111;
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
    //	NSLog(@"NewBranchListViewController cellForRowAtIndexPath:%@--%d", indexPath, [items_data count]);
	
	NSUInteger index = indexPath.row + (current_page-1) * current_page_size;
	id obj = [items_data objectAtIndex:index];
    
    NewBranchCell *cell = [[NewBranchBannerUtil me] getTableViewCell:obj];
    return cell;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"NewBranchListViewController didSelectRowAtIndexPath:%@", indexPath);
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
	if ([items_data count]>0) {
		NewBranchOutletMapViewController *outlet_map_controller = [[NewBranchOutletMapViewController alloc] initWithNibName:@"NewBranchOutletMapView" bundle:nil];
        
        [NewBranchBannerUtil tranferAnnotations:items_data];
        
		[outlet_map_controller addAnnotations:items_data];
		[outlet_map_controller setSelectedAnnotation:indexPath.row + (current_page-1) * current_page_size Delta:0.005];
		[self.navigationController pushViewController:outlet_map_controller animated:TRUE];
		[outlet_map_controller release];
	}
	
}


@end
