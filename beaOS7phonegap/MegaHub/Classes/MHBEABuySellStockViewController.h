//
//  MHBEABuySellStockViewController.h
//  BEA
//
//  Created by MegaHub on 07/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHBEAWatchlistLv0ViewController.h"
#import "ASIFormDataRequest.h"
#import "RotateMenu3ViewController.h"

typedef enum {
	BuySellTypeBuy		= 1,
	BuySellTypeSell		= 2
} BuySellType;

@class MHBEAIndexQuoteView;
@class MHBEABuySellStockView;

@interface MHBEABuySellStockViewController : UIViewController <UIWebViewDelegate, ASIHTTPRequestDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    MHBEABuySellStockView           *m_oMHBEABuySellStockView;
    
    unsigned int					m_uiMHFeedXMessageID;
	BOOL							m_isShowingGainLoss;		// YES -> showing gain and loss, NO-> showing change and % change
    
	// Storing MHFeedXObjQuote
	NSMutableArray					*m_oStockArray;
    
	// Storing MHBEAObjWatchlistStock for calulating gain and loss
	NSMutableArray					*m_oMHBEAObjWatchlistStockArray;
    
    NSString						*m_sStockUpdateTime;
    
	UIWebView                       *m_oWebView;
	
	BuySellType                     m_iBuySellType;
	NSString                        *m_sSelectedSymbol;
    
    BOOL                            m_isWebTrade;
    
    RotateMenu3ViewController       *v_rmvc;
}

- (id)init;
- (void)dealloc;
- (void)loadView;
- (void)viewDidLoad;
- (void)reloadText;
- (void)viewDidUnload;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)hideWebView;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (void)reloadDataSource;
- (void)setTableEditing:(BOOL)aBool;
- (void)setShowGainLoss:(BOOL)aBool;
- (void)setBuySellType:(BuySellType)aType;
- (void)switchToWebTrade:(NSString*)stockCode;
- (void)webViewLoadString:(NSString *)aURLString;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)onAddButtonPressed:(id)sender;
- (void)onCellGainLossButtonPressed:(id)sender;
- (void)onBuySellButtonPressed:(id)sender;
- (void)handleNoReg;
- (void)handleHaveReg:(NSString *)aToken;
- (void)requestCheckMobileRegisterStatus;
- (void)requestCheckMobileRegisterStatusInBackground;
- (void)requestStarted:(ASIHTTPRequest *)request;
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
- (MHBEAObjWatchlistStock *)getWatchlistStockWithSymbol:(NSString *)aSymbol;
- (void)removeWatchlistStockWithSymbol:(NSString *)aSymbol;
- (void)updateStockTotalValueLabel;
- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)msg;
- (void)handleGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)aGetLiteQuoteMsg;
- (void)onGetLiteQuoteReceived:(NSNotification *)n;

@end