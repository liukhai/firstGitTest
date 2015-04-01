//
//  OutletListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OutletListViewController.h"


@implementation OutletListViewController
@synthesize delegate;
@synthesize is_show_distance, show_all_in_map, show_distance, scrollable;
@synthesize items_data;
//Jeff
@synthesize title_label;
@synthesize prev, next;
//
@synthesize table_view, fromType;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		items_data = [NSMutableArray new];
		is_show_distance = FALSE;
		show_all_in_map = FALSE;
		scrollable = FALSE;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
 //   self.view.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
  //  table_view.frame = CGRectMake(0, 22, 320, 345+[[MyScreenUtil me] getScreenHeightAdjust]);

	title_label.text = NSLocalizedString(@"Contact Info",nil);
	NSLog(@"is_show_distance %d",is_show_distance);
	if (is_show_distance) {
		locmgr = [[CLLocationManager alloc] init];
		locmgr.delegate = self;
		[locmgr startUpdatingLocation];
	}
    if ([fromType isEqualToString:@"YRO"]) {
        background_imageView.hidden = YES;
//        line_imageView.hidden = YES;
        CGRect line_frame = line_imageView.frame;
        line_frame.origin.y -= 22;
        line_frame.origin.x -= 11;
        line_imageView.frame = line_frame;
        CGRect frame = title_label.frame;
        frame.origin.y -= 20;
        frame.origin.x -= 15;
        [title_label setTextColor:[UIColor blackColor]];
        title_label.frame = frame;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
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
    [line_imageView release];
    line_imageView = nil;
    [background_imageView release];
    background_imageView = nil;
    [self setTable_view:nil];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;

}


- (void)dealloc {
    [table_view release];
    [background_imageView release];
    [line_imageView release];
    [_background_imageView release];
    [super dealloc];
}

-(void)getMerchantOutlet:(NSString *)merchantName {
	[[CoreData sharedCoreData].mask showMask];
	current_merchant_name = merchantName;
	if (!is_show_distance) {
		api_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?n=%@&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[[[current_merchant_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"&" withString:@"%26"] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"],[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
		api_request.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:api_request];
	}
}

-(void)getMerchantOutlet:(NSString *)merchantName QuarterlySurprise:(BOOL)qs {
	[[CoreData sharedCoreData].mask showMask];
	current_merchant_name = merchantName;
	if (!is_show_distance) {
		if (qs) {
			api_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?qs=true&n=%@&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[[[current_merchant_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"&" withString:@"%26"] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"],[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
			/*api_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?qs=true&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
			[api_request setPostValue:current_merchant_name forKey:@"n"];*/
		} else {
			api_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?qs=false&n=%@&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[[[current_merchant_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"&" withString:@"%26"] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"],[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
			/*api_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
			[api_request setPostValue:current_merchant_name forKey:@"n"];*/
		}
		api_request.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:api_request];
	}
	//jeff
	//NSLog(@"getMerchantOutlet : %@", api_request.url);
}

-(void)getMerchantOutlet:(NSString *)merchantName District:(NSString *)location {
	[[CoreData sharedCoreData].mask showMask];
	current_merchant_name = merchantName;
	if (!is_show_distance) {
		api_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?dt=%@&n=%@&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,location,[[[current_merchant_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"&" withString:@"%26"] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"],[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
		/*api_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?dt=%@&n=%@&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,location,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
		[api_request setPostValue:current_merchant_name forKey:@"n"];*/
		api_request.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:api_request];
	}
}

-(void)getMerchantOutletWithRefId:(NSString *)refId QuarterlySurprise:(BOOL)qs {
	[[CoreData sharedCoreData].mask showMask];
	current_merchant_name = refId;
	if (!is_show_distance) {
//		if (qs) {
//			api_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?refid=%@&qs=true&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,refId,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
//            NSLog(@"URL is %@", [NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?refid=%@&qs=true&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,refId,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]);
//		} else {
			api_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?refid=%@&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,refId,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
            NSLog(@"URL is %@", [NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?refid=%@&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,refId,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]);
//        }
		/*api_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
		 [api_request setPostValue:current_merchant_name forKey:@"n"];*/
		api_request.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:api_request];
	}
	//jeff
    NSLog(@"debug getMerchantOutletWithRefId : %@", api_request.url);
}

-(void)getLatestPromotionOutlet:(NSString *)merchantName {
	[[CoreData sharedCoreData].mask showMask];
	current_merchant_name = merchantName;
	if (!is_show_distance) {
		api_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@latestpromotionoutlets.api?refid=%@&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[[current_merchant_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"&" withString:@"%26"],[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
		api_request.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:api_request];
	}
}

-(void)sortByDistance {
	NSLog(@"sortByDistance");
	NSMutableArray *sorted_items_data = [NSMutableArray new];
	for (int i=0; i<[items_data count]; i++) {
		NSArray *gps = [[[items_data objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
		CLLocation *outlet_location = [[CLLocation alloc] initWithLatitude:[[gps objectAtIndex:0] floatValue] longitude:[[gps objectAtIndex:1] floatValue]];
		//float distance = [outlet_location getDistanceFrom:current_location];
		float distance = [outlet_location distanceFromLocation:current_location];
		NSLog(@"%f",distance);
		int position = 0;
		for (int j=0; j<[sorted_items_data count]; j++) {
			if (distance > [[[sorted_items_data objectAtIndex:j] objectForKey:@"distance"] floatValue]) {
				position = j+1;
				break;
			}
		}
		NSLog(@"%d",position);
		temp_record = [items_data objectAtIndex:i];
		[temp_record setValue:[NSNumber numberWithFloat:distance] forKey:@"distance"];
		[sorted_items_data insertObject:temp_record atIndex:position];
        [outlet_location release];
	}
	[items_data removeAllObjects];
	[items_data release];
	items_data = [sorted_items_data retain];
	NSLog(@"sort complete %d",[items_data count]);
	[table_view reloadData];

}

-(IBAction)prevButtonPressed:(UIButton *)button {
	if (current_page>1) {
		current_page--;
		next.enabled = TRUE;
		if (current_page==1) {
			prev.enabled = FALSE;
		}
		[table_view reloadData];
	}
}

-(IBAction)nextButtonPressed:(UIButton *)button {
	if (current_page<total_page) {
		current_page++;
		prev.enabled = TRUE;
		if (current_page==total_page) {
			next.enabled = FALSE;
		}
		[table_view reloadData];
	}
}

-(IBAction)shareButtonPressed:(UIButton *)button {
	UIAlertView *share_prompt = [[[UIAlertView alloc] init] retain];
	[share_prompt setDelegate:self];
	[share_prompt setTitle:NSLocalizedString(@"Share to Friend",nil)];
	[share_prompt setMessage:NSLocalizedString(@"Share App with Friends by Email",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"OK",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"Back",nil)];
	
	
	/*	CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 100.0);
	 [login_prompt setTransform: moveUp];*/
	[share_prompt show];
	[share_prompt release];
}

-(IBAction)bookmarkButtonPressed:(UIButton *)button {
}

-(void)callOutlet:(UIButton *)button {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[button titleForState:UIControlStateNormal]]]];
}

//////////////////////
//ASI Delegate
//////////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	
    NSLog(@"debug OutletListViewController requestFinished:%@",[request responseString]);
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	prev.enabled = FALSE;
	if ([items_data count]>30) {
		next.enabled = TRUE;
		prev.hidden = FALSE;
		next.hidden = FALSE;
	} else {
		prev.hidden = TRUE;
		next.hidden = TRUE;
	}
	
	[[CoreData sharedCoreData].mask hiddenMask];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"OutletListViewController requestFailed:%@", request.error);
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
}

////////////////////
//XML delegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	[items_data removeAllObjects];
	current_page = 1;
	key = [NSArray arrayWithObjects:@"id",@"title",@"merchant",@"shortdescription",@"description",@"category",@"cuisine",@"address",@"district",@"image",@"suprise",@"tel",@"opening",@"card",@"expire",@"gps",@"remark",nil];
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	total_page = ceil([items_data count]/(float)current_page_size);
	if (current_page==1) {
		prev.enabled = FALSE;
	} else {
		prev.enabled = TRUE;
	}

	if (current_page==total_page || total_page==0) {
		next.enabled = FALSE;
	} else {
		next.enabled = TRUE;
	}

	NSLog(@"%d outlets",[items_data count]);
	[table_view reloadData];
	[delegate OutletListUpdated:items_data];
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
//			NSLog(@"%@ %@",currentElementName,string);
		} else if ([currentElementName isEqualToString:[key objectAtIndex:i]]) {
			[temp_record setObject:[[temp_record objectForKey:currentElementName] stringByAppendingString:string] forKey:currentElementName];
			//			NSLog(@"%@ %@",currentElementName,string);
		}
	}
}

//////////////////////////
//LocationManager delegate
//////////////////////////
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
	NSLog(@"Got location New");
    CLLocation *newLocation = [locations lastObject];
	[manager stopUpdatingLocation];
	current_location = [newLocation retain];
	[[CoreData sharedCoreData].mask showMask];
	api_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?n=%@&lat=%f&lon=%f&dist=%f&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[current_merchant_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],newLocation.coordinate.latitude,newLocation.coordinate.longitude,show_distance/1000.0,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
	NSLog(@"%@beaoutletslist.api?n=%@&lat=%f&lon=%f&dist=%f&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[current_merchant_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],newLocation.coordinate.latitude,newLocation.coordinate.longitude,show_distance/1000.0,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID);
	api_request.delegate = self;
	[[CoreData sharedCoreData].queue addOperation:api_request];
}

//Deprecated in iOS 6.0
//-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//	NSLog(@"Got location Old");
//	[manager stopUpdatingLocation];
//	current_location = [newLocation retain];
//	[[CoreData sharedCoreData].mask showMask];
//	api_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beaoutletslist.api?n=%@&lat=%f&lon=%f&dist=%f&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[current_merchant_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],newLocation.coordinate.latitude,newLocation.coordinate.longitude,show_distance/1000.0,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
//	NSLog(@"%@beaoutletslist.api?n=%@&lat=%f&lon=%f&dist=%f&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[current_merchant_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],newLocation.coordinate.latitude,newLocation.coordinate.longitude,show_distance/1000.0,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID);
//	api_request.delegate = self;
//	[[CoreData sharedCoreData].queue addOperation:api_request];
////	[self sortByDistance];
//}

/////////////////////
//Table Delegate
/////////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	//jeff
	//return 101;
    if ([fromType isEqualToString:@"YRO"]) {
        int height = [self fitHeightWithString:[[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"address"]];
        if (height >= 45) {
            if (indexPath.row == [items_data count] % current_page_size - 1) {
                return 35 + height;
            }
            return 36 + height;
        }
    }
    if (indexPath.row == [items_data count] % current_page_size - 1) {
        return 80;
    }
	return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	int total_record = [items_data count];
	if (total_record - (current_page-1) * current_page_size > current_page_size) {
		if (!scrollable) {
			table_view.frame = CGRectMake(0, 24, 320, 81 * current_page_size);
			self.view.bounds = CGRectMake(0, 0, 320, 81 * current_page_size + 24);
			//jeff
			//table_view.frame = CGRectMake(0, 24, 320, 101 * current_page_size);
			//self.view.bounds = CGRectMake(0, 0, 320, 101 * current_page_size + 24);
		}
		return current_page_size;
	} else {
		if (!scrollable) {
            if ([fromType isEqualToString:@"YRO"]) {
                CGFloat tableH = 0.0;
                for (int i = 0; i < total_record % current_page_size; i++) {
                    NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
                    tableH += [self tableView:table_view heightForRowAtIndexPath:index];
                }
                table_view.frame = CGRectMake(0, 24, 320, tableH);
            }else {
                table_view.frame = CGRectMake(0, 24, 320, 81 * (total_record % current_page_size));
            }
			
			//jeff
			//table_view.frame = CGRectMake(0, 24, 320, 101 * (total_record % current_page_size));
		}
		return total_record % current_page_size;
	}
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *status = [[PageUtil pageUtil] getPageTheme];
    if ([fromType isEqualToString:@"YRO"]) {
        NSString *identifier = @"OutletListCell2";
        OutletListCell2 *cell = (OutletListCell2 *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell = [[OutletListCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (indexPath.row%2==0) {
            UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
//            bgImageView.contentMode = UIViewContentModeCenter;
            cell.backgroundView = bgImageView;
        } else {
            UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
//            bgImageView.contentMode = UIViewContentModeCenter;
            cell.backgroundView = bgImageView;
        }
        if (![[[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"gps"] isEqualToString:@"0,0"]) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UIButton *btn_map = [[UIButton alloc] initWithFrame:CGRectMake(260, 25, 25, 25)];
            if ([status isEqualToString:@"1"]) {
                [btn_map setBackgroundImage:[UIImage imageNamed:@"btn_map.png"] forState:UIControlStateNormal];
            } else {
                [btn_map setBackgroundImage:[UIImage imageNamed:@"btn_map_new.png"] forState:UIControlStateNormal];
            }
            NSLog(@"debug OutletListViewController cellForRowAtIndexPath add btn_map:%@", btn_map);
            [btn_map setTag:indexPath.row];
            [btn_map addTarget:self action:@selector(toMap:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn_map];
        }
        cell.address.text = [[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"address"];
        [cell layoutViews];
        int height = [self fitHeight:cell.address];
//        cell.tel.frame = CGRectMake(cell.tel.frame.origin.x, height+5, cell.tel.frame.size.width, cell.tel.frame.size.height);
//        cell.handset.frame = CGRectMake(cell.handset.frame.origin.x, height+5, cell.handset.frame.size.width, cell.handset.frame.size.height);
        [cell.tel setTitle:[[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"tel"] forState:UIControlStateNormal];
        cell.distance.text = [[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"distance"];
        return cell;
    }
    else {
        NSString *identifier = @"OutletListCell";
        OutletListCell *cell = (OutletListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell = [[OutletListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    
        if (indexPath.row%2==0) {
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
        } else {
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
        }

	if (![[[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"gps"] isEqualToString:@"0,0"]) {
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        UIButton *btn_map = [[UIButton alloc] initWithFrame:CGRectMake(260, 25, 25, 25)];
        if ([status isEqualToString:@"1"]) {
            [btn_map setBackgroundImage:[UIImage imageNamed:@"btn_map.png"] forState:UIControlStateNormal];
        } else {
            [btn_map setBackgroundImage:[UIImage imageNamed:@"btn_map_new.png"] forState:UIControlStateNormal];
        }
        NSLog(@"debug OutletListViewController cellForRowAtIndexPath add btn_map:%@", btn_map);
        [btn_map setTag:indexPath.row];
        [btn_map addTarget:self action:@selector(toMap:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn_map];
	}
        NSString *address = [[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"address"];
        CGSize labelSize = [address sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(225, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        CGRect frame = cell.address.frame;
        frame.size = labelSize;
        cell.address.frame = frame;
        cell.address.text = address;
	//jeff-testing
	//cell.address.text = @"addressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddressaddress";
	//
	
	//[cell.tel setTitle:[[[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"tel"] stringByReplacingOccurrencesOfString:@" " withString:@""] forState:UIControlStateNormal];
	//[cell.tel addTarget:self action:@selector(callOutlet:) forControlEvents:UIControlEventTouchUpInside];
	//cell.tel.text = [NSString stringWithFormat:@"+852 %@",[[[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"tel"] stringByReplacingOccurrencesOfString:@" " withString:@""]];
	[cell.tel setTitle:[[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"tel"] forState:UIControlStateNormal];
	/*if ([[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"opening"]!=nil) {
		cell.opening.text = [[[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"opening"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	}*/
	cell.distance.text = [[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"distance"];
    // cell.tel.frame.origin.y+cell.tel.frame.size.height
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 81, cell.frame.size.width, 1)];
//    lineLabel.backgroundColor = [UIColor lightGrayColor];
//    [cell.contentView addSubview:lineLabel];
//    [lineLabel release];
        return cell;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"debug OutletListViewController didSelectRowAtIndexPath:%@", [[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"gps"]);
//	if (![[[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"gps"] isEqualToString:@"0,0"]) {
//		[self tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
//		[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
//	}
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSUInteger)row {
	OutletMapViewController *outlet_map_controller = [[OutletMapViewController alloc] initWithNibName:@"OutletMapView" bundle:nil];
    outlet_map_controller.isNeedBox = YES;
	if (show_all_in_map) {
		[outlet_map_controller addAnnotations:items_data];
		[outlet_map_controller setSelectedAnnotation:(current_page-1) * current_page_size + row Delta:0.005];
	} else {
		[outlet_map_controller addAnnotations:[NSArray arrayWithObject:[items_data objectAtIndex:(current_page-1) * current_page_size + row]]];
		[outlet_map_controller setSelectedAnnotation:0 Delta:0.005];
	}
    [outlet_map_controller hiddenButton:YES];
    YearRoundOffersSummaryViewController *yroViewController = self.delegate;
    [yroViewController.navigationController pushViewController:outlet_map_controller animated:YES];
  //  [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:outlet_map_controller animated:TRUE];
	[outlet_map_controller release];
}
-(void)toMap:(UIButton *)button{
	NSLog(@"toMap:");
    NSLog(@"debug OutletListViewController didSelectRowAtIndexPath:%@", [[items_data objectAtIndex:(current_page-1) * current_page_size + button.tag] objectForKey:@"gps"]);
	if (![[[items_data objectAtIndex:(current_page-1) * current_page_size + button.tag] objectForKey:@"gps"] isEqualToString:@"0,0"]) {
		[self tableView:self.table_view accessoryButtonTappedForRowWithIndexPath:button.tag];
//		[table_view deselectRowAtIndexPath:indexPath animated:TRUE];
	}
}
- (int) fitHeight:(UILabel*)sender
{
    //    NSLog(@"debug ATMCustomCellCMS fitHeight:%@", sender.text);
    
    CGSize maxSize = CGSizeMake(sender.frame.size.width, 50);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height * 1.2);
    int height = sender.frame.origin.y + sender.frame.size.height;
    return height;
}

- (int) fitHeightWithString:(NSString *)str
{
    //    NSLog(@"debug ATMCustomCellCMS fitHeight:%@", sender.text);
    
    CGSize maxSize = CGSizeMake(225, MAXFLOAT);
    CGSize text_area = [str sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    int height = text_area.height * 1.2;
    return height;
}
@end
