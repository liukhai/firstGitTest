//
//  LoadingView.m
//  MagicTrader
//
//  Created by Hong on 18/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoadingView.h"
#import "MHLanguage.h"

#define LOADINGVIEW_LOADING_TIMEOUT			20

@implementation LoadingView

@synthesize m_oLoadingMask;
@synthesize m_oLoadingLabel;
@synthesize m_oSpinner;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {		
		
		// LoadingMask
		m_oLoadingMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[m_oLoadingMask setBackgroundColor:[UIColor blackColor]];
		[m_oLoadingMask setHidden:YES];
		[m_oLoadingMask setAlpha:0.8];
		[m_oLoadingMask.layer setCornerRadius:8];
		[self addSubview:m_oLoadingMask];

		
		//-------------------------------------------------------------------------
		// Loading Label
		m_oLoadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, m_oLoadingMask.center.y+15, frame.size.width, 26)];
		[m_oLoadingLabel setBackgroundColor:[UIColor clearColor]];
		[m_oLoadingLabel setHidden:YES];
		[m_oLoadingLabel setTextColor:[UIColor whiteColor]];
		[m_oLoadingLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:m_oLoadingLabel];
		[m_oLoadingLabel release];
		
		//-------------------------------------------------------------------------
		// Spinner
		m_oSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[m_oSpinner setCenter:m_oLoadingMask.center];
		[m_oSpinner setHidesWhenStopped:YES];
		[self addSubview:m_oSpinner];
	
		
		[self stopLoading];
		[self reloadText];
		
		[self setHaveBackground:NO];
		[self setHaveLoadingText:YES];


    }
    return self;
}

- (void)dealloc {
	[m_oLoadingMask release];
	[m_oSpinner release];
	
	@synchronized(m_oLoadingTimer) {
		if (m_oLoadingTimer) {
			[m_oLoadingTimer invalidate];
			[m_oLoadingTimer release];
			m_oLoadingTimer = nil;
		}
	}
	
    [super dealloc];
}


- (void)reloadText {
	[m_oLoadingLabel setText:MHLocalizedString(@"LoadingView.m_oLoadingLabel", nil)];
}

- (void)setHaveBackground:(BOOL)aBool {
	m_isHaveBg = aBool;
	m_oLoadingMask.hidden = !m_isHaveBg;
}

- (void)setHaveLoadingText:(BOOL)aBool {
	m_isHaveLoadingText = aBool;
	m_oLoadingLabel.hidden = !m_isHaveLoadingText;
}

#pragma mark -
#pragma mark Loading Functions
- (void)startLoading {
	
	[m_oSpinner startAnimating];
	[self setHidden:NO];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	@synchronized(m_oLoadingTimer) {
		if (m_oLoadingTimer) {
			[m_oLoadingTimer invalidate];
			[m_oLoadingTimer release];
			m_oLoadingTimer = nil;
		}
		m_oLoadingTimer = [NSTimer scheduledTimerWithTimeInterval:LOADINGVIEW_LOADING_TIMEOUT target:self selector:@selector(stopLoading) userInfo:nil repeats:NO];
		[m_oLoadingTimer retain];
	}
}

- (void)stopLoading {
	@synchronized(m_oLoadingTimer) {
		if (m_oLoadingTimer) {
			[m_oLoadingTimer invalidate];
			[m_oLoadingTimer release];
			m_oLoadingTimer = nil;
		}
	}
	
	[m_oSpinner stopAnimating];	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self setHidden:YES];
}


@end
