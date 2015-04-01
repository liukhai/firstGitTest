//
//  QuaterlySurpriseListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuarterlySurpriseListViewController.h"


@implementation QuarterlySurpriseListViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		items_data = [NSMutableArray new];
		qs_tnc = nil;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.delegate = self;
//    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    table_view.frame = CGRectMake(0, 45, 320, 291+[[MyScreenUtil me] getScreenHeightAdjust]);

	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
	title_label.text = [NSString stringWithFormat:@"%@\n%@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Quarterly Surprise",nil)];
	[tnc setTitle:NSLocalizedString(@"General Terms and Conditions",nil) forState:UIControlStateNormal];
	if ([[CoreData sharedCoreData].lang isEqualToString:@"zh_TW"]) {
		tnc.frame = CGRectMake(104, 340, 112, 21);
	} else {
		tnc.frame = CGRectMake(48, 340, 224, 21);
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[items_data removeAllObjects];
	[items_data release];
	if (qs_tnc!=nil) {
		[qs_tnc release];
	}
    asi_request.delegate = nil;
    [super dealloc];
}

-(void)setPageSize:(int)page_size {
	current_page_size = page_size;
}

-(void)getItemsList {
	NSLog(@"Get the list of Quarterly Surprise");
	[[CoreData sharedCoreData].mask showMask];
	qs_tnc_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@general_tnc.api?lang=%@&cat=qs&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
	qs_tnc_request.delegate = self;
	[[CoreData sharedCoreData].queue addOperation:qs_tnc_request];
	asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?qs=true&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
	asi_request.delegate = self;
	[[CoreData sharedCoreData].queue addOperation:asi_request];
}

-(IBAction)tncButtonPressed:(UIButton *)button {
	if (qs_tnc==nil) {
		return;
	}
	TermsAndConditionsViewController *tnc_controller = [[TermsAndConditionsViewController alloc] initWithNibName:@"TermsAndConditionsView" bundle:nil];
    [tnc_controller setTncStr:qs_tnc];
	[self.navigationController pushViewController:tnc_controller animated:TRUE];
//	tnc_controller.tnc.text = qs_tnc; //NSLocalizedString(@"TNC Quarterly",nil);
	[tnc_controller release];
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

-(IBAction)homeButtonPressed:(UIBarButtonItem *)button {
	[(RootViewController *)[CoreData sharedCoreData].root_view_controller setContent:-1];
}

///////////////////
//ASIHTTPRequest
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	
	//NSLog(@"%@",[request responseString]);
	if (request==asi_request) {
		currentAction = @"GetList";
		[[CoreData sharedCoreData].mask hiddenMask];
	} else {
		currentAction = @"GetTNC";
	}

	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[request release];
	
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"QuarterlySurpriseListViewController requestFailed:%@", request.error);

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
	[request release];
	
}

///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	int total_record = [items_data count];
	if (total_record - (current_page-1) * current_page_size > current_page_size) {
		return current_page_size;
	} else {
		return total_record - (current_page-1) * current_page_size;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = @"CustomCell";
//	CustomCell *cell = (CustomCell *)[table_view dequeueReusableCellWithIdentifier:identifier];
//	if (cell==nil) {
	CustomCell *cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
//	}
//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.title_label.text = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"title"];
	cell.description_label.text = [[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
	cell.distance_label.text = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"address"];
	if (![[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"card"] isEqualToString:@"Core"]) {
		cell.platinum.hidden = FALSE;
	} else {
		cell.platinum.hidden = TRUE;
	}
	if ([[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
		cell.is_new.hidden = FALSE;
	} else {
		cell.is_new.hidden = TRUE;
	}

	NSString *image = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"image"];
	if (image!=nil && ![image isEqualToString:@""]) {
		[cell.cached_image_view loadImageWithURL:[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"image"]];
	}
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	QuarterlySurpriseSummaryViewController *summary_controller = [[QuarterlySurpriseSummaryViewController alloc] initWithNibName:@"QuarterlySurpriseSummaryView" bundle:nil];
	summary_controller.merchant_info = [items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size];
	[self.navigationController pushViewController:summary_controller animated:TRUE];
	summary_controller.title_label.text = title_label.text;
	[summary_controller release];
}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	if ([currentAction isEqualToString:@"GetList"]) {
		[items_data removeAllObjects];
		current_page = 1;
		key = [NSArray arrayWithObjects:@"id",@"title",@"etitle",@"shortdescription",@"description",@"category",@"cuisine",@"coupon",@"image",@"suprise",@"card",@"remark",@"newitem",nil];
	}
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	if ([currentAction isEqualToString:@"GetList"]) {
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
		
		NSLog(@"%d merchants",[items_data count]);
		if ([items_data count]==0) {
			tnc.hidden = TRUE;
			ComingSoonViewController *coming_soon_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
			[self.navigationController pushViewController:coming_soon_controller animated:TRUE];
			[coming_soon_controller release];
		} else {
			tnc.hidden = FALSE;
			[table_view reloadData];
		}
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
//		[temp_record setValue:@"http://hkbea.mtel.ws/java/bea//images/dummy_coupon.png" forKey:@"coupon"];
		[items_data addObject:temp_record];
	}
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if ([currentAction isEqualToString:@"GetList"]) {
		for (int i=0; i<[key count]; i++) {
			if ([currentElementName isEqualToString:[key objectAtIndex:i]] && [temp_record objectForKey:currentElementName]==nil) {
				[temp_record setObject:string forKey:currentElementName];
				//NSLog(@"%@ %@",currentElementName,string);
			}
		}
	} else if ([currentAction isEqualToString:@"GetTNC"]) {
		if ([currentElementName isEqualToString:@"tnc"] && qs_tnc==nil) {
			NSLog(@"Set QS");
			qs_tnc = [string retain];
		}
	}
}

@end
