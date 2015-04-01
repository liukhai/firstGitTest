//
//  PTAHSharesViewController.h
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTAHSharesView;

@interface MHBEAFAAHSharesViewController : UIViewController <UIWebViewDelegate> {
	PTAHSharesView				*m_oPTAHSharesView;
}

- (void)loadView;
- (void)dealloc;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animate;
- (void)didReceiveMemoryWarning;
- (void)viewDidUnload;
- (void)reloadText;
- (void)reloadAHShares;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end