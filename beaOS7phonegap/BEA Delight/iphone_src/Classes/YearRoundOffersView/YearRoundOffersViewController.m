//
//  YearRoundOffersViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月18日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YearRoundOffersViewController.h"
#define ListAllShop				1
#define ListAllBrand			2
#define	ListAllShopInDistrict	3

@implementation YearRoundOffersViewController
@synthesize record_number_data, alertShowCount;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        location_list = [[NSLocalizedString(@"location_list",nil) componentsSeparatedByString:@","] retain];
        location_id_list = [[NSLocalizedString(@"location_id_list",nil) componentsSeparatedByString:@","] retain];
        category_list = [[NSLocalizedString(@"category_list",nil) componentsSeparatedByString:@","] retain];
        current_location_index = 0;
        isShowShopping = false;
        dining_tnc = nil;
        shopping_tnc = nil;
        alertShowCount = 0;
    }
    return self;
}
- (void) setShowShopping :(Boolean) isShow{
    isShowShopping = isShow;
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
//- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.delegate = self;
//    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
//}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    [self.view addSubview:content_view];
    
    NSArray *offers_list = [NSLocalizedString(@"Offer types",nil) componentsSeparatedByString:@","];
    [dining_offers setTitle:[offers_list objectAtIndex:0] forState:UIControlStateNormal];
    [shopping_offers setTitle:[offers_list objectAtIndex:1] forState:UIControlStateNormal];
    
    NSArray *offers_list_accessibility = [NSLocalizedString(@"Offer types_accessibility",nil) componentsSeparatedByString:@","];
    dining_offers.accessibilityLabel = NSLocalizedString([offers_list_accessibility objectAtIndex:0], nil);
    shopping_offers.accessibilityLabel = NSLocalizedString([offers_list_accessibility objectAtIndex:1], nil);
    
    NSArray *offers_type_list = [NSLocalizedString(@"Year round menu",nil) componentsSeparatedByString:@","];
    [tnc setTitle:NSLocalizedString(@"General Terms and Conditions",nil) forState:UIControlStateNormal];
//    tnc.titleLabel.accessibilityElementsHidden = YES;
    tnc.titleLabel.accessibilityLabel = NSLocalizedString(@"General Terms and Conditions button", nil);
//    tnc.titleLabel.accessibilityFrame = CGRectMake(tnc.titleLabel.frame.origin.x, 434+[[MyScreenUtil me] getScreenHeightAdjust], tnc.titleLabel.frame.size.width + 20, tnc.titleLabel.frame.size.height);
//    CGRect mframe = tnc.titleLabel.accessibilityFrame;
//    mframe.origin.y = tnc.frame.origin.y+tnc.titleLabel.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust];
//    mframe.origin.x = tnc.titleLabel.frame.origin.x;
//    mframe.size.width = tnc.titleLabel.frame.size.width+20;
//    tnc.titleLabel.accessibilityFrame = mframe;
    //	if ([[CoreData sharedCoreData].lang isEqualToString:@"zh_TW"]) {
    //		tnc.frame = CGRectMake(104, 340, 112, 21);
    //	} else {
    //		tnc.frame = CGRectMake(48, 340, 224, 21);
    //	}
    tnc.frame = CGRectMake(0, 404+[[MyScreenUtil me] getScreenHeightAdjust], 320, 56);
    tnc.titleLabel.accessibilityFrame = CGRectMake(0, 404+[[MyScreenUtil me] getScreenHeightAdjust], 320, 56);

    img4.frame = CGRectMake(297, 424+[[MyScreenUtil me] getScreenHeightAdjust], 14, 16);
    [button0 setTitle:[offers_type_list objectAtIndex:0] forState:UIControlStateNormal];
    button0.accessibilityTraits = UIAccessibilityTraitButton;
    [button1 setTitle:[offers_type_list objectAtIndex:1] forState:UIControlStateNormal];
    [button2 setTitle:[offers_type_list objectAtIndex:2] forState:UIControlStateNormal];
    [button3 setTitle:[offers_type_list objectAtIndex:3] forState:UIControlStateNormal];
    [button4 setTitle:[offers_type_list objectAtIndex:4] forState:UIControlStateNormal];
    [button5 setTitle:[offers_type_list objectAtIndex:5] forState:UIControlStateNormal];
    [button6 setTitle:[offers_type_list objectAtIndex:6] forState:UIControlStateNormal];
    [button7 setTitle:[offers_type_list objectAtIndex:7] forState:UIControlStateNormal];
    
    cached_image_bg.isAccessibilityElement = YES;
    cached_image_bg.accessibilityLabel = NSLocalizedString(@"More Details_accessibility", nil);
    cached_image_bg.accessibilityTraits = UIAccessibilityTraitNone;
    cached_image_bg2.isAccessibilityElement = YES;
    cached_image_bg2.accessibilityLabel = NSLocalizedString(@"More Details_accessibility", nil);
    cached_image_bg2.accessibilityTraits = UIAccessibilityTraitNone;
    cached_image_bg3.isAccessibilityElement = YES;
    cached_image_bg3.accessibilityLabel = NSLocalizedString(@"More Details_accessibility", nil);
    cached_image_bg3.accessibilityTraits = UIAccessibilityTraitNone;
    cached_image_bg4.isAccessibilityElement = YES;
    cached_image_bg4.accessibilityLabel = NSLocalizedString(@"More Details_accessibility", nil);
    cached_image_bg4.accessibilityTraits = UIAccessibilityTraitNone;
    cached_image_bg5.isAccessibilityElement = YES;
    cached_image_bg5.accessibilityLabel = NSLocalizedString(@"More Details_accessibility", nil);
    cached_image_bg5.accessibilityTraits = UIAccessibilityTraitNone;
    cached_image_bg6.isAccessibilityElement = YES;
    cached_image_bg6.accessibilityLabel = NSLocalizedString(@"More Details_accessibility", nil);
    cached_image_bg6.accessibilityTraits = UIAccessibilityTraitNone;
    cached_image_bg7.isAccessibilityElement = YES;
    cached_image_bg7.accessibilityLabel = NSLocalizedString(@"More Details_accessibility", nil);
    cached_image_bg7.accessibilityTraits = UIAccessibilityTraitNone;
    cached_image_bg8.isAccessibilityElement = YES;
    cached_image_bg8.accessibilityLabel = NSLocalizedString(@"More Details_accessibility", nil);
    cached_image_bg8.accessibilityTraits = UIAccessibilityTraitNone;
    
    new0.hidden = [[[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] objectForKey:@"checked"] boolValue];
    if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] objectForKey:@"new"] intValue]==0) {
        new0.hidden = TRUE;
    }
    new1.hidden = [[[[record_number_data objectForKey:@"YRO"] objectForKey:@"hotel"] objectForKey:@"checked"] boolValue];
    if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"hotel"] objectForKey:@"new"] intValue]==0) {
        new1.hidden = TRUE;
    }
    new2.hidden = [[[[record_number_data objectForKey:@"YRO"] objectForKey:@"chain"] objectForKey:@"checked"] boolValue];
    if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"chain"] objectForKey:@"new"] intValue]==0) {
        new2.hidden = TRUE;
    }
    new3.hidden = [[[[record_number_data objectForKey:@"YRO"] objectForKey:@"district"] objectForKey:@"checked"] boolValue];
    if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"district"] objectForKey:@"new"] intValue]==0) {
        new3.hidden = TRUE;
    }
    new4.hidden = [[[[record_number_data objectForKey:@"YRO"] objectForKey:@"apparel"] objectForKey:@"checked"] boolValue];
    if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"apparel"] objectForKey:@"new"] intValue]==0) {
        new4.hidden = TRUE;
    }
    new5.hidden = [[[[record_number_data objectForKey:@"YRO"] objectForKey:@"beauty"] objectForKey:@"checked"] boolValue];
    if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"beauty"] objectForKey:@"new"] intValue]==0) {
        new5.hidden = TRUE;
    }
    new6.hidden = [[[[record_number_data objectForKey:@"YRO"] objectForKey:@"jewellery"] objectForKey:@"checked"] boolValue];
    if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"jewellery"] objectForKey:@"new"] intValue]==0) {
        new6.hidden = TRUE;
    }
    new7.hidden = [[[[record_number_data objectForKey:@"YRO"] objectForKey:@"lifestyle"] objectForKey:@"checked"] boolValue];
    if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"lifestyle"] objectForKey:@"new"] intValue]==0) {
        new7.hidden = TRUE;
    }
    
    [self diningButtonPressed:nil];
    title_label.text = [NSString stringWithFormat:@"%@\n%@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Year-round Offers",nil)];
    self.navigationItem.backBarButtonItem.title = NSLocalizedString(@"Back",nil);
    
    //	dining_tnc_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@general_tnc.api?lang=%@&cat=dining&UDID=%@",[CoreData sharedCoreData].realServerURL,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    dining_tnc_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@general_tnc.api?lang=%@&cat=dining&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    dining_tnc_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:dining_tnc_request];
    //	shopping_tnc_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@general_tnc.api?lang=%@&cat=shopping&UDID=%@",[CoreData sharedCoreData].realServerURL,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    shopping_tnc_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@general_tnc.api?lang=%@&cat=shopping&UDID=%@",[CoreData sharedCoreData].realServerURLCard,[CoreData sharedCoreData].lang,[CoreData sharedCoreData].UDID]]];
    shopping_tnc_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:shopping_tnc_request];
    [[CoreData sharedCoreData].mask showMask];
    
    //jeff
    //NSLog(@"%@", dining_tnc_request.url);
    //NSLog(@"%@", shopping_tnc_request.url);
    
    if ([[CoreData sharedCoreData].menuType isEqualToString:@"2"]) {
        [self setMenuBar2];
    } else {
        [self setMenuBar1];
    }
    if (isShowShopping) {
        [self shoppingButtonPressed: nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *status = [[PageUtil pageUtil] getPageTheme];
    if ([status isEqualToString:@"1"]) {
        UIImage *imageSelectedLeft = [UIImage imageNamed:@"(new)borderlist_thin_gray_tap_01_left_on.png"];
        UIImage *imageNormalLeft = [UIImage imageNamed:@"borderlist_thin_gray_tap_01_left_off.png"];
        UIImage *imageSelectedRight = [UIImage imageNamed:@"(new)borderlist_thin_gray_tap_01_right_on.png"];
        UIImage *imageNormalRight = [UIImage imageNamed:@"borderlist_thin_gray_tap_01_right_off.png"];
        [dining_offers setBackgroundImage:imageNormalLeft forState:UIControlStateNormal];
        [dining_offers setBackgroundImage:imageSelectedLeft forState:UIControlStateSelected];
        [shopping_offers setBackgroundImage:imageNormalRight forState:UIControlStateNormal];
        [shopping_offers setBackgroundImage:imageSelectedRight forState:UIControlStateSelected];
        UIImage *image0 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_dining_off.png"];
        UIImage *image1 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_shopping_on.png"];
        UIImage *image2 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_dining_on.png"];
        UIImage *image3 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_shopping_off.png"];
        [img0 setImage:image0];
        [img1 setImage:image1];
        [img2 setImage:image2];
        [img3 setImage:image3];
    } else {
        UIImage *imageSelectedLeft = [UIImage imageNamed:@"borderlist_thin_gray_tap_01_left_on_new.png"];
        UIImage *imageNormalLeft = [UIImage imageNamed:@"borderlist_thin_gray_tap_01_left_off.png"];
        UIImage *imageSelectedRight = [UIImage imageNamed:@"borderlist_thin_gray_tap_01_right_on_new.png"];
        UIImage *imageNormalRight = [UIImage imageNamed:@"borderlist_thin_gray_tap_01_right_off.png"];
        [dining_offers setBackgroundImage:imageNormalLeft forState:UIControlStateNormal];
        [dining_offers setBackgroundImage:imageSelectedLeft forState:UIControlStateSelected];
        [shopping_offers setBackgroundImage:imageNormalRight forState:UIControlStateNormal];
        [shopping_offers setBackgroundImage:imageSelectedRight forState:UIControlStateSelected];
        UIImage *image0 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_dining_off_new.png"];
        UIImage *image1 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_shopping_on_new.png"];
        UIImage *image2 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_dining_on_new.png"];
        UIImage *image3 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_shopping_off_new.png"];
        [img0 setImage:image0];
        [img1 setImage:image1];
        [img2 setImage:image2];
        [img3 setImage:image3];
    }
}

-(void)setMenuBar1
{
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    //    CGRect frame3 = v_rmvc.contentView.frame;
    //    frame3.origin.x =0;
    //    frame3.origin.y =0;
    //    v_rmvc.view.frame = frame3;
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)isAccessibilityElement{
    return NO;
}

- (void)dealloc {
    [category_list release];
    if (dining_tnc!=nil) {
        [dining_tnc release];
    }
    if (shopping_tnc!=nil) {
        [shopping_tnc release];
    }
    [cached_image_bg release];
    [cached_image_bg2 release];
    [cached_image_bg3 release];
    [cached_image_bg4 release];
    [cached_image_bg5 release];
    [cached_image_bg6 release];
    [cached_image_bg7 release];
    [cached_image_bg8 release];
    [super dealloc];
}

-(void)setContent:(int)index {
    /*	if (current_view_controller!=nil) {
     [current_view_controller.view removeFromSuperview];
     [current_view_controller release];
     current_view_controller = nil;
     }*/
    switch (index) {
        case 0: //Top Merchant
            current_view_controller = [[YearRoundOffersListViewController alloc] initWithNibName:@"YearRoundOffersListView" bundle:nil];
            //jeff
            if (dining_offers.selected) {
                ((YearRoundOffersListViewController*)current_view_controller).tnc_string = dining_tnc;
            } else {
                ((YearRoundOffersListViewController*)current_view_controller).tnc_string = shopping_tnc;
            }
            //
            [(YearRoundOffersListViewController *)current_view_controller getItemsListType:@"" Category:[category_list objectAtIndex:0]];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            
            [current_view_controller release];
            break;
        case 1: //Hotel
            current_view_controller = [[YearRoundOffersListViewController alloc] initWithNibName:@"YearRoundOffersListView" bundle:nil];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            [(YearRoundOffersListViewController *)current_view_controller getItemsListType:@"" Category:[category_list objectAtIndex:1]];
            [current_view_controller release];
            break;
        case 2: //Chain restaurant
            current_view_controller = [[YearRoundOffersListViewController alloc] initWithNibName:@"YearRoundOffersListView" bundle:nil];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            [(YearRoundOffersListViewController *)current_view_controller getItemsListType:@"" Category:[category_list objectAtIndex:2]];
            [current_view_controller release];
            break;
        case 3: //District
            current_view_controller = [[YearRoundOffersListViewController alloc] initWithNibName:@"YearRoundOffersListView" bundle:nil];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            [(YearRoundOffersListViewController *)current_view_controller getItemsDistrict:current_location_index];
            [(YearRoundOffersListViewController *)current_view_controller getItemsListType:@"" Category:[category_list objectAtIndex:3]];
            [current_view_controller release];
            break;
        case 4:
            current_view_controller = [[YearRoundOffersListViewController alloc] initWithNibName:@"YearRoundOffersListView" bundle:nil];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            [(YearRoundOffersListViewController *)current_view_controller getItemsListType:@"" Category:[category_list objectAtIndex:4]];
            [current_view_controller release];
            break;
        case 5:
            current_view_controller = [[YearRoundOffersListViewController alloc] initWithNibName:@"YearRoundOffersListView" bundle:nil];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            [(YearRoundOffersListViewController *)current_view_controller getItemsListType:@"" Category:[category_list objectAtIndex:5]];
            [current_view_controller release];
            break;
        case 6:
            current_view_controller = [[YearRoundOffersListViewController alloc] initWithNibName:@"YearRoundOffersListView" bundle:nil];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            [(YearRoundOffersListViewController *)current_view_controller getItemsListType:@"" Category:[category_list objectAtIndex:6]];
            [current_view_controller release];
            break;
        case 7:
            current_view_controller = [[YearRoundOffersListViewController alloc] initWithNibName:@"YearRoundOffersListView" bundle:nil];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            [(YearRoundOffersListViewController *)current_view_controller getItemsListType:@"" Category:[category_list objectAtIndex:7]];
            [current_view_controller release];
            break;
    }
}

-(IBAction)tncButtonPressed:(UIButton *)button {
    TermsAndConditionsViewController *tnc_controller = [[TermsAndConditionsViewController alloc] initWithNibName:@"TermsAndConditionsView" bundle:nil];
    if (dining_offers.selected) {
        //		tnc_controller.tnc.text = dining_tnc; //NSLocalizedString(@"TNC Dining",nil);
        [tnc_controller setTncStr:dining_tnc];
    } else {
        //		tnc_controller.tnc.text = shopping_tnc; //NSLocalizedString(@"TNC Shopping",nil);
        [tnc_controller setTncStr:shopping_tnc];
    }
    [self.navigationController pushViewController:tnc_controller animated:TRUE];
    [tnc_controller release];
}

-(IBAction)diningButtonPressed:(UIButton *)button {
    content_view.frame = CGRectMake(0, 124, 640, 280);
    dining_offers.selected = TRUE;
    shopping_offers.selected = FALSE;
    img0.hidden = YES;
    img1.hidden = YES;
    img2.hidden = NO;
    img3.hidden = NO;
}

-(IBAction)shoppingButtonPressed:(UIButton *)button {
    content_view.frame = CGRectMake(-320, 124, 640, 280);
    dining_offers.selected = FALSE;
    shopping_offers.selected = TRUE;
    img0.hidden = NO;
    img1.hidden = NO;
    img2.hidden = YES;
    img3.hidden = YES;
}

-(IBAction)tabButtonPressed:(UIButton *)button {
    BEAAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (delegate.isClick == YES) {
        delegate.isClick = NO;
    }
    if (button.tag!=3) {
        switch (button.tag) {
            case 0:
            case 10:
                [[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
                new0.hidden = TRUE;
                //NSLog(@"%d",[[[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] objectForKey:@"total"] intValue]);
                if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] objectForKey:@"total"] intValue]==0) {
                    ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                    [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
                } else {
                    [self setContent:button.tag];
                }
                break;
            case 11:
                [[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
                new0.hidden = TRUE;
                //NSLog(@"%d",[[[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] objectForKey:@"total"] intValue]);
                if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"top"] objectForKey:@"total"] intValue]==0) {
                    ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                    [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
                } else {
                    [self setContent:button.tag];
                }
                break;
            case 1:
                [[[record_number_data objectForKey:@"YRO"] objectForKey:@"hotel"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
                new1.hidden = TRUE;
                //				if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"hotel"] objectForKey:@"total"] intValue]==0) {
                //					ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                //					[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
                //				} else {
                [self setContent:button.tag];
                //	}
                break;
            case 2:
                [[[record_number_data objectForKey:@"YRO"] objectForKey:@"chain"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
                new2.hidden = TRUE;
                if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"chain"] objectForKey:@"total"] intValue]==0) {
                    ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                    [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
                } else {
                    [self setContent:button.tag];
                }
                break;
            case 4:
                [[[record_number_data objectForKey:@"YRO"] objectForKey:@"apparel"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
                new4.hidden = TRUE;
                if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"apparel"] objectForKey:@"total"] intValue]==0) {
                    ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                    [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
                } else {
                    [self setContent:button.tag];
                }
                break;
            case 5:
                [[[record_number_data objectForKey:@"YRO"] objectForKey:@"beauty"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
                new5.hidden = TRUE;
                //				if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"beauty"] objectForKey:@"total"] intValue]==0) {
                //					ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                //					[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
                //				} else {
                [self setContent:button.tag];
                //		}
                break;
            case 6:
                [[[record_number_data objectForKey:@"YRO"] objectForKey:@"jewellery"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
                new6.hidden = TRUE;
                //				if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"jewellery"] objectForKey:@"total"] intValue]==0) {
                //					ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                //					[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
                //				} else {
                [self setContent:button.tag];
                //		}
                break;
            case 7:
                [[[record_number_data objectForKey:@"YRO"] objectForKey:@"lifestyle"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
                new7.hidden = TRUE;
                if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"lifestyle"] objectForKey:@"total"] intValue]==0) {
                    ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                    [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
                } else {
                    [self setContent:button.tag];
                }
                break;
        }
        [PlistOperator savePlistFile:@"checkUpdateData" From:record_number_data];
    } else {
        UIActionSheet *menu;
        current_location_index = 0;
        menu = [[UIActionSheet alloc] initWithTitle:nil
                                           delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                             destructiveButtonTitle:NSLocalizedString(@"Done",nil)
                                  otherButtonTitles:nil];
        [menu setUserInteractionEnabled:YES];
        
        // Add the picker
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        pickerView.showsSelectionIndicator = TRUE;
        pickerView.delegate = self;
        pickerView.dataSource = self;
        
        //   [menu showInView:[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [pickerView setFrame:CGRectMake(8, 90, 305, 180)];
        }
        else {
            [pickerView setFrame:CGRectMake(0, 140, 320, 216)];
        }
        pickerView.backgroundColor = [UIColor whiteColor];
        //[pickerView sizeToFit];
//        [menu addSubview:pickerView];
        
        
        if([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            UIWindow *window = nil;
            for (UIWindow *win in [UIApplication sharedApplication].windows) {
                if (win.tag == 2000) {
                    window = win;
                    [window makeKeyAndVisible];
                }
            }
            if (!window) {
                window = [[UIWindow alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, [MyScreenUtil me].getScreenHeight)];
                window.tag = 2000;
                [window makeKeyAndVisible];
                UIViewController *VC = [[UIViewController alloc] init];
                window.rootViewController = VC;
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:@"\n\n\n\n\n\n\n\n\n"// change UIAlertController height
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Done",nil)
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        window.hidden = YES;
                                                        if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"district"] objectForKey:@"total"] intValue]==0) {
                                                            ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
                                                            [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
                                                        } else {
                                                            [self setContent:3];
                                                        }
                                                        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"district"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
                                                        new3.hidden = TRUE;
                                                        NSLog(@"Action 1 Handler Called");
                                                    }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil)
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {
                                                        window.hidden = YES;
                                                        NSLog(@"Action 2 Handler Called");
                                                    }]];
            [pickerView setFrame:CGRectMake(0, 0, 304, 215)];
            pickerView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
            [alert.view addSubview:pickerView];

            [window.rootViewController presentViewController:alert animated:NO completion:nil];
        }else {
            [menu addSubview:pickerView];
            [menu showInView:self.view];
            [menu setBounds:CGRectMake(0, 0, 320, 480)];
            
        }
        [pickerView release];
        [menu release];
    }
}

////////////////////////
//ASIHTTPRequestDelegate
////////////////////////
-(void)requestFinished:(ASIHTTPRequest *)request {
    //    NSLog(@"YearRoundOffersViewController requestFinished:%@",[request responseString]);
    if (request==dining_tnc_request) {
        currentAction = @"Dining";
    } else {
        currentAction = @"Shopping";
    }
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
    [xml_parser setShouldProcessNamespaces:NO];
    [xml_parser setShouldReportNamespacePrefixes:NO];
    [xml_parser setShouldResolveExternalEntities:NO];
    xml_parser.delegate = self;
    [xml_parser parse];
    if (dining_tnc!=nil && shopping_tnc!=nil) {
        [[CoreData sharedCoreData].mask hiddenMask];
    }
    [request release];
}

-(void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"YearRoundOffersViewController requestFailed:%@", request.error);
    if (alertShowCount < 1) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
    }
    
    [[CoreData sharedCoreData].mask hiddenMask];
    [request release];
    alertShowCount++;
}

//////////////////////
//Picker delegate
//////////////////////
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [location_list count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [location_list objectAtIndex:row];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    current_location_index = row;
}

/////////////////////
//Action Sheet delegate
/////////////////////
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        if ([[[[record_number_data objectForKey:@"YRO"] objectForKey:@"district"] objectForKey:@"total"] intValue]==0) {
            ComingSoonViewController *view_controller = [[ComingSoonViewController alloc] initWithNibName:@"ComingSoonView" bundle:nil];
            [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:view_controller animated:TRUE];
        } else {
            [self setContent:3];
        }
        [[[record_number_data objectForKey:@"YRO"] objectForKey:@"district"] setValue:[NSNumber numberWithBool:TRUE] forKey:@"checked"];
        new3.hidden = TRUE;
    }
}

////////////////////////
//NSXMLParserDelegate
////////////////////////
-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    currentElementName = elementName;
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([currentElementName isEqualToString:@"tnc"]) {
        if ([currentAction isEqualToString:@"Dining"] && dining_tnc==nil) {
            NSLog(@"Set dining");
            dining_tnc = [string retain];
        } else if ([currentAction isEqualToString:@"Shopping"] && shopping_tnc==nil) {
            NSLog(@"Set shopping");
            shopping_tnc = [string retain];
        }
    }
}

@end
