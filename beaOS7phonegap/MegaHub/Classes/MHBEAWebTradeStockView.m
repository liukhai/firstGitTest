//
//  MHBEAWebTradeStockView.m
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAWebTradeStockView.h"
#import "MHDisclaimerBarView.h"
#import "MHBEAStyleConstant.h"
#import "MHBEAConstant.h"
#import "LoadingView.h"
#import "MHUtility.h"
#import "PTConstant.h"
#import "MBKUtil.h"
#import "MHBEAIndexQuoteView.h"
#import "MHBEABottomView.h"
#import "MHDisclaimerBarView.h"

@implementation MHBEAWebTradeStockView

@synthesize m_oMHBEAIndexQuoteView;
@synthesize m_oMHBEABottomView;
@synthesize m_oLoadingView;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController *)aController{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        controller = aController;
        
        self.backgroundColor = [UIColor whiteColor];
        
        // Index bar
		m_oMHBEAIndexQuoteView = [[MHBEAIndexQuoteView alloc] initWithFrame:CGRectMake(0, 63, 320, 63) controller:aController];
//        [m_oMHBEAIndexQuoteView.m_oAddButton addTarget:controller action:@selector(onAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oMHBEAIndexQuoteView];
		[m_oMHBEAIndexQuoteView release];
        
		// Loading View
		m_oLoadingView = [[LoadingView alloc] initWithFrame:CGRectMake((frame.size.width-100)/2, (frame.size.height-100)/2, 100, 100)];
		[m_oLoadingView.m_oSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[m_oLoadingView setHaveBackground:YES];
		[m_oLoadingView stopLoading];
		[self addSubview:m_oLoadingView];
		[m_oLoadingView release];
        
        m_oMHBEABottomView = [[MHBEABottomView alloc] initWithFrame:CGRectMake(0, frame.size.height-15-31, 320, 31)];
        [self addSubview:m_oMHBEABottomView];
        [m_oMHBEABottomView release];
        
        // Discclaimer
		m_oMHDisclaimerBarView = [[MHDisclaimerBarView alloc] initWithFrame:CGRectMake(0, frame.size.height-15, 320, 15)];
		[self addSubview:m_oMHDisclaimerBarView];
		[m_oMHDisclaimerBarView release];
    }
    return self;
}

- (void)reloadText {    
    [m_oMHBEAIndexQuoteView reloadText];
    [m_oMHBEABottomView reloadText];
	[m_oLoadingView reloadText];
}

- (void)dealloc {
    [super dealloc];
}

- (void)clean {
	[m_oMHBEAIndexQuoteView cleanStock];
}


#pragma mark -
#pragma mark UpdateFunctions
- (void)updateLastUpdateTime:(NSString *)updateTime{
    m_oMHDisclaimerBarView.m_oTextLabel.text = [NSString stringWithFormat:@"%@%@",
                                                MHLocalizedStringFile(@"MHBEAFAQuoteView.m_oLastUpdateTimeLabel", nil, MHLanguage_BEAString),
                                                updateTime?updateTime:@""];
}


#pragma mark -
#pragma mark Loading Functions
- (void)startLoading {
	[self setUserInteractionEnabled:NO];
	[m_oLoadingView startLoading];
}

- (void)stopLoading {
	[self setUserInteractionEnabled:YES];
	[m_oLoadingView stopLoading];
}

@end