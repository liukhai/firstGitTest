//
//  NearBySearchListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NearBySearchListViewController.h"
#define KmMilesRatio	1.6093470878864446

@implementation NearBySearchListViewController
@synthesize useInMap;
@synthesize outletMapVC;
@synthesize setting_view;
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		app_setting = [[NSMutableDictionary dictionaryWithDictionary:[PlistOperator openPlistFile:@"setting" Datatype:@"NSDictionary"]] retain];
		show_distance = [[app_setting objectForKey:@"show_distance"] intValue];
		show_no = [[app_setting objectForKey:@"show_no"] intValue];
		[self defineDefaultTable];
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		current_type = @"all";
		current_category = @"all";
		sorted_items_data = [NSMutableArray new];
		user_location = nil;

    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
     [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    [self.view addSubview:setting_view];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
//    self.view.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
//    UIImageView *bgv2 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[setting_view insertSubview:bgv2 atIndex:0];
//    bgv2.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
//    setting_view.frame = CGRectMake(0, 45, 320, 0);
//    table_view.frame = CGRectMake(0, 73, 320, 294+[[MyScreenUtil me] getScreenHeightAdjust]);

//	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
//	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
	title_label.text = NSLocalizedString(@"Nearby",nil);
	offer_no_label.text = NSLocalizedString(@"Offers show in Map",nil);
	offer_distance_label.text = NSLocalizedString(@"Distance show in Map",nil);
	offer_no_slider.value = [[app_setting objectForKey:@"show_no"] intValue];
	offer_distance_slider.value = [[app_setting objectForKey:@"show_distance"] intValue];
	offer_no_label_num.text = [NSString stringWithFormat:@"%.0f",offer_no_slider.value];
//	if (offer_distance_slider.value>1000) {
//		offer_distance_label_num.text = [NSString stringWithFormat:@"%@: \t%.2f km", NSLocalizedString(@"Distance show in Map",nil), offer_distance_slider.value / 1000];
//	} else {
		offer_distance_label_num.text = [NSString stringWithFormat:@"%.0f ",offer_distance_slider.value];
//	}
//	setting_view.frame = CGRectMake(0, 45, 320, 0);
	locmgr = [[CLLocationManager alloc] init];
	locmgr.delegate = self;
//	if (locmgr.locationServicesEnabled) {
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] >= kCLAuthorizationStatusAuthorized) {
        //	if (locmgr.locationServicesEnabled) {
		[locmgr startUpdatingLocation];
		[[CoreData sharedCoreData].mask showMask];
	}else {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Location_setting_nearby_atm",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
    }
    
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
 //jerry   [v_rmvc.rmUtil setNav:self.navigationController];
    [self.view addSubview:v_rmvc.contentView];
    
//    NSArray *navVC1 = self.navigationController.viewControllers;
//    NSArray *navVC2 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
//    [v_rmvc.rmUtil setNav:[CoreData sharedCoreData].root_view_controller.navigationController];
    [v_rmvc.rmUtil setNav:self.navigationController];
	NSLog(@"viewDidLoad Complete");
	
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

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
	if (user_location!=nil) {
		[user_location release];
	}
	//[distance_list release];
	//[sorted_items_data release];
	[items_data release];
//    asi_request.delegate = nil;
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

/*-(void)sortTableItem {
	if (user_location==nil || [items_data count]<1) {
		NSLog(@"waiting");
		return;
	} else {
		[sorted_items_data removeAllObjects];
		[distance_list removeAllObjects];
		for (int i=0; i<[items_data count]; i++) {
			NSArray *gps_list = [[[items_data objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
			CLLocation *shop_location = [[CLLocation alloc] initWithLatitude:[[gps_list objectAtIndex:0] floatValue] longitude:[[gps_list objectAtIndex:1] floatValue]];
			float distance = [user_location getDistanceFrom:shop_location];
			int index = [distance_list count];
			for (int j=[distance_list count]-1; j>=0; j--) {
				if (distance < [[distance_list objectAtIndex:j] floatValue]) {
					index = j;
				}
			}
			[sorted_items_data insertObject:[items_data objectAtIndex:i] atIndex:index];
			[distance_list insertObject:[NSNumber numberWithFloat:distance] atIndex:index];
		}
		while ([sorted_items_data count]>show_no) {
			[sorted_items_data removeLastObject];
		}
		NSLog(@"%d items in distance",[sorted_items_data count]);
		[table_view reloadData];
	}
}*/

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
//	title_label.text = NSLocalizedString(@"Setting",nil);
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
    setting_view.frame = CGRectMake(0, 0, 320, 480+[[MyScreenUtil me] getScreenHeightAdjust]);
    
//    if (useInMap) {
//        setting_view.frame = CGRectMake(0, 0, 320, 397+[[MyScreenUtil me] getScreenHeightAdjust]);
//    }
    [setting_view.superview bringSubviewToFront:setting_view];
    setting_view.hidden=NO;
    offer_no_slider.accessibilityValue = [NSString stringWithFormat:@"%.0f", offer_no_slider.value];
    offer_distance_slider.accessibilityValue = [NSString stringWithFormat:@"%.0f",offer_distance_slider.value];
//	[UIView commitAnimations];
}

-(IBAction)settingCloseButtonPressed:(UIButton *)button {
	asi_request = nil;
	user_location = nil;
	show_distance = offer_distance_slider.value;
	show_no = offer_no_slider.value;
	[app_setting setValue:[NSNumber numberWithFloat:show_distance] forKey:@"show_distance"];
	[app_setting setValue:[NSNumber numberWithFloat:show_no] forKey:@"show_no"];
	[PlistOperator savePlistFile:@"setting" From:app_setting];
	title_label.text = NSLocalizedString(@"Nearby",nil);
	[[CoreData sharedCoreData].mask showMask];
	[sorted_items_data removeAllObjects];
	[items_data removeAllObjects];
	locmgr = [[CLLocationManager alloc] init];
	locmgr.delegate = self;
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] >= kCLAuthorizationStatusAuthorized) {
        //	if (locmgr.locationServicesEnabled) {
		[locmgr startUpdatingLocation];
		[[CoreData sharedCoreData].mask showMask];
	}else {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Location_setting_nearby_atm",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
    }
//	[self sortTableItem];
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
	setting_view.frame = CGRectMake(0, 45, 320, 0);
//	[UIView commitAnimations];
}

-(IBAction)mapButtonPressed:(UIButton *)button {
	if ([sorted_items_data count]>0) {
		OutletMapViewController *outlet_map_controller = [[OutletMapViewController alloc] initWithNibName:@"OutletMapView" bundle:nil];
        outlet_map_controller.settingDic = [app_setting retain];
        [outlet_map_controller addAnnotations:sorted_items_data];
 //       [outlet_map_controller.map_view_controller loadAnnotationsDetailinfo:sorted_items_data settingValue:app_setting];
		[outlet_map_controller setSelectedAnnotation:0 Delta:0.005];
        outlet_map_controller.isNeedBox = NO;
		[self.navigationController pushViewController:outlet_map_controller animated:TRUE];
		[outlet_map_controller release];
        [app_setting release];
	}
	/*	YearRoundOffersMapViewController *map_view_controller = [[YearRoundOffersMapViewController alloc] initWithNibName:@"YearRoundOffersMapView" bundle:nil];
	map_view_controller.items_data = sorted_items_data;
	[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:map_view_controller animated:TRUE];
	[map_view_controller createAnnotationList];
	[map_view_controller setSelectShop:0];
	[map_view_controller release];*/
}

-(IBAction)homeButtonPressed:(UIBarButtonItem *)button {
	[(RootViewController *)[CoreData sharedCoreData].root_view_controller setContent:-1];
}

-(IBAction)showOfferChange:(UISlider *)slider {
	offer_no_label_num.text = [NSString stringWithFormat:@"%.0f", slider.value];
    offer_no_slider.accessibilityValue = [NSString stringWithFormat:@"%.0f", slider.value];
}

-(IBAction)showDistanceChange:(UISlider *)slider {
//	if (offer_distance_slider.value>1000) {
//		offer_distance_label.text = [NSString stringWithFormat:@"%@: \t%.2f km", NSLocalizedString(@"Distance show in Map",nil), offer_distance_slider.value / 1000];
//	} else {
//		offer_distance_label.text = [NSString stringWithFormat:@"%@: \t%.0f", NSLocalizedString(@"Distance show in Map",nil), offer_distance_slider.value];
//	}
    offer_distance_label_num.text = [NSString stringWithFormat:@"%.0f",offer_distance_slider.value];
    offer_distance_slider.accessibilityValue = [NSString stringWithFormat:@"%.0f",offer_distance_slider.value];
}


///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	int total_record = [sorted_items_data count];
	if (total_record - (current_page-1) * current_page_size > current_page_size) {
		return current_page_size;
	} else {
		return total_record - (current_page-1) * current_page_size;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = @"CustomCell2";
//	CustomCell2 *cell = (CustomCell2 *)[table_view dequeueReusableCellWithIdentifier:identifier];
//	if (cell==nil) {
	CustomCell2 *cell = [[CustomCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
//	}
//    ATMCustomCellCMS *cell = [[ATMCustomCellCMS alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];

//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSLog(@"row: %d, data is %@", indexPath.row + (current_page-1) * current_page_size, [sorted_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size]);
	cell.title_label.text = [[sorted_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"title"];
	cell.description_label.text = [[[sorted_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"shortdescription"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
	//NSLog(@"%@",[distance_list objectAtIndex:indexPath.row]);
	if ([[[sorted_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"distance"] floatValue]<1) {
		cell.distance_label.text = [NSString stringWithFormat:@"%.0fm",[[[sorted_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"distance"] floatValue] * 1000];
	} else {
		cell.distance_label.text = [NSString stringWithFormat:@"%.2fkm",[[[sorted_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"distance"] floatValue]];
	}

	/*if ([[distance_list objectAtIndex:indexPath.row + (current_page-1) * current_page_size] floatValue]<1000) {
		cell.distance_label.text = [NSString stringWithFormat:@"%.0fm",[[distance_list objectAtIndex:indexPath.row + (current_page-1) * current_page_size] floatValue]];
	} else {
		cell.distance_label.text = [NSString stringWithFormat:@"%.2fkm",[[distance_list objectAtIndex:indexPath.row + (current_page-1) * current_page_size] floatValue]/1000];
	}*/
	if (![[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"card"] isEqualToString:@"Core"]) {
		cell.platinum.hidden = FALSE;
	} else {
		cell.platinum.hidden = TRUE;
	}
	NSString *image = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"image"];
	if (image!=nil && ![image isEqualToString:@""]) {
		[cell.cached_image_view loadImageWithURL:[[[sorted_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"image"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
	}
	if ([[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
		cell.is_new.hidden = FALSE;
	} else {
		cell.is_new.hidden = TRUE;
	}
	//NSLog(@"%@",[[sorted_items_data objectAtIndex:indexPath.row] objectForKey:@"image"]);
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	NSString *suprise = [[sorted_items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"suprise"];
	if ([suprise isEqualToString:@"false"]) {
		YearRoundOffersSummaryViewController *summary_controller = [[YearRoundOffersSummaryViewController alloc] initWithNibName:@"YearRoundOffersSummaryView" bundle:nil];
		NSLog(@"show distance %f",show_distance);
        [CoreData sharedCoreData].menuType = @"1";
		summary_controller.show_distance = show_distance;
		summary_controller.merchant_info = [sorted_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size];
        summary_controller.title_label.text = title_label.text;
        summary_controller.headingTitle = NSLocalizedString(@"Year-round Offers", nil);
		[self.navigationController pushViewController:summary_controller animated:TRUE];
		[summary_controller release];
	} else {
		QuarterlySurpriseSummaryViewController *summary_controller = [[QuarterlySurpriseSummaryViewController alloc] initWithNibName:@"QuarterlySurpriseSummaryView" bundle:nil];
		summary_controller.show_distance = show_distance;
		summary_controller.merchant_info = [sorted_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size];
        summary_controller.headingTitle = NSLocalizedString(@"Quarterly Surprise", nil);
		[self.navigationController pushViewController:summary_controller animated:TRUE];
		summary_controller.title_label.text = title_label.text;
		[summary_controller release];
		
	}

/*	YearRoundOffersMapViewController *map_view_controller = [[YearRoundOffersMapViewController alloc] initWithNibName:@"YearRoundOffersMapView" bundle:nil];
	map_view_controller.items_data = sorted_items_data;
	[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:map_view_controller animated:TRUE];
	[map_view_controller createAnnotationList];
	[map_view_controller setSelectShop:indexPath.row];
	[map_view_controller release];*/
}

//////////////////
//DataUpdaterDelegate
//////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data

    NSLog(@"debug nearbysearchlistvc requestFinished:%@",[request responseString]);
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[[CoreData sharedCoreData].mask hiddenMask];
	[request release];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"NearBySearchListViewController: request:%@", request.error);
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
	[request release];
	
}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	[items_data removeAllObjects];
	current_page = 1;
	key = [NSArray arrayWithObjects:@"id",@"title",@"merchant",@"etitle",@"shortdescription",@"description",@"category",@"cuisine",@"image",@"suprise",@"card",@"gps",@"distance",@"remark",@"newitem",nil];
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
	
	NSLog(@"%d outlets",[items_data count]);
	result.text = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"Search1",nil),[items_data count],NSLocalizedString(@"Search2",nil)];
	if ([items_data count]==0) {
        if (useInMap) {
            [outletMapVC.map_view_controller.map removeAnnotations:outletMapVC.map_view_controller.map.annotations];
            [outletMapVC addAnnotations:sorted_items_data];
        }
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No offer in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
        
	} else {
		sorted_items_data = items_data;
		[table_view reloadData];
        if (useInMap) {
            [outletMapVC.map_view_controller.map removeAnnotations:outletMapVC.map_view_controller.map.annotations];
            [outletMapVC addAnnotations:sorted_items_data];
        }
		//[self sortTableItem];
	}

}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
	}
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {
		[items_data addObject:temp_record];
	}
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	for (int i=0; i<[key count]; i++) {
		if ([currentElementName isEqualToString:[key objectAtIndex:i]] && [temp_record objectForKey:currentElementName]==nil) {
			[temp_record setObject:string forKey:currentElementName];
			//NSLog(@"%@ %@",currentElementName,string);
		}
	}
}

/////////////////////////
//LocationManagerDelegate
/////////////////////////
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"Location updated New");
	if (newLocation.coordinate.latitude==0 || newLocation.coordinate.longitude==0 || user_location!=nil) {
		return;
	}
	[locmgr stopUpdatingLocation];
	user_location = [newLocation copy];
	if (asi_request==nil) {
		asi_request = [[ASIHTTPRequest alloc] initWithURL:
                       [NSURL URLWithString:
                        [NSString stringWithFormat:@"%@beaofferslist.api?lat=%f&lon=%f&dist=%f&ps=%.0f&lang=%@&UDID=%@",
                         [CoreData sharedCoreData].realServerURLCard,
                         newLocation.coordinate.latitude,
                         newLocation.coordinate.longitude,
                         show_distance/1000,
                         show_no,
                         [CoreData sharedCoreData].lang,
                         [CoreData sharedCoreData].UDID]]];
		NSLog(@"debug NearBySearchListViewController didUpdateToLocation:%@",asi_request.url);
		asi_request.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request];
	}

}

//Deprecated in iOS 6.0
//-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//	NSLog(@"Location updated Old");
//	if (newLocation.coordinate.latitude==0 || newLocation.coordinate.longitude==0 || user_location!=nil) {
//		return;
//	}
//	[locmgr stopUpdatingLocation];
//	user_location = [newLocation copy];
////	NSLog(@"debug didUpdateToLocation:%f %f",user_location.coordinate.latitude,user_location.coordinate.longitude);
//	if (asi_request==nil) {
//		asi_request = [[ASIHTTPRequest alloc] initWithURL:
//                       [NSURL URLWithString:
//                        [NSString stringWithFormat:@"%@beaofferslist.api?lat=%f&lon=%f&dist=%f&ps=%.0f&lang=%@&UDID=%@",
//                         [CoreData sharedCoreData].realServerURLCard,
//                         newLocation.coordinate.latitude,
//                         newLocation.coordinate.longitude,
//                         show_distance/1000,
//                         show_no,
//                         [CoreData sharedCoreData].lang,
//                         [CoreData sharedCoreData].UDID]]];
////        NSLog(@"5555555555555555555555555555 %f %.0f %@",show_no,show_distance ,asi_request.url );
////		asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaofferslist.api?lat=%f&lon=%f&dist=%f&ps=%d&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,newLocation.coordinate.latitude,newLocation.coordinate.longitude,(show_distance/1000.0),(int)round(offer_no_slider.value),[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
//		//asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaofferslist.api?lat=%f&lon=%f&dist=%f&ps=%d&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,22.3132079,114.2205583,(show_distance/1000.0),(int)round(offer_no_slider.value),[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
//		NSLog(@"debug NearBySearchListViewController didUpdateToLocation:%@",asi_request.url);
//		asi_request.delegate = self;
//		[[CoreData sharedCoreData].queue addOperation:asi_request];
//	}
//}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"debug NearBySearchListViewController didFailWithError:%@--%@", manager, error);
    //    if (![CLLocationManager locationServicesEnabled]) {
    [map setUserInteractionEnabled:NO];
    
    if (![CLLocationManager authorizationStatus] >= kCLAuthorizationStatusAuthorized) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Location_setting_nearby_atm",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
    }
    
    
    //        return;
    //    }

	[locmgr stopUpdatingLocation];
	[[CoreData sharedCoreData].mask hiddenMask];
}

@end
