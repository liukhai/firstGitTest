//
//  MHBEAFASectorRootViewController.h
//  BEA
//
//  Created by MegaHub on 15/09/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTSectorRootView;

@interface MHBEAFASectorRootViewController : UIViewController <UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource> {
	PTSectorRootView		*m_oPTSectorRootView;
	
	// Storing MHFeedXObjSector
	NSArray					*m_oDataSourceArray;
	
	NSString				*m_sSector;
}

@property(nonatomic, retain) NSString *m_sSector;

- (id) init;
- (void)dealloc;
- (void)loadView;
- (void)didReceiveMemoryWarning;
- (void)viewDidLoad;
- (void)viewDidUnload;
- (void)reloadText;
- (void)onBackButtonPressed;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getNewsLanguageTransluation;
- (void)loadSectorWithStock:(NSString *)aSymbolWithOutLeadingZer;
- (void)loadSectorWithC:(NSString *)aSector;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (void)onGetSectorNameReceived:(NSNotification *)n;

@end