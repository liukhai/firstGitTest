//
//  BEAViewController.h
//  BEA
//
//  Created by Algebra Lo on 10年6月25日.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "Base64.h"
#import "Badge.h"
#import "PlistOperator.h"
#import "BEADelightViewController.h"
#import "WebViewController.h"
#import "SettingViewController.h"
#import "MBKUtil.h"
#import "MobileTradingUtil.h"
#import "ATMLocationViewController.h"
#import "TaxLoanViewController.h"
#import "HotlineViewController.h" 
//#import "ImportantNoticeViewController.h"
#import "ConsumerLoanListViewController.h"
#import "StockGameCentreViewController.h"
#import "MKGeCardViewController.h"
#import "RateUtil.h"
#import "ATMUtil.h"
//#import "SGGUtil.h"
#import "CyberFundSearchUtil.h"
#import "RotateMenuUtil.h"
#import "RotateMenuViewController.h"
#import "LatestPromotionsListViewController.h"
#import "PBConcertsListViewController.h"
#import "AccProListViewController.h"

@class AccProListViewController;
@class PBConcertsListViewController;
@class LatestPromotionsListViewController;
@class BEADelightViewController;
@class ATMLocationViewController;
@class TaxLoanViewController;
@class PropertyLoanViewController;
@class HotlineViewController; 
//@class ImportantNoticeViewController;
@class ConsumerLoanListViewController;

//<!--------------MegaHub----------------------------
@class MHBEAFAQuoteViewController;
@class MHBEAPTSSIndexViewController;
@class MHBEAWatchlistLv0ViewController;
@class MHBEABuySellStockViewController;
@class MHDisclaimerViewController;
@class MHBEAWebTradeStockViewController;
//----------------MegaHub--------------------------!>

@interface BEAViewController : UIViewController
<UINavigationControllerDelegate,
CLLocationManagerDelegate,
UIAlertViewDelegate,
UIScrollViewDelegate,
ASIHTTPRequestDelegate,
RotateMenuDelegate,
RotateMenuDelegate2>
{
	IBOutlet UIButton
    *credit_button,
    *cyberbanking_button,
    *cybertrading_button,
    *settings_button,
    *atm_button,
    *atm_button2,
    *taxloan_button,
    *ImportantNotice_button,
    *hotline_button,
    *property_loans_button,
    *eas_cybertrading_button,
    *AccPro_button,
    *Rate_button,
    *LoanTax_button,
    *stockgame_button,
    *icoupon_button,
    *facebook_button,
    *mkgEcard_button,
    *myclick_button,
    *InstalmentLoan_button,
    *SGG_button,
    *CyberFundSearch_button;
    

    IBOutlet UIButton *mpf_button;
    IBOutlet UIButton *Insurance_button;
    IBOutlet UIButton *supremeGold_button;
    IBOutlet UIButton *year_round_dinner;
    IBOutlet UIButton *year_round_shopping;
    IBOutlet UIButton *cash_in_hand;
    IBOutlet UIButton *P2P;
    IBOutlet UIButton *Concert_Movie_Offers_more;
    IBOutlet UIButton *credit_card_latest_promotions_more;
    IBOutlet UIButton *notes_exchange_rates_button;
    IBOutlet UIButton *tt_exchange_rates_button;
    IBOutlet UIButton *gold_button;
    
	IBOutlet UILabel
    *credit_label,
    *cyberbanking_label,
    *cybertrading_label,
    *settings_label,
    *atm_label,
    *atm_label2,
    *taxloan_label,
    *hotline_label,
    *property_loans_label,
    *eas_cybertrading_label,
    *mpf_label,
    *AccPro_label,
    *Rate_label,
    *LoanTax_label,
    *stockgame_label,
    *icoupon_label,
    *facebook_label,
    *mkgEcard_label,
    *myclick_label,
    *InstalmentLoan_label,
    *SGG_label,
    *Insurance_label,
    *CyberFundSearch_label,
    *privilegeMore_label;
    
    IBOutlet UILabel *supremeGold_label;
    
    IBOutlet UILabel
    *lifestyle_tag0,
    *lifestyle_tag1,
    *lifestyle_tag2,
    *lifestyle_tag3,
    *lifestyle_tag4,
    *lifestyle_tag5,
    *lifestyle_tag6,
    *lifestyle_tag7;
    
    IBOutlet UILabel *lifestyle_tag8;
    IBOutlet UILabel
    *banking_tag0,
    *banking_tag1,
    *banking_tag2,
    *banking_tag3,
    *banking_tag4;
    IBOutlet UIButton *banking_more;

    IBOutlet UILabel
    *wealth_tag0,
    *wealth_tag1,
    *wealth_tag2,
    *wealth_tag3;

	IBOutlet Badge *badge;
    
    BOOL  pageControlUsed;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    UIImageView *nav_bar_bg;
    
//	BEADelightViewController *delight_view_controller;
	NSTimer *getBadgeTimer;
	NSTimer *openLatesPromoItem1Timer;
//	ATMLocationViewController *atmlocation_view_controller;
	TaxLoanViewController *taxLoan_view_controller;
	PropertyLoanViewController *_PropertyLoanViewController;
//	HotlineViewController *hotline_view_controller; 
//	ImportantNoticeViewController *_ImportantNoticeViewController;
	
//<!--------------MegaHub----------------------------
	MHBEAFAQuoteViewController          *m_oMHBEAFAQuoteViewController;
    MHBEAPTSSIndexViewController        *m_oMHBEAPTSSIndexViewController;
    MHBEAWatchlistLv0ViewController     *m_oMHBEAWatchlistLv0ViewController;
    MHBEABuySellStockViewController     *m_oMHBEABuyStockViewController;
    MHBEABuySellStockViewController     *m_oMHBEASellStockViewController;
    MHBEAWebTradeStockViewController    *m_oMHBEAWebTradeBuyStockViewController;
    MHBEAWebTradeStockViewController    *m_oMHBEAWebTradeSellStockViewController;
    NSMutableArray                      *m_oMHViewControllers;
    NSString                            *isInStockWatch;
//----------------MegaHub--------------------------!>

    UIView *mmenuv0;
    UIView *mmenuv1;
    UIView *mmenuv2;
    RotateMenuViewController* v_rmvc;

    UIView *m_view_megahub;
    UIViewController <RotateMenuDelegate2> *vc4process;
    
    IBOutlet UIView *bottomView4Promo1;
    IBOutlet UIView *bottomView4Promo2;
    IBOutlet UIView *bottomView4Promo3;
    
    AccProListViewController* plistvc1;
    LatestPromotionsListViewController* plistvc2;
    PBConcertsListViewController* plistvc3;

@public
//    BOOL jump1;
//    BOOL jump2;
//    BOOL jump3;
    BOOL pass1;
    BOOL isPop;
    
    BOOL goBanking;
}
@property (retain, nonatomic) IBOutlet UILabel *label_P2P;
@property (retain, nonatomic) AccProListViewController* plistvc1;
@property (retain, nonatomic) LatestPromotionsListViewController* plistvc2;
@property (retain, nonatomic) PBConcertsListViewController* plistvc3;

@property (retain, nonatomic) UIViewController <RotateMenuDelegate2> *vc4process;

@property (retain, nonatomic) IBOutlet UIView *m_view_megahub;

@property (retain, nonatomic) RotateMenuViewController* v_rmvc;
//@property (retain, nonatomic) IBOutlet UIButton *btnmenu0;
//@property (retain, nonatomic) IBOutlet UIButton *btnmenu1;
//@property (retain, nonatomic) IBOutlet UIButton *btnmenu2;
//@property (retain, nonatomic) IBOutlet UIScrollView *svmenu;
@property (retain, nonatomic) IBOutlet UIView *mmenuv0;
@property (retain, nonatomic) IBOutlet UIView *mmenuv1;
@property (retain, nonatomic) IBOutlet UIView *mmenuv2;

@property (nonatomic, retain) UIImageView *nav_bar_bg;

@property (nonatomic, retain) UIActionSheet *as_menu;

//@property (nonatomic, retain) BEADelightViewController *delight_view_controller;
//@property (nonatomic, retain) ATMLocationViewController *atmlocation_view_controller;
@property (nonatomic, retain) TaxLoanViewController *taxLoan_view_controller;
//@property (nonatomic, retain) HotlineViewController *hotline_view_controller; 
@property (nonatomic, retain) PropertyLoanViewController *_PropertyLoanViewController;
//@property (nonatomic, retain) ImportantNoticeViewController *_ImportantNoticeViewController;
@property BOOL notification_onOroff;
//<!--------------MegaHub----------------------------
@property (nonatomic, retain) MHBEAFAQuoteViewController        *m_oMHBEAFAQuoteViewController;
//@property (nonatomic, retain) MHBEAPTSSIndexViewController      *m_oMHBEAPTSSIndexViewController;
//@property (nonatomic, retain) MHBEAWatchlistLv0ViewController   *m_oMHBEAWatchlistLv0ViewController;
//@property (nonatomic, retain) MHBEABuySellStockViewController   *m_oMHBEABuyStockViewController;
//@property (nonatomic, retain) MHBEABuySellStockViewController   *m_oMHBEASellStockViewController;
//@property (nonatomic, retain) MHBEAWebTradeStockViewController  *m_oMHBEAWebTradeBuyStockViewController;
//@property (nonatomic, retain) MHBEAWebTradeStockViewController  *m_oMHBEAWebTradeSellStockViewController;
@property (nonatomic, retain) NSMutableArray                    *m_oMHViewControllers;
@property (nonatomic, retain) NSString                          *isInStockWatch;
@property (nonatomic, retain) NSString                          *fromWhere;
//----------------MegaHub--------------------------!>

-(IBAction)menuButtonPressed:(UIButton *)button;
//-(void) toggleNoticeButton;
-(void)checkMBKRegStatus;
-(void)gotoCybertrading;
- (BOOL)checkWifiNetWorkAvailable;

//-(IBAction)popupMenuPicker;
-(IBAction) changePage;

//<!--------------MegaHub----------------------------
- (void)removeMegaHubDisclaimer;
- (void)displayDisclaimer;
- (void)moreButtonPressed:(id)sender;
- (void)showMenu:(int)show;
- (IBAction)backButtonPressed:(id)sender;
//----------------MegaHub--------------------------!>

- (IBAction)sideMenuButtonPressed:(id)sender;

-(void)setTexts;
-(void)setGameButton;
-(BOOL) isPass1;
-(void) setPass1:(BOOL)value;

-(void)saveNotInstalledAndFirstOpenApp;
-(void)setAccessibilityForPlistvc1:(NSString *)tableViewTitle;
-(void)setAccessibilityForPlistvc2:(NSString *)tableViewTitle;
-(void)setAccessibilityForPlistvc3:(NSString *)tableViewTitle;

@end

