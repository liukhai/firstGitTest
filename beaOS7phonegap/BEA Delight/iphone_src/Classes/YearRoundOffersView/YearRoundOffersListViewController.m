//
//  YearRoundOffersListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月18日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YearRoundOffersListViewController.h"


@implementation YearRoundOffersListViewController
//jeff
@synthesize tnc_string;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        current_page = 1;
        current_page_size = 9999;
        total_page = 1;
        category_list = [[NSLocalizedString(@"category_list",nil) componentsSeparatedByString:@","] retain];
        items_data = [NSMutableArray new];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.delegate = self;
//    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    //    [[MyScreenUtil me] adjustModuleView:self.view];
    isInit = YES;
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    table_view.frame = CGRectMake(0, 93, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    
    [next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
    [prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
    
    if ([[CoreData sharedCoreData].menuType isEqualToString:@"2"]) {
        [self setMenuBar2];
    } else {
        [self setMenuBar1];
    }
    [self getItemsListTypeDo];
}

-(void)setMenuBar1
{
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
}

-(void)setMenuBar2
{
    RotateMenu2ViewController* v_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
    v_rmvc.rmUtil.caller = self;
    
    [self.view addSubview:v_rmvc.contentView];
    NSLog(@"%@",self.navigationController.viewControllers);
    NSArray *a_texts = [NSLocalizedString(@"tag_creditCardTitle",nil) componentsSeparatedByString:@","];
    [v_rmvc.rmUtil setTextArray:a_texts];
    UIView* view_temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    NSArray* a_views = [NSArray arrayWithObjects:view_temp,view_temp,view_temp,view_temp,view_temp,view_temp, nil];
    [v_rmvc.rmUtil setViewArray:a_views];
    
    [v_rmvc.rmUtil setNav:self.navigationController];
    [v_rmvc.rmUtil setShowIndex:3];
    [v_rmvc.rmUtil showMenu];
}

-(void)showMenu:(int)show
{
    NSLog(@"showMenu in:%@--%d", self, show);
    [CoreData sharedCoreData].menuType = @"2";
    if (show%6==0) {
    } else if (show%6==1) {
        [self.navigationController popViewControllerAnimated:NO];
        UIButton* tmp_button=[[UIButton alloc] init];
        tmp_button.tag=4;
        [[CoreData sharedCoreData].home_view_controller buttonPressed:tmp_button];
        [tmp_button release];
    } else if (show%6==2) {
        [self.navigationController popViewControllerAnimated:NO];
        UIButton* tmp_button=[[UIButton alloc] init];
        tmp_button.tag=1;
        [[CoreData sharedCoreData].home_view_controller buttonPressed:tmp_button];
        [tmp_button release];
    } else if (show%6==3) {
        //        [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
        //        UIButton* tmp_button=[[UIButton alloc] init];
        //        tmp_button.tag=0;
        //        [(HomeViewController*)([CoreData sharedCoreData].root_view_controller.current_view_controller) buttonPressed:tmp_button];
        //        [tmp_button release];
        if (isInit) {
            isInit = NO;
            return;
        }
        [self.navigationController popViewControllerAnimated:NO];
    } else if (show%6==4) {
        [self.navigationController popViewControllerAnimated:NO];
        UIButton* tmp_button=[[UIButton alloc] init];
        tmp_button.tag=3;
        [[CoreData sharedCoreData].home_view_controller buttonPressed:tmp_button];
        [tmp_button release];
    } else if (show%6==5) {
        [self.navigationController popViewControllerAnimated:NO];
        UIButton* tmp_button=[[UIButton alloc] init];
        tmp_button.tag=5;
        [[CoreData sharedCoreData].home_view_controller buttonPressed:tmp_button];
        [tmp_button release];
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
    [borderImageView release];
    borderImageView = nil;
    [lineImageView release];
    lineImageView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    NSLog(@"YearRoundOffersList deadloc");
    [category_list release];
    [current_type release];
    [current_category release];
    [items_data removeAllObjects];
    [items_data release];
    //jeff
    //	if(tnc_string != nil){
    //		[tnc_string release];
    //		tnc_string = nil;
    //	}
    if (titleText != nil) {
        [titleText release];
        titleText = nil;
    }
    [lineImageView release];
    [borderImageView release];
    asi_request.delegate = nil;
    [super dealloc];
}

-(void)setPageSize:(int)page_size {
    current_page_size = page_size;
}
-(void)getItemsListTypeDo{
    NSArray *offer_type_list = [NSLocalizedString(@"Year round menu",nil) componentsSeparatedByString:@","];
    if ([current_category isEqualToString:[category_list objectAtIndex:0]]) {
        title_label.text = [offer_type_list objectAtIndex:0];
        asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?top=true&cat=Dining&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    } else if ([current_category isEqualToString:[category_list objectAtIndex:1]]) {
        title_label.text = [offer_type_list objectAtIndex:1];
        asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?ht=true&shopping=false&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    } else if ([current_category isEqualToString:[category_list objectAtIndex:2]]) {
        title_label.text = [offer_type_list objectAtIndex:2];
        asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?cr=true&shopping=false&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    } else if ([current_category isEqualToString:[category_list objectAtIndex:3]]) {
        //        NSArray *location_list = [NSLocalizedString(@"location_list",nil) componentsSeparatedByString:@","];
        title_label.text = [titleText retain];
        return ;
    } else if ([current_category isEqualToString:[category_list objectAtIndex:4]]) {
        title_label.text = [offer_type_list objectAtIndex:4];
        asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?cat=Apparel&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    } else if ([current_category isEqualToString:[category_list objectAtIndex:5]]) {
        title_label.text = [offer_type_list objectAtIndex:5];
        asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?cat=Beauty&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    } else if ([current_category isEqualToString:[category_list objectAtIndex:6]]) {
        title_label.text = [offer_type_list objectAtIndex:6];
        asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?cat=Jewellery%%20%%26%%20Watches&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    } else if ([current_category isEqualToString:[category_list objectAtIndex:7]]) {
        title_label.text = [offer_type_list objectAtIndex:7];
        asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?cat=Lifestyle&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
        
    }
    if (asi_request==nil) {
        return;
    }
    [[CoreData sharedCoreData].mask showMask];
    //jeff
    NSLog(@"debug YearRoundOffersListViewController:%@",asi_request.url);
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
}
-(void)getItemsListType:(NSString *)list_type Category:(NSString *)category {
    NSLog(@"debug YearRoundOffersListViewController Get the list of type:%@ category:%@",list_type,category);
    current_type = [list_type retain];
    current_category = [category retain];
}

-(void)getItemsDistrict:(int)location_id {
    NSArray *location_list = [NSLocalizedString(@"location_list",nil) componentsSeparatedByString:@","];
    NSArray *location_id_list = [NSLocalizedString(@"location_id_list",nil) componentsSeparatedByString:@","];
    title_label.text = [location_list objectAtIndex:location_id];
    titleText = [[location_list objectAtIndex:location_id] retain];
    asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beamerchantlist.api?dt=%@&cat=Dining&top=false&cr=false&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[location_id_list objectAtIndex:location_id],[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    //	NSLog(@"%@",[NSString stringWithFormat:@"%@beamerchantlist.api?dt=%@&cat=Dining&top=false&cr=false&qs=false&lang=%@&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[location_id_list objectAtIndex:location_id],[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]);
    [[CoreData sharedCoreData].mask showMask];
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
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

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSLog(@"debug YearRoundOffersListViewController requestFinished:%@",[request responseString]);
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
    xml_parser.delegate = self;
    [xml_parser setShouldProcessNamespaces:NO];
    [xml_parser setShouldReportNamespacePrefixes:NO];
    [xml_parser setShouldResolveExternalEntities:NO];
    [xml_parser parse];
    [[CoreData sharedCoreData].mask hiddenMask];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"YearRoundOffersListViewController requestFailed:%@", request.error);
    
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
    /*	CustomCell *cell = (CustomCell *)[table_view dequeueReusableCellWithIdentifier:identifier];
     if (cell==nil) {
     cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
     }*/
    CustomCell2 *cell = [[CustomCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
    //	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    if ([current_category isEqualToString:[category_list objectAtIndex:0]] && [[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newtopitem"] isEqualToString:@"T"]) {
        cell.is_new.hidden = FALSE;
    } else {
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    YearRoundOffersSummaryViewController *summary_controller = [[YearRoundOffersSummaryViewController alloc] initWithNibName:@"YearRoundOffersSummaryView" bundle:nil];
    [summary_controller setMerchant_info:[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] tnc_string:tnc_string title_label:title_label.text];
    //	summary_controller.merchant_info = [items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size];
    //	//jeff
    //	summary_controller.tnc_string = tnc_string;
    summary_controller.title_label.text = title_label.text;
    summary_controller.headingTitle = title_label.text;
    [self.navigationController pushViewController:summary_controller animated:NO];
    
    [summary_controller release];
}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
    [items_data removeAllObjects];
    current_page = 1;
    key = [NSArray arrayWithObjects:@"id",@"title",@"etitle",@"shortdescription",@"description",@"category",@"cuisine",@"image",@"suprise",@"card",@"remark",@"newitem",@"newtopitem",nil];
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
    
    NSLog(@"%d merchants",[items_data count]);
    if ([items_data count]==0) {
        ComingSoonViewController *coming_soon_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
        [self.navigationController pushViewController:coming_soon_controller animated:TRUE];
        [coming_soon_controller release];
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

@end
