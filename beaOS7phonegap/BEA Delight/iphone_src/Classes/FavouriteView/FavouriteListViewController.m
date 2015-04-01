//  Created by Algebra Lo on 10年3月23日.
//  Amended by yaojzy on 201309

#import "FavouriteListViewController.h"
#import "FavouriteListViewController2.h"
#import "ATMOutletMapViewController.h"
#import "ATMDistCellCMS.h"
@implementation FavouriteListViewController

@synthesize header_list;
@synthesize groupname_list;
@synthesize itemname_listATM;
@synthesize itemname_listCreditCard;
@synthesize itemname_listprivileges, itemname_listLoans, isCreditCardBookmark;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		all_items_data = [NSMutableDictionary new];
//		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"ATM"];
//		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"PRI"];
//		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"YRO"];
//		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"QS"];
//		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"LP"];
//		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"SAR"];
//		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"PBC"];
//		[all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"GPO"];
		items_data = [NSMutableArray new];
		/*current_type = @"OfferId";
         current_category = [[CoreData sharedCoreData].bookmark listOfferId];*/
        
//        self.header_list = [NSMutableArray arrayWithObjects:
//                            NSLocalizedString(@"ATM Location",nil),
//                            NSLocalizedString(@"Offers",nil),
//                            NSLocalizedString(@"Year-round Offers",nil),
//                            NSLocalizedString(@"Quarterly Surprise",nil),
//                            NSLocalizedString(@"Latest Promotions-fav",nil),
////                            NSLocalizedString(@"Spending & Rewards",nil),
//                            NSLocalizedString(@"Rewards",nil),
//                            NSLocalizedString(@"Priority Booking for Concerts-fav",nil),
//                            NSLocalizedString(@"GlobePass Offers",nil),
//                            NSLocalizedString(@"Consumer Loans-fav",nil),
//                            nil];
//        self.groupname_list = [NSMutableArray arrayWithObjects:
//                               NSLocalizedString(@"Credit Card",nil),
//                               NSLocalizedString(@"ATM Location",nil),
//                             //  NSLocalizedString(@"Privileges",nil),
//                               NSLocalizedString(@"Offers-fav",nil),
//                               NSLocalizedString(@"Loans-fav",nil),
//                               nil];
        self.header_list = [NSMutableArray arrayWithObjects:
                            NSLocalizedString(@"Supreme Gold-fav",nil),
                            NSLocalizedString(@"Consumer Loans-fav",nil),
                            NSLocalizedString(@"Offers",nil),
                            NSLocalizedString(@"ATM Location",nil),
                            NSLocalizedString(@"Latest Promotions-fav",nil),
                            NSLocalizedString(@"Rewards",nil),
                            NSLocalizedString(@"Priority Booking for Concerts-fav",nil),
                            NSLocalizedString(@"Quarterly Surprise",nil),
                            NSLocalizedString(@"GlobePass Offers",nil),
                            NSLocalizedString(@"Year-round Offers",nil),
                            nil];
        self.groupname_list = [NSMutableArray arrayWithObjects:
                               NSLocalizedString(@"Gold-fav",nil),
                               NSLocalizedString(@"Loans-fav",nil),
                               NSLocalizedString(@"Offers-fav",nil),
                               NSLocalizedString(@"ATM Location",nil),
                               NSLocalizedString(@"Credit Card",nil),
                               nil];
        self.itemname_listCreditCard = [NSMutableArray new];
        self.itemname_listATM = [NSMutableArray new];
        self.itemname_listprivileges = [NSMutableArray new];
        self.itemname_listLoans = [NSMutableArray new];
        self.itemname_listGold = [NSMutableArray new];
        isCreditCardBookmark = NO;
    }
    NSLog(@"debug FavouriteListViewController initWithNibName:%@", self);
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (isCreditCardBookmark) {
        NSLog(@"YES");
        [[MoreMenuUtil me] setMoreMenuViews4CreditCard];
    }
    
    if ([self isMovingFromParentViewController])
    {
        if (self.navigationController.delegate == self)
        {
            self.navigationController.delegate = nil;
        }
    }

}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setExtraCellLineHidden:table_view];

    if ([table_view respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [table_view setSeparatorInset:UIEdgeInsetsZero];
        
    }
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    table_view.frame = CGRectMake(0, 110, 320, 350+[[MyScreenUtil me] getScreenHeightAdjust]);
    
	title_label.text = NSLocalizedString(@"Bookmark",nil);
	[self generateBookmark];
    
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
//    if (isCreditCardBookmark) {
////        NSArray *navCt1 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
////        NSArray *navCt2 = self.navigationController.viewControllers;
////        NSArray *navCt3 = [MoreMenuUtil me].creditCardNav.viewControllers;
//        [v_rmvc.rmUtil setNav:[CoreData sharedCoreData].root_view_controller.navigationController];
//    }
//   else {
//       [v_rmvc.rmUtil setNav:self.navigationController];
//    }
//    v_rmvc.vc_caller = self;
    NSLog(@"debug FavouriteListViewController viewDidLoad:%@", self);
    
    NSLog(@"debug :self.navigationController.view 2:%@ ",self.navigationController.view);

//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//        CGRect frame = table_view.frame;
//        frame.origin.y += 20;
//        table_view.frame = frame;
//    }
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
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
	[all_items_data release];
	[items_data release];
	[header_exist release];
    [self.itemname_listATM release];
    [self.itemname_listCreditCard release];
    [self.itemname_listLoans release];
    [self.itemname_listprivileges release];
    [self.itemname_listGold release];
    [scrollView release];
    [super dealloc];
}

- (void)removeItemsByItemsName{
    Bookmark *bookmark_data = [[Bookmark alloc] init];
    if ([[[bookmark_data getBookmarkData] objectForKey:@"QS"] count] ==0) {
        [self.itemname_listCreditCard removeObject: NSLocalizedString(@"Quarterly Surprise",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"F"];
    }
    if ([[[bookmark_data getBookmarkData] objectForKey:@"YRO"] count]!=0) {
        [self.itemname_listCreditCard removeObject:  NSLocalizedString(@"Year-round Offers",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"F"];
    }
    if ([[[bookmark_data getBookmarkData] objectForKey:@"LP"] count]!=0) {
        [self.itemname_listCreditCard removeObject:  NSLocalizedString(@"Latest Promotions-fav",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"F"];
    }
    if ([[[bookmark_data getBookmarkData] objectForKey:@"SAR"] count]!=0) {
        [self.itemname_listCreditCard removeObject:  NSLocalizedString(@"Rewards",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"F"];
    }
    if ([[[bookmark_data getBookmarkData] objectForKey:@"PBC"] count]!=0) {
        [self.itemname_listCreditCard removeObject:  NSLocalizedString(@"Priority Booking for Concerts-fav",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"F"];
    }
    if ([[[bookmark_data getBookmarkData] objectForKey:@"GPO"] count]!=0) {
        [self.itemname_listCreditCard removeObject:  NSLocalizedString(@"GlobePass Offers",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"F"];
    }
}

-(void)generateBookmark {
    NSLog(@"debug FavouriteListViewController generateBookmark:%@", self);
    if (isCreditCardBookmark) {
        if (header_exist) {
            [header_exist removeAllObjects];
            [header_exist release];
            header_exist = nil;
        }
        header_exist = [[NSMutableArray arrayWithObjects:
                         @"F",
                         @"F",
                         @"F",
                         @"F",
                         @"F",
                         nil] retain];
        
        [all_items_data removeAllObjects];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"LP"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"SAR"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"PBC"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"QS"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"GPO"];
        [all_items_data setValue:[[NSMutableArray new] autorelease] forKey:@"YRO"];
        
        [self.itemname_listCreditCard removeAllObjects];
        
        Bookmark *bookmark_data = [[Bookmark alloc] init];
        NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data:%@", bookmark_data);
        
        int no_record = TRUE;
        for (int i=0; i<9; i++) {
            if (i == 0 || i == 1 || i == 8) {
                continue;
            }
            if ([[bookmark_data listOfferIdInGroup:i] length]>0) {
                no_record = FALSE;
            }
        }
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 2:%@", bookmark_data);
        if (no_record) {
            //		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No bookmark stored",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            //		[alert show];
            //		[alert release];
            result.text = NSLocalizedString(@"No bookmark stored",nil);
            [result setHidden:NO];
            [table_view reloadData];
        } else {
            [result setHidden:YES];
        }
        if ([[bookmark_data listOfferIdInGroup:2] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:2]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@beamerchantlist.api?id=%@&qs=false&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:2],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 2:%@", urlstr);
            asi_request_yro =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_yro.delegate = self;
            NSLog(@"%@",asi_request_yro.url);
            [[CoreData sharedCoreData].queue addOperation:asi_request_yro];
        }
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 6:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:3] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:3]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@latestpromotions.api?id=%@&type=CIH&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:3],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 3:%@", urlstr);
            asi_request_qs =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_qs.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_qs];
        }
        
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 7:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:4] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:4]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@latestpromotions.api?id=%@&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:4],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 4:%@", urlstr);
            asi_request_lp =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_lp.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_lp];
        }
        
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 8:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:5] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:5]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@spending.api?id=%@&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:5],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 5:%@", urlstr);
            asi_request_sar =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_sar.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_sar];
        }
        
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 9:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:6] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:6]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@pbconcert.api?id=%@&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:6],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 6:%@", urlstr);
            asi_request_pbc =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_pbc.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_pbc];
        }
        
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 10:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:7] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:7]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@globepass.api?id=%@&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:7],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 7:%@", urlstr);
            asi_request_gpo =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_gpo.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_gpo];
        }
        [bookmark_data release];
    }
    else {
        //setup & clear
        if (header_exist) {
            [header_exist removeAllObjects];
            [header_exist release];
            header_exist = nil;
        }
        header_exist = [[NSMutableArray arrayWithObjects:
                         @"F",
                         @"F",
                         @"F",
                         @"F",
                         @"F",
                         nil] retain];
        
        [all_items_data removeAllObjects];
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
        
        [self.itemname_listCreditCard removeAllObjects];
        [self.itemname_listATM removeAllObjects];
        [self.itemname_listprivileges removeAllObjects];
        [self.itemname_listLoans removeAllObjects];
        [self.itemname_listGold removeAllObjects];
        
   //     [table_view reloadData];
        
        Bookmark *bookmark_data = [[Bookmark alloc] init];
        NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data:%@", bookmark_data);
        
        int no_record = TRUE;
        for (int i=0; i<10; i++) {
            if ([[bookmark_data listOfferIdInGroup:i] length]>0) {
                no_record = FALSE;
            }
        }
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 2:%@", bookmark_data);
        if (no_record) {
            //		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No bookmark stored",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            //		[alert show];
            //		[alert release];
            result.text = NSLocalizedString(@"No bookmark stored",nil);
            [result setHidden:NO];
            [table_view reloadData];
        } else {
            [result setHidden:YES];
        }
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 3:%@", bookmark_data);
        
        //    [[CoreData sharedCoreData].queue cancelAllOperations];
        
        if ([[bookmark_data listOfferIdInGroup:0] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:0]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@getbranch.api?idlist=%@&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURL,
                                [bookmark_data listOfferIdInGroup:0],
                                [[LangUtil me] getLangID],
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 0:%@", urlstr);
            asi_request_atm =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_atm.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_atm];
        }
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 4:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:1] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:1]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@getinfo.api?idlist=%@&lang=%@&UDID=%@&type=10",
                                [CoreData sharedCoreData].realServerURL,
                                [bookmark_data listOfferIdInGroup:1],
                                [[LangUtil me] getLangID],
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 1:%@", urlstr);
            asi_request_pri =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_pri.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_pri];
        }
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 5:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:2] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:2]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@beamerchantlist.api?id=%@&qs=false&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:2],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 2:%@", urlstr);
            asi_request_yro =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_yro.delegate = self;
            NSLog(@"%@",asi_request_yro.url);
            [[CoreData sharedCoreData].queue addOperation:asi_request_yro];
        }
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 6:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:3] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:3]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@latestpromotions.api?id=%@&type=CIH&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:3],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 3:%@", urlstr);
            asi_request_qs =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_qs.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_qs];
        }
        
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 7:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:4] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:4]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@latestpromotions.api?id=%@&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:4],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 4:%@", urlstr);
            asi_request_lp =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_lp.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_lp];
        }
        
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 8:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:5] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:5]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@spending.api?id=%@&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:5],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 5:%@", urlstr);
            asi_request_sar =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_sar.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_sar];
        }
        
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 9:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:6] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:6]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@pbconcert.api?id=%@&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:6],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 6:%@", urlstr);
            asi_request_pbc =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_pbc.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_pbc];
        }
        
        //    NSLog(@"debug FavouriteListViewController generateBookmark, bookmark_data 10:%@", bookmark_data);
        
        if ([[bookmark_data listOfferIdInGroup:7] length]>0) {
            NSLog(@"id list: %@",[bookmark_data listOfferIdInGroup:7]);
            [[CoreData sharedCoreData].mask showMask];
            NSString* urlstr = [NSString stringWithFormat:
                                @"%@globepass.api?id=%@&lang=%@&UDID=%@",
                                [CoreData sharedCoreData].realServerURLCard,
                                [bookmark_data listOfferIdInGroup:7],
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 7:%@", urlstr);
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
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 8:%@", urlstr);
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
                                [CoreData sharedCoreData].lang,
                                [CoreData sharedCoreData].UDID];
            NSLog(@"debug FavouriteListViewController request 9:%@", urlstr);
            asi_request_sg =[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
            asi_request_sg.delegate = self;
            [[CoreData sharedCoreData].queue addOperation:asi_request_sg];
        }
        [bookmark_data release];
    }
}

-(void)enableEdit {
	table_view.editing = TRUE;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(disableEdit)] autorelease];
}

-(void)disableEdit {
	table_view.editing = FALSE;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(enableEdit)] autorelease];
}

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
    
	NSLog(@"debug FavouriteListViewController response begin ===============================");
	NSLog(@"debug FavouriteListViewController response parsing_type: %d",parsing_type);
//	NSLog(@"debug FavouriteListViewController response string:%@",[request responseString]);
	NSLog(@"debug FavouriteListViewController response end ===============================");
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[[CoreData sharedCoreData].mask hiddenMask];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"FavouriteListViewController requestFailed:%@", request.error);

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
	
}

///////////////////
//UITableDelegate
///////////////////
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    if (isCreditCardBookmark) {
        if ([self.itemname_listCreditCard count] != 0) {
            table_view.frame = CGRectMake(0.0, 0.0, 298, self.itemname_listCreditCard.count * 41 + 30);
            scrollView.contentSize = CGSizeMake(298, self.itemname_listCreditCard.count * 41 + 30);
            return 1;
        }
        return 0;
    }
    else {
        table_view.frame = CGRectMake(0.0, 0.0, 298, (self.itemname_listCreditCard.count + self.itemname_listATM.count +self.itemname_listprivileges.count + self.itemname_listLoans.count + self.itemname_listGold.count) * 41 + [self numberOfheadExist] * 30);
        scrollView.contentSize = CGSizeMake(298, (self.itemname_listCreditCard.count + self.itemname_listATM.count +self.itemname_listprivileges.count + self.itemname_listLoans.count + self.itemname_listGold.count) * 41 + [self numberOfheadExist] * 30);
        return [self.groupname_list count];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (isCreditCardBookmark) {
        return 30;
    }
    else {
        if ([[header_exist objectAtIndex:section] isEqualToString:@"T"]) {
            return 30;
        } else {
            return 0;
        }
    }
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@"section is %d", section);
    if (isCreditCardBookmark) {
        return NSLocalizedString(@"Credit Card",nil);
    }
    else {
        return [self.groupname_list objectAtIndex:section];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 30.0)] autorelease];
    customView.backgroundColor = [UIColor whiteColor];
    
    UILabel * headerLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    headerLabel.frame = CGRectMake(10.0, 0.0, 290.0, 30.0);
    if (isCreditCardBookmark) {
        headerLabel.text = NSLocalizedString(@"Credit Card",nil);
    }
    else {
        headerLabel.text = [self.groupname_list objectAtIndex:section];
    }
    
    [customView addSubview:headerLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 29.0, 300.0, 1.0)];
    imageView.image = [UIImage imageNamed:@"borderlist_line.png"];
    [customView addSubview:imageView];
    
    return customView;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        return 101;
//    }
	return 41;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if (self.itemname_listCreditCard.count == 0) {
        table.separatorStyle =  UITableViewCellSeparatorStyleNone;
    }
    if (self.itemname_listCreditCard.count > 0) {
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    if (isCreditCardBookmark) {
        if ([self.itemname_listCreditCard count] == 0) {
            return 0;
        }
        return [self.itemname_listCreditCard count];
    }
    else {
        switch (section) {
            case 4:
                //      NSLog(@"bea2 self.itemname_listCreditCard : %@", self.itemname_listCreditCard);
                if ([self.itemname_listCreditCard count] == 0) {
                    return 0;
                }
                return [self.itemname_listCreditCard count];
                break;
            case 3:
                return [self.itemname_listATM count];
                break;
            case 2:
                return [self.itemname_listprivileges count];
                break;
            case 1:
                return [self.itemname_listLoans count];
                break;
            case 0:
                return [self.itemname_listGold count];
                break;
        }
    }
	return 0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = @"CustomCell";
	CustomCell *cell;

    if (isCreditCardBookmark) {
        ATMDistCellCMS *cell = [[ATMDistCellCMS alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:1];
        if ([self.itemname_listCreditCard count] == 0) {
            return cell;
        }
        NSLog(@"bea3 self.itemname_listCreditCard : %@", self.itemname_listCreditCard);
        NSLog(@"indexPath: row %d,  section %d", indexPath.row, indexPath.section);
        cell.title_label.text = [self.itemname_listCreditCard objectAtIndex:indexPath.row];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 41-1, cell.frame.size.width, 1)];
        label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
        [cell addSubview:label];
        return cell;
    }
    else {
        switch (indexPath.section) {
            case 4:
            {
                //            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                ATMDistCellCMS *cell = [[ATMDistCellCMS alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:1];
                if ([self.itemname_listCreditCard count] == 0) {
                    return cell;
                }
                NSLog(@"bea3 self.itemname_listCreditCard : %@", self.itemname_listCreditCard);
                NSLog(@"indexPath: row %d,  section %d", indexPath.row, indexPath.section);
                cell.title_label.text = [self.itemname_listCreditCard objectAtIndex:indexPath.row];
                //            cell.textLabel.text = [self.itemname_listCreditCard objectAtIndex:indexPath.row];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 41-1, cell.frame.size.width, 1)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [cell addSubview:label];
                return cell;
                
            }
                break;
            case 3:
            {
                ATMDistCellCMS *cell = [[ATMDistCellCMS alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:1];
                if ([self.itemname_listATM count] == 0) {
                    return cell;
                }
                cell.title_label.text = [self.itemname_listATM objectAtIndex:indexPath.row];
                //            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault           reuseIdentifier:identifier];
                //            cell.textLabel.text = [self.itemname_listATM objectAtIndex:indexPath.row];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 41-1, cell.frame.size.width, 1)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [cell addSubview:label];
                return cell;
            }
                break;
            case 2:
            {
                
                ATMDistCellCMS *cell = [[ATMDistCellCMS alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:1];
                if ([self.itemname_listprivileges count] == 0) {
                    return cell;
                }
                cell.title_label.text = [self.itemname_listprivileges objectAtIndex:indexPath.row];
                //            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                //            cell.textLabel.text = [self.itemname_listprivileges objectAtIndex:indexPath.row];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 41-1, cell.frame.size.width, 1)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [cell addSubview:label];
                
                return cell;
            }
                break;
            case 1:
            {
                
                ATMDistCellCMS *cell = [[ATMDistCellCMS alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:1];
                if ([self.itemname_listLoans count] == 0) {
                    return cell;
                }
                cell.title_label.text = [self.itemname_listLoans objectAtIndex:indexPath.row];
                //            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                //            cell.textLabel.text = [self.itemname_listprivileges objectAtIndex:indexPath.row];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 41-1, cell.frame.size.width, 1)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [cell addSubview:label];
                return cell;
            }
                break;
            case 0:
            {
                
                ATMDistCellCMS *cell = [[ATMDistCellCMS alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:1];
                if ([self.itemname_listGold count] == 0) {
                    return cell;
                }
                cell.title_label.text = [self.itemname_listGold objectAtIndex:indexPath.row];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 41-1, cell.frame.size.width, 1)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                [cell addSubview:label];
                return cell;
            }
                break;
        }
    }

	return cell;
}

-(void)viewDidLayoutSubviews

{
    
    if ([table_view respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [table_view setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        
    }
    
    
    
    if ([table_view respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [table_view setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    NSLog(@"debug didSelectRowAtIndexPath  : %d",indexPath.row);
    
    FavouriteListViewController2 *favouriteListView = [[FavouriteListViewController2 alloc] initWithNibName:@"FavouriteListView2" bundle:nil];
    favouriteListView.caller = self;

    if (isCreditCardBookmark) {
        favouriteListView.groupname = [self.itemname_listCreditCard objectAtIndex:indexPath.row];
    }
    else {
        if (indexPath.section==4) {
            favouriteListView.groupname = [self.itemname_listCreditCard objectAtIndex:indexPath.row];
        } else if (indexPath.section==3) {
            favouriteListView.groupname = [self.itemname_listATM objectAtIndex:indexPath.row];
        } else if (indexPath.section==2) {
            favouriteListView.groupname = [self.itemname_listprivileges objectAtIndex:indexPath.row];
            favouriteListView.fromType = @"Pri";
        } else if (indexPath.section==1) {
            favouriteListView.groupname = [self.itemname_listLoans objectAtIndex:indexPath.row];
            favouriteListView.fromType = @"CL";
        } else if (indexPath.section==0) {
            favouriteListView.groupname = [self.itemname_listGold objectAtIndex:indexPath.row];
            favouriteListView.fromType = @"SG";
        }
    }
    
    NSLog(@"debug didSelectRowAtIndexPath  : %@",favouriteListView.groupname);
    
    [self.navigationController pushViewController:favouriteListView animated:TRUE];
    [favouriteListView release];
}

-(NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return NSLocalizedString(@"Delete",nil);
}

//-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//		NSLog(@"Delete section:%d row:%d",indexPath.section, indexPath.row);
//		Bookmark *bookmark_data = [[Bookmark alloc] init];
//		switch (indexPath.section) {
//            case 0:
//				[bookmark_data removeBookmark:[[all_items_data objectForKey:@"ATM"] objectAtIndex:indexPath.row] InGroup:0];
//				[[all_items_data objectForKey:@"ATM"] removeObjectAtIndex:indexPath.row];
//				break;
//			case 1:
//				[bookmark_data removeBookmark:[[all_items_data objectForKey:@"PRI"] objectAtIndex:indexPath.row] InGroup:1];
//				[[all_items_data objectForKey:@"PRI"] removeObjectAtIndex:indexPath.row];
//				break;
//			case 2:
//				[bookmark_data removeBookmark:[[all_items_data objectForKey:@"YRO"] objectAtIndex:indexPath.row] InGroup:2];
//				[[all_items_data objectForKey:@"YRO"] removeObjectAtIndex:indexPath.row];
//				break;
//			case 3:
//				[bookmark_data removeBookmark:[[all_items_data objectForKey:@"QS"] objectAtIndex:indexPath.row] InGroup:3];
//				[[all_items_data objectForKey:@"QS"] removeObjectAtIndex:indexPath.row];
//				break;
//			case 4:
//				[bookmark_data removeBookmark:[[all_items_data objectForKey:@"LP"] objectAtIndex:indexPath.row] InGroup:4];
//				[[all_items_data objectForKey:@"LP"] removeObjectAtIndex:indexPath.row];
//				break;
//			case 5:
//				[bookmark_data removeBookmark:[[all_items_data objectForKey:@"SAR"] objectAtIndex:indexPath.row] InGroup:5];
//				[[all_items_data objectForKey:@"SAR"] removeObjectAtIndex:indexPath.row];
//				break;
//			case 6:
//				[bookmark_data removeBookmark:[[all_items_data objectForKey:@"PBC"] objectAtIndex:indexPath.row] InGroup:6];
//				[[all_items_data objectForKey:@"PBC"] removeObjectAtIndex:indexPath.row];
//				break;
//			case 7:
//				[bookmark_data removeBookmark:[[all_items_data objectForKey:@"GPO"] objectAtIndex:indexPath.row] InGroup:7];
//				[[all_items_data objectForKey:@"GPO"] removeObjectAtIndex:indexPath.row];
//				break;
//		}
//		[table_view deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:TRUE];
//		[self generateBookmark];
//		/*int total_result = 0;
//         total_result += [[all_items_data objectForKey:@"YRO"] count];
//         total_result += [[all_items_data objectForKey:@"QS"] count];
//         total_result += [[all_items_data objectForKey:@"LP"] count];
//         total_result += [[all_items_data objectForKey:@"SAR"] count];
//         total_result += [[all_items_data objectForKey:@"PBC"] count];
//         total_result += [[all_items_data objectForKey:@"GPO"] count];
//         result.text = [NSString stringWithFormat:@"%@ %d",NSLocalizedString(@"Bookmark1",nil), total_result];*/
//		
//    }
//}

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
                   nil];
            break;
	}
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	total_page = ceil([items_data count]/(float)current_page_size);
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
	NSLog(@"debug FavouriteListViewController parserDidEndDocument %d merchants",[items_data count]);
//	NSLog(@"debug FavouriteListViewController parserDidEndDocument merchants:%@",items_data);
	Bookmark *bookmark_data = [[Bookmark alloc] init];
	NSArray *id_list = [[bookmark_data listOfferIdInGroup:parsing_type] componentsSeparatedByString:@","];
    NSLog(@"debug FavouriteListViewController parserDidEndDocument id_list:%@",id_list);
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
//		[header_exist replaceObjectAtIndex:parsing_type withObject:@"T"];
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
    [self.itemname_listCreditCard removeAllObjects];
    [self.itemname_listATM removeAllObjects];
    [self.itemname_listprivileges removeAllObjects];
    [self.itemname_listLoans removeAllObjects];
    [self.itemname_listGold removeAllObjects];
    
    if ([[all_items_data objectForKey:@"LP"] count]!=0) {
        [self.itemname_listCreditCard addObject:  NSLocalizedString(@"Latest Promotions-fav",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"T"];
    }
    if ([[all_items_data objectForKey:@"SAR"] count]!=0) {
        //        [self.itemname_listCreditCard addObject:  NSLocalizedString(@"Spending & Rewards",nil)];
        [self.itemname_listCreditCard addObject:  NSLocalizedString(@"Rewards",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"T"];
    }
    if ([[all_items_data objectForKey:@"PBC"] count]!=0) {
        [self.itemname_listCreditCard addObject:  NSLocalizedString(@"Priority Booking for Concerts-fav",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"T"];
    }
    if ([[all_items_data objectForKey:@"QS"] count]!=0) {
        [self.itemname_listCreditCard addObject:  NSLocalizedString(@"Quarterly Surprise",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"T"];
    }
    if ([[all_items_data objectForKey:@"GPO"] count]!=0) {
        [self.itemname_listCreditCard addObject:  NSLocalizedString(@"GlobePass Offers",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"T"];
    }
    if ([[all_items_data objectForKey:@"YRO"] count]!=0) {
        [self.itemname_listCreditCard addObject:  NSLocalizedString(@"Year-round Offers",nil)];
        [header_exist replaceObjectAtIndex:4 withObject:@"T"];
    }
    
    if ([[all_items_data objectForKey:@"ATM"] count]!=0) {      // To be retested
        for (NSDictionary *itemDic in [all_items_data objectForKey:@"ATM"]) {
            if (itemDic && [[itemDic valueForKey:@"branch_type"] isEqualToString:@"4"] ) {
                if (![self.itemname_listATM containsObject:NSLocalizedString(@"Branch",nil)]) {
                    [self.itemname_listATM addObject: NSLocalizedString(@"Branch",nil)];
                    [header_exist replaceObjectAtIndex:3 withObject:@"T"];
                }
            }
            if (itemDic && [[itemDic valueForKey:@"branch_type"] isEqualToString:@"2"] ) {
                if (![self.itemname_listATM containsObject:NSLocalizedString(@"ATM",nil)]) {
                    [self.itemname_listATM addObject: NSLocalizedString(@"ATM",nil)];
                    [header_exist replaceObjectAtIndex:3 withObject:@"T"];
                }
            }
            if (itemDic && [[itemDic valueForKey:@"branch_type"] isEqualToString:@"5"] ) {
                if (![self.itemname_listATM containsObject:NSLocalizedString(@"SupremeGold Centre",nil)]) {
                    [self.itemname_listATM addObject: NSLocalizedString(@"SupremeGold Centre",nil)];
                    [header_exist replaceObjectAtIndex:3 withObject:@"T"];
                }
            }
            if (itemDic && [[itemDic valueForKey:@"branch_type"] isEqualToString:@"3"] ) {
                if (![self.itemname_listATM containsObject:NSLocalizedString(@"i-Financial center",nil)]) {
                    [self.itemname_listATM addObject: NSLocalizedString(@"i-Financial center",nil)];
                    [header_exist replaceObjectAtIndex:3 withObject:@"T"];
                }
            }
        }
        NSMutableArray *sortArray = [NSMutableArray array];
        if ([self.itemname_listATM containsObject:NSLocalizedString(@"i-Financial center",nil)]) {
            [sortArray insertObject:NSLocalizedString(@"i-Financial center",nil) atIndex:0];
        }
        if ([self.itemname_listATM containsObject:NSLocalizedString(@"SupremeGold Centre",nil)]) {
            [sortArray insertObject:NSLocalizedString(@"SupremeGold Centre",nil) atIndex:0];
        }
        if ([self.itemname_listATM containsObject:NSLocalizedString(@"ATM",nil)]) {
            [sortArray insertObject:NSLocalizedString(@"ATM",nil) atIndex:0];
        }
        if ([self.itemname_listATM containsObject:NSLocalizedString(@"Branch",nil)]) {
            [sortArray insertObject:NSLocalizedString(@"Branch",nil) atIndex:0];
        }
        self.itemname_listATM = [sortArray mutableCopy];
//        [self.itemname_listATM addObject:  NSLocalizedString(@"ATM Location",nil)];
//        [header_exist replaceObjectAtIndex:1 withObject:@"T"];
    }
    if ([[all_items_data objectForKey:@"PRI"] count]!=0) {
        [self.itemname_listprivileges addObject:  NSLocalizedString(@"Offers",nil)];
        [header_exist replaceObjectAtIndex:2 withObject:@"T"];
    }
    if ([[all_items_data objectForKey:@"CL"] count]!=0) {
        [self.itemname_listLoans addObject:  NSLocalizedString(@"Consumer Loans-fav",nil)];
        [header_exist replaceObjectAtIndex:1 withObject:@"T"];
    }
    if ([[all_items_data objectForKey:@"SG"] count]!=0) {
        [self.itemname_listGold addObject:  NSLocalizedString(@"Supreme Gold-fav",nil)];
        [header_exist replaceObjectAtIndex:0 withObject:@"T"];
    }
    NSLog(@"debug parserDidEndDocument credit cards:%@",self.itemname_listCreditCard);
    NSLog(@"debug parserDidEndDocument branch&atm  :%@",self.itemname_listATM);
    NSLog(@"debug parserDidEndDocument privileges  :%@",self.itemname_listprivileges);
    NSLog(@"debug parserDidEndDocument privileges  :%@",self.itemname_listLoans);
    NSLog(@"debug parserDidEndDocument privileges  :%@",self.itemname_listGold);
    
	[table_view reloadData];
    
	int total_result = 0;
	total_result += [self.itemname_listprivileges count];
	total_result += [self.itemname_listATM count];
	total_result += [self.itemname_listCreditCard count];
    total_result += [self.itemname_listLoans count];
    total_result += [self.itemname_listGold count];
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
	} else if ([elementName isEqualToString:@" "]) {
		temp_pdt_list = [NSMutableArray new];
	}
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    [self fixspace:@"id"];
    [self fixspace:@"image"];
    [self fixspace:@"title"];
    [self fixspace:@"tel"];
    [self fixspace:@"tel_label"];
    [self fixspace:@"thumb"];
    [self fixspace:@"url"];
    [self fixspace:@"url_label"];
    [self fixspace:@"pdf_url"];
    [self fixspace:@"tnc_label"];

	if ([elementName isEqualToString:@"item"]) {
		[items_data addObject:temp_record];
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
	} else if ([currentElementName isEqualToString:@"image"] && parsing_type!=0 && parsing_type!=1) {
		if ([string length]>4) {
			[temp_image_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"coorganiser"]) {
		if ([string length]>4) {
			NSLog(@"Add coorganiser");
			[temp_coorganisers_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"sponsor"]) {
		if ([string length]>4) {
			NSLog(@"Add title sponsor");
			[temp_pb_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"management"]) {
		if ([string length]>4) {
			NSLog(@"Add management");
			[temp_mgt_list addObject:string];
		}
	} else if ([currentElementName isEqualToString:@"production"]) {
		if ([string length]>4) {
			NSLog(@"Add production");
			[temp_pdt_list addObject:string];
		}
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
        [akey isEqualToString:@"pdf_url"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    } else if (![akey isEqualToString:@"title"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    //    NSLog(@"debug fixspace end:[%@]--[%@]", akey, value);
    [temp_record setObject:value forKey:akey];
    return;
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [[MoreMenuUtil me] setMoreMenuViews4Common];
//}
-(IBAction)backToHomePressed:(UIButton *)button {
    [[MoreMenuUtil me] setMoreMenuViews4Common];
}
- (IBAction)doMenuButtonsPressed:(UIButton *)sender
{
    switch (sender.tag) {
        case 2:
            NSLog(@"back");
            [self backToHomePressed:sender];
            break;
            
        default:
            break;
    }
    
}

- (int)numberOfheadExist {
    int headNum = 0;
    for (NSString *str in header_exist) {
        if ([@"T" isEqualToString:str]) {
            headNum ++;
        }
    }
    return headNum;
}
@end
