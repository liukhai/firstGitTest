//
//  NearBySearchListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdvanceSearchListViewController.h"

#define NoOffer 1000

@implementation AdvanceSearchListViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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
    //    self.view.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    table_view.frame = CGRectMake(0, 45, 320, 322+[[MyScreenUtil me] getScreenHeightAdjust]);
    
    //	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
    //	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
    title_label.text = NSLocalizedString(@"Advance Search",nil);
    
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    [v_rmvc.rmUtil setNav:self.navigationController];
    [self.view addSubview:v_rmvc.contentView];
}

-(void) viewWillDisappear:(BOOL) animated
{
    [super viewWillDisappear:animated];
    if ([self isMovingFromParentViewController])
    {
        if (self.navigationController.delegate == self)
        {
            self.navigationController.delegate = nil;
        }
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
    [items_data release];
    asi_request.delegate = nil;
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

-(void)getItemsListCuisine:(NSString *)cuisine Location:(NSString *)location Keywords:(NSString *)keywords {
    searching_type = @"dining";
    NSLog(@"Get the list of cuisine:%@ location:%@ keywords:%@",cuisine,location,keywords);
    asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?cat=Dining&cui=%@&qs=false&dt=%@&s=%@&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,cuisine,location,[keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    NSLog(@"load %@",asi_request.url);
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
    [[CoreData sharedCoreData].mask showMask];
}

-(void)getItemsListCategory:(NSString *)category Keywords:(NSString *)keywords {
    searching_type = @"shopping";
    NSLog(@"Get the list of cuisine:%@ keywords:%@",category,keywords);
    asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?cat=%@&s=%@&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,category,[keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    NSLog(@"load %@",asi_request.url);
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
    [[CoreData sharedCoreData].mask showMask];
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
    NSLog(@"AdvanceSearchListViewController requestFailed:%@", [request responseString]);
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
    int total_record = [items_data count];
    if (total_record - (current_page-1) * current_page_size > current_page_size) {
        return current_page_size;
    } else {
        return total_record - (current_page-1) * current_page_size;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"CustomCell";
    CustomCell2 *cell = [[CustomCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
    cell.title_label.text = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"title"];
    cell.description_label.text = [[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
    cell.distance_label.text = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"address"];
    if (![[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"card"] isEqualToString:@"Core"]) {
        cell.platinum.hidden = FALSE;
    } else {
        cell.platinum.hidden = TRUE;
    }
    NSString *image = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"image"];
    if (image!=nil && ![image isEqualToString:@""]) {
        [cell.cached_image_view loadImageWithURL:[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"image"]];
    }
    if ([[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
        cell.is_new.hidden = FALSE;
    } else {
        cell.is_new.hidden = TRUE;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    NSString *suprise = [[items_data objectAtIndex:(current_page-1) * current_page_size + indexPath.row] objectForKey:@"suprise"];
    if ([suprise isEqualToString:@"true"]) {
        YearRoundOffersSummaryViewController *summary_controller = [[YearRoundOffersSummaryViewController alloc] initWithNibName:@"YearRoundOffersSummaryView" bundle:nil];
        summary_controller.merchant_info = [items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size];
        summary_controller.headingTitle = NSLocalizedString(@"Year-round Offers", nil);
        [self.navigationController pushViewController:summary_controller animated:TRUE];
        summary_controller.title_label.text = title_label.text;
        [summary_controller release];
        
        
    } else {
        QuarterlySurpriseSummaryViewController *summary_controller = [[QuarterlySurpriseSummaryViewController alloc] initWithNibName:@"QuarterlySurpriseSummaryView" bundle:nil];
        summary_controller.merchant_info = [items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size];
        summary_controller.headingTitle = NSLocalizedString(@"Year-round Offers", nil);
        // summary_controller.headingTitle = NSLocalizedString(@"Quarterly Surprise", nil);
        [self.navigationController pushViewController:summary_controller animated:TRUE];
        summary_controller.title_label.text = title_label.text;
        [summary_controller release];
        
    }
}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
    [items_data removeAllObjects];
    current_page = 1;
    key = [NSArray arrayWithObjects:
           @"id",
           @"title",
           @"etitle",
           @"shortdescription",
           @"description",
           @"category",
           @"cuisine",
           @"coupon",
           @"image",
           @"suprise",
           @"card",
           @"remark",
           @"newitem",
           nil];
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
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
    
    NSLog(@"%d merchants",[items_data count]);
    if ([items_data count]==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Cannot find offer for the search",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        alert.tag = NoOffer;
        [alert show];
        [alert release];
    } else {
        [table_view reloadData];
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
        if ([searching_type isEqualToString:@"shopping"] && [[temp_record objectForKey:@"category"] isEqualToString:@"Dining"]) {
        } else {
            [items_data addObject:temp_record];
        }
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    for (int i=0; i<[key count]; i++) {
        if ([currentElementName isEqualToString:[key objectAtIndex:i]] && [temp_record objectForKey:currentElementName]==nil) {
            [temp_record setObject:string forKey:currentElementName];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == NoOffer) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
