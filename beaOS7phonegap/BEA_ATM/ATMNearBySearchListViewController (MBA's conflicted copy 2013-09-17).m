//
//  ATMNearBySearchListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMNearBySearchListViewController.h"
#import "ATMOutletMapViewController.h"
#import "ATMUtil.h"
#import "ATMNearBySearchDistCMSViewController.h"

#define KmMilesRatio	1.6093470878864446
#define max_show_distance 3000
#define default_show_distance 1000
#define min_show_distance 500
#define max_show_no	50
#define default_show_no	30
#define min_show_no	1

@implementation ATMNearBySearchListViewController

@class ATMOutletMapViewController;

@synthesize supremegoldbutton, atmbutton, branchbutton;
@synthesize items_data, sorted_items_data, distance_list, selected_items_data;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		app_setting = [[NSMutableDictionary dictionaryWithDictionary:[PlistOperator openPlistFile:@"setting" Datatype:@"NSDictionary"]] retain];
		show_distance = [[app_setting objectForKey:@"atm_show_distance"] intValue];
		show_no = [[app_setting objectForKey:@"atm_show_no"] intValue];
		if (show_distance < min_show_distance) {
			show_distance = default_show_distance;
			[app_setting setValue:[NSNumber numberWithFloat:show_distance] forKey:@"atm_show_distance"];
			[PlistOperator savePlistFile:@"setting" From:app_setting];
		}
		if (show_distance > max_show_distance) {
			show_distance = max_show_distance;
			[app_setting setValue:[NSNumber numberWithFloat:show_distance] forKey:@"atm_show_distance"];
			[PlistOperator savePlistFile:@"setting" From:app_setting];
		}
		if (show_no < min_show_no) {
			show_no = default_show_no;
			[app_setting setValue:[NSNumber numberWithFloat:show_no] forKey:@"atm_show_no"];
			[PlistOperator savePlistFile:@"setting" From:app_setting];
		}
		if (show_no > max_show_no) {
			show_no = max_show_no;
			[app_setting setValue:[NSNumber numberWithFloat:show_no] forKey:@"atm_show_no"];
			[PlistOperator savePlistFile:@"setting" From:app_setting];
		}
		NSLog(@"show_no, show_distance:%0.2f--%0.2f", show_no, show_distance);
		[self defineDefaultTable];
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		current_type = @"all";
		current_category = @"A";
		sorted_items_data = nil;
		user_location = nil;

    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.frame = CGRectMake(0, 24, 320, 411+[[MyScreenUtil me] getScreenHeightAdjust]);
//    table_view.frame = CGRectMake(0, 164, 320, 263+[[MyScreenUtil me] getScreenHeightAdjust]);
	setting_view.frame = CGRectMake(0, 88, 320, 0);
//	btnSearch.frame = CGRectMake(219, 435+[[MyScreenUtil me] getScreenHeightAdjust], 91, 20);
    [self.view addSubview:setting_view];

    [btnSearch setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
	title_label.text = NSLocalizedString(@"ATM_Nearby",nil);
	offer_no_slider.maximumValue = max_show_no;
	offer_no_slider.minimumValue = min_show_no;
	offer_no_slider.value = show_no;
	offer_distance_slider.maximumValue = max_show_distance;
	offer_distance_slider.minimumValue = min_show_distance;
	offer_distance_slider.value = show_distance;
	offer_no_label.text = [NSString stringWithFormat:@"%@: %.0f", NSLocalizedString(@"Places show in Map",nil), offer_no_slider.value];
	if (offer_distance_slider.value>1000) {
		offer_distance_label.text = [NSString stringWithFormat:@"%@: %.2f %@", NSLocalizedString(@"Distance show in Map",nil), offer_distance_slider.value / 1000.0, NSLocalizedString(@"tag_km", nil)];
	} else {
		offer_distance_label.text = [NSString stringWithFormat:@"%@: %.0f %@", NSLocalizedString(@"Distance show in Map",nil), offer_distance_slider.value, NSLocalizedString(@"tag_m", nil)];
	}
	NSLog(@"distance cur,max,min:%0.2f--%0.2f--%0.2f", offer_distance_slider.value, offer_distance_slider.maximumValue, offer_distance_slider.minimumValue);

//	[supremegoldbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
//	[atmbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//	[branchbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
//
//	[supremegoldbutton setTitle:NSLocalizedString(@"SupremeGold",nil) forState:UIControlStateNormal];
//	[atmbutton setTitle:NSLocalizedString(@"ATM",nil) forState:UIControlStateNormal];
//	[branchbutton setTitle:NSLocalizedString(@"Branch",nil) forState:UIControlStateNormal];

    [_lbDistanceMin setText:NSLocalizedString(@"500m", nil)];
    [_lbDistanceMax setText:NSLocalizedString(@"3km", nil)];
    
//	if (![MBKUtil isLangOfChi]) {
//		supremegoldbutton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//		supremegoldbutton.titleLabel.numberOfLines = 2;
//		supremegoldbutton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
//	}
//	supremegoldbutton.titleLabel.textAlignment = UITextAlignmentCenter;
//	if ([@"_PropertyLoanViewController" isEqualToString:[CoreData sharedCoreData].lastScreen]) {
//		[self BranchButtonPressed:nil];
//	}else if ([@"ConsumerLoanViewController" isEqualToString:[CoreData sharedCoreData].lastScreen]) {
//        [atmbutton removeFromSuperview];
//        [branchbutton setFrame:CGRectMake(branchbutton.frame.origin.x, branchbutton.frame.origin.y , branchbutton.frame.size.width + 52, branchbutton.frame.size.height)];
//        [supremegoldbutton setFrame:CGRectMake(supremegoldbutton.frame.origin.x+52, supremegoldbutton.frame.origin.y, supremegoldbutton.frame.size.width+52, supremegoldbutton.frame.size.height)];
//        [self BranchButtonPressed:nil];
//    }else if([@"AccProViewController" isEqualToString:[CoreData sharedCoreData].lastScreen]) {
//        [atmbutton removeFromSuperview];
//        [branchbutton setFrame:CGRectMake(branchbutton.frame.origin.x, branchbutton.frame.origin.y , branchbutton.frame.size.width + 52, branchbutton.frame.size.height)];
//        [supremegoldbutton setFrame:CGRectMake(supremegoldbutton.frame.origin.x+52, supremegoldbutton.frame.origin.y, supremegoldbutton.frame.size.width+52, supremegoldbutton.frame.size.height)];
//        [self BranchButtonPressed:nil];
//    }else if([@"RateViewController" isEqualToString:[CoreData sharedCoreData].lastScreen]) {
//        [atmbutton removeFromSuperview];
//        [branchbutton setFrame:CGRectMake(branchbutton.frame.origin.x, branchbutton.frame.origin.y , branchbutton.frame.size.width + 52, branchbutton.frame.size.height)];
//        [supremegoldbutton setFrame:CGRectMake(supremegoldbutton.frame.origin.x+52, supremegoldbutton.frame.origin.y, supremegoldbutton.frame.size.width+52, supremegoldbutton.frame.size.height)];
//        [self BranchButtonPressed:nil];
//    }else{
//        [self ATMButtonPressed:nil];
//    }

    RotateMenu2ViewController* v_rmvc = [[[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil] autorelease];
    v_rmvc.rmUtil.caller = self;

    [self.view addSubview:v_rmvc.contentView];
    NSArray *a_texts = [NSLocalizedString(@"rotatemenu.atmsearch.texts",nil) componentsSeparatedByString:@","];
    NSLog(@"v_rmvc.rmUtil setTextArray:%@",a_texts);
    [v_rmvc.rmUtil setTextArray:a_texts];
    
    UIView* view_temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSArray* a_views = [NSArray arrayWithObjects:view_temp , view_temp, view_temp,view_temp, nil];
    [v_rmvc.rmUtil setViewArray:a_views];

    [v_rmvc.rmUtil setNav:self.navigationController];
    [v_rmvc.rmUtil showMenu];

}

-(void)showMenu:(int)show
{
    NSLog(@"showMenu in:%@", self);
    
    if (show%4==0) {
        [self ATMButtonPressed:nil];
    } else if (show%4==1) {
        [self SupremeGoldButtonPressed:nil];
    } else if (show%4==2) {
        [self iFinancialButtonPressed:nil];
    } else if (show%4==3) {
        [self BranchButtonPressed:nil];
    }
}

- (void) startToGetNearBy{
	NSLog(@"startToGetNearBy");

	locmgr = nil;
	user_location = nil;
	sorted_items_data = nil;
	items_data = nil;
	if (sorted_items_data!=nil) {
		[sorted_items_data removeAllObjects];
	}
	if (items_data!=nil) {
		[items_data removeAllObjects];
	}
	locmgr = [[CLLocationManager alloc] init];
	locmgr.delegate = self;
    if ([CLLocationManager locationServicesEnabled]) {
        //	if (locmgr.locationServicesEnabled) {
		[locmgr startUpdatingLocation];
		[[CoreData sharedCoreData].mask showMask];
	}
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
    [self setLbDistanceMax:nil];
    [self setLbDistanceMin:nil];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	if (user_location!=nil) {
		[user_location release];
	}
	[distance_list release];
	//[sorted_items_data release];
	[items_data release];
    [_lbDistanceMin release];
    [_lbDistanceMax release];
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

-(void)sortTableItem {
	NSLog(@"sortTableItem begin");
	if (user_location==nil || items_data==nil || [items_data count]<1) {
		NSLog(@"sortTableItem temp");
		return;
	} else {
		sorted_items_data = [NSMutableArray new];
		[distance_list removeAllObjects];
		for (int i=0; i<[items_data count]; i++) {
			float distance = [(NSString*)[[items_data objectAtIndex:i] objectForKey:@"distance"] floatValue];
			int index = [distance_list count];
			for (int j=[distance_list count]-1; j>=0; j--) {
				if (distance < [[distance_list objectAtIndex:j] floatValue]) {
					index = j;
				}
			}
			if (distance <= show_distance) {
				[sorted_items_data insertObject:[items_data objectAtIndex:i] atIndex:index];
				[distance_list insertObject:[NSNumber numberWithFloat:distance] atIndex:index];
			}
		}

		items_data = sorted_items_data;

        [ATMUtil moveForwardItemsByKey:items_data];

		while ([sorted_items_data count]>show_no) {
			[sorted_items_data removeLastObject];
		}

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

		result.text = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"ATMSearch1",nil),[items_data count],NSLocalizedString(@"ATMSearch2",nil)];

		NSLog(@"sortTableItem end:%d",[sorted_items_data count]);
	}
}

-(void)selectMerchant:(int)merchant_id {
	[self tableView:table_view didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:merchant_id inSection:0]];
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

-(IBAction)settingButtonPressed:(UIButton *)button {
	next.hidden = TRUE;
	prev.hidden = TRUE;
	title_label.text = NSLocalizedString(@"Setting",nil);
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
	setting_view.hidden = NO;
	setting_view.frame = CGRectMake(0, 88, 320, 372+[[MyScreenUtil me] getScreenHeightAdjust]);
//	[UIView commitAnimations];
}

-(IBAction)settingCloseButtonPressed:(UIButton *)button {
	show_distance = offer_distance_slider.value;
	show_no = offer_no_slider.value;
	[app_setting setValue:[NSNumber numberWithFloat:show_distance] forKey:@"atm_show_distance"];
	[app_setting setValue:[NSNumber numberWithFloat:show_no] forKey:@"atm_show_no"];
	[PlistOperator savePlistFile:@"setting" From:app_setting];
	title_label.text = NSLocalizedString(@"ATM_Nearby",nil);
	[[CoreData sharedCoreData].mask showMask];

//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.2];
	setting_view.frame = CGRectMake(0, 88, 320, 0);
//	[UIView commitAnimations];

    //	[self performSelector:@selector(parseFromFile) withObject:nil afterDelay:0.5];
    [self stepone];
//    [self performSelector:@selector(stepone) withObject:nil afterDelay:1.5];
}

- (void)parseFromFile {
	[[CoreData sharedCoreData].mask showMask];

	items_data = nil;
	current_page = 1;

	NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[MBKUtil me] getDocATMplistPath]];
	items_data = [md_temp objectForKey:@"atmlist"];
	NSLog(@"parseFromFile count:%d", [items_data count]);

	if ([items_data count]>0){
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
	}else {
		total_page = 0;
		current_page = 0;
		prev.hidden = TRUE;
		next.hidden = TRUE;
		items_data = nil;
		sorted_items_data = nil;
	}

	NSLog(@"parseFromFile begin sort:items,sorted:%d--%d", [items_data count], [sorted_items_data count]);

	if ([items_data count]<=0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No result in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		sorted_items_data = items_data;
		[self selecteTypes];
		[self calculateDistance];
		[self sortTableItem];
		[table_view reloadData];
	}

	result.text = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"ATMSearch1",nil),[items_data count],NSLocalizedString(@"ATMSearch2",nil)];

	NSLog(@"parseFromFile end sort:items,sorted:%d--%d", [items_data count], [sorted_items_data count]);

	[[CoreData sharedCoreData].mask hiddenMask];

}

-(IBAction)mapButtonPressed:(UIButton *)button {
	if ([sorted_items_data count]>0) {
		ATMOutletMapViewController *outlet_map_controller = [[ATMOutletMapViewController alloc] initWithNibName:@"ATMOutletMapView" bundle:nil];
		[self.navigationController pushViewController:outlet_map_controller animated:TRUE];
		[outlet_map_controller addAnnotations:sorted_items_data];
		[outlet_map_controller setSelectedAnnotation:0 Delta:0.005];
		[outlet_map_controller release];
	}
}

-(IBAction)showOfferChange:(UISlider *)slider {
	offer_no_label.text = [NSString stringWithFormat:@"%@: %.0f", NSLocalizedString(@"Offers show in Map",nil), offer_no_slider.value];
	//	offer_no.text = [NSString stringWithFormat:@"%.0f", slider.value];
}

-(IBAction)showDistanceChange:(UISlider *)slider {
	if (offer_distance_slider.value>1000) {
		offer_distance_label.text = [NSString stringWithFormat:@"%@: %.2f %@", NSLocalizedString(@"Distance show in Map",nil), offer_distance_slider.value / 1000.0, NSLocalizedString(@"tag_km", nil)];
	} else {
		offer_distance_label.text = [NSString stringWithFormat:@"%@: %.0f %@", NSLocalizedString(@"Distance show in Map",nil), offer_distance_slider.value, NSLocalizedString(@"tag_m", nil)];
	}
}


///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row + (current_page-1) * current_page_size;
    ATMCustomCellCMS* cell = [self genCell:sorted_items_data by:index];
    int height = cell.frame.size.height;
    return height;
}

- (ATMCustomCellCMS*) genCell:(NSMutableArray*)datas by:(NSUInteger)index
{
	id obj = [datas objectAtIndex:index];
	NSLog(@"ATMNearBySearchListViewController genCell:%@", obj);
    
	NSString *identifier = @"ATMCustomCellCMS";
	ATMCustomCellCMS *cell = [[ATMCustomCellCMS alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier mystyle:(++index%2)];
	
    cell.title_label.text = [obj objectForKey:@"branch"];
	cell.address_label.text = [obj objectForKey:@"address"];
    
	if ([[obj objectForKey:@"distance"] floatValue]<1000) {
		cell.distance_label.text = [NSString stringWithFormat:@"%.0f%@",[[obj objectForKey:@"distance"] floatValue], NSLocalizedString(@"tag_m", nil)];
	} else {
		cell.distance_label.text = [NSString stringWithFormat:@"%.2f%@",[[obj objectForKey:@"distance"] floatValue] / 1000.0, NSLocalizedString(@"tag_km", nil)];
	}
	[cell.tel setTitle:[obj objectForKey:@"tel"] forState:UIControlStateNormal] ;
	cell.description_label.text = [obj objectForKey:@"opeinghour"];
    if ([current_category isEqualToString:@"2"]) {
        [cell set2ATM];
    } else {
        [cell setPlace];
    }

    return cell;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	if ([sorted_items_data count]<1) {
		return 0;
	}
	int total_record = [sorted_items_data count];
	if (total_record - (current_page-1) * current_page_size > current_page_size) {
		return current_page_size;
	} else {
		return total_record - (current_page-1) * current_page_size;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row + (current_page-1) * current_page_size;
    ATMCustomCellCMS* cell = [self genCell:sorted_items_data by:index];
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];

	NSLog(@"ATMNearBySearchListViewController didSelectRowAtIndexPath:%@---%d", indexPath, [sorted_items_data count]);
	if ([sorted_items_data count]>0) {
		ATMOutletMapViewController *outlet_map_controller = [[ATMOutletMapViewController alloc] initWithNibName:@"ATMOutletMapView" bundle:nil];
		[self.navigationController pushViewController:outlet_map_controller animated:TRUE];
		[outlet_map_controller addAnnotations:sorted_items_data];
        //        NSLog(@"ATMNearBySearchListViewController didSelectRowAtIndexPath:%@", sorted_items_data);
		[outlet_map_controller setSelectedAnnotation:indexPath.row + (current_page-1) * current_page_size Delta:0.005];
		[outlet_map_controller release];
	}
}

//////////////////
//DataUpdaterDelegate
//////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
	NSLog(@"debug ATMNearBySearchListViewController requestFinished:%@", reponsedString);
    //	if ([request_type isEqualToString:@"stepone"]) {
    //		request_type = @"steptwo";
    //		[self checkATMListDelta:[request responseData]];
    //	}
    //	[self parseFromFile];

    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];

}

- (void)requestFailed:(ASIHTTPRequest *)request {

	//	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	//	[alert_view show];
	//	[alert_view release];
	//	[[CoreData sharedCoreData].mask hiddenMask];
	//	[request release];

    //	[self parseFromFile];

}
////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	[items_data removeAllObjects];
    items_data = nil;
    items_data = [NSMutableArray new];
	current_page = 1;
	key = [NSArray arrayWithObjects:
           @"id",
           @"tel",
           @"fax",
           @"district1",
           @"lat",
           @"lon",
           @"iconshow",
           @"distance",
           @"branch",
           @"address",
           @"opeinghour",
           @"contacts",
           @"services",
           @"categories",
           nil];
    //	NSLog(@"debug parserDidStartDocument:%@",key);
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
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

	NSLog(@"debug parserDidEndDocument:%d outlets",[items_data count]);
	result.text = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"ATMSearch1",nil),[items_data count],NSLocalizedString(@"ATMSearch2",nil)];
	if ([items_data count]==0) {
        [table_view reloadData];

		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No result in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		sorted_items_data = items_data;
        [self calculateDistance];

		[table_view reloadData];
		//[self sortTableItem];
	}
    //	NSLog(@"debug parserDidEndDocument:%@",items_data);
    [[CoreData sharedCoreData].mask hiddenMask];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
	}
    //	NSLog(@"debug didStartElement:%@",elementName);
}

-(void)fixspace:(NSMutableDictionary*)dic key:(NSString*)akey
{
    NSString* value=[dic objectForKey:akey];
    NSLog(@"debug fixspace begin:[%@]--[%@]", akey, value);
    if (value == nil){
        value = @"";
    }
    
    if ([akey isEqualToString:@"opeinghour"]
        ||
        [akey isEqualToString:@"branch"]
        ||
        [akey isEqualToString:@"address"]
        ) {
        //        value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\t\t" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\n\t" withString:@""];
    } else {
        value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }

    NSLog(@"debug fixspace end:[%@]", value);
    [dic setObject:value forKey:akey];
    return;
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {
        [self fixspace:temp_record key:@"tel"];
        [self fixspace:temp_record key:@"address"];
        [self fixspace:temp_record key:@"branch"];
        [self fixspace:temp_record key:@"categories"];
        [self fixspace:temp_record key:@"contacts"];
        [self fixspace:temp_record key:@"distance"];
        [self fixspace:temp_record key:@"district1"];
        [self fixspace:temp_record key:@"fax"];
        [self fixspace:temp_record key:@"iconshow"];
        [self fixspace:temp_record key:@"id"];
        [self fixspace:temp_record key:@"lat"];
        [self fixspace:temp_record key:@"lon"];
        [self fixspace:temp_record key:@"services"];
        [self fixspace:temp_record key:@"opeinghour"];

		[items_data addObject:temp_record];
        //        NSLog(@"debug didEndElement----:%@",temp_record);
	}
    //	NSLog(@"debug didEndElement:%@",elementName);
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	for (int i=0; i<[key count]; i++) {
		if ([currentElementName isEqualToString:[key objectAtIndex:i]]) {
            NSString * oldstr = [temp_record objectForKey:currentElementName];
            if (!oldstr){
                oldstr = @"";
            }
            oldstr = [oldstr stringByAppendingString:string];
			[temp_record setObject:oldstr forKey:currentElementName];
            //            NSLog(@"debug foundCharacters++++:%@ %@",currentElementName,string);
		}
	}
    //	NSLog(@"debug foundCharacters:%@",currentElementName);
}


/////////////////////////
//LocationManagerDelegate
/////////////////////////
-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//	NSLog(@"my locmgr:%@", locmgr);
	if (newLocation.coordinate.latitude==0 || newLocation.coordinate.longitude==0 || user_location!=nil) {
		return;
	}
	[locmgr stopUpdatingLocation];
	user_location = [newLocation copy];
	NSLog(@"my gps:%f--%f--%d",user_location.coordinate.latitude,user_location.coordinate.longitude,[[MBKUtil me].mvflag intValue]);
    //	if ([[MBKUtil me].mvflag intValue] < 1){
    //		[[MBKUtil me] increaseMvflag];
    [self stepone];
    //	}
    //        else {
    //		[self parseFromFile];
    //	}

}

-(void)stepone{
	request_type = @"stepone";
    /*
     NSURL *url = [NSURL URLWithString:[MBKUtil getURLOfgetATMListOTA]];
     asi_request = nil;
     asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
     NSLog(@"stepone url:%@",asi_request.url);
     [asi_request setUsername:@"iphone"];
     [asi_request setPassword:@"iphone"];
     [asi_request setValidatesSecureCertificate:NO];
     asi_request.delegate = self;
     [[CoreData sharedCoreData].queue addOperation:asi_request];
     */

    //    ASIFormDataRequest *request = [HttpRequestUtils getPostRequest4steponeCMS:self];
    //    [[CoreData sharedCoreData].queue addOperation:request];
    ASIHTTPRequest* asi_request = [[ASIHTTPRequest alloc]
                                   initWithURL:
                                   [NSURL
                                    URLWithString:
                                    [NSString
                                     stringWithFormat:@"%@getbranch.api?lat=%f&lon=%f&dist=%0.1f&limitshow=%0.0f&lang=%@&cat=%@",
                                     [CoreData sharedCoreData].realServerURL,
                                     user_location.coordinate.latitude,
                                     user_location.coordinate.longitude,
                                     show_distance/1000,
                                     show_no,
                                     [[LangUtil me] getLangID],
                                     current_category]]];
    NSLog(@"debug ATMNearBySearchListViewController stepone:%@",asi_request.url);
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];

	[[CoreData sharedCoreData].mask showMask];
}

- (void) checkATMListDelta:(NSData*)datas{
	NSString *ns_temp_file = [MBKUtil getDocTempFilePath];
	//	NSLog(@"checkATMListDelta:<rsp>%@</rsp>", datas);
	[datas writeToFile:ns_temp_file atomically:YES];

    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:ns_temp_file];
	NSLog(@"dict:%d", [md_temp count]);
	NSString * atmlist_sn = [md_temp objectForKey:@"SN"];
	NSLog(@"checkATMListDelta:<new>%@</new>--<old>%@</old>", atmlist_sn, [[MBKUtil me] getATMListSNFromLocal]);
	if (atmlist_sn==nil || [atmlist_sn isEqualToString:@""] || [atmlist_sn isEqualToString:[[MBKUtil me] getATMListSNFromLocal]]){
	}else {
		NSArray *rsp_atmlist = [md_temp objectForKey:@"atmlist"];
		NSDictionary *rsp_item;
		NSString *expire;
		NSString *item_id;
		NSString *item_id_old;
		if (atmlist_sn!=nil && ![atmlist_sn isEqualToString:@""]){
			NSMutableDictionary *old_atmplist = [NSMutableDictionary dictionaryWithContentsOfFile:[[MBKUtil me] getDocATMplistPath]];
			NSMutableArray *old_atmlist = [old_atmplist objectForKey:@"atmlist"];
			if (old_atmlist==nil || [old_atmlist count]<=0) {
				old_atmlist = [NSMutableArray new];
			}
			NSLog(@"delta all:%@--<rsp>%d---<old>%d", [[MBKUtil me] getDocATMplistPath], [rsp_atmlist count], [old_atmlist count]);

			NSDictionary *old_item;
			BOOL isExistRecord = FALSE;
			int index_process = 0;

			for (int i=0; i<[rsp_atmlist count]; i++) {
				rsp_item = [rsp_atmlist objectAtIndex:i];
				expire = [rsp_item objectForKey:@"expire"];
				item_id = [rsp_item objectForKey:@"id"];
				isExistRecord = FALSE;
				index_process = 0;
				old_item = nil;
				item_id_old = nil;

				NSLog(@"searching...:%@--%@", [rsp_item objectForKey:@"id"], [rsp_item objectForKey:@"title"]);

				for (index_process=0; index_process<[old_atmlist count]; index_process++) {
					old_item = [old_atmlist objectAtIndex:index_process];
					item_id_old = [old_item objectForKey:@"id"];
					if ([item_id isEqualToString:item_id_old]){
						isExistRecord = TRUE;
						break;
					}
				}

				NSLog(@"searched:%d--%d", index_process, isExistRecord);

				if (isExistRecord) {
					[old_atmlist removeObjectAtIndex:index_process];
					NSLog(@"delete:%d", index_process);
					if (![expire isEqualToString:@"1"]){//edit
						[old_atmlist insertObject:rsp_item atIndex:index_process];
						NSLog(@"add:%d--%@", [old_atmlist count], rsp_item);
					}else {//delete
					}
				}else {
					[old_atmlist insertObject:rsp_item atIndex:index_process];
					NSLog(@"add:%d--%@", [old_atmlist count], rsp_item);
				}

			}

			NSLog(@"delta old:%d", [old_atmlist count]);

            //			if ([old_atmlist count]<1) {
            //				old_item = [NSDictionary dictionaryWithObject:@"0" forKey:@"id"];
            //				[old_atmlist insertObject:old_item atIndex:0];
            //			}

			NSMutableDictionary *updated_atm_plist = [NSMutableDictionary new];
			[updated_atm_plist setObject:atmlist_sn forKey:@"SN"];
			[updated_atm_plist setObject:old_atmlist forKey:@"atmlist"];
			[updated_atm_plist writeToFile:[[MBKUtil me] getDocATMplistPath] atomically:YES];
		}
	}
	[[NSFileManager defaultManager] removeItemAtPath:ns_temp_file error:nil];
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	[locmgr stopUpdatingLocation];
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) calculateDistance{
    //	NSLog(@"calculateDistance");
	if (user_location==nil || [items_data count]<1) {
		return;
	} else {
		for (int i=0; i<[items_data count]; i++) {
            //			NSArray *gps_list = [[[items_data objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
            CLLocationDegrees latitude = [[[items_data objectAtIndex:i] objectForKey:@"lat"] doubleValue];
            CLLocationDegrees longitude = [[[items_data objectAtIndex:i] objectForKey:@"lon"] doubleValue];
			CLLocation *shop_location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
			float distance = [user_location distanceFromLocation:shop_location];
			NSString *nsdistance = [NSString stringWithFormat:@"%0.2f", distance];
			[[items_data objectAtIndex:i] setObject:nsdistance forKey:@"distance"];
		}
	}
}

-(void) selecteTypes{
	NSLog(@"selecteTypes begin: sorted, items, cur_cat:%d--%d--%@", [sorted_items_data count], [items_data count], current_category);
	int total_record = [items_data count];
	if (NSOrderedSame==[current_category compare:@"all"]) {
	}else{
		sorted_items_data = [NSMutableArray new];
		for (int i=0; i<total_record; i++) {
			id obj = [items_data objectAtIndex:i];
			NSString *selected_gategory = [obj objectForKey:@"category"];
            NSString *item_expire = [obj objectForKey:@"expire"];
			if( NSOrderedSame == [current_category compare:selected_gategory] && [item_expire isEqualToString:@"0"]){
				[sorted_items_data addObject:[items_data objectAtIndex:i]];
			}
		}
		items_data = sorted_items_data;
	}
	result.text = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"ATMSearch1",nil),[sorted_items_data count],NSLocalizedString(@"ATMSearch2",nil)];

	NSLog(@"selecteTypes end: sorted, items:%d--%d", [sorted_items_data count], [items_data count]);
}

-(IBAction)SupremeGoldButtonPressed:(UIButton *)button
{
	NSLog(@"SupremeGoldButtonPressed:%@", button);
	[supremegoldbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[atmbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
	[branchbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    //	current_category = @"S";
	current_category = @"5";
	[self startToGetNearBy];
}

-(IBAction)ATMButtonPressed:(UIButton *)button
{
	NSLog(@"ATMButtonPressed:%@", button);
	[supremegoldbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
	[atmbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[branchbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    //	current_category = @"A";
	current_category = @"2";
	[self startToGetNearBy];
}

-(IBAction)BranchButtonPressed:(UIButton *)button
{
	NSLog(@"BranchButtonPressed:%@", button);
	[supremegoldbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
	[atmbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
	[branchbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //	current_category = @"B";
	current_category = @"4";
	[self startToGetNearBy];
}

-(IBAction)iFinancialButtonPressed:(UIButton *)button
{
	NSLog(@"iFinancialButtonPressed:%@", button);
	[supremegoldbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
	[atmbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
	[branchbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //	current_category = @"B";
	current_category = @"3";
	[self startToGetNearBy];
}

-(IBAction)searchButtonPressed:(UIButton *)button
{
    ATMNearBySearchDistCMSViewController* current_view_controller = [[ATMNearBySearchDistCMSViewController alloc] initWithNibName:@"ATMNearBySearchDistCMSView" bundle:nil];
    [[CoreData sharedCoreData].atmlocation_view_controller.navigationController pushViewController:current_view_controller animated:TRUE];
    [current_view_controller release];
}

@end
