//
//  SpendingRewardsSummaryViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年5月17日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpendingRewardsSummaryViewController.h"
#define MerchantLogoWidth	320

#define AlertActionShare	0
#define AlertActionBookmark	1

@implementation SpendingRewardsSummaryViewController
@synthesize merchant_info;
@synthesize title_label;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

- (void)setViewControllerPushType:(NSInteger)type {
    pushType = type;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    isInit = YES;
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    scroll_view.frame = CGRectMake(0, 140, 320, 277+[[MyScreenUtil me] getScreenHeightAdjust]);
//    scroll_view.frame = CGRectMake(0, 140, 320, 340);

    
    tnc.frame = CGRectMake(110, 420+[[MyScreenUtil me] getScreenHeightAdjust], 96, 37);
    share.frame = CGRectMake(215, 420+[[MyScreenUtil me] getScreenHeightAdjust], 96, 37);
    ecoupon.frame = CGRectMake(5, 420+[[MyScreenUtil me] getScreenHeightAdjust], 96, 37);

	title_label.text = [NSString stringWithFormat:@"%@\n%@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"GlobePass Offers",nil)];
	[tnc setTitle:NSLocalizedString(@"T&C",nil) forState:UIControlStateNormal];
	[share setTitle:NSLocalizedString(@"Share Offer",nil) forState:UIControlStateNormal];
//	[bookmark setTitle:NSLocalizedString(@"Add to Bookmark",nil) forState:UIControlStateNormal];
	[ecoupon setTitle:NSLocalizedString(@"Details",nil) forState:UIControlStateNormal];
	
	float footer = 0;
	merchant.text = [merchant_info objectForKey:@"title"];
	if ([merchant_info objectForKey:@"preview"]!=nil || [[merchant_info objectForKey:@"preview"] length]==0) {
		[preview loadImageWithURL:[merchant_info objectForKey:@"preview"]];
		footer += preview.frame.size.height + 10;
	}
	description.font = [UIFont systemFontOfSize:16];
	description.text = [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
	CGSize maxSize = CGSizeMake(description.frame.size.width-20, MAXFLOAT);
	CGSize text_area = [description.text sizeWithFont:description.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
	description.frame = CGRectMake(0, footer, 320, text_area.height + 50);
	footer += description.frame.size.height + 50;
	description.alwaysBounceVertical = NO;
    description.alwaysBounceHorizontal = NO;
    
	NSLog(@"Coupon %@",[merchant_info objectForKey:@"coupon"]);
	if ([merchant_info objectForKey:@"coupon"]==nil || [[merchant_info objectForKey:@"coupon"] length]==0) {
		ecoupon.hidden = TRUE;
	} else {
		ecoupon.hidden = FALSE;
//		ecoupon.center = CGPointMake(160, footer + ecoupon.frame.size.height/2);
//		footer += ecoupon.frame.size.height;
	}
	
	scroll_view.contentSize = CGSizeMake(320, footer);

    Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([bookmark_data isOfferExist:merchant_info InGroup:5]) {
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
        [self adjustViewByRotateMenuType];
    }
    else {
        if ([[CoreData sharedCoreData].menuType isEqualToString:@"2"]) {
            [self setMenuBar2];
        } else {
            [self setMenuBar1];
            [self adjustViewByRotateMenuType];
        }
    }

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

- (void)adjustViewByRotateMenuType {
    CGRect frame1 = scroll_view.frame;
    frame1.origin.y -= 31;
    frame1.size.height += 31;
    scroll_view.frame = frame1;
    CGRect frame2 = merchant.frame;
    frame2.origin.y -= 31;
    merchant.frame = frame2;
    if (!bookmark.hidden) {
        CGRect frame2 = bookmark.frame;
        frame2.origin.y -= 31;
        bookmark.frame = frame2;
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
    [v_rmvc.rmUtil setShowIndex:4];
    [v_rmvc.rmUtil showMenu];
}

-(void)showMenu:(int)show
{
    NSLog(@"showMenu in:%@--%d", self, show);
    [CoreData sharedCoreData].menuType = @"2";
    if (show%6==0) {
        [self.navigationController popViewControllerAnimated:NO];
        UIButton* tmp_button=[[UIButton alloc] init];
        tmp_button.tag=2;
        [[CoreData sharedCoreData].home_view_controller buttonPressed:tmp_button];
        [tmp_button release];
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
        [self.navigationController popViewControllerAnimated:NO];
        UIButton* tmp_button=[[UIButton alloc] init];
        tmp_button.tag=0;
        [[CoreData sharedCoreData].home_view_controller buttonPressed:tmp_button];
        [tmp_button release];
    } else if (show%6==4) {
        //        [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
        //        UIButton* tmp_button=[[UIButton alloc] init];
        //        tmp_button.tag=3;
        //        [(HomeViewController*)([CoreData sharedCoreData].root_view_controller.current_view_controller) buttonPressed:tmp_button];
        //        [tmp_button release];
        if (isInit) {
            isInit = NO;
            return;
        }
        [self.navigationController popViewControllerAnimated:NO];
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
    [_bookButton release];
    [share release];
    [super dealloc];
}

-(IBAction)ecouponButtonPressed:(UIButton *)button {
}

-(IBAction)contactButtonPressed:(UIButton *)button {
	LatestPromotionContactInfoViewController *contact_controller = [[LatestPromotionContactInfoViewController alloc] initWithNibName:@"LatestPromotionContactInfoView" bundle:nil];
	[self.navigationController pushViewController:contact_controller animated:TRUE];
	[contact_controller release];
}

-(IBAction)detailsButtonPressed:(UIButton *)button {
	NewsPhotosViewController *details_controlller = [[NewsPhotosViewController alloc] initWithNibName:@"NewsPhotosView" bundle:nil];
	details_controlller.items_data = [NSArray arrayWithObject:merchant_info];
	details_controlller.news_id = 0;
	[self.navigationController pushViewController:details_controlller animated:TRUE];
	[details_controlller updateContent];
	[details_controlller release];
}

-(IBAction)tncButtonPressed:(UIButton *)button {
	TermsAndConditionsViewController *tnc_controller = [[TermsAndConditionsViewController alloc] initWithNibName:@"TermsAndConditionsView" bundle:nil];
    [tnc_controller setTncStr:[merchant_info objectForKey:@"remark"]];
	[self.navigationController pushViewController:tnc_controller animated:TRUE];
	tnc_controller.title_label.text = NSLocalizedString(@"Terms and Conditions",nil);
//	tnc_controller.tnc.text = [merchant_info objectForKey:@"remark"];
	[tnc_controller release];
}

-(IBAction)shareButtonPressed:(UIButton *)button {
	UIAlertView *share_prompt = [[[UIAlertView alloc] init] retain];
	[share_prompt setDelegate:self];
	[share_prompt setTitle:NSLocalizedString(@"Share to Friends",nil)];
	[share_prompt setMessage:NSLocalizedString(@"Share App with Friends by Email",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"OK",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"Back",nil)];
	
	
	/*	CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 100.0);
	 [login_prompt setTransform: moveUp];*/
	[share_prompt show];
	[share_prompt release];
}

-(IBAction)bookmarkButtonPressed:(UIButton *)button {
	Bookmark *bookmark_data = [[Bookmark alloc] init];
//	[bookmark_data addBookmark:merchant_info ToGroup:5];
//	[bookmark_data release];
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//	[alert show];
//	[alert release];
	/*UIAlertView *share_prompt = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Add to Bookmark?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
	[share_prompt show];
	[share_prompt release];
	alert_action = AlertActionBookmark;*/
    
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([bookmark_data isOfferExist:merchant_info InGroup:5]) {
        [bookmark_data removeBookmark:merchant_info InGroup:5];
        if ([pageTheme isEqualToString:@"1"]) {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark.png"] forState:UIControlStateNormal];
        } else {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_new.png"] forState:UIControlStateNormal];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Delete from Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else {
        [bookmark_data addBookmark:merchant_info ToGroup:5];
        if ([pageTheme isEqualToString:@"1"]) {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
        } else {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}


/////////////////////////
//UIAlertViewDelegate
/////////////////////////
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"list clicked");
	if (buttonIndex==0) {
		if (alert_action==AlertActionShare) {
            EMailViewController* email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
//			[[CoreData sharedCoreData].email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Spending & Rewards",nil)] Message:[[[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@",
//																																																			NSLocalizedString(@"Spending & Rewards",nil),[merchant_info objectForKey:@"title"],
//																																																			NSLocalizedString(@"Offer details",nil),
//																																																			[[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "]]
//																																																			stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
//																																																			stringByAppendingFormat:@"\n\n\n%@",NSLocalizedString(@"Share App",nil)]];
            [email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Spending & Rewards",nil)] Message:[[[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@",
                                                                                                                                                                                                              NSLocalizedString(@"Spending & Rewards",nil),[merchant_info objectForKey:@"title"],
                                                                                                                                                                                                              NSLocalizedString(@"Offer details",nil),
                                                                                                                                                                                                              [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "]]
                                                                                                                                                                                                             stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                                                                                                                                                                                                            stringByAppendingFormat:@"\n\n\n%@",NSLocalizedString(@"Share App",nil)]];
            self.navigationController.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]+20);
            [self.view addSubview:email.view];
//            [self.view addSubview:[CoreData sharedCoreData].email.view];
		} else if (alert_action==AlertActionBookmark) {
			Bookmark *bookmark_data = [[Bookmark alloc] init];
			[bookmark_data addBookmark:merchant_info ToGroup:5];
			[bookmark_data release];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
}

@end
