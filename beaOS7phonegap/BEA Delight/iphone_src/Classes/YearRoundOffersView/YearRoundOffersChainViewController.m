//
//  YearRoundOffersChainViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YearRoundOffersChainViewController.h"


@implementation YearRoundOffersChainViewController
@synthesize delegate;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		lang = [CoreData sharedCoreData].lang;
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	default_title_font_size = 14;
	default_description_font_size = 12;
	default_date_font_size = 12;
	items_data = [NSMutableArray new];
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

-(void)getItemsListType:(NSString *)list_type Category:(NSString *)category {
	current_type = list_type;
	current_category = category;
	[[CoreData sharedCoreData].updater setURL:[NSString stringWithFormat:@"%@beaofferslist.api?cat=Chain Restaurants&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURL,lang,[CoreData sharedCoreData].UDID] XMLFilename:[NSString stringWithFormat:@"offerlist_%@_%@_%@.xml",current_type,current_category,lang]];
	[CoreData sharedCoreData].updater.delegate = self;
	[[CoreData sharedCoreData].mask showMask];
	[[CoreData sharedCoreData].updater updateInfo];
}

//////////////////
//DataUpdaterDelegate
//////////////////
-(void) dataUpdated:(BOOL)success {
	// Use when fetching text data
	[[CoreData sharedCoreData].mask hiddenMask];
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
	path = [NSString stringWithFormat:@"%@/offerlist_%@_%@_%@.xml",path,current_type,current_category,lang];
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:path]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
}


/////////////////////
//UITableViewDelegate
/////////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 70;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [items_data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = @"CustomCell";
	CustomCell *cell = (CustomCell *)[table_view dequeueReusableCellWithIdentifier:identifier];
	if (cell==nil) {
		cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
//	cell.title_label.font = [UIFont systemFontOfSize:default_title_font_size];
	cell.title_label.text = [[items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
//	cell.description_label.font = [UIFont systemFontOfSize:default_description_font_size];
	cell.description_label.text = [[items_data objectAtIndex:indexPath.row] objectForKey:@"description"];
	cell.distance_label.text = [[items_data objectAtIndex:indexPath.row] objectForKey:@"address"];
	[cell.cached_image_view loadImageWithURL:[[items_data objectAtIndex:indexPath.row] objectForKey:@"image"]];
	if (![[[items_data objectAtIndex:indexPath.row] objectForKey:@"card"] isEqualToString:@"Core"]) {
		cell.platinum.hidden = FALSE;
	}
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	NSString *address = [[items_data objectAtIndex:indexPath.row] objectForKey:@"address"];
	if ([address isEqualToString:@"All outlets"] || [address isEqualToString:@"全線分店"]) {
		return;
	} else {
		YearRoundOffersMapViewController *map_view_controller = [[YearRoundOffersMapViewController alloc] initWithNibName:@"YearRoundOffersMapView" bundle:nil];
		map_view_controller.items_data = [NSArray arrayWithObject:[items_data objectAtIndex:indexPath.row]];
		[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:map_view_controller animated:TRUE];
		[map_view_controller createAnnotationList];
		[map_view_controller setSelectShop:0];
		[map_view_controller release];
	}

//	[delegate openListWithType:@"all" Category:[[items_data objectAtIndex:indexPath.row] objectForKey:@"title"]];
}

////////////////////
//XMLParserDelegate
////////////////////
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	//	NSLog(@"found file and started parsing");
	[items_data removeAllObjects];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download data from server"];
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	//	NSLog(@"found this element: %@", elementName);
	current_element = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		temp_id = [NSMutableString new];
		temp_title = [NSMutableString new];
		temp_shortdescription = [NSMutableString new];
		temp_description = [NSMutableString new];
		temp_card = [NSMutableString new];
		temp_address = [NSMutableString new];
		temp_tel = [NSMutableString new];
		temp_date = [NSMutableString new];
		temp_image_source = [NSMutableString new];
		temp_gps = [NSMutableString new];
		temp_expire = [NSMutableString new];
		temp_remarks = [NSMutableString new];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array...
		NSMutableDictionary *temp_record = [NSMutableDictionary new];
		[temp_record setValue:temp_id forKey:@"id"];
		[temp_record setValue:temp_title forKey:@"title"];
		[temp_record setValue:temp_shortdescription forKey:@"shortdescription"];
		[temp_record setValue:temp_description forKey:@"description"];
		[temp_record setValue:temp_card forKey:@"card"];
		[temp_record setValue:temp_address forKey:@"address"];
		[temp_record setValue:temp_tel forKey:@"tel"];
		[temp_record setValue:temp_date forKey:@"date"];
		[temp_record setValue:temp_image_source forKey:@"image"];
		[temp_record setValue:temp_gps forKey:@"gps"];
		[temp_record setValue:temp_expire forKey:@"expire"];
		[temp_record setValue:temp_remarks forKey:@"remarks"];
		[items_data addObject:temp_record];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//	NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([current_element isEqualToString:@"id"]) {
		[temp_id appendString:string];
	} else if ([current_element isEqualToString:@"title"]) {
		[temp_title appendString:string];
	} else if ([current_element isEqualToString:@"shortdescription"]) {
		[temp_shortdescription appendString:string];
	} else if ([current_element isEqualToString:@"description"]) {
		[temp_description appendString:string];
	} else if ([current_element isEqualToString:@"card"]) {
		if ([temp_card length]==0) {
			[temp_card appendString:string];
		}
	} else if ([current_element isEqualToString:@"date"]) {
		[temp_date appendString:string];
	} else if ([current_element isEqualToString:@"image"]) {
		if ([temp_image_source length]==0) {
			[temp_image_source appendString:string];
		}
	} else if ([current_element isEqualToString:@"address"]) {
		[temp_address appendString:string];
	} else if ([current_element isEqualToString:@"tel"]) {
		[temp_tel appendString:string];
	} else if ([current_element isEqualToString:@"expire"]) {
		[temp_expire appendString:string];
	} else if ([current_element isEqualToString:@"gps"]) {
		[temp_gps appendString:string];
	} else if ([current_element isEqualToString:@"remark"]) {
		[temp_remarks appendString:string];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	/*	[activityIndicator stopAnimating];
	 [activityIndicator removeFromSuperview];*/
	
	NSLog(@"Array has %d items", [items_data count]);
	[table_view reloadData];
}

@end
