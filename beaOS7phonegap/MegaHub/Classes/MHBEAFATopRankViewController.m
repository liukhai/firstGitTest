    //
//  MHBEAFATopRankViewController.m
//  BEA
//
//  Created by MegaHub on 15/09/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAFATopRankViewController.h"
#import "MagicTraderAppDelegate.h"
#import "ViewControllerDirector.h"
#import "MHFeedConnectorX.h"
#import "PTTopRankView.h"
#import "StyleConstant.h"
#import "MHLanguage.h"
#import "MHUtility.h"

@implementation MHBEAFATopRankViewController

- (id)init {
	self = [super init];
	if (self != nil) {
        m_sSectorString				= String_XML_TopRank_Sector_Stock;
		m_sCategoryString			= String_XML_TopRank_Category_GAIN;
	}
	return self;
}

- (void)loadView {
	m_oPTTopRankView = [[PTTopRankView alloc] initWithFrame:CGRectMake(0, 94, 320, [MHUtility getAppHeight]-15-31-94)];
	self.view = m_oPTTopRankView;
	
	m_oPTTopRankView.m_oWebView.delegate = self;
	m_oPTTopRankView.m_oSectorSubmenu.m_idDelegate = self;
	m_oPTTopRankView.m_oCategorySubMenu.m_idDelegate = self;
	
    [m_oPTTopRankView.m_oSectorSubmenu removeSubmenuItem:SUBMENU_ITEM_TOPRANK_OPTION];
    [m_oPTTopRankView.m_oCategorySubMenu removeSubmenuItem:SUBMENU_ITEM_TOPRANK_CATEGORY_OPTION];
    
    [m_oPTTopRankView.m_oSectorSubmenu setSelectedSubmenu:SUBMENU_ITEM_STOCK];
	[m_oPTTopRankView.m_oCategorySubMenu setSelectedSubmenu:SUBMENU_ITEM_TOPRANK_CATEGORY_GAIN];

}

- (void)dealloc {
	[m_sSectorString release];
	[m_sCategoryString release];
	[m_oPTTopRankView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self reloadTopRank];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[m_oPTTopRankView release];	
	m_oPTTopRankView = nil;
}

- (void)reloadText {
	[m_oPTTopRankView reloadText];
    [self reloadTopRank];
}

#pragma mark -
#pragma mark UIWebView Delegate Functions
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[m_oPTTopRankView startLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[m_oPTTopRankView stopLoading];
	if ([webView canGoBack]) {
		//[m_oBackButton setHidden:NO];
	}
	if ([webView canGoForward]) {
		//[m_oBackButton setHidden:YES];
	}
	
	// load if show detail view
	if ([MT_DELEGATE loadIsDetailViewInTopRankView]) {
		[webView stringByEvaluatingJavaScriptFromString:JAVASCRIPT_TOPRANK_DETAIL];
	}
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[m_oPTTopRankView stopLoading];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	NSString *urlString = [[request URL] absoluteString];
	
	if ([[[request URL] scheme] isEqualToString:STOCK_QUOTE_LINK_PREFIX] == YES) {
		ViewControllerDirectorParameter *p = [[ViewControllerDirectorParameter alloc] init];
		p.m_sString1 = urlString;
		
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDQuote para:p];
		[p release];
		
	}  else if([[[request URL] scheme] isEqualToString:DISCLAIMER_PREFIX] == YES){
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDSolutionProviderDisclaimer
																	 para:nil];
	}
	
	
	return YES;
}


#pragma mark -
#pragma mark MHSubmenuDelegate Functions
- (void)MHSubmenuDelegateCallback:(NSNumber *)aSubmenuNumberCode {
	NSString *sectorString = nil;
	NSString *categoryString = nil;
	
	switch ([aSubmenuNumberCode intValue]) {
		case SUBMENU_ITEM_STOCK:{			sectorString = String_XML_TopRank_Sector_Stock;			break;}
		case SUBMENU_ITEM_HSCEI	:{			sectorString = String_XML_TopRank_Sector_HShares;		break;}
		case SUBMENU_ITEM_REDCHIPS:{		sectorString = String_XML_TopRank_Sector_RedChips;		break;}
		case SUBMENU_ITEM_GEM	:{			sectorString = String_XML_TopRank_Sector_GEM;			break;}
		case SUBMENU_ITEM_WARRANT:{			sectorString = String_XML_TopRank_Sector_Warrant;		break;}
		case SUBMENU_ITEM_CBBC	:{			sectorString = String_XML_TopRank_Sector_CBBC;			break;}
	}
	
	switch ([aSubmenuNumberCode intValue]) {
		case SUBMENU_ITEM_TOPRANK_CATEGORY_GAIN: {			categoryString = String_XML_TopRank_Category_GAIN;			break;}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_LOSS: {			categoryString = String_XML_TopRank_Category_LOSS;			break;}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_PGAIN: {			categoryString = String_XML_TopRank_Category_PGAIN;			break;}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_PLOSS: {			categoryString = String_XML_TopRank_Category_PLOSS;			break;}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_VOLUME: {		categoryString = String_XML_TopRank_Category_VOLUME;		break;}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_TURNOVER: {		categoryString = String_XML_TopRank_Category_TURNOVER;		break;}	
		case SUBMENU_ITEM_TOPRANK_CATEGORY_52HIGH: {		categoryString = String_XML_TopRank_Category_52HIGH;		break;}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_52LOW: {			categoryString = String_XML_TopRank_Category_52LOW;			break;}
	}
	
	if (sectorString) {
		if (m_sSectorString) {
			[m_sSectorString release];
			m_sSectorString = nil;
		}
		m_sSectorString = [sectorString retain];
	}
	
	if (categoryString) {
		if (m_sCategoryString) {
			[m_sCategoryString release];
			m_sCategoryString = nil;
		}
		m_sCategoryString = [categoryString retain];
	}
	
	[self reloadTopRank];
}

- (void)reloadTopRank {
	
	NSString *urlString = [[MHFeedConnectorX sharedMHFeedConnectorX] urlTopRank:PT_WEBVIEW_STYLE
																	   language:[MHLanguage getCurrentLanguage] 
																	refreshRate:nil 
																		 sector:m_sSectorString 
																	   category:m_sCategoryString 
																		 action:@"-1" 
																	   realtime:@"0"
                                                                        version:URL_VERSION_1_0
                                                                              v:nil];
	
    urlString = [NSString stringWithFormat:@"%@&showAll=1",urlString];
	[m_oPTTopRankView loadURLString:urlString];
	
}

@end