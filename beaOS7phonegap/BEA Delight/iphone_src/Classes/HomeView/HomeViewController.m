//
//  HomeViewController.m
//  Citibank Card Offer
//
//  Created by Algebra Lo on 10年3月2日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        [CoreData sharedCoreData].home_view_controller = self;
        record_updated = FALSE;
        current_lastpublish = nil;
        current_checksum = nil;
        currentCat = @"";
        currentSubCat = @"";
        temp_record_number_data_dic = [PlistOperator openPlistFile:@"checkUpdateData" Datatype:@"NSDictionary"];
        NSLog(@"debug HomeViewController temp_record_number_data:%@", temp_record_number_data);
        record_number_data = [NSMutableDictionary new];
        [record_number_data setValue:[NSMutableDictionary new] forKey:@"YRO"];
        [[record_number_data objectForKey:@"YRO"] setValue:[[temp_record_number_data_dic objectForKey:@"YRO"] objectForKey:@"checked"] forKey:@"checked"];
        NSLog(@"debug HomeViewController record_number_data:%@", record_number_data);
        NSArray *key = [[temp_record_number_data_dic objectForKey:@"YRO"] allKeys];
        for (int i=0; i<[key count]; i++) {
            if (![[key objectAtIndex:i] isEqualToString:@"checked"]) {
                [[record_number_data objectForKey:@"YRO"] setValue:[NSMutableDictionary dictionaryWithDictionary:[[temp_record_number_data_dic objectForKey:@"YRO"] objectForKey:[key objectAtIndex:i]]] forKey:[key objectAtIndex:i]];
            } else {
                [[record_number_data objectForKey:@"YRO"] setValue:[[temp_record_number_data_dic objectForKey:@"YRO"] objectForKey:@"checked"] forKey:@"checked"];
            }
            
        }
        key = [temp_record_number_data_dic allKeys];
        for (int i=0; i<[key count]; i++) {
            if ([[key objectAtIndex:i] isEqualToString:@"lastpublish"]) {
                [record_number_data setValue:[temp_record_number_data_dic objectForKey:@"lastpublish"] forKey:@"lastpublish"];
            } else if ([[key objectAtIndex:i] isEqualToString:@"checksum"]) {
                [record_number_data setValue:[temp_record_number_data_dic objectForKey:@"checksum"] forKey:@"checksum"];
            } else if (![[key objectAtIndex:i] isEqualToString:@"YRO"]) {
                [record_number_data setValue:[NSMutableDictionary dictionaryWithDictionary:[temp_record_number_data_dic objectForKey:[key objectAtIndex:i]]] forKey:[key objectAtIndex:i]];
            }
        }
        
        //record_number_data = [[NSMutableDictionary dictionaryWithDictionary:[PlistOperator openPlistFile:@"checkUpdateData" Datatype:@"NSDictionary"]] retain];
        getting = 0;
        
    }
    _bottombanner.frame = CGRectMake(0, 397+[[MyScreenUtil me] getScreenHeightAdjust], 320, 63);
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    [[MyScreenUtil me] adjustModuleView:self.view];
    
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    [v_rmvc.rmUtil setNav:self.navigationController];
    [self.view addSubview:v_rmvc.contentView];
    v_rmvc.vc_caller = self;
}

//edit by chu 20150223
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.creditCardTitle.text = NSLocalizedString(@"creditcardtitle",nil);
    self.creditCardTitle.accessibilityLabel = NSLocalizedString(@"creditcardtitle",nil);
    
    //    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    _bottombanner.frame = CGRectMake(0, 397+[[MyScreenUtil me] getScreenHeightAdjust], 320, 63);
    //edit by chu 20150224
    _bottombanner.isAccessibilityElement = NO;
    _bottombanner.accessibilityTraits = UIAccessibilityTraitNone;
    
    NSArray *title_list = [NSLocalizedString(@"Title",nil) componentsSeparatedByString:@","];
    label0.text = [title_list objectAtIndex:0];
    label1.text = [title_list objectAtIndex:1];
    label2.text = [title_list objectAtIndex:2];
    label3.text = [title_list objectAtIndex:3];
    label4.text = [title_list objectAtIndex:4];
    label5.text = [title_list objectAtIndex:5];
    fundLabel.text = [title_list objectAtIndex:6];
    [self reloadNew];
    
    NSArray *title_list_accessibility = [NSLocalizedString(@"Title_accessibility",nil) componentsSeparatedByString:@","];
    button0.accessibilityLabel = NSLocalizedString([title_list_accessibility objectAtIndex:0], nil);
    button1.accessibilityLabel = NSLocalizedString([title_list_accessibility objectAtIndex:1], nil);
    button2.accessibilityLabel = NSLocalizedString([title_list_accessibility objectAtIndex:2], nil);
    button3.accessibilityLabel = NSLocalizedString([title_list_accessibility objectAtIndex:3], nil);
    button4.accessibilityLabel = NSLocalizedString([title_list_accessibility objectAtIndex:4], nil);
    button5.accessibilityLabel = NSLocalizedString([title_list_accessibility objectAtIndex:5], nil);
    
    //edit by chu 20150224
    label0.isAccessibilityElement = NO;
    label1.isAccessibilityElement = NO;
    label2.isAccessibilityElement = NO;
    label3.isAccessibilityElement = NO;
    label4.isAccessibilityElement = NO;
    label5.isAccessibilityElement = NO;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

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
    [fundLabel release];
    fundLabel = nil;
    [self setBottombanner:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    NSLog(@"HomeViewController dealloc");
    [record_number_data release];
    [_bottombanner release];
    [fundLabel release];
    [super dealloc];
}

-(IBAction)buttonPressed:(UIButton *)button {
    //    NSLog(@"debug HomeViewController buttonPressed:%@", self);
    NSLog(@"debug HomeViewController buttonPressed button:%d", button.tag);
    //    NSLog(@"debug HomeViewController buttonPressed record_number_data:%@", record_number_data);
    BOOL isAnimate = YES;
    //    if ([[CoreData sharedCoreData].menuType isEqualToString:@"2"]) {
    isAnimate = NO;
    //    }
    
    UIViewController *view_controller;
    switch (button.tag) {
        case 0:
        case 10:
            [[record_number_data objectForKey:@"YRO"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
            [badge0 setNumber:0];
            //            [CoreData sharedCoreData].lastScreen=@"YearRoundOffersView";
            view_controller = [[YearRoundOffersViewController alloc] initWithNibName:@"YearRoundOffersView" bundle:nil];
            ((YearRoundOffersViewController *)view_controller).record_number_data = record_number_data;
            [((YearRoundOffersViewController *)view_controller) shoppingButtonPressed:Nil];
            //			[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:isAnimate];
            [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
            NSLog(@"%@",NSStringFromCGRect(view_controller.view.frame));
            [view_controller release];
            break;
            
        case 11:
            [[record_number_data objectForKey:@"YRO"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
            [badge0 setNumber:0];
            view_controller = [[YearRoundOffersViewController alloc] initWithNibName:@"YearRoundOffersView" bundle:nil];
            ((YearRoundOffersViewController *)view_controller).record_number_data = record_number_data;
            [((YearRoundOffersViewController *)view_controller) setShowShopping: true];
            [((YearRoundOffersViewController *)view_controller) shoppingButtonPressed:Nil];
            //			[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:isAnimate];
            [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
//            [view_controller release];
            break;
        case 12:
            view_controller = [[ICouponMenuViewController alloc] initWithNibName:@"ICouponMenuViewController" bundle:nil];
            [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
            [view_controller release];
            break;
        case 1:
            //QS or LP
            [[record_number_data objectForKey:@"LP"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
            [badge1 setNumber:0];
            if ([[[record_number_data objectForKey:@"LP"] objectForKey:@"total"] intValue]==0) {
                view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
            } else {
                view_controller = [[CardLoanListViewController alloc] initWithNibName:@"CardLoanListView" bundle:nil];
                //				[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:isAnimate];
                [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
                [(CardLoanListViewController *)view_controller getItemsList];
            }
            [view_controller release];
            break;
            //
        case 2:
            [[record_number_data objectForKey:@"LP"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
            [badge2 setNumber:0];
            if ([[[record_number_data objectForKey:@"LP"] objectForKey:@"total"] intValue]==0) {
                view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
            } else {
                view_controller = [[LatestPromotionsListViewController alloc] initWithNibName:@"LatestPromotionsListView" bundle:nil];
                //				[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:isAnimate];
                [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
                [(LatestPromotionsListViewController *)view_controller getItemsList];
            }
            [view_controller release];
            break;
        case 3:
            [[record_number_data objectForKey:@"SP"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
            [badge3 setNumber:0];
            if ([[[record_number_data objectForKey:@"SP"] objectForKey:@"total"] intValue]==0) {
                view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:isAnimate];
            } else {
                view_controller = [[SpendingRewardsListViewController alloc] initWithNibName:@"SpendingRewardsListView" bundle:nil];
                //				[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:isAnimate];
                [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
                [(SpendingRewardsListViewController *)view_controller getItemsList];
            }
            [view_controller release];
            break;
        case 4:
            [[record_number_data objectForKey:@"PB"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
            [badge4 setNumber:0];
            if ([[[record_number_data objectForKey:@"PB"] objectForKey:@"total"] intValue]==0) {
                view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:isAnimate];
            } else {
                view_controller = [[PBConcertsListViewController alloc] initWithNibName:@"PBConcertsListView" bundle:nil];
                //				[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:isAnimate];
                [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
                [(PBConcertsListViewController *)view_controller getItemsList];
            }
            [view_controller release];
            break;
        case 5:
            [[record_number_data objectForKey:@"GP"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
            [badge5 setNumber:0];
            //			if ([[[record_number_data objectForKey:@"GP"] objectForKey:@"total"] intValue]==0) {
            //				view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
            //				[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:isAnimate];
            //			} else {
            view_controller = [[GlobePassListViewController alloc] initWithNibName:@"GlobePassListView" bundle:nil];
            //				[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:NO];
            [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:view_controller animated:NO];
            [(GlobePassListViewController *)view_controller getItemsList];
            //			}
            [view_controller release];
            break;
        case 6:
        {
            BEAAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            if (delegate.isClick == YES) {
                delegate.isClick = NO;
            }
            NearBySearchListViewController* current_view_controller = [[NearBySearchListViewController alloc] initWithNibName:@"NearBySearchListView" bundle:nil];
            //            NSArray *navVC1 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
            //            NSArray *navVC2 = [MoreMenuUtil me].nav4process.viewControllers;
            //            NSArray *navVC3 = [MoreMenuUtil me].creditCardNav.viewControllers;
            //			[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:current_view_controller animated:NO];
            //            [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:current_view_controller animated:NO];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            [current_view_controller release];
        }
            break;
        case 7:
        {
            BEAAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            if (delegate.isClick == YES) {
                delegate.isClick = NO;
            }
//            if ([CoreData sharedCoreData].root_view_controller.current_view_controller != nil) {
//                [CoreData sharedCoreData].main_view_controller.delegate = nil;
//                [[CoreData sharedCoreData].root_view_controller.current_view_controller release];
//                [CoreData sharedCoreData].root_view_controller.current_view_controller = nil;
//            }
            AdvanceSearchViewController* current_view_controller = [[AdvanceSearchViewController alloc] initWithNibName:@"AdvanceSearchView" bundle:nil];
            //            NSArray *navVC1 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
            //            NSArray *navVC2 = [MoreMenuUtil me].nav4process.viewControllers;
            //            NSArray *navVC3 = [MoreMenuUtil me].creditCardNav.viewControllers;
            //			[[CoreData sharedCoreData].root_view_controller.navigationController  pushViewController:current_view_controller animated:NO];
            //            [[CoreData sharedCoreData].home_view_controller.navigationController pushViewController:current_view_controller animated:NO];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            [current_view_controller release];
        }
            break;
        case 22:
        {
            [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:button];
        }
            break;
            
    }
    [PlistOperator savePlistFile:@"checkUpdateData" From:record_number_data];
    //	[(RootViewController *)[CoreData sharedCoreData].root_view_controller setContent:button.tag];
}

-(IBAction)backToHomePressed:(UIButton *)button {
    NSLog(@"debug HomeViewController backToHomePressed", nil);
    //	[UIView beginAnimations:nil context:NULL];
    //	[UIView setAnimationDuration:0.5];
    //	[CoreData sharedCoreData].delight_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    //    [[CoreData sharedCoreData].delight_view_controller.navigationController popViewControllerAnimated:NO];
    [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
    [CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    //	[UIView commitAnimations];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    [[MoreMenuUtil me] setMoreMenuViews4Common];
}

-(void)reloadNew {
    NSLog(@"reloadNew");
    //Staging
    /*if (getting==0) {
     check_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@api/checkupdate.xml",[CoreData sharedCoreData].realServerURL]]];
     getting = 1;
     } else {
     check_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@api/checkupdate2.xml",[CoreData sharedCoreData].realServerURL]]];
     getting = 0;
     }*/
    
    //Release
    check_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@checkupdate.api",[CoreData sharedCoreData].realServerURLCard]]];
    check_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:check_request];
    [[CoreData sharedCoreData].mask showMask];
    //jeff
    NSLog(@"class: %@, check_request.url: %@", [self class], check_request.url);
    //
}

-(int)getBadgeExist {
    int exist = 0;
    if ([badge0 getNumber]>0) {
        exist++;
    }
    if ([badge1 getNumber]>0) {
        exist++;
    }
    if ([badge2 getNumber]>0) {
        exist++;
    }
    if ([badge3 getNumber]>0) {
        exist++;
    }
    if ([badge4 getNumber]>0) {
        exist++;
    }
    if ([badge5 getNumber]>0) {
        exist++;
    }
    return exist;
}

///////////////////////
//ASIHTTPRequest
///////////////////////
-(void)requestFinished:(ASIHTTPRequest *)request {
    //    NSLog(@"HomeViewController requestFinished:%@",[request responseString]);
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
    xml_parser.delegate = self;
    [xml_parser parse];
    
    if ([[[record_number_data objectForKey:@"YRO"] objectForKey:@"checked"] boolValue]) {
        [badge0 setNumber:0];
    } else {
        int total_new = 0;
        //NSLog(@"Added total %@",[[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] objectForKey:@"new"]);
        NSArray *key = [[record_number_data objectForKey:@"YRO"] allKeys];
        for (int i=0; i<[key count]; i++) {
            if ([[key objectAtIndex:i] isEqualToString:@"checked"]) {
            } else {
                if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:[key objectAtIndex:i]] objectForKey:@"new"] intValue]>0) {
                    total_new++;
                }
            }
        }
        [badge0 setNumber:total_new];
    }
    /*NSLog(@"%@",[[record_number_data objectForKey:@"QS"] objectForKey:@"new"]);
     NSLog(@"%@",[[record_number_data objectForKey:@"LP"] objectForKey:@"new"]);
     NSLog(@"%@",[[record_number_data objectForKey:@"SP"] objectForKey:@"new"]);
     NSLog(@"%@",[[record_number_data objectForKey:@"PB"] objectForKey:@"new"]);
     NSLog(@"%@",[[record_number_data objectForKey:@"GP"] objectForKey:@"new"]);*/
    if (![[[record_number_data objectForKey:@"QS"] objectForKey:@"checked"] boolValue] && [[[record_number_data objectForKey:@"QS"] objectForKey:@"new"] intValue]>0) {
        [badge1 setNumber:[[[record_number_data objectForKey:@"QS"] objectForKey:@"new"] intValue]];
    }
    if (![[[record_number_data objectForKey:@"LP"] objectForKey:@"checked"] boolValue] && [[[record_number_data objectForKey:@"LP"] objectForKey:@"new"] intValue]>0) {
        [badge2 setNumber:[[[record_number_data objectForKey:@"LP"] objectForKey:@"new"] intValue]];
    }
    if (![[[record_number_data objectForKey:@"SP"] objectForKey:@"checked"] boolValue] && [[[record_number_data objectForKey:@"SP"] objectForKey:@"new"] intValue]>0) {
        [badge3 setNumber:[[[record_number_data objectForKey:@"SP"] objectForKey:@"new"] intValue]];
    }
    if (![[[record_number_data objectForKey:@"PB"] objectForKey:@"checked"] boolValue] && [[[record_number_data objectForKey:@"PB"] objectForKey:@"new"] intValue]>0) {
        [badge4 setNumber:[[[record_number_data objectForKey:@"PB"] objectForKey:@"new"] intValue]];
    }
    if (![[[record_number_data objectForKey:@"GP"] objectForKey:@"checked"] boolValue] && [[[record_number_data objectForKey:@"GP"] objectForKey:@"new"] intValue]>0) {
        [badge5 setNumber:[[[record_number_data objectForKey:@"GP"] objectForKey:@"new"] intValue]];
    }
    [[CoreData sharedCoreData].mask hiddenMask];
    [request release];
}

-(void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"HomeViewController requestFailed:%@", request.error);
    
    [[CoreData sharedCoreData].mask hiddenMask];
    [request release];
}

///////////////////////
//XMLParserDelegate
///////////////////////
-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Parse error");
}

-(void) parserDidStartDocument:(NSXMLParser *)parser {
    if (current_lastpublish!=nil) {
        [current_lastpublish release];
    }
    current_lastpublish = nil;
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
    if (record_updated) {
        //		[record_number_data release];
        record_number_data = temp_record_number_data;
        NSLog(@"temp_record_number_data%@",temp_record_number_data);
        [PlistOperator savePlistFile:@"checkUpdateData" From:record_number_data];
    } else {
        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] setValue:[[[temp_record_number_data objectForKey:@"YRO"] objectForKey:@"top"] objectForKey:@"total"] forKey:@"total"];
        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"hotel"] setValue:[[[temp_record_number_data objectForKey:@"YRO"] objectForKey:@"hotel"] objectForKey:@"total"] forKey:@"total"];
        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"chain"] setValue:[[[temp_record_number_data objectForKey:@"YRO"] objectForKey:@"chain"] objectForKey:@"total"] forKey:@"total"];
        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"district"] setValue:[[[temp_record_number_data objectForKey:@"YRO"] objectForKey:@"district"] objectForKey:@"total"] forKey:@"total"];
        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"apparel"] setValue:[[[temp_record_number_data objectForKey:@"YRO"] objectForKey:@"apparel"] objectForKey:@"total"] forKey:@"total"];
        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"beauty"] setValue:[[[temp_record_number_data objectForKey:@"YRO"] objectForKey:@"beauty"] objectForKey:@"total"] forKey:@"total"];
        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"jewellery"] setValue:[[[temp_record_number_data objectForKey:@"YRO"] objectForKey:@"jewellery"] objectForKey:@"total"] forKey:@"total"];
        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"lifestyle"] setValue:[[[temp_record_number_data objectForKey:@"YRO"] objectForKey:@"lifestyle"] objectForKey:@"total"] forKey:@"total"];
        [[record_number_data objectForKey:@"QS"] setValue:[[temp_record_number_data objectForKey:@"QS"] objectForKey:@"total"] forKey:@"total"];
        [[record_number_data objectForKey:@"LP"] setValue:[[temp_record_number_data objectForKey:@"LP"] objectForKey:@"total"] forKey:@"total"];
        [[record_number_data objectForKey:@"SP"] setValue:[[temp_record_number_data objectForKey:@"SP"] objectForKey:@"total"] forKey:@"total"];
        [[record_number_data objectForKey:@"PB"] setValue:[[temp_record_number_data objectForKey:@"PB"] objectForKey:@"total"] forKey:@"total"];
        [[record_number_data objectForKey:@"GP"] setValue:[[temp_record_number_data objectForKey:@"GP"] objectForKey:@"total"] forKey:@"total"];
        [PlistOperator savePlistFile:@"checkUpdateData" From:record_number_data];
    }
    
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    //if (record_updated) {
    if ([elementName isEqualToString:@"item"]) {
        currentCat = [attributeDict objectForKey:@"id"];
        [temp_record_number_data setValue:[NSMutableDictionary new] forKey:currentCat];
        [[temp_record_number_data objectForKey:currentCat] setValue:[NSNumber numberWithBool:FALSE] forKey:@"checked"];
    }
    if ([currentCat isEqualToString:@"YRO"]) {
        NSArray *key = [NSArray arrayWithObjects:@"top",@"hotel",@"chain",@"district",@"apparel",@"beauty",@"jewellery",@"lifestyle",nil];
        for (int i=0; i<[key count]; i++) {
            if ([elementName isEqualToString:[key objectAtIndex:i]]) {
                currentSubCat = elementName;
                [[temp_record_number_data objectForKey:currentCat] setValue:[NSMutableDictionary new] forKey:currentSubCat];
                [[[temp_record_number_data objectForKey:currentCat] objectForKey:currentSubCat] setValue:[NSNumber numberWithBool:FALSE] forKey:@"checked"];
            }
        }
    }
    //}
    currentElementName = elementName;
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([currentElementName isEqualToString:@"lastpublish"] && current_lastpublish==nil) {
        current_lastpublish = [string retain];
        if (![[record_number_data objectForKey:@"lastpublish"] isEqualToString:current_lastpublish]) {
            NSLog(@"Data updated %@",string);
            record_updated = TRUE;
            temp_record_number_data = [NSMutableDictionary new];
            [temp_record_number_data setValue:current_lastpublish forKey:@"lastpublish"];
        }
    }
    if ([currentElementName isEqualToString:@"checksum"] && current_checksum==nil) {
        current_checksum = [string retain];
        if (![[record_number_data objectForKey:@"checksum"] isEqualToString:current_checksum]) {
            temp_record_number_data = [NSMutableDictionary new];
            [temp_record_number_data setValue:current_checksum forKey:@"checksum"];
        }
    }
    //if (record_updated) {
    if ([currentElementName isEqualToString:@"new"] || [currentElementName isEqualToString:@"total"]) {
        //NSLog(@"%@ %@ %@ %@",currentCat,currentSubCat,currentElementName,string);
        if ([currentCat isEqualToString:@"YRO"]) {
            if ([[[temp_record_number_data objectForKey:currentCat] objectForKey:currentSubCat] objectForKey:currentElementName]==nil) {
                [[[temp_record_number_data objectForKey:currentCat] objectForKey:currentSubCat] setValue:string forKey:currentElementName];
            }
        } else {
            if ([[temp_record_number_data objectForKey:currentCat] objectForKey:currentElementName]==nil) {
                [[temp_record_number_data objectForKey:currentCat] setValue:string forKey:currentElementName];
            }
        }
    }
    //}
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



@end
