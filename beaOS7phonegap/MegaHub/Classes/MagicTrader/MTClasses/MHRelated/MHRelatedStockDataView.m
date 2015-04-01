//
//  MHRelatedStockDataView.m
//  MagicTrader
//
//  Created by Hong on 09/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHRelatedStockDataView.h"
#import "MHFeedConnectorX.h"
#import "MHIndexBarView.h"
#import "LoadingView.h"
#import "MHLanguage.h"

#import "PTConstant.h"

#import "MagicTraderAppDelegate.h"
#import "ViewControllerDirector.h"

#import <QuartzCore/QuartzCore.h>

@implementation MHRelatedStockDataView

@synthesize m_oWebView;
@synthesize m_sPreviousUrlString;
@synthesize m_sPreviousStockSymbol;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		// web view
		m_oWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,  frame.size.height)];
		[m_oWebView setDataDetectorTypes:UIDataDetectorTypeNone];
		m_oWebView.delegate = self;
		[self addSubview:m_oWebView];
		
		// LoadingMask
		m_oLoadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
		[m_oLoadingView setCenter:m_oWebView.center];
		[self addSubview:m_oLoadingView];
		
		isStock = YES;
		
    }
    return self;
}

- (void)dealloc {
    [m_oWebView stopLoading];
    [m_oWebView setDelegate:nil];
    [m_oWebView release];
    [m_oLoadingView release];
	[m_sPreviousUrlString release];
	[m_sPreviousStockSymbol release];
    [super dealloc];
}

- (void)reloadText {
	[m_oLoadingView reloadText];
	if(isStock){
		[self loadStock:self.m_sPreviousStockSymbol rate:REFESH_RATE_REALTED_STOCK];
	}else{
		[self loadWarrant:self.m_sPreviousStockSymbol rate:REFESH_RATE_REALTED_STOCK];
	}
}

#pragma mark -
#pragma mark Loading Functions
- (void)startLoading {
	[m_oLoadingView startLoading];
}

- (void)stopLoading {
	[m_oLoadingView stopLoading];
}

#pragma mark -
#pragma mark Custom Functions
//-----------------------------------------------------------------------------
- (void)loadURLString:(NSString *)aURLString {
	NSString *link = [aURLString stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	[m_oWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:link]]];
}


- (void)loadStock:(NSString *)aSymbolWithinMarket rate:(int)aRate action:(NSString *)aAction realtime:(BOOL)aRealTime {
    
	if(aSymbolWithinMarket == nil || [aSymbolWithinMarket length] == 0){
		return;
	}
    
	NSString *urlString = [[MHFeedConnectorX sharedMHFeedConnectorX] urlRelatedQuoteView:PT_WEBVIEW_STYLE
																				language:[MHLanguage getCurrentLanguage] 
																			 refreshRate:nil 
																				 stockID:aSymbolWithinMarket 
																				  action:aAction
																				realtime:aRealTime?PT_WEBVIEW_REALTIME:PT_WEBVIEW_DELAY
                                                                                 version:URL_VERSION_1_0 
                                                                                       v:nil];
	self.m_sPreviousUrlString = urlString;
	self.m_sPreviousStockSymbol = aSymbolWithinMarket;
	isStock = YES;
	
	[self loadURLString:urlString];
}

- (void)loadWarrant:(NSString *)aSymbolWithinMarket rate:(int)aRate action:(NSString *)aAction realtime:(BOOL)aRealTime {
	
	if(aSymbolWithinMarket == nil || [aSymbolWithinMarket length] == 0){
		return;
	}
	
	NSString *urlString = [[MHFeedConnectorX sharedMHFeedConnectorX] urlRelatedQuoteView:PT_WEBVIEW_STYLE
																				language:[MHLanguage getCurrentLanguage] 
																			 refreshRate:nil 
																			   warrantID:aSymbolWithinMarket 
																				  action:aAction
																				realtime:aRealTime?PT_WEBVIEW_REALTIME:PT_WEBVIEW_DELAY
                                                                                 version:URL_VERSION_1_0 
                                                                                       v:nil];
	
	self.m_sPreviousUrlString = urlString;
	self.m_sPreviousStockSymbol = aSymbolWithinMarket;
	isStock = NO;
	
	[self loadURLString:urlString];
}

// old function
- (void)loadStock:(NSString *)aSymbolWithinMarket rate:(int)aRate {
    if([[MHFeedConnectorX sharedMHFeedConnectorX] getPermission:MHFEEDX_PERMISSION_MT_TELETEXT]){
        [self loadStock:aSymbolWithinMarket rate:aRate action:PT_WEBVIEW_ACTION_202 realtime:YES];
    }else{
        [self loadStock:aSymbolWithinMarket rate:aRate action:PT_WEBVIEW_ACTION_202 realtime:NO];
    }
}

// old function
- (void)loadWarrant:(NSString *)aSymbolWithinMarket rate:(int)aRate {
    if([[MHFeedConnectorX sharedMHFeedConnectorX] getPermission:MHFEEDX_PERMISSION_MT_TELETEXT]){
        [self loadWarrant:aSymbolWithinMarket rate:aRate action:PT_WEBVIEW_ACTION_202 realtime:YES];
    }else{
        [self loadWarrant:aSymbolWithinMarket rate:aRate action:PT_WEBVIEW_ACTION_202 realtime:NO];
    }
}

-(void)clean{
	[self loadURLString:nil];
}

#pragma mark -
#pragma mark UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[self startLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[self stopLoading];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	if([error code] == NSURLErrorCancelled){
		return;
	}
	[self stopLoading];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	BOOL isLoad = YES;
	
	NSString *urlString = [[request URL] absoluteString];
	
	if ([[[request URL] scheme] isEqualToString:STOCK_QUOTE_LINK_PREFIX] == YES) {
		
		ViewControllerDirectorParameter *p = [[ViewControllerDirectorParameter alloc] init];
		p.m_sString1 = urlString;
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDWeb_Stock_Quote para:p];
		[p release];
		
		isLoad = NO;
        
	} else if([[[request URL] scheme] isEqualToString:DISCLAIMER_PREFIX] == YES){
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDSolutionProviderDisclaimer para:nil];
		isLoad = NO;
	}
	
	return isLoad;
}

@end


