//
//  PTTopRankView.m
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "PTTopRankView.h"
#import "MHIndexBarView.h"
#import "LoadingView.h"
#import "PTConstant.h"
#import "MHLanguage.h"
#import "MHSubmenu.h"

@implementation PTTopRankView

@synthesize m_oSectorSubmenu;
@synthesize m_oCategorySubMenu;
@synthesize m_oWebView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		int row0 = 0,					h_row0 = 27;
		int row1 = row0+h_row0,			h_row1 = 27;	
		int row2 = row1+h_row1,			h_row2 = frame.size.height - row2;	

		
		// Sector
		m_oSectorSubmenu = [[MHSubmenu alloc] initWithFrame:CGRectMake(0, row0, frame.size.width, h_row0)];
		[self addSubview:m_oSectorSubmenu];
		[m_oSectorSubmenu loadModule:MODULE_TOPRANK_SECTOR];

		
		// Category
		m_oCategorySubMenu = [[MHSubmenu alloc] initWithFrame:CGRectMake(0, row1, frame.size.width, h_row1)];
		[self addSubview:m_oCategorySubMenu];
		[m_oCategorySubMenu loadModule:MODULE_TOPRANK_CATEGORY];

		
		// WebView
		m_oWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, row2, frame.size.width, h_row2)];
		[m_oWebView setDataDetectorTypes:UIDataDetectorTypeNone];
		[self addSubview:m_oWebView];

		
		//-------------------------------------------------------------------------
		// LoadingMask
		m_oLoadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
		m_oLoadingView.center = m_oWebView.center;
		[self addSubview:m_oLoadingView];

		
    }
    return self;
}

- (void)dealloc {
    [m_oSectorSubmenu release];
    [m_oCategorySubMenu release];
    [m_oWebView stopLoading];
    [m_oWebView setDelegate:nil];
    [m_oWebView release];
    [m_oLoadingView release];
    [super dealloc];
}

- (void)reloadText {
	[m_oSectorSubmenu reloadText];
	[m_oCategorySubMenu reloadText];
	[m_oLoadingView reloadText];
}

#pragma mark -
#pragma mark Loading Functions
- (void)startLoading {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[m_oLoadingView startLoading];
}

- (void)stopLoading {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[m_oLoadingView stopLoading];
}

#pragma mark -
#pragma mark Custom Functions
//-----------------------------------------------------------------------------
- (void)loadURLString:(NSString *)aURLString {
	NSString *link = [aURLString stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	[m_oWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:link]]];
}

- (NSString *)sendJavaScriptString:(NSString *)aJavaScriptString {
	return [m_oWebView stringByEvaluatingJavaScriptFromString:aJavaScriptString];	
}

@end
