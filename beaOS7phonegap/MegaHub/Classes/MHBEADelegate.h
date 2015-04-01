//
//  MHBEADelegate.h
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MHBEA_DELEGATE				[MHBEADelegate sharedMHBEADelegate]

@interface MHBEADelegate : NSObject {
	
	// Watchlist
	// storing the symbol in NSString format
	NSMutableArray				*m_oStockWatchlistArray;

	UIAlertView					*m_oAlertView;
	
	NSString					*m_sRequestServer;
	NSString					*m_sToken;
}

@property(nonatomic, retain) NSString	*m_sRequestServer;
@property(nonatomic, retain) NSString	*m_sToken;

+ (MHBEADelegate *)sharedMHBEADelegate;
- (void)release;
- (id)autorelease;
- (NSUInteger)retainCount;
- (id)copyWithZone:(NSZone *)zone;
+ (id)allocWithZone:(NSZone *)zone;
- (id) init;
- (void)dealloc;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)showCannotAddStockToWatchlist;
- (void)showAddedStockToWatchlist;
- (void)showAddWatchlistInvalidStock;
- (void)showInvalidStock;
- (void)showNoMobileNoStockTrading;
- (void)showNoMobileNoEAS;
- (void)showNoMobileNo;
- (NSString *)loadURLAfterSessionExpired:(UIWebView *)aWebView previousUrlString:(NSString *)aPrevoiurUrlString;
- (unsigned int)getLiteQuoteWatchlistPage;
- (unsigned int)getFreeQuote:(NSString *)aSymbol;
- (unsigned int)getFAHSI;
- (NSArray *)loadStockWatchlist;
- (void)saveStockWatchlist:(NSArray *)aArray;
- (NSArray *)loadStockWatchlistGainLoss;
- (void)saveStockWatchlistGainLoss:(NSArray *)aArray;
- (BOOL)stockWathlistHaveStock:(NSString *)aStockSymbol;
- (BOOL)addStockWatchlist:(NSString *)aStockSymbol;
- (BOOL)removeStockWatchlist:(NSString *)aStockSymbol;

@end