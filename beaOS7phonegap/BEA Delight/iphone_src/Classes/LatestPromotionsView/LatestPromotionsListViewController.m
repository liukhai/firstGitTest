//
//  QuaterlySurpriseListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LatestPromotionsListViewController.h"


@implementation LatestPromotionsListViewController

@synthesize table_view;
@synthesize items_data;
@synthesize title_label;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		self.items_data = [NSMutableArray new];
        mainPagePromo = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.delegate = self;
}

//-(void) viewWillDisappear:(BOOL) animated
//{
//    [super viewWillDisappear:animated];
//    if ([self isMovingFromParentViewController])
//    {
//        if (self.navigationController.delegate == self)
//        {
//            self.navigationController.delegate = nil;
//        }
//    }
//}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    NSLog(@"%@",NSStringFromCGRect(self.navigationController.view.frame));
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
//    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
//    table_view.frame = CGRectMake(0, 63, 320, 397+[[MyScreenUtil me] getScreenHeightAdjust]);

	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
	self.title_label.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"Latest Promotions",nil)];
	
	//jeff
	commingSoonImageView.hidden = YES;

    if ([[CoreData sharedCoreData].menuType isEqualToString:@"2"]) {
        [self setMenuBar2];
        [self initTableView];
    } else {
        [self setMenuBar1];
    }
}

-(void)initTableView{
    title_label.hidden = true;
    lineImageView.hidden = true;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        CGRect frame1 = table_view.frame;
        frame1.origin.y = frame1.origin.y-4;
        frame1.size.height = frame1.size.height-10;
        table_view.frame = frame1;
        
        CGRect frame2 = borderImageView.frame;
        frame2.origin.y = frame2.origin.y + 25;
        frame2.size.height = frame2.size.height-40;
        borderImageView.frame = frame2;
    } else {
        CGRect frame1 = table_view.frame;
        frame1.origin.y = frame1.origin.y-4;
        frame1.size.height = frame1.size.height+10;
        table_view.frame = frame1;
        
        CGRect frame2 = borderImageView.frame;
        frame2.origin.y = frame2.origin.y + 25;
        frame2.size.height = frame2.size.height-20;
        borderImageView.frame = frame2;
    }
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
    
	NSArray *a_texts = [NSLocalizedString(@"tag_creditCardTitle",nil) componentsSeparatedByString:@","];
    [v_rmvc.rmUtil setTextArray:a_texts];
    UIView* view_temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    NSArray* a_views = [NSArray arrayWithObjects:view_temp,view_temp,view_temp,view_temp,view_temp,view_temp, nil];
    [v_rmvc.rmUtil setViewArray:a_views];
    
    [v_rmvc.rmUtil setNav:self.navigationController];
    [v_rmvc.rmUtil setShowIndex:0];
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
    } else if (show%6==3) {
    } else if (show%6==4) {
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.items_data removeAllObjects];
	[self.items_data release];
    asi_request.delegate = nil;
    [super dealloc];
}

-(void)setPageSize:(int)page_size {
	current_page_size = page_size;
}

-(void)getItemsList {
	NSLog(@"Get the list of Latest Promotions");
	[[CoreData sharedCoreData].mask showMask];
	asi_request = [[ASIHTTPRequest alloc] initWithURL:
                   [NSURL URLWithString:
                    [NSString stringWithFormat:@"%@latestpromotions.api?lang=%@&UDID=%@",
                     [CoreData sharedCoreData].realServerURLCard,
                     [CoreData sharedCoreData].lang,
                     [CoreData sharedCoreData].UDID]]];
	asi_request.delegate = self;
	[[CoreData sharedCoreData].queue addOperation:asi_request];
    
	//jeff
	NSLog(@"debug LatestPromotionsListViewController asi_request.url: %@", asi_request.url);
	//
}

-(IBAction)tncButtonPressed:(UIButton *)button {
	TermsAndConditionsViewController *tnc_controller = [[TermsAndConditionsViewController alloc] initWithNibName:@"TermsAndConditionsView" bundle:nil];
    [tnc_controller setTncStr:NSLocalizedString(@"TNC Shopping",nil)];
	[self.navigationController pushViewController:tnc_controller animated:TRUE];
//	tnc_controller.tnc.text = NSLocalizedString(@"TNC Shopping",nil);
	[tnc_controller release];
}

//-(IBAction)prevButtonPressed:(UIButton *)button {
//	if (current_page>1) {
//		current_page--;
//		next.hidden = FALSE;
//		if (current_page==1) {
//			prev.hidden = TRUE;
//		}
//		[table_view reloadData];
//		table_view.contentOffset = CGPointMake(0, 0);
//	}
//}
//
//-(IBAction)nextButtonPressed:(UIButton *)button {
//	if (current_page<total_page) {
//		current_page++;
//		prev.hidden = FALSE;
//		if (current_page==total_page) {
//			next.hidden = TRUE;
//		}
//		[table_view reloadData];
//		table_view.contentOffset = CGPointMake(0, 0);
//	}
//}

-(IBAction)homeButtonPressed:(UIBarButtonItem *)button {
	[(RootViewController *)[CoreData sharedCoreData].root_view_controller setContent:-1];
}

///////////////////
//ASIHTTPRequest
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	
//	NSLog(@"%@",[request responseString]);
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[[CoreData sharedCoreData].mask hiddenMask];
	/*if ([self.items_data count]==1) {
		[self tableView:table_view didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	}*/
	
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"LatestPromotionsListViewController requestFailed:%@", request.error);

    if (!mainPagePromo) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
    }
	
	[[CoreData sharedCoreData].mask hiddenMask];
	
}

///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	int total_record = [self.items_data count];
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
	LargeImageCell *cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
    
    NSString *title;
    title = @"title";
//    if (indexPath.row%2) {
//        
//    } else {
        if (indexPath.row == [self.items_data count] -1 ) {
            if ([self.items_data count] > 5) {
                
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                //            label.backgroundColor = [UIColor blueColor];
                [cell addSubview:label];

            }
//            NSLog(@"%d",indexPath.row);
        }else {
//            NSLog(@"%d",indexPath.row);
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, cell.frame.size.width, 1.5)];
            label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
            //            label.backgroundColor = [UIColor blueColor];
            [cell addSubview:label];
        }
//    }
    if (mainPagePromo) {
        cell = [[LargeImageCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:1];
        cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        //无色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title_label.font = [UIFont systemFontOfSize:13.0];
        
        cell.cached_image_view.frame = CGRectMake(cell.cached_image_view.frame.origin.x,cell.cached_image_view.frame.origin.y, cell.cached_image_view.frame.size.width, cell.cached_image_view.frame.size.height);
        cell.name = [[self.items_data objectAtIndex:indexPath.row] objectForKey:title];
        cell.title_label.frame = CGRectMake(cell.title_label.frame.origin.x-5, -4.5, cell.title_label.frame.size.width+10, cell.title_label.frame.size.height);
        cell.title_label.font = [UIFont systemFontOfSize:13.0];
    
    }
//	}
	cell.title_label.text = [[self.items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"title"];
	//cell.description_label.text = [[[self.items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
    NSLog(@"url is %@", [[self.items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"thumbnail"]);
	NSString *image = [[self.items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"thumbnail"];
	if (image!=nil && ![image isEqualToString:@""]) {
		[cell.cached_image_view loadImageWithURL:[[self.items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"thumbnail"]];
	}
	if ([[[self.items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
		cell.is_new.hidden = FALSE;
	} else {
		cell.is_new.hidden = TRUE;
	}
//    if (indexPath.row>0) {
//        if ([CoreData sharedCoreData].bea_view_controller->jump2) {
//            [CoreData sharedCoreData].bea_view_controller->jump2 = NO;
//            [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(openPromoItem1:) userInfo:nil repeats:TRUE];
//        }
//    }

	return cell;
}

//-(void)openPromoItem1:(NSTimer *)timer {
//    [timer invalidate];
//    [self didSelectRowAtIndexPath:0];
//    [[CoreData sharedCoreData].mask hiddenMask];
//}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    [self didSelectRowAtIndexPath:indexPath.row];
}

-(void) didSelectRowAtIndexPath:(int)index {
    BEAAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (delegate.isClick == YES) {
        delegate.isClick = NO;
    }
	LatestPromotionsSummaryViewController *summary_controller = [[LatestPromotionsSummaryViewController alloc] initWithNibName:@"LatestPromotionsSummaryView" bundle:nil];
	summary_controller.merchant_info = [self.items_data objectAtIndex:index + (current_page-1) * current_page_size];
	if ([self.items_data count]==1) {
		[self.navigationController pushViewController:summary_controller animated:FALSE];
	} else {
		[self.navigationController pushViewController:summary_controller animated:FALSE];
	}
	summary_controller.title_label.text = self.title_label.text;
	[summary_controller release];
//    NSLog(@"debug LatestPromotionsListViewController didSelectRowAtIndexPath:%@--%@", self.title_label.text, self.items_data);
}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	[self.items_data removeAllObjects];
	current_page = 1;
	key = [NSArray arrayWithObjects:@"id",@"title",@"etitle",@"shortdescription",@"description",@"thumbnail",@"category",@"preview",@"cuisine",@"suprise",@"address",@"tel",@"card",@"coupon",@"remark",@"newitem",nil];
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	total_page = ceil([self.items_data count]/(float)current_page_size);
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
	
//	NSLog(@"%d merchants, items_data is %@",[self.items_data count], self.items_data);
	if ([self.items_data count]==0) {
		//ComingSoonViewController *coming_soon_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
		//[self.navigationController pushViewController:coming_soon_controller animated:TRUE];
		//[coming_soon_controller release];
		commingSoonImageView.hidden = NO;
	} else {
		[table_view reloadData];
	}
    [[CoreData sharedCoreData].bea_view_controller setAccessibilityForPlistvc2:[[self.items_data objectAtIndex:0] objectForKey:@"title"]];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
	} else if ([elementName isEqualToString:@"merchants"]) {
		temp_merchant_list = [NSMutableArray new];
	} else if ([elementName isEqualToString:@"images"]) {
		temp_image_list = [NSMutableArray new];
	}
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {
		//NSLog(@"%@",[temp_record objectForKey:@"description"]);
		[self.items_data addObject:temp_record];
	} else if ([elementName isEqualToString:@"merchants"]) {
		[temp_record setValue:temp_merchant_list forKey:@"merchants"];
	} else if ([elementName isEqualToString:@"images"]) {
		[temp_record setValue:temp_image_list forKey:@"images"];
	}
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	for (int i=0; i<[key count]; i++) {
		if ([currentElementName isEqualToString:[key objectAtIndex:i]] && [temp_record objectForKey:currentElementName]==nil) {
			[temp_record setObject:string forKey:currentElementName];
			//NSLog(@"%@ %@",currentElementName,string);
		}
	}
	if ([currentElementName isEqualToString:@"merchant"]) {
		if ([string length]>4) {
			[temp_merchant_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"image"]) {
		if ([string length]>4) {
			[temp_image_list addObject:string];
		}
	}
}

@end
