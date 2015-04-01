//
//  ViewControllerDirectorParameter.h
//  MegaHub
//
//  Created by Hong on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	ViewControllerDirectorIDQuote						= 1,
	ViewControllerDirectorIDLandscapeChart,
	ViewControllerDirectorIDLandscapeChartRemove,
	ViewControllerDirectorIDWatchlist,
	ViewControllerDirectorIDTrade,
	ViewControllerDirectorIDNews,
	ViewControllerDirectorIDFX,
	ViewControllerDirectorIDMarketInfo,
	ViewControllerDirectorIDLocalIndex,
	ViewControllerDirectorIDWorldIndex,
	ViewControllerDirectorIDSector,
	ViewControllerDirectorIDTopRank,
	ViewControllerDirectorIDAHShare,
	ViewControllerDirectorIDSetting,
	ViewControllerDirectorIDReorder,
	ViewControllerDirectorIDSolutionProviderDisclaimer,
	ViewControllerDirectorIDFundamental,
	ViewControllerDirectorIDMegaHubDisclaimer,
	ViewControllerDirectorIDLogin,
	ViewControllerDirectorIDLoginDismiss,
	ViewControllerDirectorIDLanguageSetting,
	ViewControllerDirectorIDLanguageSettingRemove,
	ViewControllerDirectorIDCompanyDisclaimer,
	ViewControllerDirectorIDEdit,
	ViewControllerDirectorIDWeb_Stock_Quote,
	ViewControllerDirectorIDNewsSourceSelection,
	ViewControllerDirectorIDNewPortfolio,
	ViewControllerDirectorIDAboutMegaHub,
	ViewControllerDirectorIDRootViewController,
	ViewControllerDirectorIDAccountBalance,
	ViewControllerDirectorIDAccountPosition,
	ViewControllerDirectorIDAccountCashPositon,
	ViewControllerDirectorIDAccountOrderHistory,
	ViewControllerDirectorIDAccountOutstandingOrder,
    ViewControllerDirectorIDWebTradeBuy,
    ViewControllerDirectorIDWebTradeSell,
    ViewControllerDirectorIDBuy,
    ViewControllerDirectorIDSell,
    ViewControllerDirectorIDStock
} ViewControllerDirectorID;

@interface ViewControllerDirectorParameter : NSObject {
	ViewControllerDirectorID		m_iViewControllerID;
	int								m_iInt0;
	int								m_iInt1;
	int								m_iInt2;
	float							m_fFloat0;
	float							m_fFloat1;
	float							m_fFloat2;
	NSString						*m_sString0;
	NSString						*m_sString1;
	NSString						*m_sString2;
	NSMutableArray					*m_oArray;
	NSObject						*m_oObject;
	NSObject						*m_oObject0;
	NSObject						*m_oObject1;
	NSObject						*m_oObject2;
}

@property(nonatomic, assign) ViewControllerDirectorID		m_iViewControllerID;
@property(nonatomic, assign) int			m_iInt0;
@property(nonatomic, assign) int			m_iInt1;
@property(nonatomic, assign) int			m_iInt2;
@property(nonatomic, assign) float			m_fFloat0;
@property(nonatomic, assign) float			m_fFloat1;
@property(nonatomic, assign) float			m_fFloat2;
@property(nonatomic, retain) NSString		*m_sString0;
@property(nonatomic, retain) NSString		*m_sString1;
@property(nonatomic, retain) NSString		*m_sString2;
@property(nonatomic, retain) NSMutableArray	*m_oArray;
@property(nonatomic, retain) NSObject		*m_oObject;
@property(nonatomic, retain) NSObject		*m_oObject0;
@property(nonatomic, retain) NSObject		*m_oObject1;
@property(nonatomic, retain) NSObject		*m_oObject2;

- (id)init;
- (void)dealloc;

@end