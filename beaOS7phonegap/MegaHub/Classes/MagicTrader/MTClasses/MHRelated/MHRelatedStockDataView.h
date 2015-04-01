//
//  MHRelatedStockDataView.h
//  MagicTrader
//
//  Created by Hong on 09/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHIndexBarView;
@class LoadingView;

//TODO: put the delegate back to the controller
@interface MHRelatedStockDataView : UIView <UIWebViewDelegate> {
	UIWebView			*m_oWebView;
	
	LoadingView			*m_oLoadingView;
	
	NSString			*m_sPreviousUrlString;
	NSString			*m_sPreviousStockSymbol;
	
	BOOL				isStock;
}
@property (nonatomic, retain) NSString			*m_sPreviousUrlString;
@property (nonatomic, retain) UIWebView			*m_oWebView;
@property (nonatomic, retain) NSString			*m_sPreviousStockSymbol;

- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;

// Loading Functions
- (void)startLoading;
- (void)stopLoading;

- (void)reloadText;

// Custom Functions
- (void)loadURLString:(NSString *)aURLString;

//唔食.HK
- (void)loadStock:(NSString *)aSymbolWithinMarket rate:(int)aRate action:(NSString *)aAction realtime:(BOOL)aRealTime;
- (void)loadWarrant:(NSString *)aSymbolWithinMarket rate:(int)aRate action:(NSString *)aAction realtime:(BOOL)aRealTime;
- (void)loadStock:(NSString *)aSymbolWithinMarket rate:(int)aRate;
- (void)loadWarrant:(NSString *)aSymbolWithinMarket rate:(int)aRate;

@end
