//
//  MHBEAPTSSLocalIndexViewController.h
//  BEA
//
//  Created by Samuel Ma on 16/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHLanguage.h"

@class MHFeedXObjIndexName;
@class PTLocalIndexView;
@class PTLocalIndexConstituentView;
@class MHFeedXMsgInGetLiteQuote;

@interface MHBEAPTSSLocalIndexViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate> {

	PTLocalIndexView						*m_oPTLocalIndexView;
	PTLocalIndexConstituentView				*m_oPTLocalIndexConstituentView;
	
	NSIndexPath				*m_oSelectedCellIndexPath;
	UIImage					*m_oSelectedIndexImage;		// the graph of index in selected cell
		
	unsigned int			m_uiFeedXMsgID;
	NSMutableArray			*m_oIndexArray;				// storing MHFeedXObjQuote
    
    NSString                *m_sLocalIndexType;
	
}

- (id) init;
- (void)dealloc;
- (void)loadView;
- (void)viewDidLoad;
- (void)viewDidUnload;
- (void)reloadText;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
- (void)onAccessoryButtonPressed:(id)sender event:(id)event;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)loadGraph;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)showIndexConstituentView:(BOOL)aShow animationTime:(float)aAnimationTime;
- (MHFeedXObjIndexName *)localIndexFromIndexPath:(NSIndexPath *)aIndexPath;
- (NSString *)urlLocalIndexGraph:(NSString *)aLocalIndexType width:(int)aWdith height:(int)aHeight language:(Language)aLanguage;
- (void)reloadLocalIndex;
- (void)handleGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)aMsg;
- (void)onGetLocalIndexName:(NSNotification *)n;
- (void)onGetLiteQuoteReceived:(NSNotification *)n;

@end