//
//  MHBEAWebTradeStockViewController.h
//  BEA
//
//  Created by MegaHub on 07/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "MHBEABuySellStockViewController.h"

@class MHBEAIndexQuoteView;
@class MHBEAWebTradeStockView;

@interface MHBEAWebTradeStockViewController : UIViewController <UIWebViewDelegate, ASIHTTPRequestDelegate> {
    MHBEAWebTradeStockView          *m_oMHBEAWebTradeStockView;
    NSString						*m_sStockUpdateTime;
    NSString                        *m_sURL;
	UIWebView                       *m_oWebView;
	BuySellType                     m_iBuySellType;
	NSString                        *m_sSelectedSymbol;
}

- (void)dealloc;
- (void)loadView;
- (void)viewDidLoad;
- (void)reloadText;
- (void)viewDidUnload;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)setStockcode:(NSString *)aStockCode url:(NSString *)aURL;
- (void)setBuySellType:(BuySellType)aType;
- (void)hideWebView;
- (void)webViewLoadString:(NSString *)aURLString;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end