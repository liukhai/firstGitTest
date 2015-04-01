//
//  QuaterlySurpriseListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AccProListViewController.h"
#import "InsuranceUtil.h"


@implementation AccProListViewController

@synthesize items_data, table_view, md_temp, lb_pagetitle;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		self.items_data = [NSMutableArray new];
        mainPagePromo = NO;
    }
    NSLog(@"debug AccProListViewController initWithNibName:%@", self);
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //edit by chu 20150217
    [self refreshViewContent];
//    NSLog(@"debug AccProListViewController viewDidLoad:%@", self);
    NSLog(@"debug AccProListViewController viewDidLoad:%@", self.view);
}

//-(void) loadPlistData{
//    NSString *date_stamp;
//    md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[AccProUtil me ]findPlistPaths]];
//    date_stamp = [md_temp objectForKey:@"SN"];
//	NSLog(@"debug AccProListViewController loadPlistData:%@",date_stamp);
//    if (date_stamp == nil && ![[AccProUtil me] isSend]) {
//        [[AccProUtil me] sendRequest:date_stamp listViewController:self];
//    }else{
//        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
//        [formatter setDateFormat:@"yyyyMMdd"];
//        NSDate *now = [NSDate date];
//        now = [formatter dateFromString:[formatter stringFromDate:now] ];
//        NSDate *updateDate = [formatter dateFromString:date_stamp];
//        NSLog(@"current date:%@, update_date:%@",[formatter stringFromDate:now],date_stamp);
//        BOOL dateExpired = ((NSOrderedDescending == [now  compare:updateDate]));
//        NSLog(@"AccProListViewController: dateExpired:%d",dateExpired);
//        if (dateExpired && ![[AccProUtil me] isSend]) {
//            [[AccProUtil me] sendRequest:date_stamp listViewController:self];
//        }else{
//            self.self.items_data = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"promotionList"] copyItems:YES];
//            [table_view reloadData];
//            table_view.contentOffset = CGPointMake(0, 0);
//            
//        }
//    }
//}


- (void) loadPlistData{
	NSLog(@"debug AccProListViewController loadPlistData starts");
    
    asi_request = [[ASIHTTPRequest alloc]
                                   initWithURL:
                                   [NSURL URLWithString:
                                    [NSString stringWithFormat:@"%@getinfo.api?type=10&lang=%@",
                                     [CoreData sharedCoreData].realServerURL,
                                     [[LangUtil me] getLangID]
                                     ]]];
    NSLog(@"debug url:%@",asi_request.url);
    
    asi_request.delegate = self;
    [asi_request.delegate retain];
    [[CoreData sharedCoreData].queue addOperation:asi_request];
    
    [[CoreData sharedCoreData].mask showMask];
	NSLog(@"debug AccProListViewController loadPlistData end");
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
//    NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
//	NSLog(@"debug AccProListViewController requestFinished:%@", reponsedString);
    
    NSString *ns_temp_file = [[AccProUtil me ]findPlistPaths];
	[[request responseData] writeToFile:ns_temp_file atomically:YES];
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"AccProListViewController >> requestFailed req:%@", request);
//    [self loadPlistDataDetail];
	[[CoreData sharedCoreData].mask hiddenMask];
    [asi_request.delegate release];
}

-(void)loadPlistDataDetail{
    NSLog(@"loadPlistDataDetail starts");
    
    [[CoreData sharedCoreData].mask showMask];
    
    NSData * datas = [NSData dataWithContentsOfFile:[[AccProUtil me ]findPlistPaths]];
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:datas];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
    
    NSLog(@"loadPlistDataDetail end");
    
}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
    
    [self.items_data removeAllObjects];
    self.items_data = nil;
    self.items_data = [NSMutableArray new];
    
	key = [NSArray arrayWithObjects:
           @"id",
           @"title",//email's heading
           @"thumb",//icon
           @"image",//main page
           @"tel_label",//3.查詢
           @"tel",//3.查詢
           @"pdf_url",//1.T&C URL
           @"tnc_label",//1.T&C Label
           @"url",//4.開始遊戲
           @"url_label",//4.開始遊戲
           @"emailbody",//email's body
           @"emailsubject",//email's subject
           @"shortdesc",
           @"desc",
           @"tnc",
           nil];//2.share app
    //	NSLog(@"debug parserDidStartDocument:%@",key);
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
//	NSLog(@"debug parserDidEndDocument:%d outlets",[self.items_data count]);
	if ([temp_record count]==0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No offer in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
        [self isNotEmptyList];
	} else {
		[table_view reloadData];
	}
    [[CoreData sharedCoreData].bea_view_controller setAccessibilityForPlistvc1:[[self.items_data objectAtIndex:0] objectForKey:@"title"]];
//	NSLog(@"debug parserDidEndDocument:%@", self.items_data);
    [[CoreData sharedCoreData].mask hiddenMask];
    [asi_request.delegate release];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
	}
    //	NSLog(@"debug didStartElement:%@",elementName);
}

-(void)fixspace:(NSString*)akey
{
    NSString* value=[temp_record objectForKey:akey];
//    NSLog(@"debug fixspace begin:[%@]--[%@]", akey, value);
    if (!value) {
//        NSLog(@"debug fixspace end with nil:[%@]--[%@]", akey, value);
        return;
    }
    if (!([akey isEqualToString:@"shortdesc"] || [akey isEqualToString:@"desc"])) {
        value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    }else {
        NSString *descriptionTemp = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        descriptionTemp = [descriptionTemp stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        if ([descriptionTemp isEqualToString:@""]) {
            value = @"";
        }
    }
    if ([akey isEqualToString:@"thumb"]
        ||
        [akey isEqualToString:@"image"]
        ||
        [akey isEqualToString:@"pdf_url"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    } else if (![akey isEqualToString:@"title"] && ![akey isEqualToString:@"tel"] && ![akey isEqualToString:@"emailsubject"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
//    NSLog(@"debug fixspace end:[%@]--[%@]", akey, value);
    [temp_record setObject:value forKey:akey];
    return;
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {
        
//        NSLog(@"debug fixspace before:[%@]", temp_record);

        [self fixspace:@"id"];
        [self fixspace:@"image"];
        [self fixspace:@"title"];
        [self fixspace:@"tel"];
        [self fixspace:@"tel_label"];
        [self fixspace:@"thumb"];
        [self fixspace:@"url"];
      //  [self fixspace:@"url_label"];
        [self fixspace:@"pdf_url"];
        [self fixspace:@"tnc_label"];
        [self fixspace:@"emailsubject"];
        [self fixspace:@"tnc"];
//        [self fixspace:@"shortdesc"];
//        [self fixspace:@"desc"];
        
//        NSLog(@"debug fixspace after:[%@]", temp_record);
        NSString *value = [temp_record objectForKey:@"shortdesc"];
        if ((NSNull *)value == [NSNull null] || [value isEqualToString:@"\n\t\t\t"]) {
            [self fixspace:@"shortdesc"];
        }
        [self.items_data addObject:temp_record];
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
/*
-(void)setPageSize:(int)page_size {
	current_page_size = page_size;
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
*/
///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    int height = [self fitHeight:[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"title"]] + [self fitHeight:[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]] + 15;
    if ([self cellHeight:indexPath] > 81) {
        return [self cellHeight:indexPath];
    }
	return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    NSLog(@"debug AccProListViewController numberOfRowsInSection:%d",[self.items_data count]);
	return [self.items_data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = @"CustomCell";
    
    LargeImageCell* cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
//    if (indexPath.row%2) {
//        
//    } else {

//    }
//	cell.accessoryType = UITableViewCellAccessoryNone;
//	cell.title_label.frame = CGRectMake(cell.title_label.frame.origin.x, cell.title_label.frame.origin.y, cell.title_label.frame.size.width, 60);
//	cell.title_label.numberOfLines = 0;
    NSString *thumbnail;
    NSString *title;
    thumbnail = @"thumb";
    title = @"title";
//    if ([AccProUtil isLangOfChi]) {
//        thumbnail = @"thumbnail_zh";
//        title = @"title_zh";
//    }else{
//        thumbnail = @"thumbnail_en";
//        title = @"title_en";
//    }
    
//	cell.description_label.text = [[[self.items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
    cell.name = [[self.items_data objectAtIndex:indexPath.row] objectForKey:title];

    cell.description = [[self.items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"];
    
    if (indexPath.row == [self.items_data count] -1 ) {
        if ([self cellHeight:indexPath] < 81) {
            if ([self cellHeight:indexPath] < 81) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                //            label.backgroundColor = [UIColor blueColor];
                [cell addSubview:label];
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self cellHeight:indexPath] - 1.5, cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                //            label.backgroundColor = [UIColor blueColor];
                [cell addSubview:label];
            }
        }
        NSLog(@"%d",indexPath.row);
    }else {
        NSLog(@"%d",indexPath.row);
        if ([self cellHeight:indexPath] < 81) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, cell.frame.size.width, 1.5)];
            label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
            //            label.backgroundColor = [UIColor blueColor];
            [cell addSubview:label];
        } else {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self cellHeight:indexPath] - 1.5, cell.frame.size.width, 1.5)];
            label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
            //            label.backgroundColor = [UIColor blueColor];
            [cell addSubview:label];
        }
        
    }
    
    NSLog(@"debug title:%@",cell.name);
//    if (cell.title_label.frame.size.height < 81) {
//        
//        cell.title_label.frame = CGRectMake(cell.title_label.frame.origin.x-5, cell.title_label.frame.origin.y, cell.title_label.frame.size.width+10, cell.title_label.frame.size.height);
//        cell.description_label.frame = CGRectMake(cell.description_label.frame.origin.x-5, cell.title_label.frame.origin.y + cell.title_label.frame.size.height + 10, cell.description_label.frame.size.width+10, cell.description_label.frame.size.height);
//    } else {
//        cell.title_label.frame = CGRectMake(cell.title_label.frame.origin.x-5, cell.title_label.frame.origin.y-6, cell.title_label.frame.size.width+10, cell.title_label.frame.size.height);
//        cell.description_label.frame = CGRectMake(cell.description_label.frame.origin.x-5, cell.title_label.frame.origin.y + cell.title_label.frame.size.height + 10, cell.description_label.frame.size.width+10, cell.description_label.frame.size.height);
//    }
//    if ([self fitHeight:[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"title"]] + [self fitHeight:[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]] + 15 < 81) {
////        cell.cached_image_view.backgroundColor = [UIColor yellowColor];
//        cell.cached_image_view.frame = CGRectMake(cell.cached_image_view.frame.origin.x,10, cell.cached_image_view.frame.size.width, cell.cached_image_view.frame.size.height);
//        cell.cached_image_bg.frame = CGRectMake(cell.cached_image_bg.frame.origin.x,81/2-cell.cached_image_bg.frame.size.height/2, cell.cached_image_bg.frame.size.width, cell.cached_image_bg.frame.size.height);
//    }else {
//        cell.cached_image_view.frame = CGRectMake(cell.cached_image_view.frame.origin.x,([self fitHeight:[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"title"]] + [self fitHeight:[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]] + 15)/2 - cell.cached_image_view.frame.size.height/2, cell.cached_image_view.frame.size.width, cell.cached_image_view.frame.size.height);
//    }
    if (mainPagePromo) {
        cell = [[LargeImageCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:1];
        cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        //无色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self fitHeight:[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"title"]] + [self fitHeight:[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]] + 15 < 81) {
            cell.cached_image_view.frame = CGRectMake(cell.cached_image_view.frame.origin.x,0, cell.cached_image_view.frame.size.width, cell.cached_image_view.frame.size.height);
            cell.name = [[self.items_data objectAtIndex:indexPath.row] objectForKey:title];
            cell.title_label.frame = CGRectMake(cell.title_label.frame.origin.x-5, -3, cell.title_label.frame.size.width+10, cell.title_label.frame.size.height);
            cell.title_label.font = [UIFont systemFontOfSize:13.0];
        } else {
            cell.cached_image_view.frame = CGRectMake(cell.cached_image_view.frame.origin.x,cell.cached_image_view.frame.origin.y, cell.cached_image_view.frame.size.width, cell.cached_image_view.frame.size.height);
            cell.name = [[self.items_data objectAtIndex:indexPath.row] objectForKey:title];
            cell.title_label.frame = CGRectMake(cell.title_label.frame.origin.x-5, -3, cell.title_label.frame.size.width+10, cell.title_label.frame.size.height);
            cell.title_label.font = [UIFont systemFontOfSize:13.0];
        }
        
    }
    
    
    
    NSString *image = [[self.items_data objectAtIndex:indexPath.row] objectForKey:thumbnail];
    if (image!=nil && ![image isEqualToString:@""]) {
        [cell.cached_image_view loadImageWithURL:[[self.items_data objectAtIndex:indexPath.row] objectForKey:thumbnail]];
    }
//	if ([[[self.items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
		cell.is_new.hidden = FALSE;
//	} else {
//		cell.is_new.hidden = TRUE;
//	}
    
	if (indexPath.row>0) {
        if ([[AccProUtil me].inStockWatch isEqualToString:@"YES"]) {
            [AccProUtil me].inStockWatch = @"";
            openLatesPromoItem1Timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(openLatestPromoItem1:) userInfo:nil repeats:TRUE];
        }
    }
//    if (indexPath.row>0) {
//        if ([CoreData sharedCoreData].bea_view_controller->jump1) {
//            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(openLatestPromoItem1:) userInfo:nil repeats:TRUE];
//        }
//    }
    NSLog(@"debug AccProListViewController cellForRowAtIndexPath:%@", cell);
	return cell;
}

//-(void)openLatestPromoItem1:(NSTimer *)timer {
//    [timer invalidate];
//    [self didSelectRowAtIndexPath:0];
//    [[CoreData sharedCoreData].mask hiddenMask];
//}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    [self didSelectRowAtIndexPath:indexPath.row];
}

-(void) didSelectRowAtIndexPath:(int)index {
    
    //	LatestPromotionsSummaryViewController *summary_controller = [[LatestPromotionsSummaryViewController alloc] initWithNibName:@"LatestPromotionsSummaryView" bundle:nil];
    //	summary_controller.merchant_info = [self.items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size];
    //	if ([self.items_data count]==1) {
    //		[self.navigationController pushViewController:summary_controller animated:TRUE];
    //	} else {
    //		[self.navigationController pushViewController:summary_controller animated:TRUE];
    //	}
//    NSString *targeturl = nil;
//    NSString *defaultViewController = nil;
//    NSString *targetHotline = nil;
//    NSString *targetBtnLabel = nil;
//    NSString *targetTNC = nil;
//    NSString *url2 = nil;
//    NSString *url2label = nil;
//    if ([AccProUtil isLangOfChi]) {
//        targeturl = [[self.items_data objectAtIndex:index + (current_page-1) * current_page_size] objectForKey:@"target_url_zh"];
//        targetBtnLabel = [[self.items_data objectAtIndex:index + (current_page-1) * current_page_size] objectForKey:@"call_zh"];
//        defaultViewController = @"AccProDefaultPageViewController_zh";
//    }else{
//        targeturl = [[self.items_data objectAtIndex:index + (current_page-1) * current_page_size] objectForKey:@"target_url_en"];
//        targetBtnLabel = [[self.items_data objectAtIndex:index + (current_page-1) * current_page_size] objectForKey:@"call_en"];
//        defaultViewController = @"AccProDefaultPageViewController_en";
//    }
    
//    targeturl = [[self.items_data objectAtIndex:index] objectForKey:@"image"];
//    targetBtnLabel=[[self.items_data objectAtIndex:index] objectForKey:@"tel_label"];
//    targetHotline = [[self.items_data objectAtIndex:index] objectForKey:@"tel"];
//    targetTNC = [[self.items_data objectAtIndex:index] objectForKey:@"pdf_url"];
//    url2 = [[self.items_data objectAtIndex:index] objectForKey:@"url"];
//    url2label = [[self.items_data objectAtIndex:index] objectForKey:@"url_label"];

//    targetHotline = [[self.items_data objectAtIndex:index + (current_page-1) * current_page_size] objectForKey:@"Hotline"];
//    AccProOffersViewController *accProOffersViewController=nil;
    
//    NSString  *web = nil;//added by jasen on 20111118
//    web = [[self.items_data objectAtIndex:index + (current_page-1) * current_page_size] objectForKey:@"web"];
//    if ([web isEqualToString:@"1"]){
    /*
        [[ConsumerLoanUtil me] showConsumerLoanViewController:@"AccProListViewController"
                                                          url:targeturl
                                                      hotline:targetHotline
                                                     btnLanel:targetBtnLabel
                                                          tnc:targetTNC
                                                         url2:url2
                                                    url2label:url2label];
    */
    
//    NSLog(@"debug didSelectRowAtIndexPath:%@", [self.items_data objectAtIndex:index]);
    
    ConsumerLoanOffersViewController* current_view_controller =
    [[ConsumerLoanOffersViewController alloc] initWithNibName:@"ConsumerLoanOffersViewController"
                                                       bundle:nil
                                                     merchant:[self.items_data objectAtIndex:index]];
    current_view_controller.functionName = NSLocalizedString(@"tag_fav_privileges", nil);
    current_view_controller.fromType = @"Pri";
    if (![MBKUtil isLangOfChi]) {
        current_view_controller.submenuName = NSLocalizedString(@"tag_offers",nil);
    }
    
    [[AccProUtil me].AccPro_view_controller.navigationController pushViewController:current_view_controller animated:YES];
//    }else if ([web isEqualToString:@"2"]){
//        //       [InsuranceUtil me].frompage = @"accpro";
//        [[InsuranceUtil me] showInsuranceViewController:@"accpro" url:targeturl hotline:targetHotline btnLanel:targetBtnLabel];
//        
//        /*
//         InsuranceOffersViewController *insuranceOffersViewController = [[InsuranceOffersViewController alloc] initWithNibName:@"InsuranceOffersViewController" bundle:nil url:targeturl hotline:targetHotline caption:targetBtnLabel];
//         [self.navigationController pushViewController:insuranceOffersViewController animated:TRUE];
//         [insuranceOffersViewController release];
//         */
//        
//    }else if ([web isEqualToString:@"3"]){
//        AccProWebViewController* _AccProWebViewController = [[AccProWebViewController alloc] initWithNibName:@"AccProWebViewController" bundle:nil latestpromoUrl:targeturl latestpromoHotline:targetHotline btnLabel:targetBtnLabel];
//        [self.navigationController pushViewController:_AccProWebViewController animated:TRUE];
//        [_AccProWebViewController release];
//    }else if([targetHotline isEqualToString:@"QuoteAndApply"]){
//        [InsuranceUtil me].animate = @"NO";
//        [AccProUtil me].animate = @"NO";
//        [self.navigationController popViewControllerAnimated:YES];
//        
//        [InsuranceUtil me].nextTab = @"application";
//        [InsuranceUtil me].quoteAndApply = @"YES";
//        UIButton* acc_pro_button=[[UIButton alloc] init];
//        acc_pro_button.tag=21;
//        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
//        [acc_pro_button release];
//        return;
//    }else if([targeturl isEqualToString:@"AccProDefaultViewController"]){
//        [[AccProUtil me].AccPro_view_controller showWelcomeOffer];
//    }else if([targeturl isEqualToString:@"TaxLoan"]){
//        [CoreData sharedCoreData].lastScreen = @"LTViewController";
//        [CoreData sharedCoreData]._LTViewController.frompage=@"latestpromot";
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.5];
//        [[CoreData sharedCoreData].root_view_controller setContent:0];
//        [(RootViewController*)[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers objectAtIndex:0] setContent:2];
//        [CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//        [UIView commitAnimations];
//    }else if([targeturl isEqualToString:@"InstalmentLoanViewController"]){
//        [CoreData sharedCoreData].lastScreen = @"InstalmentLoanViewController";
//        [CoreData sharedCoreData]._InstalmentLoanViewController.frompage=@"latestpromot";
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.5];
//        [[CoreData sharedCoreData].root_view_controller setContent:0];
//        [(RootViewController*)[[CoreData sharedCoreData]._InstalmentLoanViewController.navigationController.viewControllers objectAtIndex:0] setContent:3];
//        [CoreData sharedCoreData]._InstalmentLoanViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//        [UIView commitAnimations];
//    }else {
//        accProOffersViewController = [[AccProOffersViewController alloc] initWithNibName:@"AccProOffersViewController" bundle:nil latestpromoUrl:targeturl latestpromoHotline:targetHotline btnLabel:targetBtnLabel];
//        [self.navigationController pushViewController:accProOffersViewController animated:TRUE];
//        [accProOffersViewController release];
//    }
    
    //    if(index == 1){
    //        AccProOffersViewController *accProOffersViewController = [[AccProOffersViewController alloc] initWithNibName:@"AccProOffersViewController" bundle:nil];
    //        [self.navigationController pushViewController:accProOffersViewController animated:TRUE];
    //        [accProOffersViewController release];
    //    }
    //	summary_controller.title_label.text = title_label.text;
}

-(BOOL)isNotEmptyList
{
//    BOOL isNotEmpty = ([self.items_data count]>0);
//    if (!isNotEmpty)
//    {
        if ([[CoreData sharedCoreData].lang hasPrefix:@"e"]){
            CGRect frame = self.table_view.frame;
            UIImageView *bg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coming_soon_en.png"]] autorelease];
            bg.contentMode = UIViewContentModeScaleToFill;
            frame = bg.frame;
            frame.origin.x = ([UIScreen mainScreen].bounds.size.width-190)/2;
            frame.origin.y = (frame.size.height - 165)/2;
            frame.size.width = 190;
            frame.size.height = 165;
            bg.frame = frame;
            //		bg.frame = frame;
            [self.view addSubview:bg];
        }
        
        if ([[CoreData sharedCoreData].lang hasPrefix:@"zh_TW"]){
            CGRect frame = self.table_view.frame;
            UIImageView *bg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coming_soon_tw.png"]] autorelease];
            bg.contentMode = UIViewContentModeScaleToFill;
            frame = bg.frame;
            frame.origin.x = ([UIScreen mainScreen].bounds.size.width-190)/2;
            frame.origin.y = (frame.size.height - 165)/2;
            frame.size.width = 190;
            frame.size.height = 165;
            bg.frame = frame;
            //		bg.frame = frame;
            [self.view addSubview:bg];
        }
//    }
//    return isNotEmpty;
}

- (CGFloat) cellHeight:(NSIndexPath *)indexPath {
    NSString *str;
//    if ([[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"] isEqualToString:@""]) {
//        str = [[self.items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
//    }else {
        str = [NSString stringWithFormat:@"%@\n\n%@",[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"title"],[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]];
//    }

    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    return [self fitHeight:str] + 20;
    
}

- (int) fitHeight:(NSString *)str
{
    //    NSLog(@"debug ATMCustomCellCMS fitHeight:%@", sender.text);
    
    CGSize maxSize = CGSizeMake(150, MAXFLOAT);
    CGSize text_area = [str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    int height = text_area.height;
    return height;
}

//edit by chu - 20150217
-(void) refreshViewContent{
    //edit by chu - 20150216
    self.lb_pagetitle.text = NSLocalizedString(@"tag_fav_privileges",nil);
    self.lb_pagetitle.accessibilityLabel = NSLocalizedString(@"tag_fav_privileges",nil);
    [self.items_data removeAllObjects];
    
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 00, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    table_view.frame = CGRectMake(0, 45, 320, 322+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    
    [self loadPlistData];
    //	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
    //	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
    title_label.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"Latest Promotions",nil)];

}
@end
