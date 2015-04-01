//
//  PBConcertsSummaryViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PBConcertsSummaryViewController.h"
#define MerchantLogoWidth	80

#define AlertActionShare	0
#define AlertActionBookmark	1
#define AlertActionPhone	2
#define AlertActionWeb      3

@implementation PBConcertsSummaryViewController
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    isInit = YES;
    tnc.frame = CGRectMake(tnc.frame.origin.x, tnc.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], tnc.frame.size.width, tnc.frame.size.height);
    share.frame =  CGRectMake(share.frame.origin.x, share.frame.origin.y+[[MyScreenUtil me] getScreenHeightAdjust], share.frame.size.width, share.frame.size.height);
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
//      merchant.frame = CGRectMake(merchant.frame.origin.x, merchant.frame.origin.y-20, merchant.frame.size.width, merchant.frame.size.height);
//        scroll_view.frame = CGRectMake(scroll_view.frame.origin.x, scroll_view.frame.origin.y, scroll_view.frame.size.width, scroll_view.frame.size.height);
    }
    scroll_view.frame = CGRectMake(scroll_view.frame.origin.x, scroll_view.frame.origin.y, scroll_view.frame.size.width, scroll_view.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
	//
	[tnc setTitle:NSLocalizedString(@"Terms and Conditions",nil) forState:UIControlStateNormal];
	[share setTitle:NSLocalizedString(@"Share Offer",nil) forState:UIControlStateNormal];
	
	float footer = 0;
	merchant.text = [merchant_info objectForKey:@"title"];
	
	if ([merchant_info objectForKey:@"preview"]!=nil && [[merchant_info objectForKey:@"preview"] length]>2) {
		[preview loadImageWithURL:[merchant_info objectForKey:@"preview"]];
		footer = preview.frame.origin.y + preview.frame.size.height;
	
    merchants = [merchant_info objectForKey:@"merchants"];
        if (merchants.count > 0) {
            footer += 10;
            
            UIScrollView *photoscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, footer, scroll_view.frame.size.width, 50)];
            for (int i = 0; i < merchants.count; i++) {
                merchantImg = [[CachedImageView alloc] initWithFrame:CGRectMake(87 * i, 0, 82, 40)];
                merchantImg.contentMode = UIViewContentModeScaleAspectFit;
                [merchantImg loadImageWithURL:[merchants objectAtIndex:i]];
                [photoscroll addSubview:merchantImg];
                photoscroll.contentSize = CGSizeMake(87 * i + 82, 40);
                //            NSLog(@"%@",NSStringFromCGSize(merchantImg.image.size));
                //            footer = merchantImg.frame.origin.y + merchantImg.frame.size.height;
                //            [scroll_view addSubview:merchantImg];
                NSLog(@"%@",NSStringFromCGRect(merchant.frame));
                NSLog(@"%@",[merchants objectAtIndex:i]);
            }
            [scroll_view addSubview:photoscroll];
            footer += photoscroll.frame.size.height;
        }
       
    }
    
	description.font = [UIFont systemFontOfSize:16];
    NSString *descriptionStr=[[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
	description.text = descriptionStr;
	NSLog(@"debug PBConcertsSummaryViewController description:%@",description.text);
    int descriptionH=[self fitHeight:description];
	description.frame = CGRectMake(5, footer, 310, descriptionH);
	footer += descriptionH;
	
    CGFloat labelH = 40.0;
    CGFloat labelW = 300.0;
    if ([[merchant_info objectForKey:@"concert_date"] length] != 0) {
        UILabel *datestringLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
        datestringLabel.font = [UIFont boldSystemFontOfSize:16];
        datestringLabel.text = NSLocalizedString(@"Concert dates and time", nil);
        [scroll_view addSubview:datestringLabel];
        footer += labelH;
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
        dateLabel.font = [UIFont systemFontOfSize:16];
        dateLabel.text = [merchant_info objectForKey:@"concert_date"];
        footer += [self fitHeightLabel:dateLabel];;
        [scroll_view addSubview:dateLabel];
        
        if ([[merchant_info objectForKey:@"venue"] length] != 0) {
            UILabel *addressStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
            addressStringLabel.font = [UIFont boldSystemFontOfSize:16];
            addressStringLabel.text = NSLocalizedString(@"Venue", nil);
            footer += labelH;
            [scroll_view addSubview:addressStringLabel];
            UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
            addressLabel.font = [UIFont systemFontOfSize:16];
            addressLabel.text = [merchant_info objectForKey:@"venue"];
            footer += [self fitHeightLabel:addressLabel];
            [scroll_view addSubview:addressLabel];
        }
        if ([[merchant_info objectForKey:@"price"] length] != 0) {
            UILabel *priceStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
            priceStringLabel.font = [UIFont boldSystemFontOfSize:16];
            priceStringLabel.text = NSLocalizedString(@"Ticket price", nil);
            footer += labelH;
            [scroll_view addSubview:priceStringLabel];
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
            priceLabel.font = [UIFont systemFontOfSize:16];
            priceLabel.text = [merchant_info objectForKey:@"price"];
            footer += [self fitHeightLabel:priceLabel];
            [scroll_view addSubview:priceLabel];
        }
        
        if ([[merchant_info objectForKey:@"start"] length] != 0 && [[merchant_info objectForKey:@"expire"] length] != 0) {
            UILabel *prioritybookingDateStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
            prioritybookingDateStringLabel.font = [UIFont boldSystemFontOfSize:16];
            prioritybookingDateStringLabel.text = NSLocalizedString(@"Priority booking period", nil);
            footer += labelH;
            [scroll_view addSubview:prioritybookingDateStringLabel];
            UILabel *prioritybookingDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
            prioritybookingDateLabel.font = [UIFont systemFontOfSize:16];
            prioritybookingDateLabel.text = [NSString stringWithFormat:@"%@%@%@",[merchant_info objectForKey:@"start"],NSLocalizedString(@"Book fail2", nil),[merchant_info objectForKey:@"expire"]];
            footer += [self fitHeightLabel:prioritybookingDateLabel];
            [scroll_view addSubview:prioritybookingDateLabel];
        }
        
        if ([[merchant_info objectForKey:@"book_hotline"] length] != 0) {
            UILabel *bookTelStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
            bookTelStringLabel.font = [UIFont boldSystemFontOfSize:16];
            bookTelStringLabel.text = NSLocalizedString(@"Priority booking hotline", nil);
            footer += labelH;
            [scroll_view addSubview:bookTelStringLabel];
            UIButton *bookTelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            bookTelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            bookTelButton.frame = CGRectMake(8.0, footer, labelW, labelH);
            bookTelButton.titleLabel.font = [UIFont systemFontOfSize:16];
            bookTelButton.backgroundColor = [UIColor clearColor];
            [bookTelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [bookTelButton setTitle:[merchant_info objectForKey:@"book_hotline"] forState:UIControlStateNormal];
            [bookTelButton addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat buttonH = [self fitHeightLabel:bookTelButton.titleLabel];
            bookTelButton.frame = CGRectMake(8.0 + 20, footer, labelW - buttonH, buttonH);
            UIImageView *bookTelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8.0, footer + (buttonH - 14) / 2, 14, 14)];
            bookTelImageView.image = [UIImage imageNamed:@"telephone.png"];
            footer += buttonH;
            [self addLine:bookTelButton];
            [scroll_view addSubview:bookTelImageView];
            [scroll_view addSubview:bookTelButton];
        }
        
        if ([[merchant_info objectForKey:@"website"] length] != 0) {
            UILabel *bookWebStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, footer, labelW, labelH)];
            bookWebStringLabel.font = [UIFont boldSystemFontOfSize:16];
            bookWebStringLabel.text = NSLocalizedString(@"Priority booking link", nil);
            footer += labelH;
            [scroll_view addSubview:bookWebStringLabel];
            UIButton *bookWebButton = [UIButton buttonWithType:UIButtonTypeCustom];
            bookWebButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            bookWebButton.frame = CGRectMake(8.0, footer - 5, labelW, labelH);
            bookWebButton.titleLabel.font = [UIFont systemFontOfSize:16];
            bookWebButton.backgroundColor = [UIColor clearColor];
            [bookWebButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            bookWebButton.imageView.image = [UIImage imageNamed:@"handset_black"];
            [bookWebButton setTitle:[merchant_info objectForKey:@"website"] forState:UIControlStateNormal];
            [bookWebButton addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat buttonH = [self fitHeightLabel:bookWebButton.titleLabel];
            bookWebButton.frame = CGRectMake(8.0, footer, labelW, buttonH);
            footer += buttonH;
            [self addLine:bookWebButton];
            [scroll_view addSubview:bookWebButton];
        }

    }
    
    footer += 20;
    scroll_view.contentSize = CGSizeMake(320, footer);
    Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([bookmark_data isOfferExist:merchant_info InGroup:6]) {
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
    } else {
        [self setMenuBar2];
    }
//    if ([UIScreen mainScreen].bounds.size.height == 480) {
//        CGRect frame = merchant.frame;
//        frame.origin.y += 12;
//        merchant.frame = frame;
//    }
//    [self adjustViewByRotateMenuType];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

- (void)setViewControllerPushType:(NSInteger)type {
    pushType = type;
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
    [v_rmvc.rmUtil setShowIndex:1];
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
//        [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
//        UIButton* tmp_button=[[UIButton alloc] init];
//        tmp_button.tag=4;
//        [(HomeViewController*)([CoreData sharedCoreData].root_view_controller.current_view_controller) buttonPressed:tmp_button];
//        [tmp_button release];
        if (isInit) {
            isInit = NO;
            return;
        }
        [self.navigationController popViewControllerAnimated:NO];
    } else if (show%6==2) {
        [self.navigationController popViewControllerAnimated:NO];
        UIButton* tmp_button=[[UIButton alloc] init];
        tmp_button.tag=1;
        [[CoreData sharedCoreData].home_view_controller buttonPressed:tmp_button];
        [tmp_button release];
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
    [super dealloc];
}

-(IBAction)detailsButtonPressed:(UIButton *)button {
}

-(IBAction)tncButtonPressed:(UIButton *)button {
	TermsAndConditionsViewController *term_controller = [[TermsAndConditionsViewController alloc] initWithNibName:@"TermsAndConditionsView" bundle:nil];
    [term_controller setTncStr:[merchant_info objectForKey:@"remark"]];
	[self.navigationController pushViewController:term_controller animated:TRUE];
//	term_controller.tnc.text = [merchant_info objectForKey:@"remark"];
	[term_controller release];
}

-(IBAction)shareButtonPressed:(UIButton *)button {
	UIAlertView *share_prompt = [[[UIAlertView alloc] init] retain];
	[share_prompt setDelegate:self];
	[share_prompt setTitle:NSLocalizedString(@"Share to Friends",nil)];
	[share_prompt setMessage:NSLocalizedString(@"Share Offers with Friends by Email",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"OK",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"Back",nil)];
    alert_action = AlertActionShare;
	[share_prompt show];
	[share_prompt release];
}

-(IBAction)bookmarkButtonPressed:(UIButton *)button {
	Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([bookmark_data isOfferExist:merchant_info InGroup:6]) {
        [bookmark_data removeBookmark:merchant_info InGroup:6];
        if ([pageTheme isEqualToString:@"1"]) {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark.png"] forState:UIControlStateNormal];
        } else {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_new.png"] forState:UIControlStateNormal];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Delete from Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
        alert_action = AlertActionBookmark;
        [alert show];
        [alert release];
    } else {
        [bookmark_data addBookmark:merchant_info ToGroup:6];
        if ([pageTheme isEqualToString: @"1"]) {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
        } else {
            [bookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
        alert_action = AlertActionBookmark;
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
//			NSMutableString *contact = [NSMutableString new];
//			[contact appendString:NSLocalizedString(@"Concert dates and time",nil)];
//			[contact appendString:@"\n"];
//			[contact appendString:[merchant_info objectForKey:@"concert_date"]];
//			[contact appendString:@"\n\n"];
//			[contact appendString:NSLocalizedString(@"Venue",nil)];
//			[contact appendString:@"\n"];
//			[contact appendString:[merchant_info objectForKey:@"venue"]];
//			[contact appendString:@"\n\n"];
//			[contact appendString:NSLocalizedString(@"Ticket price",nil)];
//			[contact appendString:@"\n"];
//			[contact appendString:[merchant_info objectForKey:@"price"]];
//			[contact appendString:@"\n\n"];
//			[contact appendString:NSLocalizedString(@"Priority booking period",nil)];
//			[contact appendString:@"\n"];
//			[contact appendString:book_dates.text];
//			[contact appendString:@"\n\n"];
//			[contact appendString:NSLocalizedString(@"Priority booking hotline",nil)];
//			[contact appendString:@"\n"];
//			[contact appendString:[NSString stringWithFormat:@"%@",[merchant_info objectForKey://@"book_hotline"]]];
//			[contact appendString:@"\n\n"];
            NSString *contact = @"";
            EMailViewController* email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
//			[[CoreData sharedCoreData].email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"BEA Credit Card",nil), NSLocalizedString(@"Priority Booking for Concerts",nil)]
//                                                               Message:[[[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@\n\n%@",
//                                                                          NSLocalizedString(@"Priority Booking for Concerts",nil),
//                                                                          [[merchant_info objectForKey:@"title"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],
//                                                                          NSLocalizedString(@"Offer details",nil),
//                                                                          [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],
//                                                                          contact]
//                                                                         stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
//                                                                        stringByAppendingFormat:@"\n\n\n%@",NSLocalizedString(@"Share App",nil)]];
            [email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"BEA Credit Card",nil), NSLocalizedString(@"Priority Booking for Concerts",nil)]
                                                               Message:[[[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@\n\n%@",
                                                                          NSLocalizedString(@"Priority Booking for Concerts",nil),
                                                                          [[merchant_info objectForKey:@"title"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],
                                                                          NSLocalizedString(@"Offer details",nil),
                                                                          [[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],
                                                                          contact]
                                                                         stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                                                                        stringByAppendingFormat:@"\n\n\n%@",NSLocalizedString(@"Share App",nil)]];
            self.navigationController.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]+20);
            [self.view addSubview:email.view];
//            [self.view addSubview:[CoreData sharedCoreData].email.view];
//			[[CoreData sharedCoreData].email createComposerWithSubject:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"BEA Credit Card",nil),NSLocalizedString(@"Priority Booking for Concerts",nil)] Message:[NSString stringWithFormat:@"%@ - %@\n\n%@\n%@\n\n%@\n%@",NSLocalizedString(@"Priority Booking for Concerts",nil),[[merchant_info objectForKey:@"title"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],NSLocalizedString(@"Offer details",nil),[[merchant_info objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "],contact,NSLocalizedString(@"Share App",nil)]];
		} else if (alert_action==AlertActionBookmark) {
			Bookmark *bookmark_data = [[Bookmark alloc] init];
			[bookmark_data addBookmark:merchant_info ToGroup:6];
			[bookmark_data release];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Bookmark",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	} else {
		if (alert_action==AlertActionPhone) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[merchant_info objectForKey:@"book_hotline"] stringByReplacingOccurrencesOfString:@" " withString:@""]]]];
		}
	}
}
- (int) fitHeight:(UITextView*)sender
{
    NSLog(@"debug  fitHeight:%@", sender.text);
    
    CGSize maxSize = CGSizeMake(sender.frame.size.width, MAXFLOAT);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height);
    int height = sender.frame.size.height;
    if ([[[UIDevice currentDevice].systemVersion substringToIndex:1] intValue] >= 7) {
        height += height / 20 * 3;
    }else {
        height = sender.contentSize.height + 30;
    }
    
    NSLog(@"debug  fitHeight:%d", height);
    return height;
}

- (CGFloat)fitHeightLabel:(UILabel*)label {
    label.numberOfLines = 0;
    CGSize labelSize = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = label.frame;
    frame.size.height = labelSize.height;
    label.frame = frame;
    return label.frame.size.height;
}

- (void)addLine:(UIButton *)button {
    CGSize labelSize = [button.titleLabel.text sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(button.titleLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    CGRect frame = CGRectMake(0.0, button.frame.size.height - 2, labelSize.width, 1);
    UILabel *line = [[UILabel alloc] initWithFrame:frame];
    line.text = @"";
    line.backgroundColor = [UIColor blueColor];
    [button addSubview:line];
}

-(void)call:(UIButton *)button{
	NSLog(@"phone call pressed");
    if ([self compareDate]) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",[button titleForState:UIControlStateNormal]] message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
        alert_action = AlertActionPhone;
        [alert_view show];
        [alert_view release];
    }else {
        NSString *message = [NSString stringWithFormat:@"%@%@%@%@%@",NSLocalizedString(@"Book fail1", nil),[merchant_info objectForKey:@"start"],NSLocalizedString(@"Book fail2", nil),[merchant_info objectForKey:@"expire"],NSLocalizedString(@"Book fail3", nil)];
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:nil,nil];
        alert_action = AlertActionPhone;
        [alert_view show];
        [alert_view release];
    }
}

-(void)open:(UIButton *)button{
    NSURL *url;
    if ([[merchant_info objectForKey:@"website"] rangeOfString:@"http://"].location != NSNotFound){
        url = [NSURL URLWithString:[merchant_info objectForKey:@"website"]];
    }else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[merchant_info objectForKey:@"website"]]];
    }
    
    [[UIApplication sharedApplication] openURL:url];
}

- (BOOL)compareDate {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSString *startDateString = [merchant_info objectForKey:@"start"];;
    NSString *endDateString = [merchant_info objectForKey:@"expire"];
    if ([[merchant_info objectForKey:@"start"] intValue] > 31) {
        format.dateFormat = @"yyyy年M月d日";
    }else {
        format.dateFormat = @"d MMM, yyyy";
    }
    NSDate *startDate = [[format dateFromString:startDateString] dateByAddingTimeInterval:60 * 60 * 8];
    NSDate *endDate = [[format dateFromString:endDateString] dateByAddingTimeInterval:60 * 60 * 32];
    NSDate *nowDate = [[NSDate date] dateByAddingTimeInterval:8 * 60 * 60];
    if ([nowDate compare:startDate] ==  NSOrderedDescending && [nowDate compare:endDate] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

@end
