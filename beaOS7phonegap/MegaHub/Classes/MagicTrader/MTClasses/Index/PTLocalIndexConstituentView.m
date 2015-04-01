//
//  PTLocalIndexConstituentView.m
//  MagicTrader
//
//  Created by Hong on 15/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PTLocalIndexConstituentView.h"
#import "LoadingView.h"
#import "PTConstant.h"
#import "MHLanguage.h"

@implementation PTLocalIndexConstituentView

@synthesize m_oWebView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		// WebView
		m_oWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
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
    [m_oWebView stopLoading];
    m_oWebView.delegate = nil;
    [m_oWebView release];
	[m_oLoadingView release];
    [super dealloc];
}

- (void)reloadText {
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
