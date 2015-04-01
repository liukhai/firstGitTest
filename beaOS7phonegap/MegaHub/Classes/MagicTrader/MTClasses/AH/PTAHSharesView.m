//
//  PTAHSharesView.m
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PTAHSharesView.h"
#import "StyleConstant.h"
#import "LoadingView.h"
#import "MHLanguage.h"


@implementation PTAHSharesView

@synthesize m_oWebView;

- (id)initWithFrame:(CGRect)frame permission:(BOOL)aPermission {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		int row0 = 0,					h_row0 = frame.size.height;
		
		
		if (aPermission) {
			// WebView
			m_oWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, row0, 320, h_row0)];
			[m_oWebView setDataDetectorTypes:UIDataDetectorTypeNone];
			[self addSubview:m_oWebView];
			
			
			//-------------------------------------------------------------------------
			// LoadingView
			m_oLoadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
			[m_oLoadingView setCenter:m_oWebView.center];
			[self addSubview:m_oLoadingView];
			

		} else {	
			// if no permission
			m_oNoPermissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, h_row0)];
			[m_oNoPermissionLabel setText:MHLocalizedString(@"PTPStreamer.no_permission_text", nil)];			
			[m_oNoPermissionLabel setBackgroundColor:Default_view_background_color];
			[m_oNoPermissionLabel setTextAlignment:NSTextAlignmentCenter];
			[m_oNoPermissionLabel setTextColor:NoPermissionLabel_text_color];
			[m_oNoPermissionLabel setFont:[UIFont systemFontOfSize:21]];
			[m_oNoPermissionLabel setNumberOfLines:10];
			[self addSubview:m_oNoPermissionLabel];
		}
    }
    return self;
}


- (void)dealloc {
    [m_oWebView stopLoading];
    [m_oWebView setDelegate:nil];
    [m_oWebView release];
    [m_oLoadingView release];
    [m_oNoPermissionLabel release];
    [super dealloc];
}

- (void)reloadText {
	[m_oNoPermissionLabel setText:MHLocalizedString(@"PTPStreamer.no_permission_text", nil)];
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