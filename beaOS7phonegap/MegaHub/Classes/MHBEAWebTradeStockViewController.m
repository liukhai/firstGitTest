//
//  MHBEAWebTradeStockViewController.m
//  BEA
//
//  Created by MegaHub on 07/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAWebTradeStockViewController.h"
#import "MHBEAWebTradeStockView.h"
#import "MHBEAIndexQuoteView.h"
#import "MHBEAStyleConstant.h"
#import "MHBEADelegate.h"
#import "LoadingView.h"
#import "MHLanguage.h"
#import "MHUtility.h"
#import "MobileTradingUtil.h"
#import "MHDisclaimerBarView.h"
#import "MHBEAConstant.h"
#import "MHFeedConnectorX.h"

@implementation MHBEAWebTradeStockViewController

- (void)dealloc {
    if(m_sSelectedSymbol){
        [m_sSelectedSymbol release];
    }
    if(m_sURL){
        [m_sURL release];
    }
    if (m_sStockUpdateTime) {
        [m_sStockUpdateTime release];
    }
	[super dealloc];
}

- (void)loadView {
	[super loadView];
    
    m_oMHBEAWebTradeStockView = [[MHBEAWebTradeStockView alloc] initWithFrame:CGRectMake(0, 63, 320, [MHUtility getAppHeight]) controller:self];
	self.view = m_oMHBEAWebTradeStockView;
    [m_oMHBEAWebTradeStockView stopLoading];
    [m_oMHBEAWebTradeStockView release];
	
	// web view for trade
	m_oWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 126, 320, [MHUtility getAppHeight]-63-m_oMHBEAWebTradeStockView.m_oMHBEAIndexQuoteView.frame.size.height-31-15)];
	[m_oWebView setDelegate:self];
	[m_oWebView setHidden:YES];
	[self.view addSubview:m_oWebView];
    [m_oWebView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)reloadText {
    [m_oMHBEAWebTradeStockView reloadText];
    [m_oMHBEAWebTradeStockView updateLastUpdateTime:m_sStockUpdateTime];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    RotateMenu3ViewController *v_rmvc = [[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil];
    [v_rmvc.rmUtil setNav:self.navigationController];
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc release];
//    m_oMHBEAWebTradeStockView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text = [NSString stringWithFormat:@"%05d",[m_sSelectedSymbol intValue]];
   
    [[MBKUtil me].queryButton1 setHidden:YES];
	[self reloadText];
    
    if(m_sURL){
        [self performSelectorInBackground:@selector(webViewLoadString:) withObject:m_sURL];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)setStockcode:(NSString *)aStockCode url:(NSString *)aURL{
    if(m_sSelectedSymbol){
        [m_sSelectedSymbol release];
        m_sSelectedSymbol = nil;
    }
    m_sSelectedSymbol = [aStockCode retain];
    
    if(m_sURL){
        [m_sURL release];
        m_sURL = nil;
    }
    m_sURL = [aURL retain];
}

- (void)setBuySellType:(BuySellType)aType {
    m_iBuySellType = aType;
    
    if(aType == BuySellTypeBuy){
        [m_oMHBEAWebTradeStockView.m_oMHBEABottomView setSelectedIndex:0];
    }else{
        [m_oMHBEAWebTradeStockView.m_oMHBEABottomView setSelectedIndex:4];
    }
}

- (void)hideWebView {
	m_oWebView.hidden = YES;
}


#pragma mark WebView
- (void)webViewLoadString:(NSString *)aURLString {
	m_oWebView.hidden = NO;
	NSString *link = [aURLString stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	[m_oWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:link]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[CoreData sharedCoreData].mask showMask];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[CoreData sharedCoreData].mask hiddenMask];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	if([error code] == NSURLErrorCancelled){
		return;
	}
	
	[[CoreData sharedCoreData].mask hiddenMask];
	[self hideWebView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //	NSString *urlString = [[request URL] absoluteString];
	
	if ([[[request URL] scheme] isEqualToString:MHBEA_URL_BACK] == YES) {
		
//		NSLog(@"Receive from webview: %@",MHBEA_URL_BACK);
		
		[self hideWebView];
	} 
	
	return YES;
}

//-----------------------------------------------------------------------------
- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)msg {
    
    // Update the last update time by index bar & a stock code
	[msg retain];
    MHFeedXObjStockQuote *stockQuote = nil;
    MHFeedXObjQuote *quote = nil;
    if (msg.m_oStockQuoteArray!= nil && [msg.m_oStockQuoteArray count] > 0) {
        stockQuote = [msg.m_oStockQuoteArray objectAtIndex:0];
        if (stockQuote.m_oQuoteArray != nil && [stockQuote.m_oQuoteArray count] >0) {
            quote = [stockQuote.m_oQuoteArray objectAtIndex:0];
            
            
            // set update time
            @synchronized(m_sStockUpdateTime) {
                if (m_sStockUpdateTime) {
                    [m_sStockUpdateTime release];
                    m_sStockUpdateTime = nil;
                }
                m_sStockUpdateTime = [quote.m_sLastUpdate retain];
            }
            [m_oMHBEAWebTradeStockView updateLastUpdateTime:m_sStockUpdateTime];
        }
    }
    [msg release];
}

@end