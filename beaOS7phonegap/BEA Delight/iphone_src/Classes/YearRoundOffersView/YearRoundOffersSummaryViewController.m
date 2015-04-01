//
//  YearRoundOffersSummaryViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YearRoundOffersSummaryViewController.h"

#define AlertActionShare	0
#define AlertActionBookmark	1

@implementation YearRoundOffersSummaryViewController
@synthesize merchant_info;
@synthesize title_label;
@synthesize show_distance;
//jeff
@synthesize tnc_string, headingTitle;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        show_distance = 0;
    }
    return self;
}

- (void)setViewControllerPushType:(NSInteger)type {
    pushType = type;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    //    [[MyScreenUtil me] adjustModuleView:self.view];
    isInit = YES;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        //        CGRect frame = scroll_view.frame;
        //        frame.size.height += 80;
        //        scroll_view.frame = frame;
        //        frame = boundImageView.frame;
        //        frame.size.height += 80;
        //        boundImageView.frame = frame;
    }
    //    scroll_view.directionalLockEnabled = YES;
    //
    //    scroll_view.contentSize =  CGSizeMake(0, 100);
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    scroll_view.frame = CGRectMake(0, 143, 320, 272+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    tnc.frame = CGRectMake(8, 423+[[MyScreenUtil me] getScreenHeightAdjust], 96, 37);
    //    share.frame = CGRectMake(112, 423+[[MyScreenUtil me] getScreenHeightAdjust], 96, 37);
    tnc.frame = CGRectMake(tnc.frame.origin.x, tnc.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], tnc.frame.size.width, tnc.frame.size.height);
    share.frame = CGRectMake(share.frame.origin.x, share.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], share.frame.size.width, share.frame.size.height);
    boundImageView.frame = CGRectMake(boundImageView.frame.origin.x, boundImageView.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], boundImageView.frame.size.width, boundImageView.frame.size.height);
    //    bookmark.frame = CGRectMake(216, 423+[[MyScreenUtil me] getScreenHeightAdjust], 96, 37);
    
    float footer = 0;
    //	merchant.font = [UIFont boldSystemFontOfSize:18];
    merchant.text = [merchant_info objectForKey:@"title"];
    offer_label.text = NSLocalizedString(@"Offers",nil);
    // title_label.text = title_labelStr;
    title_label.text = headingTitle;
    [tnc setTitle:NSLocalizedString(@"Terms and Conditions",nil) forState:UIControlStateNormal];
    [share setTitle:NSLocalizedString(@"Share Offer",nil) forState:UIControlStateNormal];
    //	[bookmark setTitle:NSLocalizedString(@"Add to Bookmark",nil) forState:UIControlStateNormal];
    footer += offer_label.frame.size.height;
    description.font = [UIFont systemFontOfSize:16];
    description.text = [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
    CGSize maxSize = CGSizeMake(description.frame.size.width-20, 100000);
    CGSize text_area = [description.text sizeWithFont:description.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    NSString *image = [merchant_info objectForKey:@"image"];
    NSLog(@"image is %@", image);
    if (image!=nil && ![image isEqualToString:@""]) {
        [image_view loadImageWithURL:[[merchant_info objectForKey:@"image"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    }
    description.frame = CGRectMake(0, footer, description.frame.size.width, text_area.height * 1.1 + 20);
    description.contentSize = CGSizeMake(description.frame.size.width, description.frame.size.height + 50);
    footer += description.frame.size.height;
    
    NSLog(@"merchant_info is %@", merchant_info);
    outlet_list_controller = [[OutletListViewController alloc] initWithNibName:@"OutletListView" bundle:nil];
    
    outlet_list_controller.fromType = @"YRO";
    if (show_distance==0) {
        outlet_list_controller.is_show_distance = FALSE;
        NSLog(@"debug show_distance==0:%f", show_distance);
    } else {
        outlet_list_controller.is_show_distance = TRUE;
        outlet_list_controller.show_all_in_map = TRUE;
        outlet_list_controller.show_distance = show_distance;
        NSLog(@"debug show_distance!=0:%f", show_distance);
    }
    outlet_list_controller.delegate = self;
    outlet_list_controller.view.frame = CGRectMake(0, footer, 300, 24);
    [scroll_view addSubview:outlet_list_controller.view];
    outlet_list_controller.background_imageView.hidden = YES;
    CGRect frame = outlet_list_controller.table_view.frame;
    frame.origin.x -= 1;
    frame.size.width += 1;
    NSLog(@"merchant id:%@",[merchant_info objectForKey:@"id"]);
    if (show_distance==0) {
        [outlet_list_controller getMerchantOutletWithRefId:[merchant_info objectForKey:@"id"] QuarterlySurprise:FALSE];
    } else {
        [outlet_list_controller getMerchantOutlet:[merchant_info objectForKey:@"etitle"] QuarterlySurprise:FALSE];
    }
    scroll_view.contentSize = CGSizeMake(scroll_view.frame.size.width, description.frame.size.height + 200);
    Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([bookmark_data isOfferExist:merchant_info InGroup:2]) {
        if ([pageTheme isEqualToString:@"1"]) {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
        } else {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
        }
    }
    [bookmark_data release];
    
    if (pushType == 1) {
        bookmark.hidden = YES;
        [self setMenuBar1];
        //        CGRect frame1 = scroll_view.frame;
        //        frame1.origin.y -= 31;
        //        frame1.size.height += 31;
        //        scroll_view.frame = frame1;
        //        CGRect frame2 = merchant.frame;
        //        frame2.origin.y -= 31;
        //        merchant.frame = frame2;
        CGRect frame = backView.frame;
        frame.origin.y -= 31;
        backView.frame = frame;
    }
    else {
        if ([[CoreData sharedCoreData].menuType isEqualToString:@"2"]) {
            [self setMenuBar2];
        } else {
            [self setMenuBar1];
            CGRect frame = backView.frame;
            frame.origin.y -= 31;
            backView.frame = frame;
        }
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
    [backView release];
    backView = nil;
    [self setBackView:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [boundImageView release];
    [outlet_list_controller.view removeFromSuperview];
    [outlet_list_controller release];
    //jeff
    if(tnc_string != nil){
        [tnc_string release];
        tnc_string = nil;
    }
    //
    [backView release];
    [_bookButton release];
    [super dealloc];
}
/*
 -(IBAction)outletButtonPressed:(UIButton *)button {
	OutletListViewController *outlet_list_controller = [[OutletListViewController alloc] initWithNibName:@"OutletListView" bundle:nil];
 //	outlet_list_controller.show_distance = TRUE;
	[self.navigationController pushViewController:outlet_list_controller animated:TRUE];
	[outlet_list_controller getMerchantOutlet:[merchant_info objectForKey:@"etitle"]];
	[outlet_list_controller release];
 }
 */
-(IBAction)tncButtonPressed:(UIButton *)button {
    
    TermsAndConditionsViewController *tnc_controller = [[TermsAndConditionsViewController alloc] initWithNibName:@"TermsAndConditionsView" bundle:nil];
    if ([[merchant_info objectForKey:@"remark"] length]>4) {
        tnc_controller.title_label.text = NSLocalizedString(@"Terms and Conditions",nil);
        //NSLog(@"using remark :%@:",[[merchant_info objectForKey:@"remark"] stringByReplacingOccurrencesOfString:@" " withString:@""]);
        //jeff
        NSString *trim_string = [[merchant_info objectForKey:@"remark"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([trim_string isEqualToString:@"Pleaserefertothegeneraltermsandconditionsoftheyear-roundoffers"] || [trim_string isEqualToString:@"請查閱全年優惠之一般條款及細則"]){
            //			tnc_controller.tnc.text = tnc_string;
            [tnc_controller setTncStr:tnc_string];
        }
        else{
            //		tnc_controller.tnc.text = [merchant_info objectForKey:@"remark"];
            [tnc_controller setTncStr:[merchant_info objectForKey:@"remark"]];
        }
        //
    } else {
        if ([[merchant_info objectForKey:@"category"] isEqualToString:@"Apparel"]
            || [[merchant_info objectForKey:@"category"] isEqualToString:@"Beauty"]
            || [[merchant_info objectForKey:@"category"] isEqualToString:@"Jewellery & Watches"]
            || [[merchant_info objectForKey:@"category"] isEqualToString:@"Lifestyle"]) {
            [tnc_controller setTncStr: NSLocalizedString(@"TNC Shopping",nil)];
        } else {
            [tnc_controller setTncStr: NSLocalizedString(@"TNC Dining",nil)];
        }
        
    }
    [self.navigationController pushViewController:tnc_controller animated:TRUE];
    [tnc_controller release];
}

-(IBAction)shareButtonPressed:(UIButton *)button {
    UIAlertView *share_prompt = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Share to Friends",nil) message:NSLocalizedString(@"Share App with Friends by Email",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Back",nil),nil];
    [share_prompt show];
    [share_prompt release];
    alert_action = AlertActionShare;
}

-(IBAction)bookmarkButtonPressed:(UIButton *)button {
    
    Bookmark *bookmark_data = [[Bookmark alloc] init];
    //	[bookmark_data addBookmark:merchant_info ToGroup:2];
    //	[bookmark_data release];
    //	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
    //	[alert show];
    //	[alert release];
    /*	UIAlertView *share_prompt = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Add to Bookmark?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
     [share_prompt show];
     [share_prompt release];
     alert_action = AlertActionBookmark;*/
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([bookmark_data isOfferExist:merchant_info InGroup:2]) {
        [bookmark_data removeBookmark:merchant_info InGroup:2];
        if ([pageTheme isEqualToString:@"1"]) {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark.png"] forState:UIControlStateNormal];
        } else {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_new.png"] forState:UIControlStateNormal];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Delete from Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else {
        [bookmark_data addBookmark:merchant_info ToGroup:2];
        if ([pageTheme isEqualToString:@"1"]) {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
        } else {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

/////////////////////////
//UIAlertViewDelegate
/////////////////////////
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        if (alert_action==AlertActionShare) {
            NSMutableString *contact = [NSMutableString new];
            for (int i=0; i<[outlet_list_controller.items_data count]; i++) {
                [contact appendString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Address",nil),[[outlet_list_controller.items_data objectAtIndex:i] objectForKey:@"address"]]];
                [contact appendString:@"\n"];
                [contact appendString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Tel",nil),[[outlet_list_controller.items_data objectAtIndex:i] objectForKey:@"tel"]]];
                [contact appendString:@"\n\n"];
            }
            //            EMailViewController *email = [[EMailViewController alloc] init];
            //            [email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Year-round Offers",nil)] Message:[[[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@\n\n%@",
            //                                                                                                                                                                                                             NSLocalizedString(@"Year-round Offers",nil),
            //                                                                                                                                                                                                             [merchant_info objectForKey:@"title"],
            //                                                                                                                                                                                                             NSLocalizedString(@"Offer details",nil),
            //                                                                                                                                                                                                             [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],contact]
            //																																																			stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
            //                                                                                                                                                                                                           stringByAppendingFormat:@"\n\n\n%@",NSLocalizedString(@"Share App",nil)]];
            //            [self.view addSubview:email.view];
            //      [email release];
            EMailViewController* email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
            [[CoreData sharedCoreData].email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Year-round Offers",nil)] Message:[[[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@\n\n%@",
                                                                                                                                                                                                             NSLocalizedString(@"Year-round Offers",nil),
                                                                                                                                                                                                             [merchant_info objectForKey:@"title"],
                                                                                                                                                                                                             NSLocalizedString(@"Offer details",nil),
                                                                                                                                                                                                             [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],contact]
                                                                                                                                                                                                            stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                                                                                                                                                                                                           stringByAppendingFormat:@"\n\n\n%@",NSLocalizedString(@"Share App",nil)]];
            [email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Year-round Offers",nil)] Message:[[[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@\n\n%@",
                                                                                                                                                                                   NSLocalizedString(@"Year-round Offers",nil),
                                                                                                                                                                                   [merchant_info objectForKey:@"title"],
                                                                                                                                                                                   NSLocalizedString(@"Offer details",nil),
                                                                                                                                                                                   [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],contact]
                                                                                                                                                                                  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                                                                                                                                                                                 stringByAppendingFormat:@"\n\n\n%@",NSLocalizedString(@"Share App",nil)]];
            //            [self.view addSubview:[CoreData sharedCoreData].email.view];
            self.navigationController.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]+20);
            [self.view addSubview:email.view];
        } else if (alert_action==AlertActionBookmark) {
            Bookmark *bookmark_data = [[Bookmark alloc] init];
            [bookmark_data addBookmark:merchant_info ToGroup:2];
            [bookmark_data release];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
    }
}

-(void)setMerchant_info:(NSDictionary*)info tnc_string:(NSString *)tnc title_label:(NSString *)title{
    merchant_info = info;
    tnc_string = tnc;
    title_labelStr= title;
}
/////////////////////////
//OutletListViewDelegate
/////////////////////////
-(void) OutletListUpdated:(NSArray *)items_data {
    outlet_list_controller.view.frame = CGRectMake(0, outlet_list_controller.view.frame.origin.y, 320, 24 + outlet_list_controller.table_view.frame.size.height);
    scroll_view.contentSize = CGSizeMake(scroll_view.frame.size.width, outlet_list_controller.view.frame.origin.y + outlet_list_controller.view.frame.size.height - 1);
    //    scroll_view.contentSize = CGSizeMake(scroll_view.frame.size.width, description.frame.size.height + 50);
}

@end
