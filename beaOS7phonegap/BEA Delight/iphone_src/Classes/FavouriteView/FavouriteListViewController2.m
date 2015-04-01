//  Created by Algebra Lo on 10年3月23日.
//  Amended by yaojzy on 201309

#import "FavouriteListViewController2.h"

#import "ATMOutletMapViewController.h"
#import "SupremeGoldOffersViewController.h"

@implementation FavouriteListViewController2

@synthesize header_list;
@synthesize groupname;
@synthesize caller;
@synthesize deletedIndexpath, cellType, btnToIndexpath, temp_items_data_arr;
@synthesize cellHeight, isRecustomCell, recustomCellView, hasDeleted, fromType;  // fromType: "Pri" - "CL"
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		all_items_data = [NSMutableDictionary new];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"SG"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"CL"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"PRI"];
		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"ATM"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"LP"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"SAR"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"PBC"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"QS"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"GPO"];
		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"YRO"];
        
        [all_items_data retain];
		items_data = [NSMutableArray new];
        temp_items_data_arr = [NSMutableArray new];
        cellType = -1;
        isRecustomCell = NO;
        hasDeleted = NO;
        btnToIndexpath = [[NSMutableDictionary alloc] init];
		/*current_type = @"OfferId";
         current_category = [[CoreData sharedCoreData].bookmark listOfferId];*/
        
        self.header_list = [NSMutableArray arrayWithObjects:
                            NSLocalizedString(@"Gold-fav",nil),
                            NSLocalizedString(@"Loans-fav",nil),
                            NSLocalizedString(@"tag_fav_privileges",nil),
                            NSLocalizedString(@"ATM Location",nil),
                            NSLocalizedString(@"Latest Promotions-fav",nil),
                            NSLocalizedString(@"Rewards",nil),
                            NSLocalizedString(@"Priority Booking for Concerts-fav",nil),
                            NSLocalizedString(@"Quarterly Surprise",nil),
                            NSLocalizedString(@"GlobePass Offers",nil),
                            NSLocalizedString(@"Year-round Offers",nil),
                            nil];
        
    }
    NSLog(@"debug FavouriteListViewController2 initWithNibName:%@", self);
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    table_view.frame = CGRectMake(0, 110, 320, 350+[[MyScreenUtil me] getScreenHeightAdjust]);
    
//	title_label.text = NSLocalizedString(@"Bookmark",nil);
    title_label.text = groupname;
    
    [_btnEdit setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
    
    NSLog(@"debug FavouriteListViewController2 viewDidLoad groupname:%@", groupname);

	[self generateBookmark];
    
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
    
    NSLog(@"debug FavouriteListViewController2 viewDidLoad:%@", self);
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//        CGRect frame = table_view.frame;
//        frame.origin.y += 20;
//        table_view.frame = frame;
//     //   self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

- (NSString *) nameToKey: (NSString *) name{
    if([name isEqualToString: NSLocalizedString(@"Quarterly Surprise",nil)]){
  //  if([name isEqualToString: NSLocalizedString(@"\"Cash in Hand\"",nil)]){
        return @"QS";
    }else if([name isEqualToString: NSLocalizedString(@"Year-round Offers",nil)]){
        return @"YRO";
    }else if([name isEqualToString: NSLocalizedString(@"Latest Promotions-fav",nil)]){
        return @"LP";
    }//else if([name isEqualToString: NSLocalizedString(@"Spending & Rewards",nil)]){
    else if([name isEqualToString: NSLocalizedString(@"Rewards",nil)]){     // To be retested
        return @"SAR";
    } else if([name isEqualToString: NSLocalizedString(@"Priority Booking for Concerts-fav",nil)]){
        return @"PBC";
    }else if([name isEqualToString: NSLocalizedString(@"GlobePass Offers",nil)]){
        return @"GPO";
//    }else if([name isEqualToString: NSLocalizedString(@"ATM Location",nil)]){
//        return @"ATM";
    }else if([name isEqualToString: NSLocalizedString(@"ATM",nil)]){
        return @"ATM";
    }else if([name isEqualToString: NSLocalizedString(@"i-Financial center",nil)]){
        return @"ATM";
    }else if([name isEqualToString: NSLocalizedString(@"Branch",nil)]){
        return @"ATM";
    }else if([name isEqualToString: NSLocalizedString(@"SupremeGold Centre",nil)]){
        return @"ATM";
    }else if([name isEqualToString: NSLocalizedString(@"tag_offers",nil)] && [fromType isEqualToString:@"Pri"]){
   // else if([name isEqualToString: NSLocalizedString(@"Offers-fav",nil)]){
        return @"PRI";
    }else if([name isEqualToString: NSLocalizedString(@"Consumer Loans-fav",nil)] && [fromType isEqualToString:@"CL"]){
        return @"CL";
    }else if([name isEqualToString: NSLocalizedString(@"Supreme Gold-fav",nil)] && [fromType isEqualToString:@"SG"]){
        return @"SG";
    }
    return nil;
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSArray *indexPaths = [table_view indexPathsForVisibleRows];
    if (!flag) {
        if (cellType == 0) {
            for (NSIndexPath *indexPath in indexPaths) {
                ATMCustomCellCMS *cell = (ATMCustomCellCMS *)[table_view cellForRowAtIndexPath:indexPath];
                UIButton *btn = (UIButton *)[cell.contentView.superview viewWithTag:indexPath.row+10];
                [self endAnimationToCell:cell andButton:btn];
            }
        }
        else if (cellType == 1) {
            for (NSIndexPath *indexPath in indexPaths) {
                LargeImageCell *cell = (LargeImageCell *)[table_view cellForRowAtIndexPath:indexPath];
                UIButton *btn = (UIButton *)[cell.contentView.superview viewWithTag:indexPath.row+10];
                [self endAnimationToCell:cell andButton:btn];
            }
        }
        else if (cellType == 2) {
            for (NSIndexPath *indexPath in indexPaths) {
                CustomCell *cell = (CustomCell *)[table_view cellForRowAtIndexPath:indexPath];
                UIButton *btn = (UIButton *)[cell.contentView.superview viewWithTag:indexPath.row+10];
                [self endAnimationToCell:cell andButton:btn];
            }
        }
        flag = !flag;
    }
}
- (void)viewDidUnload {
    [self setBtnEdit:nil];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[all_items_data release];
	[items_data release];
	[header_exist release];
    [_btnEdit release];
    [super dealloc];
}

-(void)generateBookmark {
    NSLog(@"debug FavouriteListViewController2 generateBookmark:%@", self);
    
	header_exist = [[NSMutableArray arrayWithObjects:
                     @"F",
                     @"F",
                     @"F",
                     @"F",
                     @"F",
                     @"F",
                     @"F",
                     @"F",
                     @"F",
                     @"F",
                     nil] retain];
	Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data:%@", bookmark_data);
    
	int no_record = TRUE;
//    if ([groupname isEqualToString:@"ATM"] || [groupname isEqualToString:@"i-Financial Centre"] || [groupname isEqualToString:@"Branch"] || [groupname isEqualToString:@"SupremeGold Centre"]) {
//        if ([self calculateCountByBranchType] > 0)
//            no_record = FALSE;
//        else
//            no_record = TRUE;
//    }
//    else{
//        if ([[all_items_data objectForKey:[self nameToKey: groupname]] count] > 0)
//            no_record = FALSE;
//        else
//            no_record = TRUE;
//    }
	for (int i=0; i<10; i++) {
		if ([[bookmark_data listOfferIdInGroup:i] length]>0) {
			no_record = FALSE;
		}
	}
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 2:%@", bookmark_data);
	if (no_record) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No bookmark stored",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//		[alert show];
//		[alert release];
        [self.navigationController popViewControllerAnimated:YES];
		result.text = NSLocalizedString(@"No bookmark stored",nil);
//		[table_view reloadData];
	}
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 3:%@", bookmark_data);
    
	if ([[bookmark_data listOfferIdInGroup:0] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:0]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@getbranch.api?idlist=%@&lang=%@&UDID=%@",
                            [CoreData sharedCoreData].realServerURL,
                            [bookmark_data listOfferIdInGroup:0],
                            [[LangUtil me] getLangID],
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 0:%@", urlstr);
		asi_request_atm =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_atm.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request_atm];
	}
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 4:%@", bookmark_data);

	if ([[bookmark_data listOfferIdInGroup:1] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:1]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@getinfo.api?idlist=%@&lang=%@&UDID=%@&type=10",
                            [CoreData sharedCoreData].realServerURL,
                            [bookmark_data listOfferIdInGroup:1],
                            [[LangUtil me] getLangID],
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 1:%@", urlstr);
		asi_request_pri =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_pri.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request_pri];
	}
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 5:%@", bookmark_data);

	if ([[bookmark_data listOfferIdInGroup:2] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:2]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@beamerchantlist.api?id=%@&qs=false&lang=%@&UDID=%@",
                            [CoreData sharedCoreData].realServerURLCard,
                            [bookmark_data listOfferIdInGroup:2],
                            [CoreData sharedCoreData].lang,
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 2:%@", urlstr);
		asi_request_yro =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_yro.delegate = self;
		NSLog(@"%@",asi_request_yro.url);
		[[CoreData sharedCoreData].queue addOperation:asi_request_yro];
	}
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 6:%@", bookmark_data);

	if ([[bookmark_data listOfferIdInGroup:3] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:3]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@latestpromotions.api?id=%@&type=CIH&lang=%@&UDID=%@",
                            [CoreData sharedCoreData].realServerURLCard,
                            [bookmark_data listOfferIdInGroup:3],
                            [CoreData sharedCoreData].lang,
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 3:%@", urlstr);
		asi_request_qs =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_qs.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request_qs];
	}
    
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 7:%@", bookmark_data);

	if ([[bookmark_data listOfferIdInGroup:4] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:4]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@latestpromotions.api?id=%@&lang=%@&UDID=%@",
                            [CoreData sharedCoreData].realServerURLCard,
                            [bookmark_data listOfferIdInGroup:4],
                            [CoreData sharedCoreData].lang,
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 4:%@", urlstr);
		asi_request_lp =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_lp.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request_lp];
	}
    
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 8:%@", bookmark_data);

	if ([[bookmark_data listOfferIdInGroup:5] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:5]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@spending.api?id=%@&lang=%@&UDID=%@",
                            [CoreData sharedCoreData].realServerURLCard,
                            [bookmark_data listOfferIdInGroup:5],
                            [CoreData sharedCoreData].lang,
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 5:%@", urlstr);
		asi_request_sar =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_sar.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request_sar];
	}
    
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 9:%@", bookmark_data);

	if ([[bookmark_data listOfferIdInGroup:6] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:6]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@pbconcert.api?id=%@&lang=%@&UDID=%@",
                            [CoreData sharedCoreData].realServerURLCard,
                            [bookmark_data listOfferIdInGroup:6],
                            [CoreData sharedCoreData].lang,
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 6:%@", urlstr);
		asi_request_pbc =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_pbc.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request_pbc];
	}
    
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 10:%@", bookmark_data);

	if ([[bookmark_data listOfferIdInGroup:7] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:7]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@globepass.api?id=%@&lang=%@&UDID=%@",
                            [CoreData sharedCoreData].realServerURLCard,
                            [bookmark_data listOfferIdInGroup:7],
                            [CoreData sharedCoreData].lang,
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 7:%@", urlstr);
		asi_request_gpo =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_gpo.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request_gpo];
	}
    if ([[bookmark_data listOfferIdInGroup:8] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:8]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@getinfo.api?idlist=%@&lang=%@&UDID=%@&type=10",
                            [CoreData sharedCoreData].realServerURL,
                            [bookmark_data listOfferIdInGroup:8],
                            [[LangUtil me] getLangID],
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 1:%@", urlstr);
		asi_request_cl =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_cl.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request_cl];
	}
    if ([[bookmark_data listOfferIdInGroup:9] length]>0) {
		NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:9]);
		[[CoreData sharedCoreData].mask showMask];
        NSString* urlstr = [NSString stringWithFormat:
                            @"%@getinfo.api?idlist=%@&lang=%@&UDID=%@&type=15",
                            [CoreData sharedCoreData].realServerURL,
                            [bookmark_data listOfferIdInGroup:9],
                            [[LangUtil me] getLangID],
                            [CoreData sharedCoreData].UDID];
        NSLog(@"debug FavouriteListViewController2 request 1:%@", urlstr);
		asi_request_sg =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
		asi_request_sg.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request_sg];
	}
//    NSLog(@"debug FavouriteListViewController2 generateBookmark, bookmark_data 11:%@", bookmark_data);

	[bookmark_data release];
}

//-(void)enableEdit
//	table_view.editing = TRUE;
//	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(disableEdit)] autorelease];
//}
//
//-(void)disableEdit {
//	table_view.editing = FALSE;
//	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(enableEdit)] autorelease];
//}

///////////////////
//ASIHTTP Delegate
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
    if (request==asi_request_atm) {
        parsing_type = 0;
    } else if (request==asi_request_pri) {
        parsing_type = 1;
    } else if (request==asi_request_yro) {
		parsing_type = 2;
	} else if (request==asi_request_qs) {
		parsing_type = 3;
	} else if (request==asi_request_lp) {
		parsing_type = 4;
	} else if (request==asi_request_sar) {
		parsing_type = 5;
	} else if (request==asi_request_pbc) {
		parsing_type = 6;
	} else if (request==asi_request_gpo) {
		parsing_type = 7;
	} else if (request==asi_request_cl) {
		parsing_type = 8;
	} else if (request==asi_request_sg) {
		parsing_type = 9;
	}
	NSLog(@"debug FavouriteListViewController2 response begin ===============================");
	NSLog(@"debug FavouriteListViewController2 response parsing_type: %d",parsing_type);
//	NSLog(@"debug FavouriteListViewController2 response string:%@",[request responseString]);
	NSLog(@"debug FavouriteListViewController2 response end ===============================");
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[[CoreData sharedCoreData].mask hiddenMask];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"FavouriteListViewController2 requestFailed:%@", request.error);

//	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//	[alert_view show];
//	[alert_view release];
//	[[CoreData sharedCoreData].mask hiddenMask];
	
}

///////////////////
//UITableDelegate
///////////////////
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//	if ([[header_exist objectAtIndex:section] isEqualToString:@"T"]) {
//		return 30;
//	} else {
//		return 0;
//	}
//    
//}

//-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//	return self.groupname;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 30.0)] autorelease];
//    customView.backgroundColor = [UIColor whiteColor];
//    
//    UILabel * headerLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
//    headerLabel.backgroundColor = [UIColor clearColor];
//    headerLabel.opaque = NO;
//    headerLabel.textColor = [UIColor orangeColor];
//    headerLabel.highlightedTextColor = [UIColor whiteColor];
//    headerLabel.font = [UIFont boldSystemFontOfSize:15];
//    headerLabel.frame = CGRectMake(10.0, 0.0, 290.0, 30.0);
//    
//    headerLabel.text = self.groupname;
//    
//    [customView addSubview:headerLabel];
//    
//    return customView;
//}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        return 101;
//    }
	//return 81;
    
    if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)] || [groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)] || [groupname isEqualToString:NSLocalizedString(@"Branch",nil)] ||
        [groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
        NSArray *temp_items_data = [all_items_data objectForKey:@"ATM"];
        NSDictionary *itemDic = [[NSDictionary alloc] init];
        if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)]) {
            for (itemDic in temp_items_data) {
                if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 2) {
                    [temp_items_data_arr addObject:itemDic];
                }
            }
        }
        else if ([groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)]) {
            for (itemDic in temp_items_data) {
                if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 3) {
                    [temp_items_data_arr addObject:itemDic];
                }
            }
        }
        else if ([groupname isEqualToString:NSLocalizedString(@"Branch",nil)]) {
            for (itemDic in temp_items_data) {
                if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 4) {
                    [temp_items_data_arr addObject:itemDic];
                }
            }
        }
        else if ([groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
            for (itemDic in temp_items_data) {
                if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 5) {
                    [temp_items_data_arr addObject:itemDic];
                }
            }
        }
        id obj = [temp_items_data_arr objectAtIndex:indexPath.row];

        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 6.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 7.0 && [[UIScreen mainScreen] bounds].size.height == 480) {
            NSUInteger index = indexPath.row;
            ATMCustomCellCMS* cell = [self genCell:obj by:index];
            int height = cell.frame.size.height + 8;
            return height;
        } else {
            NSUInteger index = indexPath.row;
            ATMCustomCellCMS* cell = [self genCell:obj by:index];
            int height = cell.frame.size.height;
            return height;
        }
    }
    else {
//        int height = [self fitHeight:[[self.temp_items_data_arr objectAtIndex:indexPath.row] objectForKey:@"branch_type"]] + [self fitHeight:[[self.temp_items_data_arr objectAtIndex:indexPath.row] objectForKey:@"branch_type"]] + 15;
//        if (height > 81) {
//            return height;
//        }
//        return 81;
        
    }
//    if (items_data.count > indexPath.row) {
//        [tableView reloadData];
//    }
    if ([fromType isEqualToString:@"CL"] || [fromType isEqualToString:@"SG"] || [fromType isEqualToString:@"Pri"]) {
        if ([self cellHeight:indexPath] > 81) {
            return [self cellHeight:indexPath];
        }
    }else {
        int height = [self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+ [self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30;
        if (height > 81) {
            NSLog(@"%d",height);
            return height;
        }
    }
    return 81;
}


-(NSInteger)calculateCountByBranchType{
    NSInteger typeCount = 0;
    NSArray *arr = [all_items_data objectForKey:[self nameToKey: groupname]];
    if ([arr count] <= 0) {
        return 0;
    }
    for (NSDictionary *itemDic in [all_items_data objectForKey:@"ATM"]) {
        if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)]) {
            if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 2 ) {
                typeCount++;
            }
        }
        else if ([groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)]) {
            if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 3) {
                typeCount++;
            }
        }
        else if ([groupname isEqualToString:NSLocalizedString(@"Branch",nil)]) {
            if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 4) {
                typeCount++;
            }
        }
        else if ([groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
            if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 5) {
                typeCount++;
            }
        }
    }
    return typeCount;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)] || [groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)] || [groupname isEqualToString:NSLocalizedString(@"Branch",nil)] ||
        [groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
        return [self calculateCountByBranchType];
    }
    else{
        return [[all_items_data objectForKey:[self nameToKey: groupname]] count];
    }
}

- (ATMCustomCellCMS*) genCell:(id)obj by:(NSUInteger)index
{
	NSString *identifier = @"ATMCustomCellCMS";
	ATMCustomCellCMS *cell = [[ATMCustomCellCMS alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(index%2)];
    CGRect frame = cell.title_label.frame;
    frame.size.width = cell.frame.size.width-30;
    cell.title_label.numberOfLines = 0;
    cell.title_label.lineBreakMode = NSLineBreakByWordWrapping;
    cell.title_label.frame = frame;
    cell.title_label.text = [[obj objectForKey:@"branch"] stringByReplacingOccurrencesOfString:@"�" withString:@" "];
	cell.address_label.text = [[obj objectForKey:@"address"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	[cell.tel setTitle:[obj objectForKey:@"tel"] forState:UIControlStateNormal] ;
	cell.description_label.text = [obj objectForKey:@"opeinghour"];
    cell.fax_label.text = [obj objectForKey:@"fax"];
//    if ([[obj objectForKey:@"branch_type"] integerValue] == 2) {
//        [cell set2ATM];
//    } else {
        [cell setPlace];
//    }
    NSLog(@"debug genCell:%d", index);
    return cell;
}

- (id)tableView:(UITableView *)tableView isRecustomCell:(id)objCell deleteBtn:(UIButton *)delBtn rowAtIndexPath:(NSIndexPath *)indexPath cellType:(NSInteger)celltype{
    if (celltype == 0) {
        ATMCustomCellCMS *cell = (ATMCustomCellCMS *)objCell;
    
        isRecustomCell = YES;
        recustomCellView = [[UIView alloc] initWithFrame:cell.contentView.frame];
        recustomCellView.tag = 100;
        recustomCellView.backgroundColor = cell.contentView.backgroundColor;
        CGRect btnFrame = delBtn.frame;
        btnFrame.origin.x = 10;
//        btnFrame.origin.y = ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+ [self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+15)/2 - delBtn.frame.size.height/2;
        delBtn.frame = btnFrame;
        delBtn.hidden = NO;
        [recustomCellView addSubview:delBtn];

        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_cell_bg.png"]];
		bg.contentMode = UIViewContentModeScaleToFill;
		bg.frame = CGRectMake(0, 0, 320, 81);
		cell.backgroundView = bg;

        CGRect frame1 = cell.title_label.frame;
        frame1.origin.x += 40;
        cell.title_label.frame = frame1;
        [recustomCellView addSubview:cell.title_label];
        
        CGRect frame2 = cell.address_label.frame;
        frame2.origin.x += 40;
        cell.address_label.frame = frame2;
        [recustomCellView addSubview:cell.address_label];
        
        CGRect frame3 = cell.distance_label.frame;
        frame3.origin.x += 40;
        cell.distance_label.frame = frame3;
        [recustomCellView addSubview:cell.distance_label];
        
        CGRect frame4 = cell.handset.frame;
        frame4.origin.x += 40;
        cell.handset.frame = frame4;
        [recustomCellView addSubview:cell.handset];
        
        CGRect frame5 = cell.tel.frame;
        frame5.origin.x += 40;
        cell.tel.frame = frame5;
        
        CGRect frame6 = cell.description_label.frame;
        frame6.origin.x += 40;
        cell.description_label.frame = frame6;
        
        CGRect frame7 = cell.imgHome.frame;
        frame7.origin.x += 40;
        cell.imgHome.frame = frame7;
        
        CGRect frame8 = cell.imgHour.frame;
        frame8.origin.x += 40;
        cell.imgHour.frame = frame8;
        
        CGRect frame9 = cell.cached_image_bg.frame;
        frame9.origin.x += 40;
        cell.cached_image_bg.frame = frame9;
        
        [recustomCellView addSubview:cell.tel];
        [cell addSubview:recustomCellView];
        [cell.cached_image_bg setHidden:YES];
        [recustomCellView release];
        
    }
    else if (celltype == 1) {
        LargeImageCell *cell = (LargeImageCell *)objCell;
        isRecustomCell = YES;
        recustomCellView = [[UIView alloc] initWithFrame:cell.contentView.frame];
        recustomCellView.tag = 100;
        recustomCellView.backgroundColor = cell.contentView.backgroundColor;
        CGRect btnFrame = delBtn.frame;
        btnFrame.origin.x = 10;
        delBtn.frame = btnFrame;
        delBtn.hidden = NO;
        [recustomCellView addSubview:delBtn];
        
        UIImageView *bg = [[[UIImageView alloc] init] autorelease];
        int sid = (indexPath.row+1)%2;
        if (sid==1) {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
        } else {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
        }
        bg.contentMode = UIViewContentModeScaleToFill;
        cell.backgroundView = bg;
        cell.backgroundColor = [UIColor clearColor];
        
        CGRect frame1 = cell.title_label.frame;
        frame1.origin.x += 40;
        cell.title_label.frame = frame1;
        [recustomCellView addSubview:cell.title_label];
        
        CGRect frame2 = cell.cached_image_view.frame;
        frame2.origin.x += 40;
        cell.cached_image_view.frame = frame2;
        [recustomCellView addSubview:cell.cached_image_view];
  //      [cell addSubview:recustomCellView];
        [cell.contentView addSubview:recustomCellView];
        [cell.cached_image_bg setHidden:YES];
        [recustomCellView release];
    
        return cell;
    }

    else if (celltype == 2) {
        CustomCell *cell = (CustomCell *)objCell;
        isRecustomCell = YES;
        recustomCellView = [[UIView alloc] initWithFrame:cell.contentView.frame];
        recustomCellView.tag = 100;
        recustomCellView.backgroundColor = cell.contentView.backgroundColor;
        CGRect btnFrame = delBtn.frame;
        btnFrame.origin.x = 10;
        delBtn.frame = btnFrame;
        delBtn.hidden = NO;
        [recustomCellView addSubview:delBtn];
        
        UIImageView *bg = [[[UIImageView alloc] init] autorelease];
        int sid = (indexPath.row+1)%2;
        if (sid==1) {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
        } else {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
        }
        bg.contentMode = UIViewContentModeScaleToFill;
        cell.backgroundView = bg;
        cell.backgroundColor = [UIColor clearColor];
        
        CGRect frame1 = cell.title_label.frame;
        frame1.origin.x += 40;
        cell.title_label.frame = frame1;
        [recustomCellView addSubview:cell.title_label];
        
        CGRect frame2 = cell.cached_image_view.frame;
        frame2.origin.x += 40;
        cell.cached_image_view.frame = frame2;
        [recustomCellView addSubview:cell.cached_image_view];
        
        CGRect frame3 = cell.description_label.frame;
        frame3.origin.x += 40;
        cell.description_label.frame = frame3;
        [recustomCellView addSubview:cell.description_label];

//        CGRect frame4 = cell.cached_image_bg.frame;
//        frame4.origin.x += 40;
//        cell.cached_image_bg.frame = frame4;
//        [recustomCellView addSubview:cell.cached_image_bg];
//        
////        CGRect frame5 = cell.cached_image_view.frame;
////        frame5.origin.x += 40;
////        cell.cached_image_view.frame = frame5;
////        [recustomCellView addSubview:cell.cached_image_view];
//        
//        CGRect frame6 = cell.platinum.frame;
//        frame6.origin.x += 40;
//        cell.platinum.frame = frame6;
//        cell.platinum.hidden = YES;
//        [recustomCellView addSubview:cell.platinum];
//        NSArray *temp_items_data = [all_items_data objectForKey:@"YRO"];
//        if (![[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"card"] isEqualToString:@"Core"]) {
//            cell.platinum.hidden = FALSE;
//        } else {
//            cell.platinum.hidden = TRUE;
//        }
//        
//        CGRect frame7 = cell.is_new.frame;
//        frame7.origin.x += 40;
//        cell.is_new.frame = frame7;
//        cell.is_new.hidden = YES;
//        [recustomCellView addSubview:cell.is_new];
//        if ([[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"newitem"] isEqualToString:@"T"]) {
//            cell.is_new.hidden = FALSE;
//        } else {
//            cell.is_new.hidden = TRUE;
//        }
       // [cell addSubview:recustomCellView];
        [cell.contentView addSubview:recustomCellView];
        [recustomCellView release];
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setImage:[UIImage imageNamed:@"btn_close.png"] forState:UIControlStateNormal];
    if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+ [self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30 < 81) {
        [delBtn setFrame:CGRectMake(-30, 81/2-15, 30, 30)];
    }else {
        [delBtn setFrame:CGRectMake(-30, ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+ [self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2-delBtn.frame.size.height/2-15, 30, 30)];
    }
//    [delBtn setFrame:CGRectMake(-30, ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+ [self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+15)/2-delBtn.frame.size.height/2-15, 30, 30)];
    delBtn.tag = indexPath.row + 10;
    delBtn.hidden = YES;
    [delBtn addTarget:self action:@selector(handleDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnToIndexpath setValue:indexPath forKey:[NSString stringWithFormat:@"%d", delBtn.tag]];
    
//	NSString *identifier = @"CustomCell";
	/*CustomCell *cell = (CustomCell *)[table_view dequeueReusableCellWithIdentifier:identifier];
     if (cell==nil) {*/
	//}
    NSLog(@"debug cellForRowAtIndexPath  : %d",indexPath.row);
	NSArray *temp_items_data;
	CustomCell *cell;
	LargeImageCell *large_cell;
    
//    ATMCustomCellCMS *atm_cell;
	NSString *image;
    int index=-1;
    //if([groupname isEqualToString: NSLocalizedString(@"ATM Location",nil)]){
    if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)] || [groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)] || [groupname isEqualToString:NSLocalizedString(@"Branch",nil)] ||
        [groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
        index=0;
    }else if([groupname isEqualToString: NSLocalizedString(@"tag_offers",nil)] && [fromType isEqualToString:@"Pri"]){
        index=1;
    }else if([groupname isEqualToString: NSLocalizedString(@"Year-round Offers",nil)]){
        index=2;
    }else if([groupname isEqualToString: NSLocalizedString(@"Quarterly Surprise",nil)]){
        index=3;
    }else if([groupname isEqualToString: NSLocalizedString(@"Latest Promotions-fav",nil)]){
        index=4;
    }//else if([groupname isEqualToString: NSLocalizedString(@"Spending & Rewards",nil)]){
    else if([groupname isEqualToString: NSLocalizedString(@"Rewards",nil)]){    // To be retested
        index=5;
    }else if([groupname isEqualToString: NSLocalizedString(@"Priority Booking for Concerts-fav",nil)]){
        index=6;
    }else if([groupname isEqualToString: NSLocalizedString(@"GlobePass Offers",nil)]){
        index=7;
    }else if([groupname isEqualToString: NSLocalizedString(@"Consumer Loans-fav",nil)] &&[fromType isEqualToString:@"CL"]){
        index=8;
    }else if([groupname isEqualToString: NSLocalizedString(@"Supreme Gold-fav",nil)] &&[fromType isEqualToString:@"SG"]){
        index=9;
    }
    NSLog(@"debug cellForRowAtIndexPath index: %d",index);
    NSDictionary *itemDic = [[NSDictionary alloc] init];
//    NSMutableArray *temp_items_data_arr = [NSMutableArray array];
//    temp_items_data_arr = [NSMutableArray array];
	switch (index) {
        case 0:
        {
       //     temp_items_data_arr = [NSMutableArray array];
            if ([temp_items_data_arr count] != 0) {
                [temp_items_data_arr removeAllObjects];
            }
            temp_items_data = [all_items_data objectForKey:@"ATM"];
            if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)]) {
                for (itemDic in temp_items_data) {
                    if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 2) {
                        [temp_items_data_arr addObject:itemDic];
                    }
                }
            }
            else if ([groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)]) {
                for (itemDic in temp_items_data) {
                    if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 3) {
                        [temp_items_data_arr addObject:itemDic];
                    }
                }
            }
            else if ([groupname isEqualToString:NSLocalizedString(@"Branch",nil)]) {
                for (itemDic in temp_items_data) {
                    if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 4) {
                        [temp_items_data_arr addObject:itemDic];
                    }
                }
            }
            else if ([groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
                for (itemDic in temp_items_data) {
                    if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 5) {
                        [temp_items_data_arr addObject:itemDic];
                    }
                }
            }
            id obj = [temp_items_data_arr objectAtIndex:indexPath.row];
        //    id obj = [temp_items_data objectAtIndex:indexPath.row];
            cellType = 0;
            
            NSUInteger index = indexPath.row;
            ATMCustomCellCMS *cell = [self genCell:obj by:index];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self genCell:obj by:index].frame.size.height-1.5, cell.frame.size.width, 1.5)];
            label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
            //            label.backgroundColor = [UIColor blueColor];
            [cell addSubview:label];
//            UILabel *lineLable = [[UILabel alloc] initWithFrame:CGRectMake(-40, cell.frame.size.height-2, cell.frame.size.width+40, 2)];
//            lineLable.backgroundColor = [UIColor colorWithRed:233/255.0 green:221/255.0 blue:211/255.0 alpha:1.0];
//            [cell.contentView addSubview:lineLable];
            CGRect frame = delBtn.frame;
            frame.origin.y = (cell.frame.size.height - frame.size.height)/2;
            if (!flag) {
                delBtn.hidden = NO;
                [cell.contentView addSubview:delBtn];
                for (UIView *view in cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 45;
                    view.frame = frame;
                }
            }
            else {
                [cell.contentView.superview addSubview:delBtn];
            }
//            [cell.contentView.superview addSubview:delBtn];
//            cellHeight = cell.frame.size.height;
//            if (!flag) {
//                cell =  (ATMCustomCellCMS *)[self tableView:table_view isRecustomCell:cell deleteBtn:delBtn rowAtIndexPath:indexPath cellType:cellType];
//            }
            return cell;
            break;
        }
        case 1:
        {
            NSString *identifier = @"LargeImageCell";
            temp_items_data = [all_items_data objectForKey:@"PRI"];
            large_cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
            cellType = 1;
//            if (indexPath.row%2) {
//                
//            } else {
//            if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30 < 81) {
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, large_cell.frame.size.width, 1.5)];
//                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
//                [large_cell addSubview:label];
//            } else {
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30-1.5, large_cell.frame.size.width, 1.5)];
//                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
//                [large_cell addSubview:label];
//            }
//            }
//            if (indexPath.row%2) {
//                
//            } else {
                if ([self cellHeight:indexPath] < 81) {
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, large_cell.frame.size.width, 1.5)];
                    label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                    [large_cell addSubview:label];
                } else {
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self cellHeight:indexPath]-1.5, large_cell.frame.size.width, 1.5)];
                    label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                    [large_cell addSubview:label];
                }
//            }
            large_cell.name = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
            large_cell.description = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"];
//            large_cell.title_label.numberOfLines = 0;
            image = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"thumb"];
            if (image!=nil && ![image isEqualToString:@""]) {
                [large_cell.cached_image_view loadImageWithURL:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"thumb"]];
//                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
            }
//            if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30 < 81) {
//                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,81/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
//            } else {
//                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
//            }
//            if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]] + 30 < 81){
//                large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-6, 81/2-large_cell.title_label.frame.size.height/2, large_cell.title_label.frame.size.width+10, large_cell.title_label.frame.size.height);
//                large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, 81/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
//                large_cell.description_label.frame = CGRectMake(large_cell.description_label.frame.origin.x-6, large_cell.title_label.frame.size.height + 10, large_cell.description_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]);
//            }else {
//                large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-6, large_cell.title_label.frame.origin.y-3, large_cell.title_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30);
//                large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
//                large_cell.description_label.frame = CGRectMake(large_cell.description_label.frame.origin.x-6, large_cell.title_label.frame.size.height - 10, large_cell.description_label.frame.size.width+11, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30);
//            }
            large_cell.is_new.hidden = FALSE;
            
            if (!flag) {
                delBtn.hidden = NO;
                [large_cell.contentView addSubview:delBtn];
                for (UIView *view in large_cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 38;
                    view.frame = frame;
                }
            }
            else {
                [large_cell.contentView.superview addSubview:delBtn];
            }
            return large_cell;
            break;
        }
		case 2:
        {
            NSString *identifier = @"CustomCell";
			temp_items_data = [all_items_data objectForKey:@"YRO"];
			cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
            cellType = 2;
//            if (indexPath.row%2) {
//                
//            } else {
            if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30 < 81){
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [cell addSubview:label];
            }else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+30-1.5, cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [cell addSubview:label];
            }
            
//            }
            cell.title_label.textColor = [UIColor blackColor];
                cell.title_label.text = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
//                cell.description_label.text = [[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdescription"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
                if (![[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"card"] isEqualToString:@"Core"]) {
                    cell.platinum.hidden = FALSE;
                } else {
                    cell.platinum.hidden = TRUE;
                }
                image = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"image"];
                if (image!=nil && ![image isEqualToString:@""]) {
                    [cell.cached_image_view loadImageWithURL:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"image"]];
//                    cell.cached_image_view.frame = CGRectMake(cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - cell.cached_image_view.frame.size.height/2, cell.cached_image_view.frame.size.width, cell.cached_image_view.frame.size.height);
//                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                        if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30 < 81){
                            cell.cached_image_view.frame = CGRectMake(cell.cached_image_view.frame.origin.x, 81/2 - cell.cached_image_view.frame.size.height/2, cell.cached_image_view.frame.size.width, cell.cached_image_view.frame.size.height);
                            cell.cached_image_bg1.frame = CGRectMake(cell.cached_image_bg1.frame.origin.x, 81/2 - cell.cached_image_bg1.frame.size.height/2, cell.cached_image_bg1.frame.size.width, cell.cached_image_bg1.frame.size.height);
                        }else {
                            cell.cached_image_view.frame = CGRectMake(cell.cached_image_view.frame.origin.x, ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - cell.cached_image_view.frame.size.height/2, cell.cached_image_view.frame.size.width, cell.cached_image_view.frame.size.height);
                            cell.cached_image_bg1.frame = CGRectMake(cell.cached_image_bg1.frame.origin.x, ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - cell.cached_image_bg1.frame.size.height/2, cell.cached_image_bg1.frame.size.width, cell.cached_image_bg1.frame.size.height);
                        }
                        
                    }
//                }
            
//            cell.title_label.frame = CGRectMake(cell.title_label.frame.origin.x-5, cell.title_label.frame.origin.y, cell.title_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+15);
//            cell.cached_image_bg.frame = CGRectMake(cell.cached_image_bg.frame.origin.x, ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - cell.cached_image_bg.frame.size.height/2, cell.cached_image_bg.frame.size.width, cell.cached_image_bg.frame.size.height);
                if ([[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"newitem"] isEqualToString:@"T"]) {
                    cell.is_new.hidden = FALSE;
                } else {
                    cell.is_new.hidden = TRUE;
                }
            if (!flag) {
                delBtn.hidden = NO;
                [cell.contentView addSubview:delBtn];
                for (UIView *view in cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 45;
                    view.frame = frame;
                }
            }
            else {
                [cell.contentView.superview addSubview:delBtn];
            }
            [cell viewWithTag:2001].hidden = NO;
			return cell;
			break;
        }
		case 3:
        {
            NSString *identifier = @"LargeImageCell";
			temp_items_data = [all_items_data objectForKey:@"QS"];
			large_cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
            cellType = 1;
//            if (indexPath.row%2) {
//                
//            } else {
                if ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]] > 81) {
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30-1.5, large_cell.frame.size.width, 1.5)];
                    label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                    [large_cell addSubview:label];
                }else {
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, large_cell.frame.size.width, 1.5)];
                    label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                    [large_cell addSubview:label];
                }
                
                
//            }
			large_cell.title_label.text = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
			//large_cell.description_label.text = [[[temp_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
			image = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"thumbnail"];
			if (image!=nil && ![image isEqualToString:@""]) {
				[large_cell.cached_image_view loadImageWithURL:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"thumbnail"]];
			}
            if ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]] > 81) {
                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
                large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-5, large_cell.title_label.frame.origin.y, large_cell.title_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+15);
                large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
            }else {
                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x, 81/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
                large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-5, 81/2 - large_cell.title_label.frame.size.height/2, large_cell.title_label.frame.size.width+10, large_cell.title_label.frame.size.height);
                large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, 81/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
            }
            
            if (!flag) {
                delBtn.hidden = NO;
                [large_cell.contentView addSubview:delBtn];
                for (UIView *view in large_cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 45;
                    view.frame = frame;
                }
            }
            else {
                [large_cell.contentView.superview addSubview:delBtn];
            }
//            [large_cell.contentView.superview addSubview:delBtn];
//            if (!flag) {
//                large_cell =  (LargeImageCell *)[self tableView:table_view isRecustomCell:large_cell deleteBtn:delBtn rowAtIndexPath:indexPath cellType:cellType];
//            }
			return large_cell;
			break;
        }
		case 4:
        {
            NSString *identifier = @"LargeImageCell";
			temp_items_data = [all_items_data objectForKey:@"LP"];
            large_cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
                cellType = 1;
//            if (indexPath.row%2) {
//                
//            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30-1.5, large_cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [large_cell addSubview:label];
//            }
			large_cell.title_label.text = [[temp_items_data objectAtIndex:indexPath.row ] objectForKey:@"title"];
			image = [[temp_items_data objectAtIndex:indexPath.row ] objectForKey:@"thumbnail"];
			if (image!=nil && ![image isEqualToString:@""]) {
				[large_cell.cached_image_view loadImageWithURL:[[temp_items_data objectAtIndex:indexPath.row ] objectForKey:@"thumbnail"]];
                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
			}
            large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-5, large_cell.title_label.frame.origin.y, large_cell.title_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+15);
            large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
            if (!flag) {
                delBtn.hidden = NO;
                [large_cell.contentView addSubview:delBtn];
                for (UIView *view in large_cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 45;
                    view.frame = frame;
                }
            }
            else {
                [large_cell.contentView.superview addSubview:delBtn];
            }
			return large_cell;
			break;
        }
		case 5:
        {
            NSString *identifier = @"LargeImageCell";
			temp_items_data = [all_items_data objectForKey:@"SAR"];
			large_cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
            cellType = 1;
//            if (indexPath.row%2) {
//                
//            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30-1.5, large_cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [large_cell addSubview:label];
//            }
			large_cell.title_label.text = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
			//large_cell.description_label.text = [[[temp_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
			image = [[temp_items_data objectAtIndex:indexPath.row ] objectForKey:@"thumbnail"];
			if (image!=nil && ![image isEqualToString:@""]) {
				[large_cell.cached_image_view loadImageWithURL:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"thumbnail"]];
                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
			}
            large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-5, large_cell.title_label.frame.origin.y, large_cell.title_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+15);
            large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
			/*if ([[[temp_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
             cell.is_new.hidden = FALSE;
             } else {
             cell.is_new.hidden = TRUE;
             }*/
            if (!flag) {
                delBtn.hidden = NO;
                [large_cell.contentView addSubview:delBtn];
                for (UIView *view in large_cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 45;
                    view.frame = frame;
                }
            }
            else {
                [large_cell.contentView.superview addSubview:delBtn];
            }
			return large_cell;
			break;
        }
		case 6:
        {
            NSString *identifier = @"LargeImageCell";
			temp_items_data = [all_items_data objectForKey:@"PBC"];
			large_cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
            cellType = 1;
//            if (indexPath.row%2) {
//                
//            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30-1.5, large_cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [large_cell addSubview:label];
//            }
			large_cell.title_label.text = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
			//large_cell.description_label.text = [[[temp_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
			image = [[temp_items_data objectAtIndex:indexPath.row ] objectForKey:@"thumbnail"];
			if (image!=nil && ![image isEqualToString:@""]) {
				[large_cell.cached_image_view loadImageWithURL:[[temp_items_data objectAtIndex:indexPath.row ] objectForKey:@"thumbnail"]];
                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
            }
            large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-5, large_cell.title_label.frame.origin.y, large_cell.title_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+15);
            large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
			/*if ([[[temp_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
             cell.is_new.hidden = FALSE;
             } else {
             cell.is_new.hidden = TRUE;
             }*/
            if (!flag) {
                delBtn.hidden = NO;
                [large_cell.contentView addSubview:delBtn];
                for (UIView *view in large_cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 45;
                    view.frame = frame;
                }
            }
            else {
                [large_cell.contentView.superview addSubview:delBtn];
            }
			return large_cell;
			break;
        }
		case 7:
        {
            NSString *identifier = @"LargeImageCell";
			temp_items_data = [all_items_data objectForKey:@"GPO"];
            NSLog(@"debug cellForRowAtIndexPath  : %@",temp_items_data);
			large_cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
            cellType = 1;
//            if (indexPath.row%2) {
//                
//            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30-1.5, large_cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [large_cell addSubview:label];
//            }
			large_cell.title_label.text = [[temp_items_data objectAtIndex:indexPath.row ] objectForKey:@"title"];
			//large_cell.description_label.text = [[[temp_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
			image = [[temp_items_data objectAtIndex:indexPath.row ] objectForKey:@"thumbnail"];
			if (image!=nil && ![image isEqualToString:@""]) {
				[large_cell.cached_image_view loadImageWithURL:[[temp_items_data objectAtIndex:indexPath.row ] objectForKey:@"thumbnail"]];
                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
            }
            large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-5, large_cell.title_label.frame.origin.y, large_cell.title_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+15);
            large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30)/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
			/*if ([[[temp_items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
             cell.is_new.hidden = FALSE;
             } else {
             cell.is_new.hidden = TRUE;
             }*/
            if (!flag) {
                delBtn.hidden = NO;
                [large_cell.contentView addSubview:delBtn];
                for (UIView *view in large_cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 45;
                    view.frame = frame;
                }
            }
            else {
                [large_cell.contentView.superview addSubview:delBtn];
            }
			return large_cell;
			break;
        }
        case 8:
        {
            NSString *identifier = @"LargeImageCell";
            temp_items_data = [all_items_data objectForKey:@"CL"];
            large_cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
            cellType = 1;
//            if (indexPath.row%2) {
//
//            } else {
//            if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30 < 81) {
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, large_cell.frame.size.width, 1.5)];
//                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
//                [large_cell addSubview:label];
//            } else {
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30-1.5, large_cell.frame.size.width, 1.5)];
//                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
//                [large_cell addSubview:label];
//            }
            if ([self cellHeight:indexPath] < 81) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, large_cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [large_cell addSubview:label];
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self cellHeight:indexPath]-1.5, large_cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [large_cell addSubview:label];
            }
//            }
            large_cell.name = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
            large_cell.description = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"];
            image = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"thumb"];
            if (image!=nil && ![image isEqualToString:@""]) {
                [large_cell.cached_image_view loadImageWithURL:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"thumb"]];
//                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
            }
//            if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30 < 81) {
//                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,81/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
//            } else {
//                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
//            }
//            if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]] + 30 < 81){
//                large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-6, 81/2-large_cell.title_label.frame.size.height/2, large_cell.title_label.frame.size.width+10, large_cell.title_label.frame.size.height);
//                large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, 81/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
//                large_cell.description_label.frame = CGRectMake(large_cell.description_label.frame.origin.x-6, large_cell.title_label.frame.size.height + 10, large_cell.description_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]);
//            }else {
//                large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-6, large_cell.title_label.frame.origin.y-3, large_cell.title_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30);
//                large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
//                large_cell.description_label.frame = CGRectMake(large_cell.description_label.frame.origin.x-6, large_cell.title_label.frame.size.height - 10, large_cell.description_label.frame.size.width+11, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30);
//            }

            if (!flag) {
                delBtn.hidden = NO;
                [large_cell.contentView addSubview:delBtn];
                for (UIView *view in large_cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 38;
                    view.frame = frame;
                }
            }
            else {
                [large_cell.contentView.superview addSubview:delBtn];
            }
            return large_cell;
            break;
        }
        case 9:
        {
            NSString *identifier = @"LargeImageCell";
            temp_items_data = [all_items_data objectForKey:@"SG"];
            large_cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
            cellType = 1;
//            if (indexPath.row%2) {
//                
//            } else {
            if ([self cellHeight:indexPath] < 81) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, large_cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [large_cell addSubview:label];
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self cellHeight:indexPath]-1.5, large_cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [large_cell addSubview:label];
            }
            
//            }
            large_cell.name = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
            large_cell.description = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"];
            image = [[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"thumb"];
            if (image!=nil && ![image isEqualToString:@""]) {
                [large_cell.cached_image_view loadImageWithURL:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"thumb"]];
//                if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30 < 81) {
//                    large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,81/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
//                } else {
//                    large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
//                }
                
            }
//            if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30 < 81) {
//                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,81/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
//            } else {
//                large_cell.cached_image_view.frame = CGRectMake(large_cell.cached_image_view.frame.origin.x,([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2 - large_cell.cached_image_view.frame.size.height/2, large_cell.cached_image_view.frame.size.width, large_cell.cached_image_view.frame.size.height);
//            }
//
//            if ([self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]] + 30 < 81){
//                large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-6, 81/2-large_cell.title_label.frame.size.height/2, large_cell.title_label.frame.size.width+10, large_cell.title_label.frame.size.height);
//                large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, 81/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
//                large_cell.description_label.frame = CGRectMake(large_cell.description_label.frame.origin.x-6, large_cell.title_label.frame.size.height + 10, large_cell.description_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]);
//            }else {
//                large_cell.title_label.frame = CGRectMake(large_cell.title_label.frame.origin.x-6, large_cell.title_label.frame.origin.y-3, large_cell.title_label.frame.size.width+10, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+30);
//                large_cell.cached_image_bg.frame = CGRectMake(large_cell.cached_image_bg.frame.origin.x, ([self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"title"]]+[self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30)/2 - large_cell.cached_image_bg.frame.size.height/2, large_cell.cached_image_bg.frame.size.width, large_cell.cached_image_bg.frame.size.height);
//                large_cell.description_label.frame = CGRectMake(large_cell.description_label.frame.origin.x-6, large_cell.title_label.frame.size.height - 10, large_cell.description_label.frame.size.width+11, [self fitHeight:[[temp_items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]]+30);
//            }
            
            if (!flag) {
                delBtn.hidden = NO;
                [large_cell.contentView addSubview:delBtn];
                for (UIView *view in large_cell.contentView.subviews) {
                    CGRect frame = view.frame;
                    frame.origin.x += 38;
                    view.frame = frame;
                }
            }
            else {
                [large_cell.contentView.superview addSubview:delBtn];
            }
            return large_cell;
            break;
        }
	}
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!flag) {
        return ;
    }
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    int index=-1;
    if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)] || [groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)] || [groupname isEqualToString:NSLocalizedString(@"Branch",nil)] ||
        [groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
        index=0;
    }else if([groupname isEqualToString: NSLocalizedString(@"tag_offers",nil)] && [fromType isEqualToString:@"Pri"]){
        index=1;
    }else if([groupname isEqualToString: NSLocalizedString(@"Year-round Offers",nil)]){
        index=2;
    }else if([groupname isEqualToString: NSLocalizedString(@"Quarterly Surprise",nil)]){
        index=3;
    }else if([groupname isEqualToString: NSLocalizedString(@"Latest Promotions-fav",nil)]){
        index=4;
    }//else if([groupname isEqualToString: NSLocalizedString(@"Spending & Rewards",nil)]){
    else if([groupname isEqualToString: NSLocalizedString(@"Rewards",nil)]){    // To be retested
        index=5;
    }else if([groupname isEqualToString: NSLocalizedString(@"Priority Booking for Concerts-fav",nil)]){
        index=6;
    }else if([groupname isEqualToString: NSLocalizedString(@"GlobePass Offers",nil)]){
        index=7;
    }else if([groupname isEqualToString: NSLocalizedString(@"Consumer Loans-fav",nil)] &&[fromType isEqualToString:@"CL"]){
        index=8;
    }else if([groupname isEqualToString: NSLocalizedString(@"Supreme Gold-fav",nil)] &&[fromType isEqualToString:@"SG"]){
        index=9;
    }
    switch (index) {
        case 0:
        {
//            NSArray *temp_items_data = [all_items_data objectForKey:@"ATM"];
            
            ATMOutletMapViewController *outlet_map_controller = [[ATMOutletMapViewController alloc] initWithNibName:@"ATMOutletMapView" bundle:nil];
            if (temp_items_data_arr && [[[temp_items_data_arr firstObject] valueForKey:@"branch_type"] integerValue] == 2) {
                outlet_map_controller.menuID = 0;
            }
            if (temp_items_data_arr && [[[temp_items_data_arr firstObject] valueForKey:@"branch_type"] integerValue] == 3) {
                outlet_map_controller.menuID = 2;
            }
            if (temp_items_data_arr && [[[temp_items_data_arr firstObject] valueForKey:@"branch_type"] integerValue] == 4) {
                outlet_map_controller.menuID = 3;
            }
            if (temp_items_data_arr && [[[temp_items_data_arr firstObject] valueForKey:@"branch_type"] integerValue] == 5) {
                outlet_map_controller.menuID = 1;
            }
        
         //   NSUInteger index = indexPath.row;
            [outlet_map_controller addAnnotations:temp_items_data_arr];
            outlet_map_controller.favouriteIndex = indexPath.row;
        //    [outlet_map_controller setSelectedAnnotation:index Delta:0.005 annotations:temp_items_data_arr];
            [outlet_map_controller hideBookmark];
            [outlet_map_controller setViewControllerPushType:1];
           // [outlet_map_controller viewDidLoad];
            outlet_map_controller.isNeedBox = YES;
            [self.navigationController pushViewController:outlet_map_controller animated:TRUE];
          //  [outlet_map_controller startLocationFromFavouritetoMenuID:outlet_map_controller.menuID];
            [outlet_map_controller release];
            
      //      outlet_map_controller.annotations =  [temp_items_data_arr retain];
//            [outlet_map_controller addAnnotationsM:temp_items_data_arr];
//            [outlet_map_controller setSelectedAnnotation:index Delta:0.005 annotations:temp_items_data_arr];
//         //   [outlet_map_controller setSelectedAnnotation:index Delta:0.005];
//            [outlet_map_controller hideBookmark];
//            [outlet_map_controller setViewControllerPushType:1];
//            [self.navigationController pushViewController:outlet_map_controller animated:TRUE];
//            [outlet_map_controller startLocationFromFavouritetoMenuID:outlet_map_controller.menuID];
//            [outlet_map_controller release];
        //    [temp_items_data_arr release];
        }
            break;
        case 1:
        {
            NSArray *temp_items_data = [all_items_data objectForKey:@"PRI"];
            NSUInteger index = indexPath.row ;
            id obj = [temp_items_data objectAtIndex:index];
            
            ConsumerLoanOffersViewController* current_view_controller =
            [[ConsumerLoanOffersViewController alloc] initWithNibName:@"ConsumerLoanOffersViewController"
                                                               bundle:nil
                                                             merchant:obj];
            [current_view_controller setViewControllerPushType:1];
            current_view_controller.fromType = @"PRI";
            [self.navigationController pushViewController:current_view_controller animated:TRUE];
            [current_view_controller hideBookmark];
            [current_view_controller release];
        }
            
            break;
        case 2:
        {
            YearRoundOffersSummaryViewController *summary_controller = [[YearRoundOffersSummaryViewController alloc] initWithNibName:@"YearRoundOffersSummaryView" bundle:nil];
            summary_controller.merchant_info = [[all_items_data objectForKey:@"YRO"] objectAtIndex:indexPath.row];
            [summary_controller setViewControllerPushType:1];
            summary_controller.title_label.text = title_label.text;
            summary_controller.headingTitle = title_label.text;
            [self.navigationController pushViewController:summary_controller animated:TRUE];
            [summary_controller release];
        }
            break;
        case 3:
        {
            CardLoanSummaryViewController *summary_controller = [[CardLoanSummaryViewController alloc] initWithNibName:@"CardLoanSummaryView" bundle:nil];
            summary_controller.merchant_info = [[all_items_data objectForKey:@"QS"] objectAtIndex:indexPath.row];
            NSLog(@"image: %d",[[summary_controller.merchant_info objectForKey:@"images"] count]);
            [summary_controller setViewControllerPushType:1];
            [self.navigationController pushViewController:summary_controller animated:TRUE];
            summary_controller.title_label.text = title_label.text;
            //jeff
            summary_controller.showBookmark = YES;
            //
            [summary_controller release];
        }
            break;
        case 4:
        {
            LatestPromotionsSummaryViewController *summary_controller = [[LatestPromotionsSummaryViewController alloc] initWithNibName:@"LatestPromotionsSummaryView" bundle:nil];
            summary_controller.merchant_info = [[all_items_data objectForKey:@"LP"] objectAtIndex:indexPath.row];
            NSLog(@"image: %d",[[summary_controller.merchant_info objectForKey:@"images"] count]);
            [summary_controller setViewControllerPushType:1];
            [self.navigationController pushViewController:summary_controller animated:TRUE];
            summary_controller.title_label.text = title_label.text;
            [summary_controller release];
        }
            break;
        case 5:
        {
            SpendingRewardsSummaryViewController *summary_controller = [[SpendingRewardsSummaryViewController alloc] initWithNibName:@"SpendingRewardsSummaryView" bundle:nil];
            summary_controller.merchant_info = [[all_items_data objectForKey:@"SAR"] objectAtIndex:indexPath.row];
            [summary_controller setViewControllerPushType:1];
            [self.navigationController pushViewController:summary_controller animated:TRUE];
            summary_controller.title_label.text = title_label.text;
            [summary_controller release];
        }
            break;
        case 6:
        {
            PBConcertsSummaryViewController *summary_controller = [[PBConcertsSummaryViewController alloc] initWithNibName:@"PBConcertsSummaryView" bundle:nil];
            summary_controller.merchant_info = [[all_items_data objectForKey:@"PBC"] objectAtIndex:indexPath.row];
            [summary_controller setViewControllerPushType:1];
            [self.navigationController pushViewController:summary_controller animated:TRUE];
            summary_controller.title_label.text = title_label.text;
            summary_controller.bookButton.hidden = YES;
            [summary_controller release];
        }
            break;
        case 7:
        {
            GlobePassSummaryViewController *summary_controller = [[GlobePassSummaryViewController alloc] initWithNibName:@"GlobePassSummaryView" bundle:nil];
            summary_controller.merchant_info = [[all_items_data objectForKey:@"GPO"] objectAtIndex:indexPath.row];
            [summary_controller setViewControllerPushType:1];
            [self.navigationController pushViewController:summary_controller animated:TRUE];
            summary_controller.title_label.text = title_label.text;
            [summary_controller release];
        }
            break;
        case 8:
        {
            NSArray *temp_items_data = [all_items_data objectForKey:@"CL"];
            NSUInteger index = indexPath.row ;
            id obj = [temp_items_data objectAtIndex:index];
            
            ConsumerLoanOffersViewController* current_view_controller =
            [[ConsumerLoanOffersViewController alloc] initWithNibName:@"ConsumerLoanOffersViewController"
                                                               bundle:nil
                                                             merchant:obj];
            [current_view_controller setViewControllerPushType:1];
            current_view_controller.fromType = @"CL";
            [self.navigationController pushViewController:current_view_controller animated:TRUE];
            [current_view_controller hideBookmark];
            [current_view_controller release];
        }
            
            break;
        case 9:
        {
            NSArray *temp_items_data = [all_items_data objectForKey:@"SG"];
            NSUInteger index = indexPath.row ;
            id obj = [temp_items_data objectAtIndex:index];
            
            NSLog(@"SupremeGoldOffersViewController : %@",obj);
            
            SupremeGoldOffersViewController* current_view_controller =
            [[SupremeGoldOffersViewController alloc] initWithNibName:@"SupremeGoldOffersViewController"
                                                               bundle:nil
                                                             merchant:obj];
            [current_view_controller setViewControllerPushType:1];
            [self.navigationController pushViewController:current_view_controller animated:TRUE];
            [current_view_controller hideBookmark];
            [current_view_controller release];
        }
            
            break;
    }
}

-(NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return NSLocalizedString(@"Delete",nil);
}

/* To be retested begin */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSIndexPath *indexPath = deletedIndexpath;
    switch (buttonIndex) {
        case 1:     // cancel
            
            break;
        case 0:     // ok
            NSLog(@"Delete section:%d row:%d",indexPath.section, indexPath.row);
            int index=-1;
//            if([groupname isEqualToString: NSLocalizedString(@"ATM Location",nil)]){
            if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)] || [groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)] || [groupname isEqualToString:NSLocalizedString(@"Branch",nil)] ||
                [groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
                index=0;
            }else if([groupname isEqualToString: NSLocalizedString(@"tag_offers",nil)] && [fromType isEqualToString:@"Pri"]){
                index=1;
            }else if([groupname isEqualToString: NSLocalizedString(@"Year-round Offers",nil)]){
                index=2;
            }else if([groupname isEqualToString: NSLocalizedString(@"Quarterly Surprise",nil)]){
                index=3;
            }else if([groupname isEqualToString: NSLocalizedString(@"Latest Promotions-fav",nil)]){
                index=4;
            }else if([groupname isEqualToString: NSLocalizedString(@"Rewards",nil)]){
                index=5;
            }else if([groupname isEqualToString: NSLocalizedString(@"Priority Booking for Concerts-fav",nil)]){
                index=6;
            }else if([groupname isEqualToString: NSLocalizedString(@"GlobePass Offers",nil)]){
                index=7;
            }else if([groupname isEqualToString: NSLocalizedString(@"Consumer Loans-fav",nil)] &&[fromType isEqualToString:@"CL"]){
                index=8;
            }
            else if([groupname isEqualToString: NSLocalizedString(@"Supreme Gold-fav",nil)] &&[fromType isEqualToString:@"SG"]){
                index=9;
            }
            NSLog(@"debug cellForRowAtIndexPath index: %d",index);
//            NSLog(@"count is %d", [temp_items_data_arr count]);
            Bookmark *bookmark_data = [[Bookmark alloc] init];
            switch (index) {
                case 0:
                {
                    NSDictionary *itemDic = [NSDictionary dictionary];
                    NSDictionary *delDic = [NSDictionary dictionary];
                 //   NSMutableArray *temp_items_data_arr = [NSMutableArray array];
                    NSArray *temp_items_data = [all_items_data objectForKey:@"ATM"];
                    
                    if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)]) {
                        for (itemDic in temp_items_data) {
                            if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 2) {
                                NSDictionary *saveDic = [temp_items_data_arr objectAtIndex:indexPath.row];
                                if ([[itemDic valueForKey:@"id"] integerValue] == [[saveDic valueForKey:@"id"] integerValue]) {
                                    [bookmark_data removeBookmark:itemDic InGroup:0];
                                    [[all_items_data objectForKey:@"ATM"] removeObject:itemDic];
                                  //  [delDic release];
                                  //  delDic = [itemDic retain];
                                    break;
                                }
                            }
                            
                        }
                    }
                    else if ([groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)]) {
                        for (itemDic in temp_items_data) {
                            if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 3) {
                                NSDictionary *saveDic = [temp_items_data_arr objectAtIndex:indexPath.row];
                                if ([[itemDic valueForKey:@"id"] isEqualToString:[saveDic valueForKey:@"id"]]) {
                                    [bookmark_data removeBookmark:itemDic InGroup:0];
                                    delDic = [itemDic retain];
                                    break;
                                }
                            }
                        }
                        [[all_items_data objectForKey:@"ATM"] removeObject:itemDic];
//                        [delDic release];
                    }
                    else if ([groupname isEqualToString:NSLocalizedString(@"Branch",nil)]) {
                        for (itemDic in temp_items_data) {
                            if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 4) {
                                NSDictionary *saveDic = [temp_items_data_arr objectAtIndex:indexPath.row];
                                if ([[itemDic valueForKey:@"id"] isEqualToString:[saveDic valueForKey:@"id"]]) {
                                    [bookmark_data removeBookmark:itemDic InGroup:0];
                                    delDic = [itemDic retain];
                                    break;
                                }
                            }
                        }
                        [[all_items_data objectForKey:@"ATM"] removeObject:itemDic];
//                        [delDic release];
                    }
                    else if ([groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
                        for (itemDic in temp_items_data) {
                            if (itemDic && [[itemDic valueForKey:@"branch_type"] integerValue] == 5) {
                                NSDictionary *saveDic = [temp_items_data_arr objectAtIndex:indexPath.row];
                                if ([[itemDic valueForKey:@"id"] isEqualToString:[saveDic valueForKey:@"id"]]) {
                                    [bookmark_data removeBookmark:itemDic InGroup:0];
                                    delDic = [itemDic retain];
                                    break;
                                }
                            }
                        }
                        [[all_items_data objectForKey:@"ATM"] removeObject:itemDic];
//                        [delDic release];
                    }

//                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"ATM"] objectAtIndex:indexPath.row] InGroup:0];
//                    [[all_items_data objectForKey:@"ATM"] removeObjectAtIndex:indexPath.row];
                    break;
                }
                case 1:
                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"PRI"] objectAtIndex:indexPath.row] InGroup:1];
                    [[all_items_data objectForKey:@"PRI"] removeObjectAtIndex:indexPath.row];
                    break;
                case 2:
                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"YRO"] objectAtIndex:indexPath.row] InGroup:2];
                    [[all_items_data objectForKey:@"YRO"] removeObjectAtIndex:indexPath.row];
                    break;
                case 3:
                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"QS"] objectAtIndex:indexPath.row] InGroup:3];
                    [[all_items_data objectForKey:@"QS"] removeObjectAtIndex:indexPath.row];
                    break;
                case 4:
                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"LP"] objectAtIndex:indexPath.row] InGroup:4];
                    [[all_items_data objectForKey:@"LP"] removeObjectAtIndex:indexPath.row];
                    break;
                case 5:
                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"SAR"] objectAtIndex:indexPath.row] InGroup:5];
                    [[all_items_data objectForKey:@"SAR"] removeObjectAtIndex:indexPath.row];
                    break;
                case 6:
                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"PBC"] objectAtIndex:indexPath.row] InGroup:6];
                    [[all_items_data objectForKey:@"PBC"] removeObjectAtIndex:indexPath.row];
                    break;
                case 7:
                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"GPO"] objectAtIndex:indexPath.row] InGroup:7];
                    [[all_items_data objectForKey:@"GPO"] removeObjectAtIndex:indexPath.row];
                    break;
                case 8:
                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"CL"] objectAtIndex:indexPath.row] InGroup:8];
                    [[all_items_data objectForKey:@"CL"] removeObjectAtIndex:indexPath.row];
                    break;
                case 9:
                    [bookmark_data removeBookmark:[[all_items_data objectForKey:@"SG"] objectAtIndex:indexPath.row] InGroup:9];
                    [[all_items_data objectForKey:@"SG"] removeObjectAtIndex:indexPath.row];
                    break;
            }
            NSLog(@"2  Delete section:%d row:%d",indexPath.section, indexPath.row);
//            NSArray *indexPaths = [table_view indexPathsForVisibleRows];
//            for (NSIndexPath *indexpath in indexPaths) {
//                ATMCustomCellCMS *cell = (ATMCustomCellCMS *)[table_view cellForRowAtIndexPath:indexPath];
//                UIButton *btn = (UIButton *)[cell.contentView.superview viewWithTag:indexPath.row+10];
//                btn.hidden = YES;
//            }
            
//            [table_view deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:TRUE];
            hasDeleted = YES;
//            flag = !flag;
//            table_view.allowsSelection = flag;
//            if (flag) {
//                [_btnEdit setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
//            }
            int no_record = TRUE;
            if ([groupname isEqualToString:NSLocalizedString(@"ATM",nil)] || [groupname isEqualToString:NSLocalizedString(@"i-Financial center",nil)] || [groupname isEqualToString:NSLocalizedString(@"Branch",nil)] ||
                [groupname isEqualToString:NSLocalizedString(@"SupremeGold Centre",nil)]) {
                if ([self calculateCountByBranchType] > 0)
                    no_record = FALSE;
                else
                    no_record = TRUE;
            }
            else{
                  if ([[all_items_data objectForKey:[self nameToKey: groupname]] count] > 0)
                        no_record = FALSE;
                    else
                       no_record = TRUE;
            }
            if (no_record) {
                [self.navigationController popViewControllerAnimated:YES];
                [self.caller generateBookmark];
                result.text = NSLocalizedString(@"No bookmark stored",nil);
                return;
              //  [table_view reloadData];
            }
            [self generateBookmark];
            [table_view reloadData];
//            [self.caller generateBookmark];
            break;
        default:
            break;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

/* To be retested end */
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        deletedIndexpath = indexPath;
		
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 0.0;
}
////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	[items_data removeAllObjects];
	switch (parsing_type) {
		case 0:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"tel",
                   @"fax",
                   @"district1",
                   @"lat",
                   @"lon",
                   @"iconshow",
                   @"branch",
                   @"address",
                   @"opeinghour",
                   @"contacts",
                   @"services",
                   @"categories",
                   @"branch_type",
                   nil];
			break;
		case 1:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"type",
                   @"intcaltype",
                   @"title",
                   @"shortdesc",
                   @"desc",
                   @"url",
                   @"image",
                   @"thumb",
                   @"tnc",
                   @"tel_label",
                   @"url_label",
                   @"emailsubject",
                   @"emailbody",
                   @"tel",
                   @"pdf_url",
                   @"tnc_label",
                   nil];
			break;
		case 2:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"title",
                   @"etitle",
                   @"shortdescription",
                   @"description",
                   @"category",
                   @"cuisine",
                   @"image",
                   @"suprise",
                   @"card",
                   @"remark",
                   @"newitem",
                   nil];
			break;
		case 3:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"title",
                   @"etitle",
                   @"shortdescription",
                   @"description",
                   @"thumbnail",
                   @"category",
                   @"preview",
                   @"cuisine",
                   @"suprise",
                   @"address",
                   @"tel",
                   @"card",
                   @"coupon",
                   @"remark",
                   @"newitem",
                   nil];
			break;
		case 4:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"title",
                   @"etitle",
                   @"shortdescription",
                   @"description",
                   @"thumbnail",
                   @"category",
                   @"preview",
                   @"cuisine",
                   @"suprise",
                   @"address",
                   @"tel",
                   @"card",
                   @"coupon",
                   @"remark",
                   @"newitem",
                   nil];
			break;
		case 5:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"title",
                   @"etitle",
                   @"shortdescription",
                   @"description",
                   @"thumbnail",
                   @"category",
                   @"preview",
                   @"cuisine",
                   @"suprise",
                   @"card",
                   @"coupon",
                   @"remark",
                   @"newitem",
                   nil];
			break;
		case 6:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"title",
                   @"etitle",
                   @"shortdescription",
                   @"description",
                   @"thumbnail",
                   @"category",
                   @"preview",
                   @"cuisine",
                   @"suprise",
                   @"card",
                   @"concert_date",
                   @"book_hotline",
                   @"start",
                   @"expire",
                   @"venue",
                   @"price",
                   @"remark",
                   @"newitem",
                   nil];
			break;
		case 7:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"title",
                   @"etitle",
                   @"shortdescription",
                   @"description",
                   @"thumbnail",
                   @"category",
                   @"preview",
                   @"cuisine",
                   @"suprise",
                   @"card",
                   @"coupon",
                   @"remark",
                   @"newitem",
                   nil];
			break;
        case 8:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"type",
                   @"intcaltype",
                   @"title",
                   @"shortdesc",
                   @"desc",
                   @"url",
                   @"image",
                   @"thumb",
                   @"tnc",
                   @"tel_label",
                   @"url_label",
                   @"emailsubject",
                   @"emailbody",
                   @"tel",
                   @"pdf_url",
                   @"tnc_label",
                   nil];
			break;
        case 9:
			key = [NSArray arrayWithObjects:
                   @"id",
                   @"type",
                   @"intcaltype",
                   @"title",
                   @"shortdesc",
                   @"desc",
                   @"url",
                   @"image",
                   @"thumb",
                   @"tnc",
                   @"tel_label",
                   @"url_label",
                   @"emailsubject",
                   @"emailbody",
                   @"tel",
                   @"pdf_url",
                   @"tnc_label",
                   nil];
			break;
	}
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
//	total_page = ceil([items_data count]/(float)current_page_size);
    /*	if (current_page==1) {
     prev.hidden = TRUE;
     } else {
     prev.hidden = FALSE;
     }
     
     if (current_page==total_page) {
     next.hidden = TRUE;
     } else {
     next.hidden = FALSE;
     }*/
	NSLog(@"debug FavouriteListViewController2 %d merchants",[items_data count]);
//	NSLog(@"debug FavouriteListViewController2 merchants:%@",items_data);
	Bookmark *bookmark_data = [[Bookmark alloc] init];
	NSArray *id_list = [[bookmark_data listOfferIdInGroup:parsing_type] componentsSeparatedByString:@","];
	int i, j;
	for (i=[id_list count]-1; i>=0; i--) {
		BOOL found = FALSE;
		for (j=0; j<[items_data count]; j++) {
			if ([[[items_data objectAtIndex:j] objectForKey:@"id"] isEqualToString:[id_list objectAtIndex:i]]) {
				found = TRUE;
				NSLog(@"Found id:%@",[id_list objectAtIndex:i]);
			}
		}
		if (!found) {
			NSLog(@"Remove outdated bookmark id:%@",[id_list objectAtIndex:i]);
			[bookmark_data removeBookmark:[NSDictionary dictionaryWithObject:[id_list objectAtIndex:i] forKey:@"id"] InGroup:parsing_type];
		}
	}
	if ([items_data count]>0) {
		[header_exist replaceObjectAtIndex:parsing_type withObject:@"T"];
		switch (parsing_type) {
			case 0:
				if ([all_items_data objectForKey:@"ATM"]!=nil) {
					[all_items_data removeObjectForKey:@"ATM"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"ATM"];
				break;
			case 1:
				if ([all_items_data objectForKey:@"PRI"]!=nil) {
					[all_items_data removeObjectForKey:@"PRI"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"PRI"];
				break;
			case 2:
				if ([all_items_data objectForKey:@"YRO"]!=nil) {
					[all_items_data removeObjectForKey:@"YRO"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"YRO"];
				break;
			case 3:
				if ([all_items_data objectForKey:@"QS"]!=nil) {
					[all_items_data removeObjectForKey:@"QS"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"QS"];
				break;
			case 4:
				if ([all_items_data objectForKey:@"LP"]!=nil) {
					[all_items_data removeObjectForKey:@"LP"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"LP"];
				break;
			case 5:
				if ([all_items_data objectForKey:@"SAR"]!=nil) {
					[all_items_data removeObjectForKey:@"SAR"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"SAR"];
				break;
			case 6:
				if ([all_items_data objectForKey:@"PBC"]!=nil) {
					[all_items_data removeObjectForKey:@"PBC"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"PBC"];
				break;
			case 7:
				if ([all_items_data objectForKey:@"GPO"]!=nil) {
					[all_items_data removeObjectForKey:@"GPO"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"GPO"];
				break;
            case 8:
				if ([all_items_data objectForKey:@"CL"]!=nil) {
					[all_items_data removeObjectForKey:@"CL"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"CL"];
				break;
            case 9:
				if ([all_items_data objectForKey:@"SG"]!=nil) {
					[all_items_data removeObjectForKey:@"SG"];
				}
				[all_items_data setValue:[NSMutableArray arrayWithArray:items_data] forKey:@"SG"];
				break;
		}
	}
	[table_view reloadData];
    int total_result = 0;
    if([groupname isEqualToString: NSLocalizedString(@"Quarterly Surprise",nil)]){
        total_result += [[all_items_data objectForKey:@"QS"] count];
    }else if([groupname isEqualToString: NSLocalizedString(@"Year-round Offers",nil)]){
        total_result += [[all_items_data objectForKey:@"YRO"] count];
    }else if([groupname isEqualToString: NSLocalizedString(@"Latest Promotions-fav",nil)]){
       total_result += [[all_items_data objectForKey:@"LP"] count];
    }else if([groupname isEqualToString: NSLocalizedString(@"Rewards",nil)]){
       total_result += [[all_items_data objectForKey:@"SAR"] count];
    }else if([groupname isEqualToString: NSLocalizedString(@"GlobePass Offers",nil)]){
        total_result += [[all_items_data objectForKey:@"GPO"] count];
    }else if([groupname isEqualToString: NSLocalizedString(@"ATM Location",nil)]){
        total_result += [[all_items_data objectForKey:@"ATM"] count];
    }else if([groupname isEqualToString: NSLocalizedString(@"tag_offers",nil)] && [fromType isEqualToString:@"Pri"]){
        total_result += [[all_items_data objectForKey:@"PRI"] count];
    }else if([groupname isEqualToString: NSLocalizedString(@"Priority Booking for Concerts-fav",nil)]){
        total_result += [[all_items_data objectForKey:@"PBC"] count];
    }else if([groupname isEqualToString: NSLocalizedString(@"Consumer Loans-fav",nil)] && [fromType isEqualToString:@"CL"]){
        total_result += [[all_items_data objectForKey:@"CL"] count];
    }else if([groupname isEqualToString: NSLocalizedString(@"Supreme Gold-fav",nil)] && [fromType isEqualToString:@"SG"]){
        total_result += [[all_items_data objectForKey:@"SG"] count];
    }
	result.text = [NSString stringWithFormat:@"%@ %d",NSLocalizedString(@"Bookmark1",nil), total_result];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
	} else if ([elementName isEqualToString:@"merchants"]) {
		temp_merchant_list = [NSMutableArray new];
	} else if ([elementName isEqualToString:@"images"]) {
		temp_image_list = [NSMutableArray new];
	} else if ([elementName isEqualToString:@"coorganisers"]) {
		temp_coorganisers_list = [NSMutableArray new];
	} else if ([elementName isEqualToString:@"sponsors"]) {
		temp_pb_list = [NSMutableArray new];
	} else if ([elementName isEqualToString:@"managements"]) {
		temp_mgt_list = [NSMutableArray new];
	} else if ([elementName isEqualToString:@"productions"]) {
		temp_pdt_list = [NSMutableArray new];
	}
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    [self fixspace:@"id"];
    [self fixspace:@"image"];
    [self fixspace:@"title"];
 //   [self fixspace:@"tel"];
    [self fixspace:@"tel_label"];
    [self fixspace:@"thumb"];
    [self fixspace:@"url"];
    [self fixspace:@"url_label"];
    [self fixspace:@"pdf_url"];
    [self fixspace:@"tnc_label"];
    [self fixspace:@"tnc"];

    NSString *value = [temp_record objectForKey:@"shortdesc"];
    if ((NSNull *)value == [NSNull null] || [value isEqualToString:@"\n\t\t\t"]) {
        [self fixspace:@"shortdesc"];
    }

    [self fixspace:temp_record key:@"tel"];
    [self fixspace:temp_record key:@"address"];
    [self fixspace:temp_record key:@"branch"];
    [self fixspace:temp_record key:@"categories"];
    [self fixspace:temp_record key:@"contacts"];
    [self fixspace:temp_record key:@"distance"];
    [self fixspace:temp_record key:@"district1"];
    [self fixspace:temp_record key:@"fax"];
    [self fixspace:temp_record key:@"iconshow"];
    [self fixspace:temp_record key:@"id"];
    [self fixspace:temp_record key:@"lat"];
    [self fixspace:temp_record key:@"lon"];
    [self fixspace:temp_record key:@"services"];
    [self fixspace:temp_record key:@"opeinghour"];

    if ([elementName isEqualToString:@"item"]) {
		[items_data addObject:temp_record];
//        NSLog(@"[items_data addObject:temp_record] : %@", temp_record);
	} else if ([elementName isEqualToString:@"merchants"]) {
		[temp_record setValue:temp_merchant_list forKey:@"merchants"];
	} else if ([elementName isEqualToString:@"images"]) {
		[temp_record setValue:temp_image_list forKey:@"images"];
	} else if ([elementName isEqualToString:@"coorganisers"]) {
		[temp_record setValue:temp_coorganisers_list forKey:@"coorganisers"];
	} else if ([elementName isEqualToString:@"sponsors"]) {
		[temp_record setValue:temp_pb_list forKey:@"sponsors"];
	} else if ([elementName isEqualToString:@"managements"]) {
		[temp_record setValue:temp_mgt_list forKey:@"managements"];
	} else if ([elementName isEqualToString:@"productions"]) {
		[temp_record setValue:temp_pdt_list forKey:@"productions"];
	}
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//    NSLog(@"foundCharacters key: %@ %@",currentElementName,key);
	for (int i=0; i<[key count]; i++) {
		if ([currentElementName isEqualToString:[key objectAtIndex:i]]) {
            NSString * oldstr = [temp_record objectForKey:currentElementName];
            if (!oldstr){
                oldstr = @"";
            }
            oldstr = [oldstr stringByAppendingString:string];
            [temp_record setObject:oldstr forKey:currentElementName];
//			NSLog(@"foundCharacters: %@ %@--%@",currentElementName,string,oldstr);
		}
	}
	if ([currentElementName isEqualToString:@"merchant"]) {
		if ([string length]>4) {
			[temp_merchant_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"image"] && parsing_type!=0 && parsing_type!=1) {
		if ([string length]>4) {
			[temp_image_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"coorganiser"]) {
		if ([string length]>4) {
//			NSLog(@"Add coorganiser");
			[temp_coorganisers_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"sponsor"]) {
		if ([string length]>4) {
//			NSLog(@"Add title sponsor");
			[temp_pb_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"management"]) {
		if ([string length]>4) {
//			NSLog(@"Add management");
			[temp_mgt_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"production"]) {
		if ([string length]>4) {
//			NSLog(@"Add production" );
			[temp_pdt_list addObject:string];
		}
	}else if ([currentElementName isEqualToString:@"opeinghour"]) {
//			NSLog(@"Add opeinghour %@", string);
//			[temp_pdt_list addObject:string];
	}
}

-(void)fixspace:(NSString*)akey
{
    NSString* value=[temp_record objectForKey:akey];
//    NSLog(@"debug fixspace begin:[%@]--[%@]", akey, value);
    if (!value) {
        //        NSLog(@"debug fixspace end with nil:[%@]--[%@]", akey, value);
        return;
    }
    value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    if ([akey isEqualToString:@"thumb"]
        ||
        [akey isEqualToString:@"image"]
        ||
        [akey isEqualToString:@"pdf_url"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    } else if (!([akey isEqualToString:@"title"] || [akey isEqualToString:@"url_label"] || [akey isEqualToString:@"tel_label"] || [akey isEqualToString:@"tnc"])) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
//    NSLog(@"debug fixspace end:[%@]--[%@]", akey, value);
    [temp_record setObject:value forKey:akey];
    return;
}
-(void)fixspace:(NSMutableDictionary*)dic key:(NSString*)akey
{
    NSString* value=[dic objectForKey:akey];
    //    NSLog(@"debug fixspace begin:[%@]--[%@]", akey, value);
    if (value == nil){
        value = @"";
    }
    
    if ([akey isEqualToString:@"opeinghour"]
        ||
        [akey isEqualToString:@"branch"]
        ||
        [akey isEqualToString:@"address"]
        ) {
        //        value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\t\t" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\n\t" withString:@""];
    } else {
        value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        if (![akey isEqualToString:@"tel"]) {
            value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        
    }
    
    //    NSLog(@"debug fixspace end:[%@]", value);
    [dic setObject:value forKey:akey];
    return;
}
- (void)endAnimationToCell:(id)cell andButton:(UIButton *)btn
{
//    [UIView animateWithDuration:0.3 animations:^(){
        if (hasDeleted) {
            UITableViewCell *myCell = (UITableViewCell *)cell;
            for (UIView *view in myCell.contentView.subviews) {
                CGRect frame = view.frame;
                frame.origin.x -= 38;
                view.frame = frame;
            }
        }
        else {
            [table_view reloadData];
            CGRect newFrame = ((UITableViewCell *)cell).contentView.frame;
            newFrame.origin.x = 0;
            ((UITableViewCell *)cell).contentView.frame = newFrame;
            CGRect frame = btn.frame;
            frame.origin.x -= 40;
            frame.origin.y = (((UITableViewCell *)cell).contentView.frame.size.height - btn.frame.size.height)/2-2;
            btn.frame = frame;
          //  [btn removeFromSuperview];
        }
//    }];
}

- (void)beginAnimationToCell:(id)cell andButton:(UIButton *)btn
{
//    [UIView animateWithDuration:0.3 animations:^(){
        if (hasDeleted) {
            UITableViewCell *myCell = (UITableViewCell *)cell;
            for (UIView *view in myCell.contentView.subviews) {
                CGRect frame = view.frame;
                frame.origin.x += 38;
                view.frame = frame;
                if ([view isKindOfClass:[UIButton class]]) {
                    view.hidden = NO;
                }
            }
        }
        else {
            CGRect newFrame = ((UITableViewCell *)cell).contentView.frame;
            newFrame.origin.x += 38;
            ((UITableViewCell *)cell).contentView.frame = newFrame;
            CGRect frame = btn.frame;
            frame.origin.x += 40;
            frame.origin.y = (((UITableViewCell *)cell).contentView.frame.size.height - btn.frame.size.height)/2-2;
            btn.frame = frame;
        }
//    }];
}

- (void)setDeleteButtonHiddenStatus:(BOOL)status {
    NSArray *indexPaths = [table_view indexPathsForVisibleRows];
    if (status) {
        if (isRecustomCell) {
            isRecustomCell = NO;
//            [table_view reloadData];
        }
        else {
            for (NSIndexPath *indexPath in indexPaths) {
                UITableViewCell *cell = [table_view cellForRowAtIndexPath:indexPath];
                cell.editing = YES;
                UIButton *btn = (UIButton *)[cell.contentView.superview viewWithTag:indexPath.row+10];
                btn.hidden = status;
                [self endAnimationToCell:cell andButton:btn];
            }
       //     hasDeleted = NO;
        }
    }
    else {
        for (NSIndexPath *indexPath in indexPaths) {
            UITableViewCell *cell = [table_view cellForRowAtIndexPath:indexPath];
            UIButton *btn = (UIButton *)[cell.contentView.superview viewWithTag:indexPath.row+10];
            btn.hidden = status;
            [self beginAnimationToCell:cell andButton:btn];
        }
    }
}

bool flag = YES;
- (IBAction)btnPressedEdit:(id)sender {
    flag = !flag;
    if (!flag) {
        [_btnEdit setTitle:NSLocalizedString(@"Edit_done", nil) forState:UIControlStateNormal];
    }
    else {
        [_btnEdit setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
    }
    table_view.allowsSelection = flag;
    [self setDeleteButtonHiddenStatus:flag];

}

- (void)handleDeleteAction:(UIButton *)btn {
    NSLog(@"tag is %d", btn.tag);
    deletedIndexpath = (NSIndexPath *)[btnToIndexpath valueForKey:[NSString stringWithFormat:@"%d", btn.tag]];
     NSLog(@"indexPath--section:%d row:%d",deletedIndexpath.section, deletedIndexpath.row);
 //   deletedIndexpath = indexPath;
    UIAlertView *showAlert = [[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%@ ?", NSLocalizedString(@"Are you sure to delete",nil)] delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil] autorelease];
    [showAlert show];
    
}

- (CGFloat) cellHeight:(NSIndexPath *)indexPath {
    NSString *str;
    //    if ([[[self.items_data objectAtIndex:indexPath.row] objectForKey:@"shortdesc"] isEqualToString:@""]) {
    //        str = [[self.items_data objectAtIndex:indexPath.row] objectForKey:@"title"];
    //    }else {
    str = [NSString stringWithFormat:@"%@\n\n%@",[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"title"],[[[all_items_data objectForKey:[self nameToKey: groupname]] objectAtIndex:indexPath.row] objectForKey:@"shortdesc"]];
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
    NSLog(@"%d",height);
    return height;
}

@end
