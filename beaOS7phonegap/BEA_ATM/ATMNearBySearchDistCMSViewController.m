//
//  ATMNearBySearchDistCMSViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMNearBySearchDistCMSViewController.h"
#import "ATMOutletMapViewController.h"
#import "ATMUtil.h"
#import "ATMAdvanceSearchListCMSViewController.h"

#define KmMilesRatio	1.6093470878864446
#define max_show_distance 3000
#define default_show_distance 1000
#define min_show_distance 500
#define max_show_no	50
#define default_show_no	30
#define min_show_no	1

@implementation ATMNearBySearchDistCMSViewController

@class ATMOutletMapViewController;

//@synthesize supremegoldbutton, atmbutton, branchbutton;
@synthesize items_data, sorted_items_data, distance_list, selected_items_data;
@synthesize v_rmvc;
@synthesize menuID, current_category;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		app_setting = [[NSMutableDictionary dictionaryWithDictionary:[PlistOperator openPlistFile:@"setting" Datatype:@"NSDictionary"]] retain];
        
		[self defineDefaultTable];
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		current_type = @"all";
		current_category = @"A";
		sorted_items_data = nil;
        //		user_location = nil;
        
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    table_view.frame = CGRectMake(0, 158, 320, 269+[[MyScreenUtil me] getScreenHeightAdjust]);
    //	btnNearby.frame = CGRectMake(219, 435+[[MyScreenUtil me] getScreenHeightAdjust], 91, 20);
    
    [title_label setText:NSLocalizedString(@"select_location", nil)];
    [btnNearby setTitle:NSLocalizedString(@"ATM_Nearby", nil) forState:UIControlStateNormal];
    
    //    [self ATMButtonPressed:nil];
    
    v_rmvc = [[[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil] autorelease];
    v_rmvc.rmUtil.caller = self;
    
    [self.view addSubview:v_rmvc.contentView];
    
    NSArray *a_texts = [NSLocalizedString(@"rotatemenu.atmsearch.texts",nil) componentsSeparatedByString:@","];
    NSLog(@"v_rmvc.rmUtil setTextArray:%@",a_texts);
    [v_rmvc.rmUtil setTextArray:a_texts];
    
    UIView* view_temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSArray* a_views = [NSArray arrayWithObjects:view_temp , view_temp, view_temp, view_temp, nil];
    [v_rmvc.rmUtil setViewArray:a_views];
    
    [v_rmvc.rmUtil setNav:self.navigationController];
    [v_rmvc.rmUtil showMenu:menuID];
//    if ([current_category isEqualToString:@"2"]) {
//        [v_rmvc.rmUtil showMenu:0];
//    }
//    else if ([current_category isEqualToString:@"5"]) {
//        [v_rmvc.rmUtil showMenu:1];
//    }
//    else if ([current_category isEqualToString:@"3"]) {
//        [v_rmvc.rmUtil showMenu:2];
//    }
//    else if ([current_category isEqualToString:@"4"]) {
//        [v_rmvc.rmUtil showMenu:3];
//    }
}

-(void)showMenu:(int)show
{
    NSLog(@"debug ATMNearBySearchDistCMSViewController showMenu:%d", show);

    menuID = show;

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
	NSLog(@"ATMNearBySearchDistCMSViewController startToGetNearBy");
    
    //	locmgr = nil;
    //	user_location = nil;
	sorted_items_data = nil;
	items_data = nil;
	if (sorted_items_data!=nil) {
		[sorted_items_data removeAllObjects];
	}
	if (items_data!=nil) {
		[items_data removeAllObjects];
	}
    
    [self stepone];
    
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
    //	if (user_location!=nil) {
    //		[user_location release];
    //	}
	[distance_list release];
	//[sorted_items_data release];
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

-(void)selectMerchant:(int)merchant_id {
	[self tableView:table_view didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:merchant_id inSection:0]];
}

///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 41;
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
	//	NSLog(@"ATMNearBySearchDistCMSViewController cellForRowAtIndexPath:%@--%d", indexPath, [sorted_items_data count]);
    
	NSUInteger index = indexPath.row + (current_page-1) * current_page_size;
	id obj = [sorted_items_data objectAtIndex:index];
    
	NSString *identifier = @"ATMCustomCellCMS";
	ATMDistCellCMS *cell = [[ATMDistCellCMS alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(index%2)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 41-1.5, cell.frame.size.width, 1.5)];
    label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
    //            label.backgroundColor = [UIColor blueColor];
    [cell addSubview:label];
	cell.title_label.text = [obj objectForKey:@"name"];
    //	cell.address_label.text = [obj objectForKey:@"address"];
    //	cell.tel.text = [obj objectForKey:@"opeinghour"];
    
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
	NSLog(@"ATMNearBySearchDistCMSViewController didSelectRowAtIndexPath:%d", [sorted_items_data count]);
    NSUInteger index = indexPath.row + (current_page-1) * current_page_size;
	id obj = [sorted_items_data objectAtIndex:index];
    NSString* districtid = [obj objectForKey:@"id"];
    NSString* districtName = [obj objectForKey:@"name"];
    
    districtid = [districtid stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    districtid = [districtid stringByReplacingOccurrencesOfString:@" " withString:@""];
    districtid = [districtid stringByReplacingOccurrencesOfString:@"	" withString:@""];
    //    NSInteger districtid = [distance_list intValue];
	NSLog(@"ATMNearBySearchDistCMSViewController didSelectRowAtIndexPath:[%@]", districtid);
	if ([sorted_items_data count]>0) {
        ATMAdvanceSearchListCMSViewController* current_view_controller = [[ATMAdvanceSearchListCMSViewController alloc] initWithNibName:@"ATMAdvanceSearchListCMSView" bundle:nil cat:current_category];
        current_view_controller.districtid=districtid;
        current_view_controller.districtName=districtName;
        current_view_controller.distVC = self;
        
        [self.navigationController pushViewController:current_view_controller animated:NO];
        
        [current_view_controller release];
	}
}

//////////////////
//DataUpdaterDelegate
//////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
//	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
//	NSLog(@"debug requestFinished:%@", reponsedString);
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
    NSLog(@"ATMNearBySearchDistCMSViewController requestFailed:%@", [request responseString]);

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
           @"name",
           nil];
    //	NSLog(@"debug parserDidStartDocument:%@",key);
    
    temp_record = [NSMutableDictionary new];
    [temp_record setObject:@"0" forKey:@"id"];
    [temp_record setObject:NSLocalizedString(@"All", nil) forKey:@"name"];
    [items_data addObject:temp_record];
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	total_page = ceil([items_data count]/(float)current_page_size);
    
//	NSLog(@"debug parserDidEndDocument:%d outlets",[items_data count]);
	result.text = [NSString stringWithFormat:@"%@ %d %@",NSLocalizedString(@"Search1",nil),[items_data count],NSLocalizedString(@"Search2",nil)];
	if ([items_data count]==0) {
		[table_view reloadData];
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No result found nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//		[alert show];
//		[alert release];
	} else {
		sorted_items_data = items_data;
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

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {
        [self fixspace:temp_record key:@"id"];
        [self fixspace:temp_record key:@"name"];
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

-(void)fixspace:(NSMutableDictionary*)dic key:(NSString*)akey
{
    NSString* value=[dic objectForKey:akey];
//    NSLog(@"debug fixspace begin:[%@]--[%@]", akey, value);
    if (value == nil){
        value = @"";
    }
    
    value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    if (![akey isEqualToString:@"name"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
//    NSLog(@"debug fixspace end:[%@]", value);
    [dic setObject:value forKey:akey];
    return;
}

-(void)stepone{
	request_type = @"stepone";
    
    ASIHTTPRequest* asi_request = [[ASIHTTPRequest alloc]
                                   initWithURL:
                                   [NSURL
                                    URLWithString:
                                    [NSString
                                     stringWithFormat:@"%@getdistrict.api?lang=%@&d=%@",
                                     [CoreData sharedCoreData].realServerURL,
                                     [[LangUtil me] getLangID],
                                     current_category]]];
    NSLog(@"debug ATMNearBySearchDistCMSViewController stepone:%@",asi_request.url);
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
    
	[[CoreData sharedCoreData].mask showMask];
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
	NSLog(@"SupremeGoldButtonPressed in dist:%@", button);
    
	current_category = @"5";
	[self startToGetNearBy];
}

-(IBAction)ATMButtonPressed:(UIButton *)button
{
	NSLog(@"ATMButtonPressed in dist:%@", button);
    
	current_category = @"2";
	[self startToGetNearBy];
}

-(IBAction)iFinancialButtonPressed:(UIButton *)button
{
	NSLog(@"iFinancialButtonPressed in dist:%@", button);
    
	current_category = @"3";
	[self startToGetNearBy];
}

-(IBAction)BranchButtonPressed:(UIButton *)button
{
	NSLog(@"BranchButtonPressed in dist:%@", button);
    
	current_category = @"4";
	[self startToGetNearBy];
}

-(IBAction)nearbyButtonPressed:(UIButton *)button
{
    ATMNearBySearchListViewController* current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
    current_view_controller.menuID = menuID;
    [self.navigationController pushViewController:current_view_controller animated:TRUE];
    [current_view_controller release];
}

@end
