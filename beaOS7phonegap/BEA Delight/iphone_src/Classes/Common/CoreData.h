//
//  CoreData.h
//  PIPTrade
//
//  Created by MTel on 19/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LangUtil.h"

#import "UIView+Addition.h"

#import "HomeViewController.h"
#import "BEADelightViewController.h"
#import "RootViewController.h"
#import "MaskViewController.h"
#import "ECouponViewController.h"
#import "EMailViewController.h"

#import "BEAViewController.h"

#import "ATMLocationViewController.h"
#import "TaxLoanViewController.h"
#import "LTViewController.h"
#import "InstalmentLoanViewController.h"
#import "HotlineViewController.h" // --added by yelong on 2011.03.02
#import "PropertyLoanViewController.h"
//#import "ImportantNoticeViewController.h"
#import "ImportantNoticeMenuViewController.h"
#import "SGViewController.h"
#import "InsuranceViewController.h"

#import "MyScreenUtil.h"
#import "RotateMenuViewController.h"
#import "RotateMenu2ViewController.h"
#import "RotateMenu3ViewController.h"
#import "MoreMenuUtil.h"
#import "BEAAppDelegate.h"

#import "LargeImageCell.h"
#import "LargeImageCell2.h"
#import "P2PMenuViewController.h"
#import "FacebookListViewController.h"
@class BEAAppDelegate;
@class RootViewController;
@class HomeViewController;
@class BEADelightViewController;
@class ECouponViewController;
@class BEAViewController;
@class ATMLocationViewController;
//@class ImportantNoticeViewController;
@class LTViewController;
@class InstalmentLoanViewController;
@class P2PMenuViewController;
@class FacebookListViewController;
@class SGViewController;
@class InsuranceViewController;
typedef enum {
	LastVisitPageHome	= 0,
	LastVisitPageBuy	= 1,
	LastVisitPageWatchlist,
	LastVisitPageQuote,
	LastVisitPageNews,
	LastVisitPageSell
} LastVisitPage;

typedef enum {
	AccountTypeStockTrading = 1,
	AccountTypeEAS
} AccountType;


@interface CoreData : NSObject {
    BEAAppDelegate* _BEAAppDelegate;
    
	NSString *realServerURL , *realServerURLCard, *sessionID, *loginID;
	UINavigationController *main_view_controller;
	BEAViewController *bea_view_controller;
	HomeViewController *home_view_controller;
	BEADelightViewController *delight_view_controller;
	RootViewController *root_view_controller;
	MaskViewController *mask;
	ECouponViewController *ecoupon;
	EMailViewController *email;
	NSOperationQueue *queue;
	NSString *lang, *UDID, *OS;
    
	ATMLocationViewController *atmlocation_view_controller;
	TaxLoanViewController *taxLoan_view_controller;
    SGViewController *sg_view_controller;
    InsuranceViewController* _InsuranceViewController;
	LTViewController *_LTViewController;
	InstalmentLoanViewController *_InstalmentLoanViewController;
	HotlineViewController *hotline_view_controller; // --added by yelong on 2011.03.02
	PropertyLoanViewController *_PropertyLoanViewController;
    //	ImportantNoticeViewController *_ImportantNoticeViewController;
	NSString *lastScreen;
	
	//------MegaHub Added---------
	NSString *m_sLastQuoteSymbol;
	LastVisitPage m_iLastVisitPage;
	AccountType m_iAccountType;
	//------End of MegaHub Added--
}

@property (nonatomic, retain) BEAAppDelegate* _BEAAppDelegate;

@property (nonatomic, retain) NSString *realServerURL,*realServerURLCard, *sessionID, *loginID, *iCouponServerURL, *iCouponServerLogoutURL, *iCouponServer;
@property (nonatomic, retain) UINavigationController *main_view_controller;
@property (nonatomic, retain) BEAViewController *bea_view_controller;
@property (nonatomic, retain) HomeViewController *home_view_controller;
@property (nonatomic, retain) BEADelightViewController *delight_view_controller;
@property (nonatomic, retain) RootViewController *root_view_controller;
@property (nonatomic, retain) MaskViewController *mask;
@property (nonatomic, retain) ECouponViewController *ecoupon;
@property (nonatomic, retain) EMailViewController *email;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSString *lang, *UDID, *OS, *lastScreen;
+(CoreData *)sharedCoreData;
+(NSString *)md5:(NSString *)str;

@property (nonatomic, retain) ATMLocationViewController *atmlocation_view_controller;
@property (nonatomic, retain) TaxLoanViewController *taxLoan_view_controller;
@property (nonatomic, retain) SGViewController *sg_view_controller;
@property (nonatomic, retain) InsuranceViewController* _InsuranceViewController;
@property (nonatomic, retain) LTViewController *_LTViewController;
@property (nonatomic, retain) InstalmentLoanViewController *_InstalmentLoanViewController;
@property (nonatomic, retain) HotlineViewController* hotline_view_controller; // --added by yelong on 2011.03.02
@property (nonatomic, retain) PropertyLoanViewController *_PropertyLoanViewController;
//@property (nonatomic, retain) ImportantNoticeViewController *_ImportantNoticeViewController;
@property (nonatomic, retain) P2PMenuViewController * sP2PMenuViewController;
@property (nonatomic, retain) FacebookListViewController *facebookListViewController;
//------MegaHub Added---------
@property (nonatomic, retain) NSString *m_sLastQuoteSymbol;
@property (nonatomic, assign) LastVisitPage m_iLastVisitPage;
@property (nonatomic, assign) AccountType m_iAccountType;
//------End of MegaHub Added--

@property (nonatomic, assign) BOOL goBanking;

@property (nonatomic, strong) NSString *menuType;


+(NSString *)md5:(NSString *)str;
+(void)setMainViewFrame;
-(NSString *)couponLang;
@end