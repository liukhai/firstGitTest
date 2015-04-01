
//
//  BEAViewController.m
//  BEA
//
//  Created by Algebra Lo on 10年6月25日.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BEAViewController.h"
#import "HttpRequestUtils.h"
//static NSUInteger kNumberOfPages = 2;
#import "AccProUtil.h"
#import "InstalmentLoanUtil.h"
#import "MPFUtil.h"
#import "MPFRateUtil.h"
#import "AccProListViewController.h"
#import "InstalmentLoanViewController.h"
#import "InsuranceUtil.h"
//#import "NewBranchBannerUtil.h"
#import "StockGameCentreUtil.h"
#import "MKGeCardUtil.h"
#import "MigrationSetting.h"

#import "ATMFavouriteListViewController.h"
#import "ImportantNoticeMenuViewController.h"
#import "AdvanceSearchViewController.h"

#import "SideMenuUtil.h"
#import "CyberFundSearchWebViewController.h"
//<!--------------MegaHub----------------------------
#import "MHBEAWebTradeStockViewController.h"
#import "MHBEABuySellStockViewController.h"
#import "MHBEAWatchlistLv0ViewController.h"
#import "MHBEAPTSSIndexViewController.h"
#import "MHBEAFAQuoteViewController.h"
#import "MHDisclaimerViewController.h"
#import "ViewControllerDirector.h"
#import "MHBEADelegate.h"
//----------------MegaHub--------------------------!>

#import "P2PMenuViewController.h"
#import "FacebookListViewController.h"
#import "FacebookViewController.h"
#import "FacebookViewController2.h"
#import "HomeViewController.h"

#import "UserDefaultUtil.h"
//#import "ReadTagViewController.h"
@class ReadTagViewController;

@implementation BEAViewController

//@synthesize btnPagePrev;
//@synthesize btnPageNext;
//@synthesize delight_view_controller;
//@synthesize atmlocation_view_controller;
@synthesize taxLoan_view_controller;
//@synthesize hotline_view_controller; // -- added by yelong on 2011.03.02
@synthesize _PropertyLoanViewController;
//@synthesize _ImportantNoticeViewController;

@synthesize as_menu;
@synthesize nav_bar_bg;

//<!--------------MegaHub----------------------------
@synthesize m_oMHBEAFAQuoteViewController;
//@synthesize m_oMHBEAPTSSIndexViewController;
//@synthesize m_oMHBEAWatchlistLv0ViewController;
//@synthesize m_oMHBEABuyStockViewController;
//@synthesize m_oMHBEASellStockViewController;
//@synthesize m_oMHBEAWebTradeBuyStockViewController;
//@synthesize m_oMHBEAWebTradeSellStockViewController;
@synthesize m_oMHViewControllers;
@synthesize isInStockWatch;
//----------------MegaHub--------------------------!>

@synthesize
mmenuv0,
mmenuv1,
mmenuv2,
v_rmvc;

@synthesize plistvc1;
@synthesize plistvc2;
@synthesize plistvc3;

@synthesize m_view_megahub;

@synthesize vc4process;
@synthesize fromWhere;

-(void) goMainFaster
{
    NSLog(@"debug goMainFaster:%@", self);
    
}

- (IBAction)doAction4Tag:(id)sender {
    //    ReadTagViewController* vc = nil;
    //    vc = [[ReadTagViewController alloc] initWithNibName:@"ReadTagViewController" bundle:nil];
    //    [self.navigationController pushViewController:vc animated:TRUE];
    //    [vc release];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    if ([CoreData sharedCoreData].goBanking) {
        [v_rmvc.rmUtil showMenu:1];
        [CoreData sharedCoreData].goBanking = NO;
    }
//<!--------------MegaHub----------------------------
    [m_oMHBEAWatchlistLv0ViewController viewWillAppear:animated];
//----------------MegaHub--------------------------!>
    [self setPromoInMainPage1];
    [self setPromoInMainPage2];
    [self setPromoInMainPage3];
//    [self checkWifiNetWorkAvailable];
}

-(void)setTexts {
	//self.navigationItem.title = NSLocalizedString(@"Main Menu",nil);
	self.navigationItem.title = @"";//NSLocalizedString(@"Main Menu",nil);
	self.navigationItem.backBarButtonItem.title = NSLocalizedString(@"Back",nil);

    cyberbanking_button.accessibilityLabel = NSLocalizedString(@"Cyberbanking_accessibility", nil);    
    supremeGold_button.accessibilityLabel = NSLocalizedString(@"SupremeGold_accessibitliy",nil);
    taxloan_button.accessibilityLabel = NSLocalizedString(@"ConsumerLoanMenu_accessibility",nil);
    property_loans_button.accessibilityLabel = NSLocalizedString(@"PropertyLoan_accessibility",nil);
    Insurance_button.accessibilityLabel = NSLocalizedString(@"insurance.name_accessibility",nil);
    mpf_button.accessibilityLabel = NSLocalizedString(@"mpf.label_accessibility",nil);
    eas_cybertrading_button.accessibilityLabel = NSLocalizedString(@"tag_stocks_accessibility",nil);
    atm_button.accessibilityLabel = NSLocalizedString(@"ATM Location_accessibility",nil);
    hotline_button.accessibilityLabel = NSLocalizedString(@"HotlineMenu_accessibility",nil);
    banking_more.accessibilityLabel = NSLocalizedString(@"privileges_tag_more",nil);
    credit_button.accessibilityLabel = NSLocalizedString(@"Credit Card_accessibility",nil);
    year_round_dinner.accessibilityLabel = NSLocalizedString(@"tag_year_round_dining_accessibility",nil);
    year_round_shopping.accessibilityLabel = NSLocalizedString(@"tag_year_round_shopping_accessibility",nil);
    cash_in_hand.accessibilityLabel = NSLocalizedString(@"tag_fav_cc_cash_in_hand_accessibility",nil);
    facebook_button.accessibilityLabel = NSLocalizedString(@"Facebook_accessibility", nil);
    stockgame_button.accessibilityLabel = NSLocalizedString(@"tag_game", nil);
    P2P.accessibilityLabel = NSLocalizedString(@"tag_p2p",nil);
    credit_card_latest_promotions_more.accessibilityLabel = NSLocalizedString(@"tag_bar_creditcard_more", nil);
    Concert_Movie_Offers_more.accessibilityLabel = NSLocalizedString(@"tag_bar_offer_more", nil);
    notes_exchange_rates_button.accessibilityLabel = NSLocalizedString(@"tag_rates_notes_accessibility",nil);
    tt_exchange_rates_button.accessibilityLabel = NSLocalizedString(@"tag_rates_tt_accessibility",nil);
    gold_button.accessibilityLabel = NSLocalizedString(@"tag_gold_accessibility",nil);
    icoupon_button.accessibilityLabel = NSLocalizedString(@"iCoupon.title_accessibility", nil);
    
	[credit_label setText:NSLocalizedString(@"Credit Card",nil)];
    [supremeGold_label setText:NSLocalizedString(@"SupremeGold",nil)];
	[cyberbanking_label setText:NSLocalizedString(@"Cyberbanking",nil)];
	[cybertrading_label setText:NSLocalizedString(@"Cybertrading",nil)];
	[settings_label setText:NSLocalizedString(@"Settings",nil)];
    [property_loans_label setText:NSLocalizedString(@"PropertyLoan",nil)];
	[atm_label setText:NSLocalizedString(@"ATM Location",nil)];
//	[atm_label2 setText:NSLocalizedString(@"Nearby",nil)];
    [facebook_label setText:NSLocalizedString(@"Facebook", nil)];
	[hotline_label setText:NSLocalizedString(@"HotlineMenu",nil)]; // --added by yelong on 2011.03.02
	// -- ended by yelong on 2011.03.03
//	[eas_cybertrading_label setText:NSLocalizedString(@"eas_cybertrading",nil)];
    [mpf_label setText:NSLocalizedString(@"mpf.label",nil)];
    [AccPro_label setText:NSLocalizedString(@"accpro.tag.title",nil)];
	[Rate_label setText:NSLocalizedString(@"Rate.name",nil)];
    [Insurance_label setText:NSLocalizedString(@"insurance.name",nil)];

    [InstalmentLoan_label setText:NSLocalizedString(@"InstalmentLoan.name", nil)];

    [SGG_label setText:NSLocalizedString(@"SGG.name", nil)];
    [CyberFundSearch_label setText:NSLocalizedString(@"cyberfundsearch.name", nil)];
    [stockgame_label setText:NSLocalizedString(@"StockGameCentre.lable", nil)];

    [stockgame_label setText:NSLocalizedString(@"tag_game", nil)];
    
    [taxloan_label setText:NSLocalizedString(@"ConsumerLoanMenu",nil)];
    [icoupon_label setText:NSLocalizedString(@"iCoupon.title", nil)];
    NSArray *a_texts = [NSLocalizedString(@"rotatemenu.texts",nil) componentsSeparatedByString:@","];
    NSLog(@"v_rmvc.rmUtil setTextArray:%@",a_texts);
    [v_rmvc.rmUtil setTextArray:a_texts];
    [v_rmvc.rmUtil showMenu];
    
    [m_oMHBEAWatchlistLv0ViewController reloadText];

    [lifestyle_tag0 setText:NSLocalizedString(@"tag_year_round_dining",nil)];
    [lifestyle_tag1 setText:NSLocalizedString(@"tag_year_round_shopping",nil)];
    [lifestyle_tag2 setText:NSLocalizedString(@"tag_fav_cc_cash_in_hand",nil)];
    [lifestyle_tag3 setText:NSLocalizedString(@"tag_rewards",nil)];
    [lifestyle_tag4 setText:NSLocalizedString(@"tag_bar_creditcard",nil)];
    [lifestyle_tag5 setText:NSLocalizedString(@"tag_bar_offer",nil)];
    [lifestyle_tag6 setText:NSLocalizedString(@"tag_p2p",nil)];
    [lifestyle_tag7 setText:NSLocalizedString(@"tag_more",nil)];
    [lifestyle_tag8 setText:NSLocalizedString(@"tag_more",nil)];
    [privilegeMore_label setText:NSLocalizedString(@"tag_more",nil)];

    [banking_tag0 setText:NSLocalizedString(@"tag_stocks",nil)];
    [banking_tag1 setText:NSLocalizedString(@"tag_fav_insurance",nil)];
    [banking_tag2 setText:NSLocalizedString(@"tag_fav_mpf",nil)];
    [banking_tag3 setText:NSLocalizedString(@"tag_fav_privileges",nil)];
    [banking_tag4 setText:NSLocalizedString(@"tag_more",nil)];

    [wealth_tag0 setText:NSLocalizedString(@"tag_rates_notes",nil)];
    [wealth_tag1 setText:NSLocalizedString(@"tag_rates_tt",nil)];
    [wealth_tag2 setText:NSLocalizedString(@"tag_rates_prime",nil)];
    [wealth_tag3 setText:NSLocalizedString(@"tag_gold",nil)];

    [_label_P2P setText:NSLocalizedString(@"tag_p2p",nil)];

    [self setPromoInMainPage1];
    [self setPromoInMainPage2];
    [self setPromoInMainPage3];
    
    //edit by chu 20150224
    cyberbanking_label.isAccessibilityElement = NO;
    supremeGold_label.isAccessibilityElement = NO;
    taxloan_label.isAccessibilityElement = NO;
    property_loans_label.isAccessibilityElement = NO;
    banking_tag0.isAccessibilityElement = NO;
    banking_tag1.isAccessibilityElement = NO;
    banking_tag2.isAccessibilityElement = NO;
    atm_label.isAccessibilityElement = NO;
    hotline_label.isAccessibilityElement = NO;
    
    wealth_tag0.isAccessibilityElement = NO;
    wealth_tag1.isAccessibilityElement = NO;
    wealth_tag3.isAccessibilityElement = NO;
    
    credit_label.isAccessibilityElement = NO;
    icoupon_label.isAccessibilityElement = NO;
    lifestyle_tag0.isAccessibilityElement = NO;
    lifestyle_tag1.isAccessibilityElement = NO;
    lifestyle_tag2.isAccessibilityElement = NO;
    facebook_label.isAccessibilityElement = NO;
    
    
}

-(void)setGameButton {
    if ([[StockGameCentreUtil me] isGameOn]) {
        facebook_button.hidden = YES;
        facebook_label.hidden = YES;
        stockgame_button.hidden = NO;
        stockgame_label.hidden = NO;
    } else {
        stockgame_button.hidden = YES;
        stockgame_label.hidden = YES;
        facebook_button.hidden = NO;
        facebook_label.hidden = NO;
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [self checkWifiNetWorkAvailable];
	NSLog(@"BEAViewController viewDidLoad lang:%@", [[LangUtil me] getLangPref]);
	[CoreData sharedCoreData].bea_view_controller = self;
    [super viewDidLoad];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];

    //<!--------------MegaHub----------------------------
    self.isInStockWatch = @"";
    m_oMHViewControllers = [[NSMutableArray alloc] init];
    
    [[ViewControllerDirector sharedViewControllerDirector] removeObserver:self];
    [[ViewControllerDirector sharedViewControllerDirector] addObserver:self action:@selector(onReceiveViewControllerDirector:)];
    m_oMHBEAWatchlistLv0ViewController = [[MHBEAWatchlistLv0ViewController alloc] init];
    [m_view_megahub addSubview:m_oMHBEAWatchlistLv0ViewController.view];
    //----------------MegaHub--------------------------!>
    
    
    //    NSString *main_bg_name = @"index_bg.png";
    //    if ([[MyScreenUtil me] getScreenHeightAdjust]>0) {
    //        main_bg_name = @"index_bg-568h@2x.png";
    //    }
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:main_bg_name]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    NSLog(@"debug main_bg_name:%@--%@", main_bg_name, bgv);
    self.view.frame = CGRectMake(0, 20, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    scrollView.frame = CGRectMake(0, 94, 320, 366+[[MyScreenUtil me] getScreenHeightAdjust]);
//    pageControl.frame = CGRectMake(139, 350+[[MyScreenUtil me] getScreenHeightAdjust], 43, 36);

    //	//self.navigationItem.title = NSLocalizedString(@"Main Menu",nil);
    //	self.navigationItem.title = @"";//NSLocalizedString(@"Main Menu",nil);
    //	self.navigationItem.backBarButtonItem.title = NSLocalizedString(@"Back",nil);

	// a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    //    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;

    //	[credit_label setText:NSLocalizedString(@"Credit Card",nil)];
    //	[cyberbanking_label setText:NSLocalizedString(@"Cyberbanking",nil)];
    //	[cybertrading_label setText:NSLocalizedString(@"Cybertrading",nil)];
    //	[settings_label setText:NSLocalizedString(@"Settings",nil)];
    //	[property_loans_label setText:NSLocalizedString(@"PropertyLoan",nil)];
    //	[atm_label setText:NSLocalizedString(@"ATM Location",nil)];
    //	[hotline_label setText:NSLocalizedString(@"HotlineMenu",nil)]; // --added by yelong on 2011.03.02
    //	// -- ended by yelong on 2011.03.03
    //	[eas_cybertrading_label setText:NSLocalizedString(@"eas_cybertrading",nil)];
    //    [mpf_label setText:NSLocalizedString(@"mpf.label",nil)];
    //    [AccPro_label setText:NSLocalizedString(@"accpro.tag.title",nil)];
    //	[Rate_label setText:NSLocalizedString(@"Rate.name",nil)];
    //    [Insurance_label setText:NSLocalizedString(@"insurance.name",nil)];
    //
    //    [InstalmentLoan_label setText:NSLocalizedString(@"InstalmentLoan.name", nil)];
    //
    //    [SGG_label setText:NSLocalizedString(@"SGG.name", nil)];
    //    [CyberFundSearch_label setText:NSLocalizedString(@"cyberfundsearch.name", nil)];
    //    [stockgame_label setText:NSLocalizedString(@"StockGameCentre.lable", nil)];
    //
    //	//<!------------------Megahub----------------
    //	[myclick_label setText:NSLocalizedString(@"megahub.stockwatch.title", nil)];

    //    //setup the sequence of the icons in main menu page
    //	NSMutableArray* btn_arr = [NSMutableArray arrayWithObjects:
    //                               //==Page 1==
    //                               //Row 1
    //                               cyberbanking_button,
    //                               credit_button,
    //                               myclick_button,
    //                               //Row 2
    //                               AccPro_button,
    //                               taxloan_button,
    //                               cybertrading_button,
    //                               //Row 3
    //                               mpf_button,
    ////                               stockgame_button,
    //                               Insurance_button,
    //                               eas_cybertrading_button,
    //
    //                               //==Page 2==
    //                               //Row 1
    //                               property_loans_button,
    //                               CyberFundSearch_button,
    //                               atm_button,
    //
    //                               //Row 2
    //                               Rate_button,
    //                               hotline_button,
    //
    //                               //Row 3
    //                               settings_button,
    //                               nil];
    //	NSMutableArray* lab_arr = [NSMutableArray arrayWithObjects:
    //                               //==Page 1=
    //                               //Row 1
    //                               cyberbanking_label,
    //                               credit_label,
    //                               myclick_label,
    //                               //Row 2
    //                               AccPro_label,
    //                               taxloan_label,
    //                               cybertrading_label,
    //                               //Row 3
    //                               mpf_label,
    ////                               stockgame_label,
    //                               Insurance_label,
    //                               eas_cybertrading_label,
    //
    //                               //==Page 2==
    //                               //Row 1
    //                               property_loans_label,
    //                               CyberFundSearch_label,
    //                               atm_label,
    //
    //
    //                               //Row 2
    //                               Rate_label,
    //                               hotline_label,
    //
    //                               //Row 3
    //                               settings_label,
    //                               nil];

    //	if ([TaxLoanUtil isValidUtil]) {
    //    [taxloan_label setText:NSLocalizedString(@"ConsumerLoanMenu",nil)];
    //	}else {
    //		[btn_arr removeObject: taxloan_button];
    //		[lab_arr removeObject: taxloan_label];
    //		taxloan_button.hidden = YES;
    //		taxloan_label.hidden = YES;
    //	}
    [[StockGameCentreUtil me] requestAPIDatas];
    //    if ([StockGameCentreUtil isValidUtil]) {
    //    [stockgame_label setText:NSLocalizedString(@"StockGameCentre.lable",nil)];
    //        }else {
    //            [btn_arr removeObject: stockgame_button];
    //            [lab_arr removeObject: stockgame_label];
//    stockgame_button.hidden = YES;
//    stockgame_label.hidden = YES;
    //    }
    //    if ([MKGeCardUtil isValidUtil]) {
    //        [mkgEcard_label setText:NSLocalizedString(@"MKGeCard.label",nil)];
    //    }else {
    //        [btn_arr removeObject: mkgEcard_button];
    //        [lab_arr removeObject: mkgEcard_label];
    mkgEcard_button.hidden = YES;
    mkgEcard_label.hidden = YES;
    //    }

    //	if ([eCardUtil isValidUtil]){
    //		[eCard_button setTitle:NSLocalizedString(@"ecard",nil) forState:UIControlStateNormal];
    //	} else {
    //		eCard_button.hidden = YES;
    //	}

    //	int i=0;
    //	for (int index=0; index<[btn_arr count]; index++) {
    //		UIButton* btn = (UIButton*)[btn_arr objectAtIndex:index];
    //		if (!btn.hidden) {
    //			btn.frame = CGRectMake(20, 3+i*58, 280, 55);
    //			i++;
    //		}
    //	}

    //	NSUInteger btnCount = [btn_arr count];
    //    NSLog(@"btnCount %d--%f--%f",btnCount, ceil(btnCount/9.0), floor(btnCount/9.0));
    //    if (btnCount <= 9) {
    //        [scrollView setScrollEnabled:NO];
    //        pageControl.numberOfPages = 1;
    //    }else{
    //        scrollView.scrollEnabled = YES;
    //        pageControl.numberOfPages = (btnCount%9 == 0 ? btnCount/9 : btnCount/9+1);
    //    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * pageControl.numberOfPages, scrollView.frame.size.height);
    //    [pageLabel setText:[NSString stringWithFormat:@"%@ %d %@", NSLocalizedString(@"pagestr1",nil), pageControl.currentPage+1, NSLocalizedString(@"pagestr2",nil)]];
    //    [btnPagePrev.titleLabel setText:NSLocalizedString(@"Prev",nil)];
    //    [btnPageNext.titleLabel setText:NSLocalizedString(@"Next",nil)];
    //    if (pageControl.currentPage == 0){
    //        btnPagePrev.hidden=YES;
    //    }else{
    //        btnPagePrev.hidden=NO;
    //    }

    //    if (pageControl.currentPage == (pageControl.numberOfPages-1)){
    //        btnPageNext.hidden=YES;
    //    }else{
    //       btnPageNext.hidden=NO;
    //    }
    NSLog(@"pageControl pagesCount:%d",pageControl.numberOfPages);

    //    int x, y,u,v;
    //	for (unsigned i=0; i<[btn_arr count]; i++) {
    //		UIButton* btn = (UIButton*)[btn_arr objectAtIndex:i];
    //		UILabel* label = (UILabel*)[lab_arr objectAtIndex:i];
    //		x = floor(35 + (i/[[MyScreenUtil me] getMainMenuIconPageCount])*320 + (i%[[MyScreenUtil me] getMainMenuIconColCount])*100) ;
    //		y = floor(25 + (i%[[MyScreenUtil me] getMainMenuIconPageCount])/[[MyScreenUtil me] getMainMenuIconColCount]*90);
    //		btn.frame = CGRectMake(x, y, 50, 50);
    //
    //        u = floor(15 + (i/[[MyScreenUtil me] getMainMenuIconPageCount])*320 + (i%[[MyScreenUtil me] getMainMenuIconColCount])*100);
    //        v = floor(70 + (i%[[MyScreenUtil me] getMainMenuIconPageCount])/[[MyScreenUtil me] getMainMenuIconColCount]*90);
    //        label.frame = CGRectMake(u, v, 90, 42);
    //        //label.frame = CGRectMake(btn.frame.origin.x-floor((label.frame.size.width-btn.frame.size.width)/2), btn.frame.origin.y+50, label.frame.size.width, label.frame.size.height);//updated by jasen
    //    }

    //	badge.frame = CGRectMake(255, credit_button.frame.origin.y-9, 45, 27);
//    badge.frame = CGRectMake(credit_button.frame.origin.x+22, credit_button.frame.origin.y-10, 45, 27);

	self.navigationController.delegate = self;
	//<!------------------------------
//    self.nav_bar_bg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease];
//    if (![[MyScreenUtil me] adjustNavBackground:self.navigationController])
//        [self.navigationController.navigationBar insertSubview:self.nav_bar_bg atIndex:1];
//    self.nav_bar_bg.alpha = 0;
	//------------------------------!>
	getBadgeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateBadge:) userInfo:nil repeats:TRUE];
    if (([self readNotInstalledAndFirstOpenApp] && [UIDevice currentDevice].systemVersion.floatValue < 8.0) || [[[UserDefaultUtil readUserDefault] objectForKey:@"NotInstalledAndFirstOpenApp"] isEqualToString:@"YES"]) {
        
        [[AccProUtil me] sendRequestToGetBannerPlist];
        
    }else{
        isPop = NO;
        CLLocationManager *locmgr = [[CLLocationManager alloc] init];
        locmgr.delegate = self;
        if ([CLLocationManager locationServicesEnabled]) {
            [locmgr startUpdatingLocation];
        }
//        else {
//            UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Location_setting_nearby_atm",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//            [alert_view show];
//            [alert_view release];
//        }

//        if ([@"zh-Hant" isEqualToString: [[LangUtil me] getLanguage]] || [@"zh-Hans" isEqualToString: [[LangUtil me] getLanguage]]) {
//            [[LangUtil me] setLang_hant];
//        }else{
//            [[LangUtil me] setLang_en];
//        }
    }


    //amended by jasen on 201303
    [self.view addSubview:self.mmenuv0];
    CGRect frame = scrollView.frame;
//    frame.origin.y += 25;
    self.mmenuv0.frame = frame;
    [self.view addSubview:self.mmenuv1];
    self.mmenuv1.frame = frame;
    [self.view addSubview:self.mmenuv2];
    self.mmenuv2.frame = frame;

    v_rmvc = [[RotateMenuViewController alloc] initWithNibName:@"RotateMenuViewController" bundle:nil];
    [self.view addSubview:v_rmvc.contentView];

    NSString* defaultPageStr = [[LangUtil me] getDefaultMainpage];

    NSArray* a_views = [NSArray arrayWithObjects:self.mmenuv0,self.mmenuv1,mmenuv2, nil];
    [v_rmvc.rmUtil setViewArray:a_views];
    [v_rmvc.rmUtil setShowIndex:[defaultPageStr intValue]];
    
    NSLog(@"beaview show page:%@", defaultPageStr);

//    [v_rmvc.btnHome addTarget:self action:@selector(sideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [v_rmvc.btnMore  addTarget:self action:@selector(moreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    v_rmvc.vc_caller = self;

    [self setTexts];
    [self setGameButton];

//    jump1 = NO;
//    jump2 = NO;
//    jump3 = NO;
    pass1 = NO;
    NSLog(@"20131224:     %@" ,self.view);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguage" object:nil];
}

- (IBAction)doMenuButtonsPressed:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self sideMenuButtonPressed:sender];
            break;
        case 1:
            [v_rmvc.rmUtil doMenuButtonsPressed:sender];;
            break;
        default:
            break;
    }
    
}
-(BOOL) isPass1
{
    return pass1;
}

-(void) setPass1:(BOOL)value
{
    pass1 = value;
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
    //    [self setBtnPagePrev:nil];
    //    [self setBtnPageNext:nil];
    [self setMmenuv0:nil];
    [self setMmenuv1:nil];
    [self setMmenuv2:nil];
    [self setM_view_megahub:nil];
    [self setLabel_P2P:nil];
	[super viewDidUnload];
}


- (void)dealloc {
    //    [btnPagePrev release];
    //    [btnPageNext release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [m_oMHViewControllers release];
    [m_view_megahub release];
//    [taxLoan_view_controller release];
    [[ViewControllerDirector sharedViewControllerDirector] removeObserver:self];
    [_label_P2P release];
    [lifestyle_tag8 release];
    [supremeGold_button release];
    [supremeGold_label release];
    [icoupon_button release];
    [Insurance_button release];
    [Insurance_button release];
    [mpf_button release];
    [banking_tag4 release];
    [banking_more release];
    [year_round_dinner release];
    [year_round_shopping release];
    [cash_in_hand release];
    [P2P release];
    [credit_card_latest_promotions_more release];
    [Concert_Movie_Offers_more release];
    [notes_exchange_rates_button release];
    [tt_exchange_rates_button release];
    [gold_button release];
    [super dealloc];
}

-(void)openCardModule:(int) tagno//added by jasen
{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
    //    [[CoreData sharedCoreData].root_view_controller setContent:-2];
//    if ([CoreData sharedCoreData].home_view_controller == nil) {
//        if (![[CoreData sharedCoreData].lastScreen isEqualToString:@"HomeView"]) {
//            [CoreData sharedCoreData].root_view_controller.current_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
//            [[CoreData sharedCoreData].root_view_controller.current_view_controller release];
//        }
//    }
//    if ([[CoreData sharedCoreData].lastScreen isEqualToString:@"ConsumerLoanViewController"]) {
//        //        BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        //        delegate.isClick = NO;
//        [CoreData sharedCoreData].root_view_controller.current_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
//        [[CoreData sharedCoreData].root_view_controller.current_view_controller release];
//    }
//    if ([[CoreData sharedCoreData].lastScreen isEqualToString:@"main_view_controller"]) {
//        [CoreData sharedCoreData].root_view_controller.current_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
//        [[CoreData sharedCoreData].root_view_controller.current_view_controller release];
//    }
//    if ([[CoreData sharedCoreData].lastScreen isEqualToString:@"HotlineViewController"]) {
//        [CoreData sharedCoreData].root_view_controller.current_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
//        [[CoreData sharedCoreData].root_view_controller.current_view_controller release];
//    }
    NSLog(@"%d",[[self.navigationController viewControllers] count]);
    //    if ([[self.navigationController viewControllers] count] <= 1) {
    //        [[CoreData sharedCoreData].root_view_controller.current_view_controller.navigationController popToRootViewControllerAnimated:NO];
//    if(![self.navigationController.topViewController isKindOfClass:[HomeViewController class]] && ![self.navigationController.topViewController isKindOfClass:[PBConcertsListViewController class]] && ![self.navigationController.topViewController isKindOfClass:[PBConcertsSummaryViewController class]] && ![self.navigationController.topViewController isKindOfClass:[CardLoanListViewController class]] && ![self.navigationController.topViewController isKindOfClass:[LatestPromotionsListViewController class]] && ![self.navigationController.topViewController isKindOfClass:[CardLoanSummaryViewController class]] && ![self.navigationController.topViewController isKindOfClass:[YearRoundOffersViewController class]] && ![self.navigationController.topViewController isKindOfClass:[YearRoundOffersListViewController class]] && ![self.navigationController.topViewController isKindOfClass:[YearRoundOffersSummaryViewController class]] && ![self.navigationController.topViewController isKindOfClass:[SpendingRewardsListViewController class]] && ![self.navigationController.topViewController isKindOfClass:[SpendingRewardsSummaryViewController class]] && ![self.navigationController.topViewController isKindOfClass:[GlobePassListViewController class]] && ![self.navigationController.topViewController isKindOfClass:[GlobePassSummaryViewController class]] && ![self.navigationController.topViewController isKindOfClass:[QuarterlySurpriseSummaryViewController class]] && ![self.navigationController.topViewController isKindOfClass:[AdvanceSearchViewController class]]){
//        NSLog(@"%@",self.navigationController.topViewController);
//        NSLog(@"%@",[CoreData sharedCoreData].home_view_controller.navigationController.viewControllers);
//        NSLog(@"20140923%@",[CoreData sharedCoreData].root_view_controller.current_view_controller);
//        [self.navigationController pushViewController:[CoreData sharedCoreData].root_view_controller.current_view_controller animated:NO];
//    }
    NSLog(@"%@",self.navigationController.topViewController);
    NSLog(@"%@",[CoreData sharedCoreData].home_view_controller.navigationController.viewControllers);
    
    if (![[CoreData sharedCoreData].main_view_controller.viewControllers containsObject:[CoreData sharedCoreData].home_view_controller]) {
        if ([CoreData sharedCoreData].home_view_controller) {
            [[CoreData sharedCoreData].home_view_controller release];
            [CoreData sharedCoreData].home_view_controller = nil;
        }
        [CoreData sharedCoreData].home_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
        [self.navigationController pushViewController:[CoreData sharedCoreData].home_view_controller animated:NO];
        [CoreData sharedCoreData].home_view_controller.isPop = YES;
    }
    
    
    [[MoreMenuUtil me] setMoreMenuViews4CreditCard];
    UIButton* tmp_button=[[UIButton alloc] init];
    tmp_button.tag=tagno;
    [[CoreData sharedCoreData].home_view_controller buttonPressed:tmp_button];
    //    [(HomeViewController*)([CoreData sharedCoreData].root_view_controller.current_view_controller) buttonPressed:tmp_button];
    NSLog(@"%@",[CoreData sharedCoreData].root_view_controller.current_view_controller);
    NSLog(@"%@",NSStringFromCGRect([CoreData sharedCoreData].root_view_controller.current_view_controller.view.frame));
    [tmp_button release];
//    [CoreData sharedCoreData].delight_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//    [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//    [UIView commitAnimations];
//    self.vc4process = [CoreData sharedCoreData].delight_view_controller;
}

-(void)openRateModule:(int) tagno//added by jasen on 201303
{
    if(![self checkWifiNetWorkAvailable])return;
    //    if (self.vc4process != [RateUtil me].Rate_view_controller) {
    [CoreData sharedCoreData].lastScreen = @"RateViewController";
    //        [UIView beginAnimations:nil context:NULL];
    //        [UIView setAnimationDuration:0.5];
    //        [RateUtil me].Rate_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    //        [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
    //        [UIView commitAnimations];
//    if (![[CoreData sharedCoreData].main_view_controller.viewControllers containsObject:[RateUtil me].Rate_view_controller]) {
//        [[CoreData sharedCoreData].main_view_controller pushViewController:[RateUtil me].Rate_view_controller animated:NO];
//    }
    if ([RateUtil me].Rate_view_controller) {
        [[RateUtil me].Rate_view_controller release];
        [RateUtil me].Rate_view_controller = nil;
    }
    [RateUtil me].Rate_view_controller = [[RateViewController alloc] initWithNibName:@"RateViewController" bundle:nil];
    
    [[CoreData sharedCoreData].main_view_controller pushViewController:[RateUtil me].Rate_view_controller animated:NO];
    NSLog(@"debug Rate BEAViewController openRateModule:%@", [RateUtil me].Rate_view_controller);
    [[RateUtil me].Rate_view_controller welcome:tagno];
    //        self.vc4process = [RateUtil me].Rate_view_controller;
    //    }
}


//<!--------------MegaHub----------------------------
- (void)moreButtonPressed:(id)sender
{
    [m_oMHBEAWatchlistLv0ViewController hideKeyboard];
}

- (void)showMenu:(int)show
{
    [m_oMHBEAWatchlistLv0ViewController hideKeyboard];
}

- (IBAction)backButtonPressed:(id)sender
{
    
    [m_oMHViewControllers removeLastObject];
    
    if([m_oMHViewControllers count] < 1){
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        
        if([[m_oMHViewControllers lastObject] intValue] == ViewControllerDirectorIDQuote){
            [vcs insertObject:m_oMHBEAFAQuoteViewController atIndex:[vcs count]-1];
            
        }else if([[m_oMHViewControllers lastObject] intValue] == ViewControllerDirectorIDNews){
             [vcs insertObject:m_oMHBEAPTSSIndexViewController atIndex:[vcs count]-1];
            
        }else if([[m_oMHViewControllers lastObject] intValue]  == ViewControllerDirectorIDStock){
            [vcs insertObject:m_oMHBEAWatchlistLv0ViewController atIndex:[vcs count]-1];
            
        }else if([[m_oMHViewControllers lastObject] intValue] == ViewControllerDirectorIDBuy){
            [vcs insertObject:m_oMHBEABuyStockViewController atIndex:[vcs count]-1];
            
        }else if([[m_oMHViewControllers lastObject] intValue] == ViewControllerDirectorIDSell){
            [vcs insertObject:m_oMHBEASellStockViewController atIndex:[vcs count]-1];
            
        }else if([[m_oMHViewControllers lastObject] intValue] == ViewControllerDirectorIDWebTradeBuy){
            [vcs insertObject:m_oMHBEAWebTradeBuyStockViewController atIndex:[vcs count]-1];
            
        }else if([[m_oMHViewControllers lastObject] intValue] == ViewControllerDirectorIDWebTradeSell){
            [vcs insertObject:m_oMHBEAWebTradeSellStockViewController atIndex:[vcs count]-1];
        }
        
//        [self.navigationController setViewControllers:vcs animated:NO];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
//----------------MegaHub--------------------------!>

- (IBAction)sideMenuButtonPressed:(id)sender
{
    
    //<!--------------MegaHub----------------------------
    [m_oMHBEAWatchlistLv0ViewController hideKeyboard];
    //----------------MegaHub--------------------------!>
    
    CGRect destination;
    
    NSLog(@"debug BEAViewController sideMenuButtonPressed 0:%@", self.vc4process);

    if (self.vc4process && self.vc4process.view.frame.origin.x != 320) {
        destination = self.vc4process.view.frame;
    } else {
        destination = self.navigationController.view.frame;
    }

    NSLog(@"debug BEAViewController sideMenuButtonPressed 1:%@", self.navigationController.view);
    NSLog(@"debug BEAViewController sideMenuButtonPressed 2:%@", self.vc4process.view);
    NSLog(@"debug BEAViewController sideMenuButtonPressed 3:%f", destination.origin.x);
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openSideMenu = NO;
    if (destination.origin.x >= 280) {
        destination.origin.x = 0;
        destination.origin.y = 0;
        [SideMenuUtil me].menu_view.accessibilityElementsHidden = YES;
    } else if (destination.origin.x <= 0) {
        BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
        delegate.openSideMenu = YES;
        destination.origin.x = 280;
        destination.origin.y = 0;
        NSLog(@"debug BEAViewController sideMenuButtonPressed menu:%@", [SideMenuUtil me].menu_view);
        [[SideMenuUtil me] requestMenuDatas];
        [[SideMenuUtil me] scrollToTop];
        NSArray *viewControllers = [self.navigationController viewControllers];
        id setting_controller = [viewControllers lastObject];
        if ([setting_controller isKindOfClass:[SettingViewController class]]) {
            [setting_controller screenPressed];
        }
        [SideMenuUtil me].menu_view.accessibilityElementsHidden = NO;
    }

    [UIView animateWithDuration:0.25 animations:^{
        self.navigationController.view.frame = destination;
        if (self.vc4process && self.vc4process.view.frame.origin.x != 320) {
            self.vc4process.view.frame = destination;
            
        }
        NSLog(@"debug BEAViewController sideMenuButtonPressed 3:%@", self.navigationController.view);
        NSLog(@"debug BEAViewController sideMenuButtonPressed 4:%@", self.vc4process.view);
    } completion:^(BOOL finished) {
    }];
}

-(void)adjustBEAView2Top0
{
    [[MyScreenUtil me] adjustView2Top0:[CoreData sharedCoreData].main_view_controller.view];

}

-(IBAction)menuButtonPressed:(UIButton *)button {
    self.view.accessibilityViewIsModal = YES;
    [SideMenuUtil me].menu_view.accessibilityElementsHidden = YES;

    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openProperty = NO;
    delegate.openImportant = NO;
    
    CGRect destination;
    destination = self.navigationController.view.frame;
    destination.origin.x = 0;
    destination.origin.y = 0;
    self.navigationController.view.frame = destination;

    // FOR EASY REFERENCE
    // TAG 100    CREDIT CARD - all year round offers
    // TAG 101    CREDIT CARD - Cash in Hand
    // TAG 102    CREDIT CARD - Latest promo
    // TAG 103    CREDIT CARD - Spending and Rewards
    // TAG 104    CREDIT CARD - Concert/ Movie
    // TAG 105    CREDIT CARD - Global Pass Offers
    // TAG 0    CREDIT CARD
    // TAG 1    MOBILE BANKING
    // TAG 2    AIO STOCK TRADING           -->BUG
    // TAG 3    VACANT
    // TAG 4    SETTING
    // TAG 5    ATM
    // TAG 6    CONSUMER LOAN
    // TAG 7    VACANT (PREVIOUSLY ECARD)
    // TAG 8    HOTLINE
    // TAG 9    PROPERTY LOAN
    // TAG 10   EAS                         -->BUG
    // TAG 11   STOCK WATCH
    // TAG 12   MPF
    // TAG 13   LATEST PROMOTION
    // TAG 14   RATE ENQUIRY
    // TAG 15   VACANT FOR TaxLoan 2011
    // TAG 16   StockGameCentre
    // TAG 17   MKG e-Greeting Card
    // TAG 18   VACANT
    // TAG 19   VACANT
    // TAG 20   SGG
    // TAG 21   Insurance
    // TAG 22   CyberFundSearch
    // TAG 23   Bookmark
    // TAG 24   FAQ
    // TAG 25   Security tips
    // TAG 26   P2P
    // TAG 27   SupremeGold
    // TAG 203  Gold
    // TAG 106    ATM->branch
    // TAG 220  Facebook
    // WebViewController *trading_controller;
//	MH_WebViewController *trading_controller;
    
    [[MoreMenuUtil me] setMoreMenuViews4Common];

    SettingViewController *setting_controller;
    //    AccProListViewController *accProListViewController;
    //    TaxLoanListViewController *taxLoanListViewController;
    UIViewController *current_view_controller;
	NSLog(@"debug BEAViewController menuButtonPressed vc4process:%@", self.vc4process);
    if (self.vc4process != nil) {
        [self.vc4process goMainFaster];
    }
//    [self.navigationController popToRootViewControllerAnimated:NO];
//	NSData *trading;
	NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	NSLog(@"debug BEAViewController menuButtonPressed:%d", button.tag);
	//UIAlertView *alert_view;
    if (
        button.tag==100 ||
        button.tag==101 ||
        button.tag==102 ||
        button.tag==103 ||
        button.tag==104 ||
        button.tag==105 ||
//        button.tag==106 ||
        button.tag==107 ||
        button.tag==110 ||
        button.tag==111 ||
        button.tag==20107
        ){
        if (button.tag==20107) {
            [[MoreMenuUtil me] setMoreMenuViews4CreditCard];
            button.tag = 107;
        }
        pass1 = YES;
        [CoreData sharedCoreData].menuType = @"1";

        [self openCardModule:(button.tag-100)];
        return;
    }
    if (button.tag==112) {
        pass1 = YES;
        [CoreData sharedCoreData].menuType = @"1";
        
        [self openCardModule:(button.tag-100)];
    }
    if (
        button.tag==302 ||
        button.tag==304
        ){
        pass1 = YES;
        NSLog(@"debug BEAViewController menuButtonPressed:%d", [[CoreData sharedCoreData].bea_view_controller isPass1]);
        [CoreData sharedCoreData].menuType = @"1";
        [self openCardModule:(button.tag-300)];
        return;
    }
    if (
        button.tag==200 ||
        button.tag==201 ||
        button.tag==202
        ){
        [self openRateModule:(button.tag-200)];
        return;
    }
    //start -- add by Xu Xin Long 20140902
    if (button.tag==203) {
        if(![self checkWifiNetWorkAvailable])return;
        WebViewController *gold_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        NSString *urlString = [NSString stringWithFormat:@"%@Service=PG&Lang=%@&MobileNo=%@",[MigrationSetting me].m_sURLMBLogonShow,NSLocalizedString(@"gold Lang", nil),[MBKUtil decryption:[user_setting objectForKey:@"encryted_banking"]]];
        NSLog(@"%@",urlString);
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        [gold_controller setUrlRequest:request];
        [[MyScreenUtil me] adjustViewWithStatusNavbar:gold_controller.view];
        
        [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:gold_controller animated:NO];
        
        [gold_controller release];
        return;
    }
    //end -- add by Xu Xin Long 20140902
    if (button.tag==404){
        [MobileTradingUtil me].requestServer=@"MOBILEBANKING";
        setting_controller = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
        setting_controller.isScrollButtom = true;

        [self.navigationController pushViewController:setting_controller animated:NO];
//        [setting_controller scrollToBottom];
        [setting_controller release];
        return;
    }
	switch (button.tag) {
		case 0:
        {
            if ([CoreData sharedCoreData].delight_view_controller) {
                [[CoreData sharedCoreData].delight_view_controller release];
                [CoreData sharedCoreData].delight_view_controller = nil;
            }
            [CoreData sharedCoreData].delight_view_controller = [[BEADelightViewController alloc] initWithNibName:@"BEADelightView" bundle:nil];
//			[UIView beginAnimations:nil context:NULL];
//			[UIView setAnimationDuration:0.5];
//            NSArray *viewControllers = [v_rmvc.rmUtil.nav4process viewControllers];
//            NSArray *navArrs = self.navigationController.viewControllers;
//            NSArray *navArrs2 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
//            [v_rmvc.rmUtil setNav:self.navigationController];
           // [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers = self.navigationController.viewControllers;
			[[CoreData sharedCoreData].root_view_controller setContent:-1];
//			[CoreData sharedCoreData].delight_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//			[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//            self.vc4process = [CoreData sharedCoreData].delight_view_controller;
            [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].delight_view_controller animated:NO];
            NSLog(@"L209-BEAViewController");
            //			[UIView commitAnimations];

            [CoreData sharedCoreData].menuType = @"2";
            [[MoreMenuUtil me] setMoreMenuViews4CreditCard];

			break;
        }
		case 1:
            [MobileTradingUtil me].requestServer=@"MOBILEBANKING";//added by jasen
            if (user_setting!=nil &&
                [[user_setting objectForKey:@"encryted_banking"] length]>0 &&
                [[MBKUtil decryption:[user_setting objectForKey:@"encryted_banking"]] length]>0) {
                [self checkMBKRegStatus];
            } else {
                setting_controller = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
				[self.navigationController pushViewController:setting_controller animated:NO];
				[setting_controller release];
				break;
			}
			break;
		case 2: // edit by @yufei--2011.03.16
            [MobileTradingUtil me].requestServer=@"MOBILETRADING";//added by jasen
            MHBEA_DELEGATE.m_sRequestServer = @"MOBILETRADING";
            if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
				[[MobileTradingUtil me] checkMobileTradingRegStatus];
			} else {
                setting_controller = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
				[self.navigationController pushViewController:setting_controller animated:NO];
				[setting_controller release];
				break;
			}
            //			[[CoreData sharedCoreData].bea_view_controller gotoCybertrading];

            //            trading_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
            //			[self.navigationController pushViewController:trading_controller animated:TRUE];
            //
            //            trading = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
            //			[self transform:trading];
            //				//NSLog(@"%@",[[NSString alloc] initWithData:trading encoding:NSUTF8StringEncoding]);
            //			[trading_controller.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"mobiletrading",nil),[[NSString alloc] initWithData:trading encoding:NSUTF8StringEncoding]]]]];
            //			NSLog(@"BEAViewController menuButtonPressed trading:%@",[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"mobiletrading",nil),[[NSString alloc] initWithData:trading encoding:NSUTF8StringEncoding]]);
            //			[trading_controller release];
			break;
		case 4:
            [MobileTradingUtil me].requestServer=@"MOBILEBANKING";
			setting_controller = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
//            if ([fromWhere isEqualToString:@"EAS"]) {
//                setting_controller.fromWhere = @"fromEAS";
//            }
            setting_controller.isScrollButtom = false;
			[self.navigationController pushViewController:setting_controller animated:NO];
			[setting_controller release];

			break;
		case 5:
        {
            if ([CoreData sharedCoreData].atmlocation_view_controller) {
                [[CoreData sharedCoreData].atmlocation_view_controller release];
                [CoreData sharedCoreData].atmlocation_view_controller = nil;
            }

            [CoreData sharedCoreData].atmlocation_view_controller = [[ATMLocationViewController alloc] initWithNibName:@"ATMLocationView" bundle:nil];
			[CoreData sharedCoreData].lastScreen=@"main_view_controller";//added by jasen
//			[UIView beginAnimations:nil context:NULL];
//			[UIView setAnimationDuration:0.5];
			[[CoreData sharedCoreData].root_view_controller setContent:0];
//			[CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//			[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//			[UIView commitAnimations];
            [CoreData sharedCoreData].atmlocation_view_controller.menuIndex = -10;
            [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].atmlocation_view_controller animated:NO];
//			[[CoreData sharedCoreData].atmlocation_view_controller welcome];
//            self.vc4process = [CoreData sharedCoreData].atmlocation_view_controller;
            NSLog(@"debug BEAViewController menuButtonPressed atm vc4process:%@", self.vc4process);

            
            
            //            [[NewBranchBannerUtil me] requestPlist];
        }
			break;
		case 6: // ConsumerLoanViewController
            
            if ([CoreData sharedCoreData].taxLoan_view_controller != nil) {
                [[CoreData sharedCoreData].taxLoan_view_controller release];
            }
             [CoreData sharedCoreData].taxLoan_view_controller = [[TaxLoanViewController alloc] initWithNibName:@"TaxLoanView" bundle:nil];
            [CoreData sharedCoreData].lastScreen = @"ConsumerLoanViewController";
//			[UIView beginAnimations:nil context:NULL];
//			[UIView setAnimationDuration:0.5];
			[[CoreData sharedCoreData].root_view_controller setContent:0];
            //			[(RootViewController*)[[CoreData sharedCoreData].taxLoan_view_controller.navigationController.viewControllers objectAtIndex:0] setContent:1];
		//	[CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
			//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];

            [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].taxLoan_view_controller animated:NO];
           NSLog(@"Navigation Revamp - Consumer Loan - BEAViewController.m");
//			[UIView commitAnimations];
            [[CoreData sharedCoreData].taxLoan_view_controller welcome];
            //            taxLoanListViewController = [[TaxLoanListViewController alloc] initWithNibName:@"TaxLoanListViewController" bundle:nil];
            //			[self.navigationController pushViewController:taxLoanListViewController animated:TRUE];
            //			[taxLoanListViewController release];
//            self.vc4process = [CoreData sharedCoreData].taxLoan_view_controller;
			break;
            //		case 7:
            //			if ([eCardUtil isValidUtil]){
            //				[[CoreData sharedCoreData]._eCardViewController gotoWebside];
            //			}
            //			break;
			//started by yelong on 2011.02.28
            
		case 8:
        {
//            [[CoreData sharedCoreData].hotline_view_controller release];
//            HotlineViewController *hotline_view_controller = [[HotlineViewController alloc] initWithNibName:@"HotlineView" bundle:nil];
//            [[CoreData sharedCoreData]._BEAAppDelegate.window insertSubview:hotline_view_controller.view belowSubview:[MPFUtil me]._MPFImportantNoticeViewController.view];
//            hotline_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//            [CoreData sharedCoreData].hotline_view_controller = hotline_view_controller;

            if ([CoreData sharedCoreData].hotline_view_controller) {
                [[CoreData sharedCoreData].hotline_view_controller release];
                [CoreData sharedCoreData].hotline_view_controller = nil;
            }
            [CoreData sharedCoreData].hotline_view_controller = [[HotlineViewController alloc] initWithNibName:@"HotlineView" bundle:nil];
			[CoreData sharedCoreData].lastScreen=@"HotlineViewController";
//			[UIView beginAnimations:nil context:NULL];
//			[UIView setAnimationDuration:0.5];
			[[CoreData sharedCoreData].root_view_controller setContent:0];
//			[CoreData sharedCoreData].hotline_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//			[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//			[UIView commitAnimations];
			[[CoreData sharedCoreData].hotline_view_controller welcome];
//            self.vc4process = [CoreData sharedCoreData].hotline_view_controller;
		}
            break;
			//-- ended by yelong on 2011.02.28
		case 9:
//			[UIView beginAnimations:nil context:NULL];
//			[UIView setAnimationDuration:0.5];
            
            if ([CoreData sharedCoreData]._PropertyLoanViewController) {
                [[CoreData sharedCoreData]._PropertyLoanViewController release];
                [CoreData sharedCoreData]._PropertyLoanViewController = nil;
            }
            [CoreData sharedCoreData]._PropertyLoanViewController = [[PropertyLoanViewController alloc] initWithNibName:@"PropertyLoanViewController" bundle:nil];
			[CoreData sharedCoreData].lastScreen=@"_PropertyLoanViewController";
			[[CoreData sharedCoreData].root_view_controller setContent:0];
            delegate.openProperty = YES;
//			[CoreData sharedCoreData]._PropertyLoanViewController.view.center = [[MyScreenUtil me] getmainScreenCenter_20:self];
//			[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
            [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData]._PropertyLoanViewController animated:NO];
            NSLog(@"Navigation Revamp - Consumer Loan - BEAViewController.m");
//			[UIView commitAnimations];
			[[CoreData sharedCoreData]._PropertyLoanViewController welcome];
            break;
		case 10:
            [MobileTradingUtil me].requestServer=@"MOBILEBANKING";
            MHBEA_DELEGATE.m_sRequestServer = @"MOBILEBANKING";
            //			trading_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
            WebViewController* trading_controller1 = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
			
			if (user_setting!=nil && [[user_setting objectForKey:@"encryted_trading"] length]>0) {
//				trading = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_trading"]];
//				[self transform:trading];
                //NSLog(@"%@",[[NSString alloc] initWithData:trading encoding:NSUTF8StringEncoding]);
                NSString* urlstr =
                [NSString stringWithFormat:@"%@%@%@",
                 [[MigrationSetting me] CYBDomain],
                 NSLocalizedString(@"mobiletrading",nil),
//                 [[NSString alloc] initWithData:trading encoding:NSUTF8StringEncoding]
                 [MBKUtil decryption:[user_setting objectForKey:@"encryted_trading"]]
                 ];
                [trading_controller1 setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]]; //To be retested
//				[trading_controller1.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]];
                NSLog(@"BEAViewController menuButtonPressed trading:%@", urlstr);
                [self.navigationController pushViewController:trading_controller1 animated:NO];//note: will not show WebViewController corectly once animated:NO;
                
                [trading_controller1 release];
			} else {
                //  NSString* urlstr = [NSString stringWithFormat:@"%@%@%@",[[MigrationSetting me] CYBDomain],NSLocalizedString(@"mobiletrading",nil),@"00000000"];
//                NSString* urlstr = [NSString stringWithFormat:@"%@%@",[[MigrationSetting me] CYBDomain],NSLocalizedString(@"mobiletrading_noMobile",nil)];
//                [trading_controller1 setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]]; //To be retested
//				[trading_controller1.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]];
			//	NSLog(@"BEAViewController menuButtonPressed trading:%@", urlstr);
                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:settings_button];
			}
//            [self.navigationController pushViewController:trading_controller1 animated:NO];//note: will not show WebViewController corectly once animated:NO;
//
//			[trading_controller1 release];

			break;
		case 11: {
            [v_rmvc.rmUtil showMenu:2];

			//<!--------------MegaHub----------------------------
            
            [m_oMHViewControllers removeAllObjects];
            [self.navigationController popToRootViewControllerAnimated:NO];
            
//            [UIView beginAnimations:nil context:NULL];
//			[UIView setAnimationDuration:0.5];
			[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//			[UIView commitAnimations];
            
            //----------------MegaHub--------------------------!>
			break;
		}
        case 12:
            NSLog(@"click MPF unit");
            if ([MPFUtil me].MPF_view_controller) {
                [[MPFUtil me].MPF_view_controller release];
                [MPFUtil me].MPF_view_controller = nil;
            }
            [[MPFRateUtil me] sendRequestMPFRate:@"MPFMAIN"];
            [[MPFUtil me].MPF_view_controller.view setHidden:NO];
            if(![self checkWifiNetWorkAvailable])return;
            [[MPFUtil me]._MPFImportantNoticeViewController switchMe];
            break;
        case 13:
            //add by Xu Xin Long -- 20140902
            
            NSLog(@"click AccPro unit");
            if ([AccProUtil me].AccPro_view_controller != nil) {
                [CoreData sharedCoreData].main_view_controller.delegate = nil;
                [[AccProUtil me].AccPro_view_controller release];
                [AccProUtil me].AccPro_view_controller = nil;
            }
            [AccProUtil me].AccPro_view_controller = [[AccProViewController alloc] initWithNibName:@"AccProViewController" bundle:nil];
            if(![self checkWifiNetWorkAvailable])return;
            [CoreData sharedCoreData].lastScreen = @"AccProViewController";
            //            [UIView beginAnimations:nil context:NULL];
            //            [UIView setAnimationDuration:0.5];
//            [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            [[AccProUtil me].AccPro_view_controller.navigationController popToViewController:[CoreData sharedCoreData].bea_view_controller animated:NO];
//            [[CoreData sharedCoreData].taxLoan_view_controller.navigationController popToViewController:[CoreData sharedCoreData].bea_view_controller animated:NO];
            [CoreData setMainViewFrame];
//            [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
            
            [[CoreData sharedCoreData].main_view_controller pushViewController:[AccProUtil me].AccPro_view_controller animated:NO];
            //            [UIView commitAnimations];
            [[AccProUtil me].AccPro_view_controller welcome];
//            self.vc4process = [AccProUtil me].AccPro_view_controller;
            break;
        case 14:
            NSLog(@"click Rate unit");
            if(![self checkWifiNetWorkAvailable])return;
            [CoreData sharedCoreData].lastScreen = @"RateViewController";
            //			[UIView beginAnimations:nil context:NULL];
            //			[UIView setAnimationDuration:0.5];
            if ([RateUtil me].Rate_view_controller) {
                [[RateUtil me].Rate_view_controller release];
                [RateUtil me].Rate_view_controller = nil;
            }
            [RateUtil me].Rate_view_controller = [[RateViewController alloc] initWithNibName:@"RateViewController" bundle:nil];
            
            [[CoreData sharedCoreData].main_view_controller pushViewController:[RateUtil me].Rate_view_controller animated:NO];
//			[RateUtil me].Rate_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//			[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
            //            [UIView commitAnimations];
            [[RateUtil me].Rate_view_controller welcome];
//            self.vc4process = [RateUtil me].Rate_view_controller;
            break;
            //		case 15: // Tax Loan 2011
            //            [CoreData sharedCoreData].lastScreen = @"LTViewController";
            //			[UIView beginAnimations:nil context:NULL];
            //			[UIView setAnimationDuration:0.5];
            //			[[CoreData sharedCoreData].root_view_controller setContent:0];
            //			[(RootViewController*)[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers objectAtIndex:0] setContent:2];
            //			[CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            //			[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
            //			[UIView commitAnimations];
            //			break;
        case 16:
            //StockGameCentre
            NSLog(@"StockGameCentre click");
            if(![self checkWifiNetWorkAvailable])return;
            [self.navigationController popToRootViewControllerAnimated:FALSE];
            current_view_controller = [[StockGameCentreViewController alloc] initWithNibName:@"StockGameCentreViewController" bundle:nil];
            [self.navigationController pushViewController:current_view_controller animated:NO];
            break;
        case 17:
            //MKG e-Greeting Card
            NSLog(@"MKGeCard click");
            //            [[CoreData sharedCoreData].root_view_controller setContent:-1];
            //            if(![self checkWifiNetWorkAvailable])return;
            //            [self.navigationController popToRootViewControllerAnimated:FALSE];
            //            current_view_controller = [[MKGeCardViewController alloc] initWithNibName:@"MKGeCardViewController" bundle:nil];
            //            [self.navigationController pushViewController:current_view_controller animated:TRUE];
            [MKGeCardUtil showeCard];
            break;
        case 20:
            //SGG
            NSLog(@"SGG click");
            //if(![self checkWifiNetWorkAvailable])return;
            //            [[SGGUtil me] showMainViewController];
            break;
        case 21:
            NSLog(@"click Insurance unit");
//            if ([InsuranceUtil me].Insurance_view_controller) {
//                [[InsuranceUtil me].Insurance_view_controller release];
//                [InsuranceUtil me].Insurance_view_controller = nil;
//            }
            [InsuranceUtil me].Insurance_view_controller = [[InsuranceViewController alloc] initWithNibName:@"InsuranceViewController" bundle:nil];
//            [CoreData sharedCoreData]._InsuranceViewController = [InsuranceUtil me].Insurance_view_controller;
            NSLog(@"L209-Insurance 20140702 BEAViewController.m");
            if(![self checkWifiNetWorkAvailable])return;
            [CoreData sharedCoreData].lastScreen = @"InsuranceViewController";
            if ([[InsuranceUtil me].animate isEqualToString:@"YES"]) {
                //                [UIView beginAnimations:nil context:NULL];
                //                [UIView setAnimationDuration:0.5];
            }
            [InsuranceUtil me].isInIns = true;
            
//            [InsuranceUtil me].Insurance_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter_20:self];
//            [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
            [[CoreData sharedCoreData].main_view_controller pushViewController:[InsuranceUtil me].Insurance_view_controller animated:NO];
             NSLog(@"L209-Insurance 20140702 BEAViewController.m");
            if ([[InsuranceUtil me].animate isEqualToString:@"YES"]) {
                //                [UIView commitAnimations];
            }
//            [[InsuranceUtil me].Insurance_view_controller welcome];
//            self.vc4process = [InsuranceUtil me].Insurance_view_controller;
            [[InsuranceUtil me].Insurance_view_controller welcome];
            break;
        case 22:
            NSLog(@"click Cyber Fund Search unit");
            if(![self checkWifiNetWorkAvailable])return;
            [[CyberFundSearchUtil me]._CyberFundSearchImportantNoticeViewController switchMe];
            break;
		case 23:
        case 2023:
        {
			FavouriteListViewController* vc = [[FavouriteListViewController alloc] initWithNibName:@"FavouriteListView" bundle:nil];
            //            [[MyScreenUtil me] adjustNavView:self.navigationController.view];
            NSLog(@"debug :self.navigationController.view 1:%@ ",self.navigationController.view);
			[self.navigationController pushViewController:vc animated:NO];
            if (button.tag == 2023) {
                [[MoreMenuUtil me] setMoreMenuViews4CreditCard];
            }
			[vc release];
        }
			break;
        case 2024:
        {
//            NSArray *navArr1 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
//            NSArray *navArr2 = [CoreData sharedCoreData].bea_view_controller.navigationController.viewControllers;
			FavouriteListViewController* vc = [[FavouriteListViewController alloc] initWithNibName:@"FavouriteListView" bundle:nil];
            vc.isCreditCardBookmark = YES;
            NSLog(@"debug :self.navigationController.view 1:%@ ",self.navigationController.view);
	//jerry		[self.navigationController pushViewController:vc animated:NO];
//            [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:vc animated:NO];
            [self.navigationController pushViewController:vc animated:NO];
//            NSArray *navArr3 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
//            NSArray *navArr4 = [CoreData sharedCoreData].bea_view_controller.navigationController.viewControllers;
            if (button.tag == 2024) {
                [[MoreMenuUtil me] setMoreMenuViews4CreditCard];
            }
			[vc release];
        }
			break;
		case 24:
        {
            
			ImportantNoticeMenuViewController* vc = [[ImportantNoticeMenuViewController alloc] initWithNibName:@"ImportantNoticeMenuViewController" bundle:nil nav:[CoreData sharedCoreData].bea_view_controller.navigationController];
            delegate.openImportant = YES;
			[self.navigationController pushViewController:vc animated:NO];
			[vc release];
        }
			break;
		case 25:
        {
			ImportantNoticeMenuViewController* vc = [[ImportantNoticeMenuViewController alloc] initWithNibName:@"ImportantNoticeMenuViewController" bundle:nil nav:[CoreData sharedCoreData].bea_view_controller.navigationController];
			[self.navigationController pushViewController:vc animated:NO];
            [vc welcome:1];
			[vc release];
        }
			break;
            
		case 26:
        {
//            if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
                P2PMenuViewController* vc = [[P2PMenuViewController alloc] initWithNibName:@"P2PMenuViewController" bundle:nil nav:[CoreData sharedCoreData].bea_view_controller.navigationController];
                [CoreData sharedCoreData].lastScreen=@"P2PMenuViewController";
                [CoreData sharedCoreData].sP2PMenuViewController = vc;
                [self.navigationController pushViewController:vc animated:NO];
                [vc release];
//			} else {
//                setting_controller = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
            //                setting_controller.EntranceType = 3;
            //				[self.navigationController pushViewController:setting_controller animated:NO];
            //				[setting_controller release];
            //				break;
            //			}
            
        }
			break;
            
        case 27:
        {
            //add by Xu Xin Long -- 20140903 -- SupremeGold Function
            
            if ([CoreData sharedCoreData].sg_view_controller != nil) {
                [CoreData sharedCoreData].main_view_controller.delegate = nil;
                [[CoreData sharedCoreData].sg_view_controller release];
            }
            [CoreData sharedCoreData].sg_view_controller = [[SGViewController alloc] initWithNibName:@"SGViewController" bundle:nil];
            [CoreData sharedCoreData].lastScreen = @"SupremeGoldViewController";
            [[CoreData sharedCoreData].root_view_controller setContent:0];
            [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].sg_view_controller animated:NO];
            NSLog(@"Navigation Revamp - SupremeGold - BEAViewController.m");
            [[CoreData sharedCoreData].sg_view_controller welcome];
            break;
        }
        case 28:
        {
            ImportantNoticeMenuViewController* vc = [[ImportantNoticeMenuViewController alloc] initWithNibName:@"ImportantNoticeMenuViewController" bundle:nil nav:[CoreData sharedCoreData].bea_view_controller.navigationController];
            [self.navigationController pushViewController:vc animated:NO];
            [vc welcome:2];
            [vc release];
        }
            break;
        case 106:
        case 20106:
        {
            [[CoreData sharedCoreData].root_view_controller setContent:0];
			[CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
			[CoreData sharedCoreData]._PropertyLoanViewController.view.center = [[MyScreenUtil me] getmainScreenLeft_20:self];
			[[CoreData sharedCoreData].atmlocation_view_controller welcome2];
            [CoreData sharedCoreData].bea_view_controller.vc4process = [CoreData sharedCoreData].atmlocation_view_controller;
            if (button.tag == 20106) {
                [[MoreMenuUtil me] setMoreMenuViews4CreditCard];
            }
        }
            break;
        case 220:
        {
            [[CoreData sharedCoreData].root_view_controller setContent:-2];
            FacebookListViewController *fblVC = [[FacebookListViewController alloc] initWithNibName:@"FacebookListViewController" bundle:nil];
            [CoreData sharedCoreData].lastScreen = @"FacebookListViewController";
            [CoreData sharedCoreData].facebookListViewController = fblVC;
            [self.navigationController pushViewController:fblVC animated:NO];
            [fblVC release];
//            P2PMenuViewController* vc = [[P2PMenuViewController alloc] initWithNibName:@"P2PMenuViewController" bundle:nil nav:[CoreData sharedCoreData].bea_view_controller.navigationController];
//            [CoreData sharedCoreData].lastScreen=@"P2PMenuViewController";
//            [CoreData sharedCoreData].sP2PMenuViewController = vc;
//            [self.navigationController pushViewController:vc animated:NO];
//            [vc release];
        }
        
    }
    NSLog(@"debug main_view_controller.view.frame BEAViewController menuButtonPressed:%f",
          [CoreData sharedCoreData].main_view_controller.view.frame.origin.y
          );
}

//<!--------------MegaHub----------------------------
- (void)removeMegaHubDisclaimer {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)displayDisclaimer {
	MHDisclaimerViewController *con = [[MHDisclaimerViewController alloc] init];
	[con setOKButtonTarget:self action:@selector(removeMegaHubDisclaimer)];
    [self presentViewController:con animated:NO completion:nil];
	[con release];
}
//----------------MegaHub--------------------------!>

-(void)updateBadge:(NSTimer *)timer {
	[badge setNumber:[[CoreData sharedCoreData].home_view_controller getBadgeExist]];
	//NSLog(@"Badge in home: %d",[[CoreData sharedCoreData].home_view_controller getBadgeExist]);
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)] && [UIApplication sharedApplication].currentUserNotificationSettings.types < 1) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        if ([[CoreData sharedCoreData].home_view_controller getBadgeExist]>0) {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
        } else {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    }


}


//////////////////////////////
//NavigationControllerDelegate
//////////////////////////////
-(void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"BEAViewController willShowViewController:%d--%@",[[navigationController viewControllers] count], viewController);
    
    //    int navBarSubviewsCount = [self.navigationController.navigationBar.subviews count];
    //
    //	if ([[navigationController viewControllers] count]<=1) {
    //        for (int i=0; i<navBarSubviewsCount; i++) {
    //            if ([[self.navigationController.navigationBar.subviews objectAtIndex:i] class]==[UIImageView class]) {
    //                ((UIImageView*)[self.navigationController.navigationBar.subviews objectAtIndex:i]).alpha=0;
    //            }
    //        }
    //    }
    
    if ([viewController class]==[WebViewController class]
        || [viewController class]==[P2PMenuViewController class]
        || [viewController class]==[FacebookViewController class]
        || [viewController class]==[FacebookViewController2 class]) {
        [MBKUtil me].queryButtonWillShow=@"NO";
    }else {
        [MBKUtil me].queryButtonWillShow=@"YES";
    }
//    self.nav_bar_bg.alpha = 1;
    
    //<!--------------MegaHub----------------------------
	if ([[navigationController viewControllers] count] <= 1) {
        MHBEA_DELEGATE.m_sRequestServer = nil;
	}
    
    if ([viewController class] ==[MHBEAFAQuoteViewController class] ||
        [viewController class] ==[MHBEAPTSSIndexViewController class] ||
        [viewController class] ==[MHBEAWatchlistLv0ViewController class] ||
        [viewController class] ==[MHBEABuySellStockViewController class] ||
        [viewController class] ==[MHDisclaimerViewController class] ||
        [viewController class] ==[MHBEAWebTradeStockViewController class]) {
        
        [MBKUtil me].queryButtonWillShow=@"NO";
    }
    
    //----------------MegaHub--------------------------!>
    
}

- (void)navigationController:(UINavigationController *)nav didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"BEAViewController didShowViewController:%d--%@",[[nav viewControllers] count], viewController);
	NSLog(@"BEAViewController didShowViewController:%@", viewController.view);
    if ([[nav viewControllers] count]<=1 && [[AccProUtil me].inStockWatch isEqualToString:@"YES"]) {
        openLatesPromoItem1Timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(openLatestPromoItem1:) userInfo:nil repeats:TRUE];
    }
    
    //<!--------------MegaHub----------------------------
    if ([viewController class] ==[MHBEAFAQuoteViewController class]) {
        self.isInStockWatch = @"YES";
    }else{
        self.isInStockWatch = @"NO";
    }
    //----------------MegaHub--------------------------!>
}

-(void)openLatestPromoItem1:(NSTimer *)timer {
    [openLatesPromoItem1Timer invalidate];
    UIButton* acc_pro_button=[[UIButton alloc] init];
    acc_pro_button.tag=13;
    [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
    [acc_pro_button release];
}

-(void)goMain {
	[self.navigationController popToRootViewControllerAnimated:TRUE];
}

-(void)checkMBKRegStatus{
	NSLog(@"BEAViewController checkMBKRegStatus");
//	NSData *banking;
	NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
//		banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
//		[self transform:banking];
        /*
         NSURL *url = [NSURL URLWithString:[MBKUtil getCheckRegStatusURL]];
         asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
         NSLog(@"BEAViewController checkMBKRegStatus url:%@",asi_request.url);
         [asi_request setUsername:@"iphone"];
         [asi_request setPassword:@"iphone"];
         [asi_request setValidatesSecureCertificate:NO];
         asi_request.delegate = self;
         [[CoreData sharedCoreData].queue addOperation:asi_request];
         */
        ASIFormDataRequest *request =[HttpRequestUtils getPostRequest4checkMBKRegStatus:self];
        
        [[CoreData sharedCoreData].queue addOperation:request];
		[[CoreData sharedCoreData].mask showMask];
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"BEAViewController requestFinished:%@",[request responseString]);
	NSString * regStatus = [NSString stringWithFormat:@"%@", [request responseString]];
    NSString * CyberbankingDomain = [[MigrationSetting me] CYBDomain];
    
	if (NSOrderedSame == [regStatus compare:@"1"]){
//		NSData *banking;
		NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
		if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
			WebViewController *_WebViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
//			banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
//			[self transform:banking];
			//NSLog(@"%@",[[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding]);
            NSURL * url=
            [NSURL URLWithString:
             [NSString stringWithFormat:@"%@%@%@%@",
              CyberbankingDomain,
              NSLocalizedString(@"mobilebanking",nil),
//              [[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding],
              [MBKUtil decryption:[user_setting objectForKey:@"encryted_banking"]],
              [[MPFUtil me] getReqParam]]
             ];
            [_WebViewController setUrlRequest:[NSURLRequest requestWithURL:url]]; //To be retested
			[self.navigationController pushViewController:_WebViewController animated:NO];//NOTE: why it will not do "web_view loadRequest" once changed to "animated:NO"?!
            
            
            //			[_WebViewController.web_view loadRequest:[NSURLRequest requestWithURL:url]];
            //			NSLog(@"BEAViewController menuButtonPressed banking:%@",url);
			[_WebViewController release];
		}
        
	}else if (NSOrderedSame == [regStatus compare:@"0"]){
        
		UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Pop Up Notice for Register",nil) message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Continue",nil),nil];
		[alert_view show];
		[alert_view release];
        
	}
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
	NSURL *url = [MBKUtil getURLCYBMBKREG];
	NSLog(@"BEAViewController clickedButtonAtIndex url:%@", url);
    
	[[UIApplication sharedApplication] openURL:url];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"BEAViewController requestFailed error:%@", [request error]);
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
    
}

-(void)gotoCybertrading{
	WebViewController* trading_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
    //	MH_WebViewController* trading_controller = [[MH_WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
	
//	NSData *trading;
	NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	if (user_setting!=nil && [[user_setting objectForKey:@"encryted_trading"] length]>0) {
//		trading = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_trading"]];
//		[self transform:trading];
//		NSLog(@"%@",[[NSString alloc] initWithData:trading encoding:NSUTF8StringEncoding]);
        NSString* urlstr =
        [NSString stringWithFormat:@"%@%@%@",
         [[MigrationSetting me] CYBDomain],
         NSLocalizedString(@"mobiletrading",nil),
//         [[NSString alloc] initWithData:trading encoding:NSUTF8StringEncoding]
         [MBKUtil decryption:[user_setting objectForKey:@"encryted_trading"]]
         ];

        [trading_controller setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]]; //To be retested
        //		[trading_controller.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]];
		NSLog(@"BEAViewController menuButtonPressed trading:%@",urlstr);
	} else {
        NSString* urlstr = [NSString stringWithFormat:@"%@%@%@",[[MigrationSetting me] CYBDomain],NSLocalizedString(@"mobiletrading",nil),@"00000000"];
        [trading_controller setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]]; //To be retested
        //		[trading_controller.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]];
	}
    [self.navigationController pushViewController:trading_controller animated:NO];
	[trading_controller release];
}

//-(IBAction)popupMenuPicker{
//    [self toggleNoticeButton];
//	[[CoreData sharedCoreData]._ImportantNoticeViewController switchMe];
//}
//
//-(void) toggleNoticeButton{
//    [ImportantNotice_button setHidden:!ImportantNotice_button.hidden];
//}


-(IBAction) changePage{
    NSInteger page = pageControl.currentPage;
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender{
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    //    [pageLabel setText:[NSString stringWithFormat:@"%@ %d %@", NSLocalizedString(@"pagestr1",nil), pageControl.currentPage+1, NSLocalizedString(@"pagestr2",nil)]];
    
    //    if (pageControl.currentPage == 0){
    //        btnPagePrev.hidden=YES;
    //   }else{
    //        btnPagePrev.hidden=NO;
    //    }
    
    //    if (pageControl.currentPage == (pageControl.numberOfPages-1)){
    //        btnPageNext.hidden=YES;
    //   }else{
    //       btnPageNext.hidden=NO;
    //   }
}

- (IBAction)doPrev:(id)sender {
    pageControl.currentPage--;
    [self changePage];
    pageControlUsed = NO;
}

- (IBAction)doNext:(id)sender {
    pageControl.currentPage++;
    [self changePage];
    pageControlUsed = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (BOOL)checkWifiNetWorkAvailable{
    if (![MBKUtil wifiNetWorkAvailable]) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
        return FALSE;
    }
    return YES;
}

-(void)setPromoInMainPage1
{
    CGRect frame = bottomView4Promo1.frame;
    frame.origin.x = 2;
    frame.origin.y = 13;
    frame.size.width = 296;
    frame.size.height = 50;
    [self setPromoInView1:bottomView4Promo1 frame:frame];
}

-(void)setPromoInView1:(UIView*)aView frame:(CGRect)frame
{
    NSLog(@"debug BEAViewController setPromoInView1");
    
    NSArray* subviews = [aView subviews];
    for (int i=0; i<[subviews count]; i++) {
        UIView* view = (UIView*)[subviews objectAtIndex:i];
        NSLog(@"debug setPromoInView1:%@", view);
        [view removeFromSuperview];
    }
    
    [plistvc1 release];
    plistvc1 = nil;
    plistvc1 = [[AccProListViewController alloc] initWithNibName:@"AccProListViewController" bundle:nil];
    plistvc1->mainPagePromo = YES;
    [plistvc1 viewDidLoad];
    [plistvc1.table_view removeFromSuperview];
    CGRect newFrame = frame;
    newFrame.size.height += 11;
    frame = newFrame;
    plistvc1.table_view.frame = frame;
    [plistvc1.table_view setScrollEnabled:NO];
    bottomView4Promo1.layer.cornerRadius = 7.0;
    plistvc1.table_view.layer.cornerRadius = 7.0;

    [aView addSubview:plistvc1.table_view];
    plistvc1.table_view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoPromo1:)];
    [aView addGestureRecognizer:tapGesture];
    [tapGesture release];
}

-(void)setAccessibilityForPlistvc1:(NSString *)tableViewTitle{
    bottomView4Promo1.accessibilityLabel = tableViewTitle;
}

-(void)gotoPromo1:(UIButton *)button{
    if (![MBKUtil wifiNetWorkAvailable]) {
        if ((plistvc1.items_data == nil)||([plistvc1.items_data count]<=0)) {
            UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert_view show];
            [alert_view release];
            
        }else {
            ConsumerLoanOffersViewController* current_view_controller =
            [[ConsumerLoanOffersViewController alloc] initWithNibName:@"ConsumerLoanOffersViewController"
                                                               bundle:nil
                                                             merchant:[plistvc1.items_data firstObject]];
            current_view_controller.fromType = @"Pri";
            [self.navigationController pushViewController:current_view_controller animated:NO];
        }
        
    }else {
        if ((plistvc1.items_data == nil)||([plistvc1.items_data count]<=0)) {
            return ;
        }
        ConsumerLoanOffersViewController* current_view_controller =
        [[ConsumerLoanOffersViewController alloc] initWithNibName:@"ConsumerLoanOffersViewController"
                                                           bundle:nil
                                                         merchant:[plistvc1.items_data firstObject]];
        current_view_controller.fromType = @"Pri";
        [self.navigationController pushViewController:current_view_controller animated:NO];
    }
    
}

-(void)setPromoInMainPage2
{
    CGRect frame = bottomView4Promo2.frame;
    frame.origin.x = 2;
    frame.origin.y = 13;
    frame.size.width = 296;
    frame.size.height = 50;
    [self setPromoInView2:bottomView4Promo2 frame:frame];
}

-(void)setPromoInView2:(UIView*)aView frame:(CGRect)frame
{
    NSLog(@"debug BEAViewController setPromoInView2");
    
    NSArray* subviews = [aView subviews];
    for (int i=0; i<[subviews count]; i++) {
        UIView* view = (UIView*)[subviews objectAtIndex:i];
        NSLog(@"debug setPromoInView1:%@", view);
        [view removeFromSuperview];
    }
//    if (plistvc2) {
        [plistvc2 release];
        plistvc2 = nil;
//    }
    plistvc2 = [[LatestPromotionsListViewController alloc] initWithNibName:@"LatestPromotionsListView" bundle:nil];
    plistvc2->mainPagePromo = YES;
    [plistvc2 viewDidLoad];
    [plistvc2 getItemsList];
    [plistvc2.table_view removeFromSuperview];
    CGRect newFrame = frame;
    newFrame.size.height += 11;
    frame = newFrame;
    plistvc2.table_view.frame = frame;
    [plistvc2.table_view setScrollEnabled:NO];
    bottomView4Promo2.layer.cornerRadius = 7.0;
    plistvc2.table_view.layer.cornerRadius = 7.0;

    [aView addSubview:plistvc2.table_view];
    plistvc2.table_view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoPromo2:)];
    [aView addGestureRecognizer:tapGesture];
    [tapGesture release];
    
}

-(void)setAccessibilityForPlistvc2:(NSString *)tableViewTitle{
    bottomView4Promo2.accessibilityLabel = tableViewTitle;
}

-(void)gotoPromo2:(UIButton *)button{
    //    jump2 = YES;
    //    pass1 = YES;
    //    UIButton* acc_pro_button=[[UIButton alloc] init];
    //    acc_pro_button.tag=102;
    //    [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
//    if ((plistvc2.items_data == nil)||([plistvc3.items_data count]<=0)) {
//        return ;
//    }
    if (![MBKUtil wifiNetWorkAvailable]) {
        if ((plistvc2.items_data == nil)||([plistvc2.items_data count]<=0)) {
            UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert_view show];
            [alert_view release];
            
        }else {
            LatestPromotionsSummaryViewController *summary_controller = [[LatestPromotionsSummaryViewController alloc] initWithNibName:@"LatestPromotionsSummaryView" bundle:nil];
            summary_controller.merchant_info = [plistvc2.items_data objectAtIndex:0];
            [summary_controller setViewControllerPushType:1];
            [self.navigationController pushViewController:summary_controller animated:NO];
            summary_controller.title_label.text = plistvc2.title_label.text;
            [summary_controller release];
        }
        
    }else {
        if ((plistvc2.items_data == nil)||([plistvc2.items_data count]<=0)) {
            return ;
        }
        LatestPromotionsSummaryViewController *summary_controller = [[LatestPromotionsSummaryViewController alloc] initWithNibName:@"LatestPromotionsSummaryView" bundle:nil];
        summary_controller.merchant_info = [plistvc2.items_data objectAtIndex:0];
        [summary_controller setViewControllerPushType:1];
        [self.navigationController pushViewController:summary_controller animated:NO];
        summary_controller.title_label.text = plistvc2.title_label.text;
        [summary_controller release];
    }
    //    NSLog(@"debug BEAViewController didSelectRowAtIndexPath:%@--%@", plistvc2.title_label.text, plistvc2.items_data);
}

-(void)setPromoInMainPage3
{
    CGRect frame = bottomView4Promo3.frame;
    frame.origin.x = 2;
    frame.origin.y = 13;
    frame.size.width = 296;
    frame.size.height = 50;
    [self setPromoInView3:bottomView4Promo3 frame:frame];
}

-(void)setPromoInView3:(UIView*)aView frame:(CGRect)frame
{
    NSLog(@"debug BEAViewController setPromoInView3");
    
    NSArray* subviews = [aView subviews];
    for (int i=0; i<[subviews count]; i++) {
        UIView* view = (UIView*)[subviews objectAtIndex:i];
        NSLog(@"debug setPromoInView1:%@", view);
        [view removeFromSuperview];
    }
    
    [plistvc3 release];
    plistvc3 = nil;
    plistvc3 = [[PBConcertsListViewController alloc] initWithNibName:@"PBConcertsListView" bundle:nil];
    plistvc3->mainPagePromo = YES;
    [plistvc3 viewDidLoad];
    [plistvc3 getItemsList];
    [plistvc3.table_view removeFromSuperview];
    CGRect newFrame = frame;
    newFrame.size.height += 11;
    frame = newFrame;
    plistvc3.table_view.frame = frame;
    [plistvc3.table_view setScrollEnabled:NO];
    bottomView4Promo3.layer.cornerRadius = 7.0;
    plistvc3.table_view.layer.cornerRadius = 7.0;
    
    [aView addSubview:plistvc3.table_view];
    plistvc3.table_view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoPromo3:)];
    [aView addGestureRecognizer:tapGesture];
    [tapGesture release];
}

-(void)setAccessibilityForPlistvc3:(NSString *)tableViewTitle{
    bottomView4Promo3.accessibilityLabel = tableViewTitle;
}

-(void)gotoPromo3:(UIButton *)button{
    //    jump3 = YES;
    //    pass1 = YES;
    //    UIButton* acc_pro_button=[[UIButton alloc] init];
    //    acc_pro_button.tag=104;
    //    [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
    
//    if ((plistvc3.items_data == nil)||([plistvc3.items_data count]<=0)) {
//        return ;
//    }
    if (![MBKUtil wifiNetWorkAvailable]) {
        if ((plistvc3.items_data == nil)||([plistvc3.items_data count]<=0)) {
            UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert_view show];
            [alert_view release];
        }else {
            PBConcertsSummaryViewController *summary_controller = [[PBConcertsSummaryViewController alloc] initWithNibName:@"PBConcertsSummaryView" bundle:nil];
            summary_controller.merchant_info = [plistvc3.items_data objectAtIndex:0];
            [summary_controller setViewControllerPushType:1];
            [self.navigationController pushViewController:summary_controller animated:NO];
            summary_controller.title_label.text = plistvc3.title_label.text;
            [summary_controller release];
        }
        
    }else {
        if ((plistvc3.items_data == nil)||([plistvc3.items_data count]<=0)) {
            return ;
        }
        PBConcertsSummaryViewController *summary_controller = [[PBConcertsSummaryViewController alloc] initWithNibName:@"PBConcertsSummaryView" bundle:nil];
        summary_controller.merchant_info = [plistvc3.items_data objectAtIndex:0];
        [summary_controller setViewControllerPushType:1];
        [self.navigationController pushViewController:summary_controller animated:NO];
        summary_controller.title_label.text = plistvc3.title_label.text;
        [summary_controller release];
    }
}

//<!--------------MegaHub----------------------------
- (void)onReceiveViewControllerDirector:(NSNotification *)n {
	ViewControllerDirectorParameter *para = [n object];
	if ([para isKindOfClass:[ViewControllerDirectorParameter class]] == NO){
		return;
	}
    
	switch (para.m_iViewControllerID) {
        case ViewControllerDirectorIDQuote: {
            
//            [self.navigationController popViewControllerAnimated:NO];
            [m_oMHViewControllers addObject:[NSNumber numberWithInt:ViewControllerDirectorIDQuote]];
            
            if(m_oMHBEAFAQuoteViewController){
                [m_oMHBEAFAQuoteViewController release];
                m_oMHBEAFAQuoteViewController = nil;
            }
            
            m_oMHBEAFAQuoteViewController = [[MHBEAFAQuoteViewController alloc] init];
            m_oMHBEAFAQuoteViewController.view.userInteractionEnabled = YES;
            
            if(para.m_iInt0 > 0 && para.m_iInt0 <= 99999){
                //                [m_oMHBEAFAQuoteViewController setStockCode:[NSString stringWithFormat:@"%d",para.m_iInt0]];
                [CoreData sharedCoreData].m_sLastQuoteSymbol = [NSString stringWithFormat:@"%d",para.m_iInt0];
                
            }else if(para.m_sString1 != nil && [para.m_sString1 length] > 0){
                int prefixStringLength	= ([STOCK_QUOTE_LINK_PREFIX length]+[@"://" length]);
				NSString *dataString	= [para.m_sString1 substringFromIndex:prefixStringLength];
				NSArray *dataArray = [dataString componentsSeparatedByString:@"."];
				NSString *symbolString = [dataArray objectAtIndex:0];
                [CoreData sharedCoreData].m_sLastQuoteSymbol = symbolString;
                //                [m_oMHBEAFAQuoteViewController setStockCode:symbolString];
            }
            
            [self.navigationController pushViewController:m_oMHBEAFAQuoteViewController animated:NO];
            
            break;
        }
        case ViewControllerDirectorIDNews: {
            
//            [self.navigationController popViewControllerAnimated:NO];
            [m_oMHViewControllers addObject:[NSNumber numberWithInt:ViewControllerDirectorIDNews]];
            
            if(m_oMHBEAPTSSIndexViewController){
                [m_oMHBEAPTSSIndexViewController release];
                m_oMHBEAPTSSIndexViewController = nil;
            }
            
            m_oMHBEAPTSSIndexViewController = [[MHBEAPTSSIndexViewController alloc] init];
            m_oMHBEAPTSSIndexViewController.view.userInteractionEnabled = YES;

            
            
            [self.navigationController pushViewController:m_oMHBEAPTSSIndexViewController animated:NO];
            
            break;
        }
        case ViewControllerDirectorIDStock: {
            
            //            [self.navigationController popViewControllerAnimated:NO];
            //            [m_oMHViewControllers addObject:[NSNumber numberWithInt:ViewControllerDirectorIDStock]];
            //
            //            if(self.m_oMHBEAWatchlistLv0ViewController == nil){
            //                self.m_oMHBEAWatchlistLv0ViewController = [[MHBEAWatchlistLv0ViewController alloc] init];
            //                [self.navigationController pushViewController:m_oMHBEAWatchlistLv0ViewController animated:YES];
            //                [m_oMHBEAWatchlistLv0ViewController release];
            //            }else{
            //                [self.navigationController pushViewController:m_oMHBEAWatchlistLv0ViewController animated:YES];
            //            }
            
            [m_oMHViewControllers removeAllObjects];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            break;
        }
        case ViewControllerDirectorIDBuy: {
            
//            [self.navigationController popViewControllerAnimated:NO];
            [m_oMHViewControllers addObject:[NSNumber numberWithInt:ViewControllerDirectorIDBuy]];
            
            if(m_oMHBEABuyStockViewController){
                [m_oMHBEABuyStockViewController release];
                m_oMHBEABuyStockViewController = nil;
            }
            
            m_oMHBEABuyStockViewController = [[MHBEABuySellStockViewController alloc] init];
            [m_oMHBEABuyStockViewController.view setUserInteractionEnabled:YES];
            
            [m_oMHBEABuyStockViewController setBuySellType:BuySellTypeBuy];
            
            if(para.m_iInt0 > 0 && para.m_iInt0 <= 99999){
                [m_oMHBEABuyStockViewController switchToWebTrade:[NSString stringWithFormat:@"%d",para.m_iInt0]];
            }
            
            [self.navigationController pushViewController:m_oMHBEABuyStockViewController animated:NO];
            
            break;
        }
        case ViewControllerDirectorIDSell: {
            
//            [self.navigationController popViewControllerAnimated:NO];
            [m_oMHViewControllers addObject:[NSNumber numberWithInt:ViewControllerDirectorIDSell]];
            
            if(m_oMHBEASellStockViewController){
                [m_oMHBEASellStockViewController release];
                m_oMHBEASellStockViewController = nil;
            }
            
            m_oMHBEASellStockViewController = [[MHBEABuySellStockViewController alloc] init];
            [m_oMHBEASellStockViewController.view setUserInteractionEnabled:YES];
            
            [m_oMHBEASellStockViewController setBuySellType:BuySellTypeSell];
            
            if(para.m_iInt0 > 0 && para.m_iInt0 <= 99999){
                [m_oMHBEASellStockViewController switchToWebTrade:[NSString stringWithFormat:@"%d",para.m_iInt0]];
            }
            
            [self.navigationController pushViewController:m_oMHBEASellStockViewController animated:NO];
            
            break;
        }
        case ViewControllerDirectorIDWebTradeBuy: {
            
//            [self.navigationController popViewControllerAnimated:NO];
            [m_oMHViewControllers addObject:[NSNumber numberWithInt:ViewControllerDirectorIDWebTradeBuy]];
            
            if(m_oMHBEAWebTradeBuyStockViewController){
                [m_oMHBEAWebTradeBuyStockViewController release];
                m_oMHBEAWebTradeBuyStockViewController = nil;
            }
            
            m_oMHBEAWebTradeBuyStockViewController = [[MHBEAWebTradeStockViewController alloc] init];
            [m_oMHBEAWebTradeBuyStockViewController.view setUserInteractionEnabled:YES];
            
            [m_oMHBEAWebTradeBuyStockViewController setStockcode:para.m_sString0 url:para.m_sString1];
            [m_oMHBEAWebTradeBuyStockViewController setBuySellType:BuySellTypeBuy];
            
            [self.navigationController pushViewController:m_oMHBEAWebTradeBuyStockViewController animated:NO];
            
            break;
        }
        case ViewControllerDirectorIDWebTradeSell: {
            
//            [self.navigationController popViewControllerAnimated:NO];
            [m_oMHViewControllers addObject:[NSNumber numberWithInt:ViewControllerDirectorIDWebTradeSell]];
            
            if(m_oMHBEAWebTradeSellStockViewController){
                [m_oMHBEAWebTradeSellStockViewController release];
                m_oMHBEAWebTradeSellStockViewController = nil;
            }
            
            m_oMHBEAWebTradeSellStockViewController = [[MHBEAWebTradeStockViewController alloc] init];
            [m_oMHBEAWebTradeSellStockViewController.view setUserInteractionEnabled:YES];
            
            [m_oMHBEAWebTradeSellStockViewController setStockcode:para.m_sString0 url:para.m_sString1];
            [m_oMHBEAWebTradeSellStockViewController setBuySellType:BuySellTypeSell];
            
            [self.navigationController pushViewController:m_oMHBEAWebTradeSellStockViewController animated:NO];
            
            break;
        }
		case ViewControllerDirectorIDMegaHubDisclaimer: {
			[self displayDisclaimer];
			break;
		}default: break;
	}
}
//----------------MegaHub--------------------------!>


-(void)saveNotInstalledAndFirstOpenApp
{
    BOOL notNotInstalledAndFirstOpenApp = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:notNotInstalledAndFirstOpenApp forKey:@"NotInstalledAndFirstOpenApp"];
    [userDefaults synchronize];
}

-(BOOL)readNotInstalledAndFirstOpenApp
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    BOOL notNotInstalledAndFirstOpenApp = [userDefaultes integerForKey:@"NotInstalledAndFirstOpenApp"];
    return notNotInstalledAndFirstOpenApp;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (!([self readNotInstalledAndFirstOpenApp] || isPop)) {
//        [self saveNotInstalledAndFirstOpenApp];
        isPop = YES;
        [[AccProUtil me] sendRequestToGetBannerPlist];
        
    }
    NSLog(@"didChangeAuthorizationStatus----%@",error);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    if (!([self readNotInstalledAndFirstOpenApp] || isPop)) {
//        [self saveNotInstalledAndFirstOpenApp];
        isPop = YES;
        [[AccProUtil me] sendRequestToGetBannerPlist];
    }
    [manager stopUpdatingLocation];
    NSLog(@"didUpdateLocations:  newLocation: %@",newLocation);
}

- (void)changeLanguage:(NSNotification *)notification {
    [self setTexts];
    [[StockGameCentreUtil me] requestAPIDatas];
}

//ios8 AuthorizationStatus
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:
            
            if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                
                [manager requestWhenInUseAuthorization];
                
            }
            
            break;
            
        default: {
            if (!(isPop)) {
                //        [self saveNotInstalledAndFirstOpenApp];
                isPop = YES;
                [[AccProUtil me] sendRequestToGetBannerPlist];
            }
        }
            
            break;
            
    }
    
    
}

@end
