//
//  MHBEAFAQuoteView.m
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAFAQuoteView.h"

#import "MHBEAStyleConstant.h"
#import "MHFeedConnectorX.h"
#import "MHFeedXObjQuote.h"
#import "MHStaticDataView.h"
#import "StyleConstant.h"
#import "LoadingView.h"
#import "MHLanguage.h"
#import "MHUtility.h"
#import "MHBEAIndexQuoteView.h"
#import "MHRelatedStockDataView.h"

@implementation MHBEAFAQuoteView

@synthesize m_oMHBEAIndexQuoteView;
@synthesize m_oScrollView;
@synthesize m_oDespLabel;
@synthesize m_oMHStaticDataView;
@synthesize m_oMHBEABasicDataView;
@synthesize m_oBidView;
@synthesize m_oAskView;
@synthesize m_oBidTitleLabel;
@synthesize m_oAskTitleLabel;
@synthesize m_oBidValueLabel;
@synthesize m_oAskValueLabel;
@synthesize m_oCopyBidButton;
@synthesize m_oCopyAskButton;
@synthesize m_oChartImageView;
@synthesize m_oTurnDeviceLandscapeImageView;
@synthesize m_oCharLoadingView;
@synthesize m_oMHBEAQuoteGainLossView;
@synthesize m_oMHBEABottomView;
@synthesize m_oBottomLeftButton;
@synthesize m_oBottomRightButton;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController*)aController{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
		
        // Index bar
		m_oMHBEAIndexQuoteView = [[MHBEAIndexQuoteView alloc] initWithFrame:CGRectMake(0, 63, 320, 63) controller:aController];
		[self addSubview:m_oMHBEAIndexQuoteView];
        [m_oMHBEAIndexQuoteView.m_oQuoteButton addTarget:self action:@selector(onQuoteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[m_oMHBEAIndexQuoteView release];
        
        // Scroll
		m_oScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 126, frame.size.width, [MHUtility convertHeightBasedOnCurrentDevice:301])];
		[m_oScrollView setContentSize:CGSizeMake(2*frame.size.width, 301)];
		[m_oScrollView setPagingEnabled:YES];
		[m_oScrollView setShowsVerticalScrollIndicator:NO];
		[m_oScrollView setShowsHorizontalScrollIndicator:NO];
		[m_oScrollView setAlwaysBounceVertical:NO];
		[self addSubview:m_oScrollView];
		[m_oScrollView release];
		
		// Page1
		//---------------------------------------------------------------------
		m_oDespLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
		[m_oDespLabel setBackgroundColor:[UIColor clearColor]];
		[m_oDespLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oDespLabel setFont:[UIFont boldSystemFontOfSize:13]];
		[m_oDespLabel setNumberOfLines:2];
		[m_oScrollView addSubview:m_oDespLabel];
		[m_oDespLabel release];
		
		// Static data
		m_oMHStaticDataView = [[MHStaticDataView alloc] initWithFrame:CGRectMake(0, 30, 100, 244)];
		[m_oMHStaticDataView setSRMode:YES];
        m_oMHStaticDataView.m_isShowQuoteMeter = NO;
		[m_oScrollView addSubview:m_oMHStaticDataView];
		[m_oMHStaticDataView release];
		
		//Row 1
		//Bid
		m_oBidView		= [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 110, 36)];
		m_oBidView.image = MHBidAskView_m_oBidView_background_image;
		[m_oScrollView addSubview:m_oBidView];
		[m_oBidView release];
		
		m_oBidTitleLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 2, 110, 18)];
		[m_oBidTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oBidTitleLabel setTextColor:MHBidAskView_m_oBidTitleLabel_textColor];
		[m_oBidTitleLabel setFont:MHBidAskView_m_oBidTitleLabel_font];
		[m_oBidView addSubview:m_oBidTitleLabel];
		[m_oBidTitleLabel release];
		
		m_oBidValueLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 14, 110, 22)];
		m_oBidValueLabel.textAlignment = NSTextAlignmentRight;
		[m_oBidValueLabel setTextColor:MHBidAskView_m_oBidValueLabel_textColor];
		[m_oBidValueLabel setFont:MHBidAskView_m_oBidValueLabel_font];
		[m_oBidView addSubview:m_oBidValueLabel];
		[m_oBidValueLabel release];
		
		
		//Ask
		m_oAskView		= [[UIImageView alloc] initWithFrame:CGRectMake(210, 0, 110, 36)];
		m_oAskView.image = MHBidAskView_m_oAskView_background_image;
		[m_oScrollView addSubview:m_oAskView];
		[m_oAskView release];
		
		m_oAskTitleLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 2, 110, 18)];
		[m_oAskTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oAskTitleLabel setTextColor:MHBidAskView_m_oAskTitleLabel_textColor];
		[m_oAskTitleLabel setFont:MHBidAskView_m_oAskTitleLabel_font];
		[m_oAskView addSubview:m_oAskTitleLabel];
		[m_oAskTitleLabel release];
		
		m_oAskValueLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 14, 110, 22)];
		m_oAskValueLabel.textAlignment = NSTextAlignmentRight;
		[m_oAskValueLabel setTextColor:MHBidAskView_m_oAskValueLabel_textColor];
		[m_oAskValueLabel setFont:MHBidAskView_m_oAskValueLabel_font];
		[m_oAskView addSubview:m_oAskValueLabel];
		[m_oAskValueLabel release];
		
        
		// Chart
		//---------------------------------------------------------------------
		m_oChartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 56, 220, 180)];
		[m_oChartImageView setBackgroundColor:[UIColor whiteColor]];
		[m_oScrollView addSubview:m_oChartImageView];
		[m_oChartImageView release];
		
		// turn landscap indicator
		UIImage *img = MHBEAFAQuoteView_iphone_image;
		m_oTurnDeviceLandscapeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(m_oChartImageView.frame.origin.x+img.size.height/2+50,
																						m_oChartImageView.frame.origin.y+img.size.height/2+25,
																						img.size.width,
																						img.size.height)];
        
		m_oTurnDeviceLandscapeImageView.image = img;
		[m_oScrollView addSubview:m_oTurnDeviceLandscapeImageView];
		[m_oTurnDeviceLandscapeImageView release];
		m_oTurnDeviceLandscapeImageView.hidden = YES;
		
		// Loading Chart View
		m_oChartLoadingView = [[LoadingView alloc] initWithFrame:CGRectMake((m_oScrollView.frame.size.width-50)/2, (m_oScrollView.frame.size.height-50)/2, 50, 50)];
		[m_oChartLoadingView setCenter:m_oChartLoadingView.center];
        [m_oChartLoadingView setHaveBackground:YES];
        [m_oChartLoadingView setHaveLoadingText:NO];
		[m_oScrollView addSubview:m_oChartLoadingView];
		[m_oChartLoadingView release];
		
		// Suspend
		m_oSuspendImage = [[UIImageView alloc] initWithFrame:CGRectMake(280, 40, 30, 30)];
		m_oSuspendImage.image = MHStockQuoteBarView_m_oSuspendImage_image;
		[m_oScrollView addSubview:m_oSuspendImage];
		[m_oSuspendImage release];
		m_oSuspendImage.hidden = YES;
		
		// GainLoss View
		m_oMHBEAQuoteGainLossView = [[MHBEAQuoteGainLossView alloc] initWithFrame:CGRectMake(100, 240, 220, 34)];
		m_oMHBEAQuoteGainLossView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
		[m_oScrollView addSubview:m_oMHBEAQuoteGainLossView];
		[m_oMHBEAQuoteGainLossView release];
		
		// Page2
        // Stock Data View
		m_oMHBEABasicDataView = [[MHBEABasicDataView alloc] initWithFrame:CGRectMake(320, 0, 320, m_oScrollView.frame.size.height)];
		[m_oScrollView addSubview:m_oMHBEABasicDataView];
		[m_oMHBEABasicDataView release];
        
        UIView *bottomBarView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-15-31-15, 320, 15)];
        bottomBarView.backgroundColor = MHBEAFAQuoteView_bottom_bar_background_color;
        [self addSubview:bottomBarView];
        [bottomBarView release];
        
        m_oBottomLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        m_oBottomLeftButton.frame = CGRectMake(5, frame.size.height-15-31-15, 120, 15);
        m_oBottomLeftButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [m_oBottomLeftButton setTitleColor:MHBEABasicDataView_m_oBottomLeftButton_text_color forState:UIControlStateNormal];
        [m_oBottomLeftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [m_oBottomLeftButton addTarget:self action:@selector(onBottomLeftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        m_oBottomLeftButton.backgroundColor = [UIColor clearColor];
        m_oBottomLeftButton.hidden = YES;
        [self addSubview:m_oBottomLeftButton];
        
        m_oBottomRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        m_oBottomRightButton.frame = CGRectMake(320-120-5, frame.size.height-15-31-15, 120, 15);
        m_oBottomRightButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [m_oBottomRightButton setTitleColor:MHBEABasicDataView_m_oBottomRightButton_text_color forState:UIControlStateNormal];
        [m_oBottomRightButton.titleLabel setTextAlignment:NSTextAlignmentRight];
        [m_oBottomRightButton addTarget:self action:@selector(onBottomRightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        m_oBottomRightButton.backgroundColor = [UIColor clearColor];
        m_oBottomRightButton.hidden = NO;
        [self addSubview:m_oBottomRightButton];
        
        m_oMHBEABottomView = [[MHBEABottomView alloc] initWithFrame:CGRectMake(0, frame.size.height-15-31, 320, 31)];
        [m_oMHBEABottomView setSelectedIndex:1];
        [self addSubview:m_oMHBEABottomView];
        [m_oMHBEABottomView release];
        
        // Discclaimer
		m_oMHDisclaimerBarView = [[MHDisclaimerBarView alloc] initWithFrame:CGRectMake(0, frame.size.height-15, 320, 15)];
		[self addSubview:m_oMHDisclaimerBarView];
		[m_oMHDisclaimerBarView release];
        
        [self reloadText];
    
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)clean {
	[m_oMHBEAIndexQuoteView cleanStock];
	[m_oMHStaticDataView clean];
	[m_oMHBEAQuoteGainLossView clean];
	m_oDespLabel.text = @"";
	m_oBidValueLabel.text = @"";
	m_oAskValueLabel.text = @"";
	m_oChartImageView.image = nil;
}

- (void)reloadText {
    [m_oMHBEABasicDataView reloadText];
	[m_oMHBEAIndexQuoteView reloadText];
	[m_oMHStaticDataView reloadText];
    
    [m_oBottomLeftButton setTitle:MHLocalizedStringFile(@"MHBEABasicDataView.m_oBottomLeftButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
    [m_oBottomRightButton setTitle:MHLocalizedStringFile(@"MHBEABasicDataView.m_oBottomRightButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];

	m_oBidTitleLabel.text = MHLocalizedStringFile(@"MHBEAFAQuoteView.m_oBidTitleLabel", nil, MHLanguage_BEAString);
	m_oAskTitleLabel.text = MHLocalizedStringFile(@"MHBEAFAQuoteView.m_oAskTitleLabel", nil, MHLanguage_BEAString);
	[m_oMHBEAQuoteGainLossView reloadText];
	
	m_oMHDisclaimerBarView.m_oTextLabel.text = [NSString stringWithFormat:@"%@%@", 
								   MHLocalizedStringFile(@"MHBEAFAQuoteView.m_oLastUpdateTimeLabel", nil, MHLanguage_BEAString),
								   m_sLastUpdateTime?m_sLastUpdateTime:@""];
	
	[m_oMHBEABottomView reloadText];
}

- (void)switchToPage:(int)page {
	[m_oScrollView setContentOffset:CGPointMake(page * 320, 0)];
    if(page == 0){
        m_oBottomLeftButton.hidden = YES;
        m_oBottomRightButton.hidden = NO;
    }else{
        m_oBottomLeftButton.hidden = NO;
        m_oBottomRightButton.hidden = YES;
    }
}

#pragma mark -
- (void)onBottomLeftButtonPressed:(id)sender {
    [m_oScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)onBottomRightButtonPressed:(id)sender {
    [m_oScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
}

- (void)onQuoteButtonPressed:(id)sender {
    if (m_oMHBEAIndexQuoteView.m_oSymbolTextField.text != nil && [m_oMHBEAIndexQuoteView.m_oSymbolTextField.text length] > 0) {
        [m_oChartLoadingView startLoading];
	}
}

- (void)onChartGetTime:(MHFeedXMsgInGetTime *)aMsg {
    [self performSelectorInBackground:@selector(onChartGetTimeInBackground:) withObject:aMsg];
}

- (void)onChartGetTimeInBackground:(MHFeedXMsgInGetTime *)aMsg {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSString *aTimeString = aMsg.m_sTimeMillis;
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:MHBEAFAQuotePageView_Chart_URL,
                                       aMsg.m_oPara,
                                       @"2",
                                       @"2",
                                       350, //(int)m_oChartImageView.frame.size.width,
                                       350, //(int)m_oChartImageView.frame.size.height,
                                       CHART_CR,
                                       aTimeString,
                                       [MHUtility getOneDayChartEncryptionKey:aTimeString]]];
    
	
	NSData *chartData = [NSData dataWithContentsOfURL:url];
	UIImage *chartImage = [UIImage imageWithData:chartData];
    
	
	[self performSelectorOnMainThread:@selector(performChartUpdateTasks:) withObject:chartImage waitUntilDone:YES];
    [pool release];
}

- (void)displayChartInBackground:(NSString *)sSymbol {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [[MHFeedConnectorX sharedMHFeedConnectorX] getTime:self action:@selector(onChartGetTime:) para:sSymbol];
    [pool release];
}

- (void)performChartUpdateTasks:(UIImage *)chartImage {
	m_oChartImageView.image = chartImage;
    
    [m_oChartLoadingView stopLoading];
    
    if(m_oTurnDeviceLandscapeImageView.hidden){
        m_oTurnDeviceLandscapeImageView.hidden = NO;
        double animationDuration = PTStockQuotePageView_animationDuration;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationDuration];
        m_oTurnDeviceLandscapeImageView.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0);
    [UIView commitAnimations];
    [self performSelector:@selector(turnDeviceLandscapeImageViewDidAnimated) withObject:nil afterDelay:animationDuration];
    }
}

- (void)updateStockInfo:(MHFeedXMsgInGetLiteQuote *)msg {
	[m_oMHStaticDataView updateStockInfo:msg];
    
    MHFeedXObjStockQuote *stockQuote = nil;
	MHFeedXObjQuote *quote = nil;
    
    if(msg.m_oStockQuoteArray == nil || [msg.m_oStockQuoteArray count] <= 0) {
        return;
    }
    
    stockQuote = [msg.m_oStockQuoteArray objectAtIndex:0];
    
    if(stockQuote.m_oQuoteArray == nil || [stockQuote.m_oQuoteArray count] <= 0){
        return;
    }
    
    quote = [stockQuote.m_oQuoteArray objectAtIndex:0];
    
    m_oDespLabel.text = quote.m_sDesp;
    
	m_oSuspendImage.hidden = ([quote.m_sSuspension isEqualToString:@"Y"])?NO:YES;
	m_oBidValueLabel.text = quote.m_sBid;
	m_oAskValueLabel.text = quote.m_sAsk;
	
	[self performSelectorInBackground:@selector(displayChartInBackground:) withObject:quote.m_sSymbol];

	// update last update time
	@synchronized(m_sLastUpdateTime) {
		if (m_sLastUpdateTime) {
			[m_sLastUpdateTime release];
		}
		m_sLastUpdateTime = [quote.m_sLastUpdate retain];
	}
	m_oMHDisclaimerBarView.m_oTextLabel.text = [NSString stringWithFormat:@"%@%@",
												MHLocalizedStringFile(@"MHBEAFAQuoteView.m_oLastUpdateTimeLabel", nil, MHLanguage_BEAString),
												m_sLastUpdateTime?m_sLastUpdateTime:@""];
}

- (void)displaySuspend:(BOOL)display {
    if(display){
        m_oSuspendImage.hidden = NO;
    }else{
        m_oSuspendImage.hidden = YES;
    }
}

-(void)turnDeviceLandscapeImageViewDidAnimated{
	m_oTurnDeviceLandscapeImageView.transform = CGAffineTransformIdentity;
	m_oTurnDeviceLandscapeImageView.hidden = YES;
}

@end