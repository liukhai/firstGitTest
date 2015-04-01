//
//  MHBEADelegate.m
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAObjWatchlistStock.h"
#import "MobileTradingUtil.h"
#import "MHFeedConnectorX.h"
#import "MHBEADelegate.h"
#import "MHBEAConstant.h"
#import "MHLanguage.h"
#import "MHUtility.h"
#import "MBKUtil.h"
#import "PTConstant.h"

#define TAG_ALERTVIEW_showCannotAddStockToWatchlist		1000
#define TAG_ALERTVIEW_showAddedStockToWatchlist			1100
#define TAG_ALERTVIEW_showAddWatchlistInvalidStock		1200
#define TAG_ALERTVIEW_showInvalidStock					1300
#define TAG_ALERTVIEW_showNoMobileNoStockTrading		1400
#define TAG_ALERTVIEW_showNoMobileNoEAS					1500
/////////////////////////////////

// For SSL http Server

/////////////////////////////////

@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
	return YES; // Or whatever logic
}
@end

/////////////////////////////////

// End of For SSL http Server

/////////////////////////////////

////////////////////////////////

@implementation MHBEADelegate

@synthesize	m_sRequestServer;
@synthesize m_sToken;

static MHBEADelegate *sharedMHBEADelegate = nil;

+ (MHBEADelegate *)sharedMHBEADelegate {
	@synchronized(self) {
		if (sharedMHBEADelegate == nil) {
			sharedMHBEADelegate	= [[self alloc] init];
		}
	}
	
	return sharedMHBEADelegate;
}

- (void)release {
}

- (id)autorelease { 
	return self;
}

- (NSUInteger)retainCount {
	return NSUIntegerMax;
}
- (id)retain {
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedMHBEADelegate == nil) {
			sharedMHBEADelegate = [super allocWithZone:zone];
			return sharedMHBEADelegate;
		}
	}
	
	return nil;
}

- (id) init {
	self = [super init];
	if (self != nil) {
		m_oStockWatchlistArray = [[NSMutableArray alloc] initWithArray:[self loadStockWatchlist]];
	}
	return self;
}

- (void)dealloc {
	[m_oStockWatchlistArray release];
	[m_sRequestServer release];
	[super dealloc];
}

//=============================================================================


#pragma mark -
#pragma mark AlertView Delegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (alertView.tag) {
			
		case TAG_ALERTVIEW_showCannotAddStockToWatchlist: {
						break;
		}
					
		default:
			break;
	}
}

- (void)showCannotAddStockToWatchlist {
	if (m_oAlertView) {
		[m_oAlertView dismissWithClickedButtonIndex:0 animated:YES];
		[m_oAlertView release];
		m_oAlertView = nil;
	}
	
	// TODO:string
	m_oAlertView = [[UIAlertView alloc] initWithTitle:MHLocalizedStringFile(@"AlertView.showCannotAddStockToWatchlist.title", nil, MHLanguage_BEAString)
											  message:nil
											 delegate:self 
									cancelButtonTitle:MHLocalizedStringFile(@"AlertView.showCannotAddStockToWatchlist.ok", nil, MHLanguage_BEAString)
									otherButtonTitles:nil];
	[m_oAlertView setTag:TAG_ALERTVIEW_showCannotAddStockToWatchlist];
	[m_oAlertView show];
}

- (void)showAddedStockToWatchlist {
	if (m_oAlertView) {
		[m_oAlertView dismissWithClickedButtonIndex:0 animated:YES];
		[m_oAlertView release];
		m_oAlertView = nil;
	}
	
	// TODO:string
	m_oAlertView = [[UIAlertView alloc] initWithTitle:MHLocalizedStringFile(@"AlertView.showAddedStockToWatchlist.title", nil, MHLanguage_BEAString)
											  message:MHLocalizedStringFile(@"AlertView.showAddedStockToWatchlist.message", nil, MHLanguage_BEAString)
											 delegate:self 
									cancelButtonTitle:MHLocalizedStringFile(@"AlertView.showAddedStockToWatchlist.ok", nil, MHLanguage_BEAString)
									otherButtonTitles:nil];
	[m_oAlertView setTag:TAG_ALERTVIEW_showAddedStockToWatchlist];
	[m_oAlertView show];
}

- (void)showAddWatchlistInvalidStock {
	if (m_oAlertView) {
		[m_oAlertView dismissWithClickedButtonIndex:0 animated:YES];
		[m_oAlertView release];
		m_oAlertView = nil;
	}
	
	// TODO:string
	m_oAlertView = [[UIAlertView alloc] initWithTitle:MHLocalizedStringFile(@"AlertView.showAddWatchlistInvalidStock.title", nil, MHLanguage_BEAString)
											  message:MHLocalizedStringFile(@"AlertView.showAddWatchlistInvalidStock.message", nil, MHLanguage_BEAString)
											 delegate:self 
									cancelButtonTitle:MHLocalizedStringFile(@"AlertView.showAddWatchlistInvalidStock.ok", nil, MHLanguage_BEAString)
									otherButtonTitles:nil];
	[m_oAlertView setTag:TAG_ALERTVIEW_showAddWatchlistInvalidStock];
	[m_oAlertView show];
}

- (void)showInvalidStock {
	if (m_oAlertView) {
		[m_oAlertView dismissWithClickedButtonIndex:0 animated:YES];
		[m_oAlertView release];
		m_oAlertView = nil;
	}
	
	// TODO:string
	m_oAlertView = [[UIAlertView alloc] initWithTitle:MHLocalizedStringFile(@"MHBEAFAQuoteViewController.title.invalid_stock", nil, MHLanguage_BEAString)
											  message:nil
											 delegate:self 
									cancelButtonTitle:MHLocalizedStringFile(@"MHBEAFAQuoteViewController.ok", nil, MHLanguage_BEAString)
									otherButtonTitles:nil];
	[m_oAlertView setTag:TAG_ALERTVIEW_showInvalidStock];
	[m_oAlertView show];
}

- (void)showNoMobileNoStockTrading {
	if (m_oAlertView) {
		[m_oAlertView dismissWithClickedButtonIndex:0 animated:YES];
		[m_oAlertView release];
		m_oAlertView = nil;
	}
	
	// TODO:string
	m_oAlertView = [[UIAlertView alloc] initWithTitle:MHLocalizedStringFile(@"AlertView.showNoMobileNoStockTrading.title", nil, MHLanguage_BEAString)
											  message:nil
											 delegate:self 
									cancelButtonTitle:MHLocalizedStringFile(@"AlertView.showNoMobileNoStockTrading.cancelButton", nil, MHLanguage_BEAString)
									otherButtonTitles:nil];
	[m_oAlertView setTag:TAG_ALERTVIEW_showNoMobileNoStockTrading];
	[m_oAlertView show];
}

- (void)showNoMobileNoEAS {
	if (m_oAlertView) {
		[m_oAlertView dismissWithClickedButtonIndex:0 animated:YES];
		[m_oAlertView release];
		m_oAlertView = nil;
	}
	
	// TODO:string
	m_oAlertView = [[UIAlertView alloc] initWithTitle:MHLocalizedStringFile(@"AlertView.showNoMobileNoEAS.title", nil, MHLanguage_BEAString)
											  message:nil
											 delegate:self 
									cancelButtonTitle:MHLocalizedStringFile(@"AlertView.showNoMobileNoEAS.cancelButton", nil, MHLanguage_BEAString)
									otherButtonTitles:nil];
	[m_oAlertView setTag:TAG_ALERTVIEW_showNoMobileNoEAS];
	[m_oAlertView show];
}

- (void)showNoMobileNo {
	if (MHBEA_DELEGATE.m_sRequestServer == nil || 
		[MHBEA_DELEGATE.m_sRequestServer length] == 0 ) {
		// show BEA
		[self showNoMobileNoStockTrading];
		
	} else if ([MHBEA_DELEGATE.m_sRequestServer isEqualToString:@"MOBILETRADING"]) {	
		// Stock trading
		[self showNoMobileNoStockTrading];
		
	} else if ([MHBEA_DELEGATE.m_sRequestServer isEqualToString:@"MOBILEBANKING"]) {	
		// EAS
		[self showNoMobileNoEAS];
	} 
}

- (NSString *)loadURLAfterSessionExpired:(UIWebView *)aWebView previousUrlString:(NSString *)aPrevoiurUrlString {
//	[self refreshTGT];
	
	sleep(1);
	NSString *oldTGT = [MHUtility extractString:aPrevoiurUrlString identifier:@"tgt="];
	NSString *action = [MHUtility extractString:aPrevoiurUrlString identifier:@"a="];
	NSString *newTGT = [[MHFeedConnectorX sharedMHFeedConnectorX] getTGT:action];
	NSString *newUrl = [aPrevoiurUrlString stringByReplacingOccurrencesOfString:oldTGT withString:newTGT];
	aPrevoiurUrlString = newUrl;
	[aWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newUrl]]];
	
	return aPrevoiurUrlString;
}

- (unsigned int)getLiteQuoteWatchlistPage {
	if ([m_oStockWatchlistArray count] <= 0) {
        return -1;
    }
	
	NSString *symbol = nil;
	NSMutableArray *symbolArray = [[[NSMutableArray alloc] init] autorelease];
	for (symbol in m_oStockWatchlistArray) {
		[symbolArray addObject:[NSString stringWithFormat:@"%d.HK", [symbol intValue]]];
	}
	
	NSArray *typeArray = [NSArray arrayWithObjects:Parameter_Desp, Parameter_Prev_Close, Parameter_Last, Parameter_BidandAsk, Parameter_Change, Parameter_Pct_Change, Parameter_Last_Update, nil];
	
	return [[MHFeedConnectorX sharedMHFeedConnectorX] getLiteQuoteWithAuthen:symbolArray
                                                                        type:typeArray
																	language:[MHLanguage getCurrentLanguage] 
																  fromObject:self
                                                                    freeText:nil
																	  action:@"-1"
																	realtime:@"0"];
	
	
}

- (unsigned int)getFreeQuote:(NSString *)aSymbol {
	NSArray *symbolArray = [NSArray arrayWithObject:[NSString stringWithFormat:@"%d.HK", [aSymbol intValue]]];
	NSArray *typeArray = [NSArray arrayWithObjects:
                          Parameter_Stock_Type,
                          Parameter_Desp,
                          Parameter_Last,
                          Parameter_BidandAsk,
                          Parameter_Change,
                          Parameter_Pct_Change,
                          Parameter_Open,
                          Parameter_Prev_Close,
                          Parameter_AvgPrice,
                          Parameter_Volume,
                          Parameter_Turnover,
                          Parameter_Premium,
                          Parameter_PE,
                          Parameter_Gearing,
                          Parameter_Lot_Size,
                          Parameter_High,
                          Parameter_Low,
                          Parameter_52WeekHighLow,
                          Parameter_Underlying_Code,
                          Parameter_Underlying_Change,
                          Parameter_Underlying_Price,
                          Parameter_Suspension,
                          Parameter_Yeild,
                          
                          Parameter_IEVOrIEP,
                          Parameter_Currency,
                          Parameter_CurrencyDesp,
                          Parameter_Issuer,
                          Parameter_Entitlement_Ratio,
                          Parameter_Strike,
                          Parameter_Outstanding_QtyPencentage,
                          Parameter_Effective_Gearing,
                          Parameter_Imp_Vol,
                          Parameter_Delta,
                          Parameter_Maturity,
                          Parameter_Moneyness,
                          Parameter_Call_Price,
                          Parameter_Spot_vs_call,
                          Parameter_1MonthHighLow,
                          Parameter_Volatility30,
                          Parameter_AuthCap,
                          Parameter_Shares_Issued,
                          Parameter_Market_Cap,
                          Parameter_NAV,
                          Parameter_EPS,
                          Parameter_DPS,
                          Parameter_SpreadType,
                          Parameter_BidAskSpread,
                          Parameter_Last_Update,
                          
                          Parameter_SMA10,
                          Parameter_SMA20,
                          Parameter_SMA50,
                          Parameter_SMA100,
                          Parameter_SMA250,
                          Parameter_MACD817,
                          Parameter_MACD1225,
                          Parameter_RSI9,
                          Parameter_RSI14,
                          Parameter_RSI20,
                          Parameter_STC10,
                          Parameter_STC14,
                          Parameter_STC20,
                          
                          nil];
	
	return [[MHFeedConnectorX sharedMHFeedConnectorX] getLiteQuoteWithAuthen:symbolArray type:typeArray language:[MHLanguage getCurrentLanguage]
																  fromObject:self
																	freeText:nil
																	  action:@"-1"
																	realtime:PT_WEBVIEW_DELAY];
	
}

- (unsigned int)getFAHSI {
	NSArray *symbolArray = [NSArray arrayWithObject:@"HSI.HK"];
	NSArray *typeArray = [NSArray arrayWithObjects:Parameter_Desp, Parameter_Last, Parameter_Change, Parameter_Pct_Change, Parameter_Last_Update, nil];
	
    return [[MHFeedConnectorX sharedMHFeedConnectorX] getLiteQuoteWithAuthen:symbolArray
                                                                        type:typeArray
                                                                    language:[MHLanguage getCurrentLanguage]
                                                                  fromObject:nil
                                                                    freeText:nil
                                                                      action:@"-1"
                                                                    realtime:PT_WEBVIEW_DELAY];
}


#pragma mark -
#pragma mark Local Watchlist funtions
// storing the symbol of stock in NSString format
- (NSArray *)loadStockWatchlist {
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	NSArray *stockWatchlistSmybolArray = nil;
	
	@synchronized(preferences) {
		stockWatchlistSmybolArray = [preferences objectForKey:SAVEKEY_STOCKWATCHLIST];
	}
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (NSString *s in stockWatchlistSmybolArray) {
		[array addObject:[NSString stringWithFormat:@"%d", [s intValue]]];
	}
	
	return [array autorelease];
	
}

// stroing the symbol of stock in NSString format
- (void)saveStockWatchlist:(NSArray *)aArray {
	[m_oStockWatchlistArray removeAllObjects];
	for (NSString *s in aArray) {
		[m_oStockWatchlistArray addObject:[NSString stringWithFormat:@"%d", [s intValue]]];
	}
	
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	[preferences setObject:aArray forKey:SAVEKEY_STOCKWATCHLIST];
	[preferences synchronize];
}

// Storing MHBEAObjWatchlistStock
- (NSArray *)loadStockWatchlistGainLoss {
	NSArray *array = nil;
	NSMutableArray *returnArray = [[[NSMutableArray alloc] init] autorelease];
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	
	@synchronized(preferences) {
		array = [preferences objectForKey:SAVEKEY_STOCKWATCHLIST_GAINLOSS];
	}
	
	for (NSDictionary *dict in array) {
		MHBEAObjWatchlistStock *stock = [[MHBEAObjWatchlistStock alloc] initWithDictionary:dict];
		[returnArray addObject:stock];
		[stock release];
	}
	
	return returnArray;
}

// Storing MHBEAObjWatchlistStock
- (void)saveStockWatchlistGainLoss:(NSArray *)aArray {
	NSMutableArray *newArray = [[NSMutableArray alloc] init];
	for (MHBEAObjWatchlistStock *stock in aArray) {
		[newArray addObject:[stock toDictionary]];
	}
	
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	[preferences setObject:newArray forKey:SAVEKEY_STOCKWATCHLIST_GAINLOSS];
	[preferences synchronize];
	[newArray release];
}


#pragma mark -
#pragma mark Watchlist
- (BOOL)stockWathlistHaveStock:(NSString *)aStockSymbol {
	NSString *stockSym = [NSString stringWithFormat:@"%d", [aStockSymbol intValue]];
	for (NSString *tmp in m_oStockWatchlistArray) {
		if ([tmp isEqualToString:aStockSymbol] ||
			[tmp isEqualToString:stockSym]) {
			return YES; // have
		}
	}
	return NO;
}


// add the symbol of the stock to watchlist Array
// leading zero will be removed
- (BOOL)addStockWatchlist:(NSString *)aStockSymbol {
	NSString *symbolWithoutZero = [NSString stringWithFormat:@"%d", [aStockSymbol intValue]];
	if ([self stockWathlistHaveStock:symbolWithoutZero]) {
		[self showCannotAddStockToWatchlist];
		return NO; // failed
	}
	
	[m_oStockWatchlistArray addObject:symbolWithoutZero];
	[self saveStockWatchlist:[NSArray arrayWithArray:m_oStockWatchlistArray]];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[self loadStockWatchlistGainLoss]];
    MHBEAObjWatchlistStock *stock = [[MHBEAObjWatchlistStock alloc] init];
    stock.m_sSymbol = aStockSymbol;
    [array addObject:stock];
    [stock release];
    [self saveStockWatchlistGainLoss:array];
    [array release];
	
	return YES;
}

- (BOOL)removeStockWatchlist:(NSString *)aStockSymbol {
	NSString *symbolWithoutZero = [NSString stringWithFormat:@"%d", [aStockSymbol intValue]];
	
	if ([self stockWathlistHaveStock:symbolWithoutZero] == NO ) {
		return NO; // failed
	}
	
	[m_oStockWatchlistArray removeObject:symbolWithoutZero];
	[self saveStockWatchlist:[NSArray arrayWithArray:m_oStockWatchlistArray]];
	
	return YES;
}

@end