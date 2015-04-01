//
//  MHBEAFATopRankViewController.h
//  BEA
//
//  Created by MegaHub on 15/09/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHSubmenu.h"

@class PTTopRankView;

@interface MHBEAFATopRankViewController : UIViewController <UIWebViewDelegate> {
	PTTopRankView               *m_oPTTopRankView;
    NSString					*m_sSectorString;
	NSString					*m_sCategoryString;
}

- (id)init;
- (void)loadView;
- (void)dealloc;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)viewDidUnload;
- (void)reloadText;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)MHSubmenuDelegateCallback:(NSNumber *)aSubmenuNumberCode;
- (void)reloadTopRank;

@end