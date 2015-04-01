//
//  QuarterlySurpriseSummaryViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuarterlySurpriseSummaryViewController.h"

#define AlertActionShare	0
#define AlertActionBookmark	1

@implementation QuarterlySurpriseSummaryViewController
@synthesize merchant_info;
@synthesize title_label;
@synthesize show_distance, headingTitle;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		show_distance = 0;
    }
    return self;
}

//- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.delegate = self;
//    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
//}
//
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
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
//    self.view.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
//    scroll_view.frame = CGRectMake(0, 127, 320, 195+[[MyScreenUtil me] getScreenHeightAdjust]);
//    tnc.frame = CGRectMake(4, 330+[[MyScreenUtil me] getScreenHeightAdjust], 106, 37);
//    share.frame = CGRectMake(107, 330+[[MyScreenUtil me] getScreenHeightAdjust], 106, 37);
    scroll_view.frame = CGRectMake(scroll_view.frame.origin.x, scroll_view.frame.origin.y, scroll_view.frame.size.width, scroll_view.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    tnc.frame = CGRectMake(tnc.frame.origin.x, tnc.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], tnc.frame.size.width, tnc.frame.size.height);
    share.frame = CGRectMake(share.frame.origin.x, share.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], share.frame.size.width, share.frame.size.height);
    boundImageView.frame = CGRectMake(boundImageView.frame.origin.x, boundImageView.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], boundImageView.frame.size.width, boundImageView.frame.size.height);
    backImageView.frame = CGRectMake(backImageView.frame.origin.x, backImageView.frame.origin.y, backImageView.frame.size.width, backImageView.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    bookmark.frame = CGRectMake(210, 330+[[MyScreenUtil me] getScreenHeightAdjust], 106, 37);

	//title_label.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Quarterly Surprise",nil)];
    title_label.text = headingTitle;
	[tnc setTitle:NSLocalizedString(@"Terms and Conditions",nil) forState:UIControlStateNormal];
	[share setTitle:NSLocalizedString(@"Share Offer",nil) forState:UIControlStateNormal];
//	[bookmark setTitle:NSLocalizedString(@"Add to Bookmark",nil) forState:UIControlStateNormal];
	[ecoupon setTitle:NSLocalizedString(@"e-Coupon",nil) forState:UIControlStateNormal];
	float footer = 0;
	merchant.font = [UIFont boldSystemFontOfSize:16];
	merchant.text = [merchant_info objectForKey:@"title"];
    NSLog(@"merchant.text is %@", merchant.text);
	description.font = [UIFont systemFontOfSize:16];
	description.text = [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
	CGSize maxSize = CGSizeMake(description.frame.size.width - 20, 100000);
	CGSize text_area = [description.text sizeWithFont:description.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
	NSString *image = [merchant_info objectForKey:@"image"];
	if (image!=nil && ![image isEqualToString:@""]) {
        [image_view loadImageWithURL:[[merchant_info objectForKey:@"image"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
	}
	description.frame = CGRectMake(0, 0, 320, text_area.height * 1.1 + 20);
	footer += description.frame.size.height;
	
	NSLog(@"Coupon %@ %d",[merchant_info objectForKey:@"coupon"], [[merchant_info objectForKey:@"coupon"] length]);
	if ([merchant_info objectForKey:@"coupon"]==nil || [[merchant_info objectForKey:@"coupon"] length]<4) {
		ecoupon.hidden = TRUE;
	} else {
		ecoupon.hidden = FALSE;
		ecoupon.frame = CGRectMake(ecoupon.frame.origin.x, footer, ecoupon.frame.size.width, ecoupon.frame.size.height);
		footer += ecoupon.frame.size.height;
	}
    NSLog(@"merchant_info is %@", merchant_info);
	outlet_list_controller = [[OutletListViewController alloc] initWithNibName:@"OutletListView" bundle:nil];
    outlet_list_controller.fromType = @"YRO";
	if (show_distance==0) {
		outlet_list_controller.is_show_distance = FALSE;
	} else {
		outlet_list_controller.is_show_distance = TRUE;
		outlet_list_controller.show_all_in_map = TRUE;
		outlet_list_controller.show_distance = show_distance;
	}
	outlet_list_controller.delegate = self;
	outlet_list_controller.view.frame = CGRectMake(0, footer, 320, 24);
	[scroll_view addSubview:outlet_list_controller.view];
	if (show_distance==0) {
		[outlet_list_controller getMerchantOutletWithRefId:[merchant_info objectForKey:@"id"] QuarterlySurprise:TRUE];
	} else {
		[outlet_list_controller getMerchantOutlet:[merchant_info objectForKey:@"etitle"] QuarterlySurprise:TRUE];
	}
    outlet_list_controller.background_imageView.hidden = YES;
	
	scroll_view.contentSize = CGSizeMake(scroll_view.frame.size.width, description.frame.size.height);
    
    Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([bookmark_data isOfferExist:merchant_info InGroup:3]) {
        if ([pageTheme isEqualToString:@"1"]) {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
        } else {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
        }
    }
    [bookmark_data release];

    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
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
    [backImageView release];
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

-(IBAction)ecouponButtonPressed:(UIButton *)button {
	NSLog(@"ecouponButtonPressed");
	[[CoreData sharedCoreData].ecoupon loadImageWithURL:[merchant_info objectForKey:@"coupon"]];
	[[CoreData sharedCoreData].ecoupon showCoupon];
}

-(IBAction)tncButtonPressed:(UIButton *)button {
	TermsAndConditionsViewController *tnc_controller = [[TermsAndConditionsViewController alloc] initWithNibName:@"TermsAndConditionsView" bundle:nil];
	[self.navigationController pushViewController:tnc_controller animated:TRUE];
	if ([[merchant_info objectForKey:@"remark"] length]>4) {
		tnc_controller.title_label.text = NSLocalizedString(@"Terms and Conditions",nil);
//		tnc_controller.tnc.text = [merchant_info objectForKey:@"remark"];
        [tnc_controller setTncStr:[merchant_info objectForKey:@"remark"]];
	} else {
//		tnc_controller.tnc.text = NSLocalizedString(@"TNC Quarterly",nil);
        [tnc_controller setTncStr:NSLocalizedString(@"TNC Quarterly",nil)];
	}
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
//	[bookmark_data addBookmark:merchant_info ToGroup:3];
//	[bookmark_data release];
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//	[alert show];
//	[alert release];
/*	UIAlertView *share_prompt = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Add to Bookmark?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
	[share_prompt show];
	[share_prompt release];
	alert_action = AlertActionBookmark;*/
    
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([bookmark_data isOfferExist:merchant_info InGroup:3]) {
        [bookmark_data removeBookmark:merchant_info InGroup:3];
        if ([pageTheme isEqualToString:@"1"]) {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark.png"] forState:UIControlStateNormal];
        } else {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_new.png"] forState:UIControlStateNormal];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Delete from Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else {
        [bookmark_data addBookmark:merchant_info ToGroup:3];
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
	if (buttonIndex==0) {
		if (alert_action==AlertActionShare) {
			NSMutableString *contact = [NSMutableString new];
			for (int i=0; i<[outlet_list_controller.items_data count]; i++) {
				[contact appendString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Address",nil),[[outlet_list_controller.items_data objectAtIndex:i] objectForKey:@"address"]]];
				[contact appendString:@"\n"];
				[contact appendString:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Tel",nil),[[outlet_list_controller.items_data objectAtIndex:i] objectForKey:@"tel"]]];
				[contact appendString:@"\n\n"];
			}
            EMailViewController* email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
//			[[CoreData sharedCoreData].email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Quarterly Surprise",nil)] Message:[[[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@\n\n%@",
//																																																			NSLocalizedString(@"Quarterly Surprise",nil),[merchant_info objectForKey:@"title"],
//																																																			NSLocalizedString(@"Offer details",nil),
//																																																			[[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],contact]
//																																																			 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
//																																																			stringByAppendingFormat:@"\n\n\n%@",NSLocalizedString(@"Share QS",nil)]];
            [email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Quarterly Surprise",nil)] Message:[[[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@\n\n%@",
                                                                                                                                                                                                              NSLocalizedString(@"Quarterly Surprise",nil),[merchant_info objectForKey:@"title"],
                                                                                                                                                                                                              NSLocalizedString(@"Offer details",nil),
                                                                                                                                                                                                              [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],contact]
                                                                                                                                                                                                             stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                                                                                                                                                                                                            stringByAppendingFormat:@"\n\n\n%@",NSLocalizedString(@"Share QS",nil)]];
            self.navigationController.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]+20);
            [self.view addSubview:email.view];
//            [self.view addSubview:[CoreData sharedCoreData].email.view];
		} else if (alert_action==AlertActionBookmark) {
			Bookmark *bookmark_data = [[Bookmark alloc] init];
			[bookmark_data addBookmark:merchant_info ToGroup:3];
			[bookmark_data release];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		/*
		NSMutableString *contact = [NSMutableString new];
		for (int i=0; i<[outlet_list_controller.items_data count]; i++) {
			[contact appendString:[NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"Address",nil),[[outlet_list_controller.items_data objectAtIndex:i] objectForKey:@"address"]]];
			[contact appendString:@"\n"];
			[contact appendString:[NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"Tel",nil),[[outlet_list_controller.items_data objectAtIndex:i] objectForKey:@"tel"]]];
			[contact appendString:@"\n\n"];
		}*/
	}
}

/////////////////////////
//OutletListViewDelegate
/////////////////////////
-(void) OutletListUpdated:(NSArray *)items_data {
	outlet_list_controller.view.frame = CGRectMake(0, outlet_list_controller.view.frame.origin.y, 320, 24 + [items_data count] * 81);
//	scroll_view.contentSize = CGSizeMake(scroll_view.frame.size.width, outlet_list_controller.view.frame.origin.y + outlet_list_controller.view.frame.size.height);
    scroll_view.contentSize = CGSizeMake(scroll_view.frame.size.width, outlet_list_controller.view.frame.origin.y + outlet_list_controller.view.frame.size.height - 1);
}

@end
