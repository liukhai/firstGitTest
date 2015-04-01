//
//  PTSectorRootView.m
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PTSectorRootView.h"
#import "StyleConstant.h"
#import "LoadingView.h"
#import "PTConstant.h"
#import "MHLanguage.h"

@implementation PTSectorRootView

@synthesize m_oTableView;
@synthesize m_oWebView;
@synthesize m_oLoadingView;

- (id)initWithFrame:(CGRect)frame permission:(BOOL)aPermission {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		if (aPermission) {
			m_oTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
			[m_oTableView setBackgroundColor:[UIColor clearColor]];
			[m_oTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
			[m_oTableView setSeparatorColor:[UIColor blackColor]];
			[self addSubview:m_oTableView];
			
			// WebView
			m_oWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
			[m_oWebView setDataDetectorTypes:UIDataDetectorTypeNone];
			[self addSubview:m_oWebView];
			
			//-------------------------------------------------------------------------
			// LoadingMask
			m_oLoadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
			[m_oLoadingView setCenter:m_oWebView.center];
			[self addSubview:m_oLoadingView];
			[m_oLoadingView stopLoading];
            
		} else {		
		
			m_oNoPermissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
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
    [m_oTableView release];
    [m_oWebView stopLoading];
    m_oWebView.delegate = nil;
    [m_oWebView release];
    [m_oLoadingView release];
    [m_oNoPermissionLabel release];
    [super dealloc];
}

- (void)reloadText {
	[m_oNoPermissionLabel setText:MHLocalizedString(@"PTPStreamer.no_permission_text", nil)];	
	[m_oLoadingView reloadText];
	[m_oTableView reloadData];
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

- (void)switchWebViewWithURLString:(NSString *)aURLString {
	[self loadURLString:aURLString];
	m_oTableView.hidden = NO;
	m_oWebView.hidden = NO;
	
	float animationTime = 0.4;
	// new
	[m_oWebView setFrame:CGRectMake(320, 
									  m_oWebView.frame.origin.y,
									  m_oWebView.frame.size.width,
									  m_oWebView.frame.size.height)];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:animationTime];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	// webview 0<-320
	[m_oWebView setFrame:CGRectMake(0, 
									m_oWebView.frame.origin.y,
									m_oWebView.frame.size.width, 
									m_oWebView.frame.size.height)];	
	// tableview -320<-0
	[m_oTableView setFrame:CGRectMake(-320, 
									m_oTableView.frame.origin.y,
									m_oTableView.frame.size.width, 
									m_oTableView.frame.size.height)];	
	
	
	[UIView commitAnimations];
	
}

- (void)switchTableView {
	//TODO: Add animation
	m_oTableView.hidden = NO;
	m_oWebView.hidden = NO;
	
	float animationTime = 0.4;
	// new
	[m_oTableView setFrame:CGRectMake(-320, 
									  m_oTableView.frame.origin.y,
									  m_oTableView.frame.size.width,
									  m_oTableView.frame.size.height)];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:animationTime];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	// webview 0->320
	[m_oWebView setFrame:CGRectMake(320, 
									 m_oWebView.frame.origin.y,
									 m_oWebView.frame.size.width, 
									 m_oWebView.frame.size.height)];
	// table -320->0
	[m_oTableView setFrame:CGRectMake(0, 
									  m_oTableView.frame.origin.y,
									  m_oTableView.frame.size.width,
									  m_oTableView.frame.size.height)];
	
	[UIView commitAnimations];
	
}

@end