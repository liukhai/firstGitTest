//
//  TacticalDinningListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月30日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TacticalDiningListViewController.h"


@implementation TacticalDiningListViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		[self defineDefaultTable];
		current_page = 1;
		current_page_size = 20;
		total_page = 1;
		lang = [CoreData sharedCoreData].lang;
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
	[current_type release];
	[current_category release];
	[items_data removeAllObjects];
	[items_data release];
    [super dealloc];
}

-(void)defineDefaultTable {
	cell_height = 100;
	default_title_font_size = 14;
	default_description_font_size = 12;
	default_date_font_size = 12;
	default_image_source_type = @"url";
	default_image_alignment = @"left";
	items_data = [NSMutableArray new];
}

-(void)getItemsListType:(NSString *)list_type Category:(NSString *)category {
	NSLog(@"Get the list of type:%@ category:%@",list_type,category);
	current_type = [list_type retain];
	current_category = [category retain];
	[[CoreData sharedCoreData].updater setURL:[NSString stringWithFormat:@"%@beatacticallist.jsp?type=%@&category=%@&lang=%@",[CoreData sharedCoreData].realServerURL,current_type,current_category,lang] XMLFilename:[NSString stringWithFormat:@"tacticallist_%@_%@_%@.xml",current_type,current_category,lang]];
	[CoreData sharedCoreData].updater.delegate = self;
	[[CoreData sharedCoreData].mask showMask];
	[[CoreData sharedCoreData].updater updateInfo];
}

-(IBAction)homeButtonPressed:(UIBarButtonItem *)button {
	[(RootViewController *)[CoreData sharedCoreData].root_view_controller setContent:-1];
}

///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return cell_height;
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
	cell.title_label.font = [UIFont systemFontOfSize:default_title_font_size];
	cell.title_label.text = [[items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
	cell.description_label.font = [UIFont systemFontOfSize:default_description_font_size];
	cell.description_label.text = [[items_data objectAtIndex:indexPath.row] objectForKey:@"description"];
	if ([[[items_data objectAtIndex:indexPath.row] objectForKey:@"image_source"] isEqualToString:@"url"]) {
		[cell.cached_image_view loadImageWithURL:[[items_data objectAtIndex:indexPath.row] objectForKey:@"image"]];
	} else {
		cell.cached_image_view.image = [UIImage imageNamed:[[items_data objectAtIndex:indexPath.row] objectForKey:@"image"]];
	}
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	TacticalDiningViewController *dining_view_controller = [[TacticalDiningViewController alloc] initWithNibName:@"TacticalDiningView" bundle:nil];
	dining_view_controller.items_data = items_data;
	[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:dining_view_controller animated:TRUE];
	[dining_view_controller setSelectShop:indexPath.row];
	[dining_view_controller release];
}

//////////////////
//DataUpdaterDelegate
//////////////////
-(void) dataUpdated:(BOOL)success {
	// Use when fetching text data
	[[CoreData sharedCoreData].mask hiddenMask];
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
	path = [NSString stringWithFormat:@"%@/tacticallist_%@_%@_%@.xml",path,current_type,current_category,lang];
	//	NSLog(@"%@",path);
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:path]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
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
		temp_coupon = [NSMutableString new];
		temp_date = [NSMutableString new];
		temp_image_source = [NSMutableString new];
		temp_expire = [NSMutableString new];
		temp_remarks = [NSMutableString new];
		if ([attributeDict objectForKey:@"source"]!=nil) {
			temp_image_source_type = [attributeDict objectForKey:@"source"];
		} else {
			temp_image_source_type = default_image_source_type;
		}
		if ([attributeDict objectForKey:@"align"]!=nil) {
			temp_image_alignment = [attributeDict objectForKey:@"align"];
		} else {
			temp_image_alignment = default_image_alignment;
		}
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
		[temp_record setValue:temp_coupon forKey:@"coupon"];
		[temp_record setValue:temp_date forKey:@"date"];
		[temp_record setValue:temp_image_source forKey:@"image"];
		[temp_record setValue:temp_image_source_type forKey:@"image_source"];
		[temp_record setValue:temp_image_alignment forKey:@"image_align"];
		[temp_record setValue:temp_expire forKey:@"expire"];
		[temp_record setValue:temp_remarks forKey:@"remarks"];
		[items_data addObject:temp_record];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//	NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([current_element isEqualToString:@"itemsTotal"]) {
		if ([string intValue]>0) {
			total_page = (int)ceil((float)[string intValue] / current_page_size);
		}
	} else if ([current_element isEqualToString:@"id"]) {
		[temp_id appendString:string];
	} else if ([current_element isEqualToString:@"title"]) {
		[temp_title appendString:string];
	} else if ([current_element isEqualToString:@"shortdescription"]) {
		[temp_shortdescription appendString:string];
	} else if ([current_element isEqualToString:@"description"]) {
		[temp_description appendString:string];
	} else if ([current_element isEqualToString:@"date"]) {
		[temp_date appendString:string];
	} else if ([current_element isEqualToString:@"image"]) {
		if ([temp_image_source length]==0) {
			[temp_image_source appendString:string];
		}
	} else if ([current_element isEqualToString:@"coupon"]) {
		if ([temp_coupon length]==0) {
			[temp_coupon appendString:string];
		}
	} else if ([current_element isEqualToString:@"expire"]) {
		[temp_expire appendString:string];
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
