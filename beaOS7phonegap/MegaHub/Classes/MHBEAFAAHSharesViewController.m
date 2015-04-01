    //
//  MHBEAFAAHSharesViewController.m
//  BEA
//
//  Created by MegaHub on 15/09/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAFAAHSharesViewController.h"
#import "MHDetailDisclaimerButton.h"
#import "MHBEAPTSSIndexViewController.h"
#import "MHFeedConnectorX.h"
#import "PTAHSharesView.h"
#import "MHLanguage.h"
#import "PTConstant.h"
#import "StyleConstant.h"
#import "MHDetailDisclaimerButton.h"
#import "MagicTraderAppDelegate.h"

#import "ViewControllerDirector.h"
#import "MHUtility.h"

@implementation MHBEAFAAHSharesViewController

- (void)loadView {
    m_oPTAHSharesView = [[PTAHSharesView alloc] initWithFrame:CGRectMake(0, 94, 320, [MHUtility getAppHeight]-15-31-94) permission:YES];
	self.view = m_oPTAHSharesView;
	[m_oPTAHSharesView.m_oWebView setDelegate:self];
}

- (void)dealloc {
    [super dealloc];
    [m_oPTAHSharesView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	[m_oPTAHSharesView release];
	m_oPTAHSharesView = nil;
}

- (void)reloadText {
	[m_oPTAHSharesView reloadText];
	[self reloadAHShares];
}

- (void)reloadAHShares {
    
    NSString *urlString = [[MHFeedConnectorX sharedMHFeedConnectorX] urlAHShares:PT_WEBVIEW_STYLE
																		language:[MHLanguage getCurrentLanguage]
																	 refreshRate:nil
																		  action:@"-1"
																		realtime:PT_WEBVIEW_DELAY
                                                                         version:URL_VERSION_1_0
                                                                               v:nil];
    urlString = [NSString stringWithFormat:@"%@%@",urlString,@"&showAll=1"];
	[m_oPTAHSharesView loadURLString:urlString];
	
}


#pragma mark -
#pragma mark WebView delegate functions
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	NSString *urlString = [[request URL] absoluteString];
	
	if ([[[request URL] scheme] isEqualToString:STOCK_QUOTE_LINK_PREFIX] == YES) {
		
		ViewControllerDirectorParameter *p = [[ViewControllerDirectorParameter alloc] init];
		p.m_sString1 = urlString;
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDQuote para:p];
		[p release];
		
	} else if([[[request URL] scheme] isEqualToString:DISCLAIMER_PREFIX] == YES){
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDSolutionProviderDisclaimer para:nil];
	}
    
	return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[m_oPTAHSharesView startLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[m_oPTAHSharesView stopLoading];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[m_oPTAHSharesView stopLoading];
}

@end