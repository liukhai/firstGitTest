//
//  QuaterlySurpriseListViewController.m
//  BEA Surprise
//
//  Created by neo on 12年1月11日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConsumerLoanListViewController.h"
#import "MBKUtil.h"
#import "SideMenuUtil.h"
#import "TaxLoanOffersViewController.h"

@implementation ConsumerLoanListViewController
@synthesize items_data, table_view, lb_pagetitle;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
//		current_page = 1;
//		current_page_size = 9999;
//		total_page = 1;
		items_data = [NSMutableArray new];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //edit by chu 20150216
    self.lb_pagetitle.text = NSLocalizedString(@"ConsumerLoansOffers",nil);
    self.lb_pagetitle.accessibilityLabel = NSLocalizedString(@"ConsumerLoansOffers",nil);
//    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    [SideMenuUtil me].menu_view.accessibilityElementsHidden = YES;
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
//    self.view.frame = CGRectMake(0, 0, 320, 363+[[MyScreenUtil me] getScreenHeightAdjust]);
//    table_view.frame = CGRectMake(15, 15, 290, 433+[[MyScreenUtil me] getScreenHeightAdjust]);

    [self loadPlistData];
    [self initTableView];
//	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
//	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
	title_label.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"TaxLoanMenu",nil)];
}

-(void)initTableView{
    title_label.hidden = true;
    //    lineImageView.hidden = true;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        CGRect frame1 = table_view.frame;
        frame1.origin.y = frame1.origin.y-4;
        frame1.size.height = frame1.size.height-25;
        table_view.frame = frame1;
        
        CGRect frame2 = borderImageView.frame;
        frame2.origin.y = frame2.origin.y;
        frame2.size.height = frame2.size.height-30;
        borderImageView.frame = frame2;
    }
}

//-(void) loadPlistData{
//    NSString *date_stamp;
//    md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[TaxLoanUtil me ] findPlistPaths]];
//    date_stamp = [md_temp objectForKey:@"SN"];
//	NSLog(@"loadPlistData:%@",date_stamp);
//    if (date_stamp == nil && ![[TaxLoanUtil me] isSend]) {
//        [[TaxLoanUtil me] sendRequest:date_stamp listViewController:self];
//    }else{
//        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
//        [formatter setDateFormat:@"yyyyMMdd"];
//        NSDate *now = [NSDate date];
//        now = [formatter dateFromString:[formatter stringFromDate:now] ];
//        NSDate *updateDate = [formatter dateFromString:date_stamp];
//        NSLog(@"current date:%@, update_date:%@",[formatter stringFromDate:now],date_stamp);
//        BOOL dateExpired = ((NSOrderedDescending == [now  compare:updateDate]));
//        NSLog(@"ConsumerLoanListViewController: dateExpired:%d",dateExpired);
//        if (dateExpired && ![[TaxLoanUtil me] isSend]) {
//            [[TaxLoanUtil me] sendRequest:date_stamp listViewController:self];
//        }else{
//            self.items_data = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"promotionList"] copyItems:YES];
//            [table_view reloadData];
//            table_view.contentOffset = CGPointMake(0, 0);
//            if ([self isNotEmptyList]) [table_view reloadData];
//            table_view.contentOffset = CGPointMake(0, 0);
//        }
//    }
//}

- (void) loadPlistData{
	NSLog(@"debug ConsumerLoanListViewController loadPlistData starts");
    
    ASIHTTPRequest* asi_request = [[ASIHTTPRequest alloc]
                                   initWithURL:
                                   [NSURL
                                    URLWithString:
                                    [NSString
                                     stringWithFormat:@"%@getinfo.api?type=3&lang=%@",
                                     [CoreData sharedCoreData].realServerURL,
                                     [[LangUtil me] getLangID]
                                     ]]];
    NSLog(@"debug url:%@",asi_request.url);
    
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
    
    [[CoreData sharedCoreData].mask showMask];
	NSLog(@"debug ConsumerLoanListViewController loadPlistData end");
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
//    NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
//	NSLog(@"debug ConsumerLoanListViewController requestFinished:%@", reponsedString);
    
    NSString *ns_temp_file = [[TaxLoanUtil me ] findPlistPaths];
	[[request responseData] writeToFile:ns_temp_file atomically:YES];
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"ConsumerLoanListViewController >> requestFailed:%@", request.error);
    [self loadPlistDataDetail];
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void)loadPlistDataDetail{
    NSLog(@"loadPlistDataDetail starts");
    
    [[CoreData sharedCoreData].mask showMask];
    
    NSData * datas = [NSData dataWithContentsOfFile:[[TaxLoanUtil me ] findPlistPaths]];
    
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

//	key = [NSArray arrayWithObjects:
//           @"id",
//           @"title",
//           @"thumb",
//           @"image",
//           @"tel_label",
//           @"tel",
//           @"pdf_url",
//           @"url",
//           @"url_label",
//           nil];
	key = [NSArray arrayWithObjects:
           @"id",
           @"title",//email's heading
           @"thumb",//icon
           @"image",//main page
           @"tel_label",//3.查詢
           @"tel",//3.查詢
           @"pdf_url",//1.T&C
           @"url",//4.開始遊戲
           @"url_label",//4.開始遊戲
           @"emailbody",//email's body
           @"emailsubject",//email's subject
           @"tnc_label",
           @"tnc",
           @"shortdesc",
           @"desc",
           nil];//2.share app
    //	NSLog(@"debug parserDidStartDocument:%@",key);
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	NSLog(@"debug ConsumerLoanListViewController parserDidEndDocument:%d outlets",[self.items_data count]);
	if ([temp_record count]==0) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No offer in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//		[alert show];
//		[alert release];
        [self isNotEmptyList];
	} else {
		[table_view reloadData];
	}
//	NSLog(@"debug ConsumerLoanListViewController parserDidEndDocument:%@", self.items_data);
    [[CoreData sharedCoreData].mask hiddenMask];
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
        value = @"";
    }
    value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    if ([akey isEqualToString:@"thumb"]
        ||
        [akey isEqualToString:@"image"]
        ||
        [akey isEqualToString:@"pdf_url"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
//    NSLog(@"debug fixspace end:[%@]", value);
    [temp_record setObject:value forKey:akey];
    return;
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {

        [self fixspace:@"id"];
        [self fixspace:@"image"];
        [self fixspace:@"title"];
        [self fixspace:@"tel"];
        [self fixspace:@"tel_label"];
        [self fixspace:@"thumb"];
        [self fixspace:@"pdf_url"];
        [self fixspace:@"url"];
        [self fixspace:@"url_label"];
        [self fixspace:@"tnc_label"];
        [self fixspace:@"emailsubject"];
        [self fixspace:@"tnc"];
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

#pragma mark - UITabbarDelegate

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    UIAlertView *alert_view =nil;
    switch (item.tag) {
		case 0: // Offers TabBar
            alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TaxLoanCallApply",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
            [alert_view show];
            [alert_view release];
			break;
	}
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(@"TaxLoanApplyHotline",nil)]];
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
    [borderImageView release];
    [super dealloc];
}

//-(void)setPageSize:(int)page_size {
//	current_page_size = page_size;
//}


-(IBAction)tncButtonPressed:(UIButton *)button {
	TermsAndConditionsViewController *tnc_controller = [[TermsAndConditionsViewController alloc] initWithNibName:@"TermsAndConditionsView" bundle:nil];
    [tnc_controller setTncStr:NSLocalizedString(@"TNC Shopping",nil)];
	[self.navigationController pushViewController:tnc_controller animated:NO];
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
//		if ([self isNotEmptyList]) [table_view reloadData];
//        table_view.contentOffset = CGPointMake(0, 0);
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
//		if ([self isNotEmptyList]) [table_view reloadData];
//        table_view.contentOffset = CGPointMake(0, 0);
//	}
//}


-(IBAction)homeButtonPressed:(UIBarButtonItem *)button {
	[(RootViewController *)[CoreData sharedCoreData].root_view_controller setContent:-1];
}


///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self cellHeight:indexPath] > 81) {
        return [self cellHeight:indexPath];
    }
    return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    NSLog(@"table count :%d",[self.items_data count]);
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
        if ([self.items_data count] < 5) {
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
    
    
    NSString *image = [[self.items_data objectAtIndex:indexPath.row] objectForKey:thumbnail];
    if (image!=nil && ![image isEqualToString:@""]) {
        [cell.cached_image_view loadImageWithURL:[[self.items_data objectAtIndex:indexPath.row] objectForKey:thumbnail]];
    }
    
    cell.is_new.hidden = FALSE;
    
    NSLog(@"debug ConsumerLoanListViewController cellForRowAtIndexPath:%@", cell);
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    //	LatestPromotionsSummaryViewController *summary_controller = [[LatestPromotionsSummaryViewController alloc] initWithNibName:@"LatestPromotionsSummaryView" bundle:nil];
    //	summary_controller.merchant_info = [items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size];
    //	if ([items_data count]==1) {
    //		[self.navigationController pushViewController:summary_controller animated:TRUE];
    //	} else {
    //		[self.navigationController pushViewController:summary_controller animated:TRUE];
    //	}
//    NSString  *targeturl = nil;
//    NSString *targetHotline = nil;
//    NSString *targetBtnLabel = nil;
//    NSString *targetTNC = nil;

    //    NSString *defaultViewController = nil;
//    if ([AccProUtil isLangOfChi]) {
//        targeturl = [[items_data objectAtIndex:indexPath.row] objectForKey:@"image"];
//        targetBtnLabel=[[items_data objectAtIndex:indexPath.row] objectForKey:@"tel_label"];
        //      defaultViewController = @"AccProDefaultPageViewController_zh";
//    }else{
//        targeturl = [[items_data objectAtIndex:indexPath.row] objectForKey:@"target_url_en"];
//        targetBtnLabel=[[items_data objectAtIndex:indexPath.row] objectForKey:@"call_en"];
        //     defaultViewController = @"AccProDefaultPageViewController_en";
//    }
//    targetHotline = [[items_data objectAtIndex:indexPath.row] objectForKey:@"tel"];
//    if (targetBtnLabel==nil || [targetBtnLabel isEqualToString:@""]){
//        targetBtnLabel =  [NSString stringWithFormat:@"%@", NSLocalizedString(@"Application",nil)];
//        targetHotline = @"NULL";
//    }
//    targetTNC = [[items_data objectAtIndex:indexPath.row] objectForKey:@"pdf_url"];
//    NSString *url2 = [[items_data objectAtIndex:indexPath.row] objectForKey:@"url"];
//    NSString *url2label = [[items_data objectAtIndex:indexPath.row] objectForKey:@"url_label"];

//    NSString  *web = nil;//added by jasen on 20111118
//    web = [[items_data objectAtIndex:indexPath.row] objectForKey:@"web"];
//    NSLog(@"debug ConsumerLoanListViewController didSelectRowAtIndexPath:%@, %@",web, targeturl);
//    NSLog(@"debug ConsumerLoanListViewController didSelectRowAtIndexPath:%@", targeturl);
//    if ([web isEqualToString:@"1"]){
//        [[ConsumerLoanUtil me] showConsumerLoanViewController:@"ConsumerLoanListViewController"
//                                                          url:targeturl
//                                                      hotline:targetHotline
//                                                     btnLanel:targetBtnLabel
//                                                          tnc:targetTNC
//                                                         url2:url2
//                                                    url2label:url2label];
    [[ConsumerLoanUtil me] showConsumerLoanViewController:@"ConsumerLoanListViewController"
                                                 merchant:[items_data objectAtIndex:indexPath.row]];
    
//    }else if([targeturl isEqualToString:@"ConsumerLoanViewController"]){
//        [[CoreData sharedCoreData].taxLoan_view_controller forwardNextView:NSClassFromString(@"TaxLoanOffersViewController") viewName:@"TaxLoanOffersViewController"];

//    }else if([targeturl isEqualToString:@"LTViewController"]) {
//        [CoreData sharedCoreData].lastScreen = @"LTViewController";
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.5];
//        [[CoreData sharedCoreData].root_view_controller setContent:0];
//        [(RootViewController*)[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers objectAtIndex:0] setContent:2];
//        [CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//        [UIView commitAnimations];
//        
//    }else if([targeturl isEqualToString:@"InstalmentLoanViewController"]) {
//        [CoreData sharedCoreData].lastScreen = @"InstalmentLoanViewController";
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.5];
//        [[CoreData sharedCoreData].root_view_controller setContent:0];
//        [(RootViewController*)[[CoreData sharedCoreData]._InstalmentLoanViewController.navigationController.viewControllers objectAtIndex:0] setContent:3];
//        [CoreData sharedCoreData]._InstalmentLoanViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//        [UIView commitAnimations];
//        
//    }
    
    //    if(indexPath.row == 1){
    //        AccProOffersViewController *accProOffersViewController = [[AccProOffersViewController alloc] initWithNibName:@"AccProOffersViewController" bundle:nil];
    //        [self.navigationController pushViewController:accProOffersViewController animated:TRUE];
    //        [accProOffersViewController release];
    //    }
    //	summary_controller.title_label.text = title_label.text;
    //	[accProOffersViewController release];
}
-(BOOL)isNotEmptyList
{
//    BOOL isNotEmpty = ([self.items_data count]>0);
//    if (isNotEmpty)
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
@end
