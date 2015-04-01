//
//  MHStockView.m
//  MegaHub
//
//  Created by MegaHub on 17/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MHStockView.h"
#import "MHUILabel.h"
#import "MHUtility.h"
#import "PTConstant.h"

#import "MHFeedXMsgInGetLiteQuote.h"
#import "MHFeedXObjStockQuote.h"
#import "MHFeedXObjQuote.h"

#import "StyleConstant.h"

@implementation MHStockView
@synthesize m_oNorminalPriceLabel, m_oChangeLabel, m_oBidPriceLabel, m_oAskPriceLabel;
@synthesize m_fChangePercentage, m_fChange;
@synthesize m_fBid, m_fAsk, m_fPreviousClose, m_fNorminalPrice;
@synthesize m_oCopyBidPriceButton, m_oCopyAskPriceButton;
@synthesize m_oBackgroundImageView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        m_oBackgroundImageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:m_oBackgroundImageView];
        [m_oBackgroundImageView release];
		
		m_oNorminalPriceLabel = [[[MHUILabel alloc] initWithFrame:CGRectMake(0, 4, 119, 30)] autorelease];
        m_oNorminalPriceLabel.textAlignment = NSTextAlignmentCenter;
        [m_oNorminalPriceLabel setFont:MHStockView_m_oNorminalPriceLabel];
		[self addSubview:m_oNorminalPriceLabel];
		
		m_oChangeLabel = [[[MHUILabel alloc] initWithFrame:CGRectMake(119, 4, 74, 15)] autorelease];
        m_oChangeLabel.adjustsFontSizeToFitWidth = YES;
        m_oChangeLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:m_oChangeLabel];
		
		m_oChangePctLabel = [[[MHUILabel alloc] initWithFrame:CGRectMake(119, 19, 74, 15)] autorelease];
        m_oChangePctLabel.adjustsFontSizeToFitWidth = YES;
		m_oChangePctLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:m_oChangePctLabel];
		
		m_oCopyBidPriceButton = [[[UIButton alloc] initWithFrame:CGRectMake(193, 0, 64, frame.size.height)] autorelease];
		[m_oCopyBidPriceButton setImage:MHStockView_m_oCopyBidPriceButton_image forState:UIControlStateNormal];
		[self addSubview:m_oCopyBidPriceButton];
		
		m_oCopyAskPriceButton = [[[UIButton alloc] initWithFrame:CGRectMake(257, 0, 64, frame.size.height)] autorelease];
		[m_oCopyAskPriceButton setImage:MHStockView_m_oCopyAskPriceButton_image forState:UIControlStateNormal];
		[self addSubview:m_oCopyAskPriceButton];

		m_oBidPriceLabel = [[[MHUILabel alloc] initWithFrame:CGRectMake(195, 20, 60, 17)] autorelease];
		m_oAskPriceLabel = [[[MHUILabel alloc] initWithFrame:CGRectMake(195+60, 20, 60, 17)] autorelease];
		[m_oBidPriceLabel setTextAlignment:NSTextAlignmentRight];
		[m_oAskPriceLabel setTextAlignment:NSTextAlignmentRight];
        [m_oBidPriceLabel setAdjustsFontSizeToFitWidth:YES];
        [m_oAskPriceLabel setAdjustsFontSizeToFitWidth:YES];
		[self addSubview:m_oBidPriceLabel];
		[self addSubview:m_oAskPriceLabel];
		
		m_oBidTitleLabel = [[[MHUILabel alloc] initWithFrame:CGRectMake(193+4, 0, 40, 21)] autorelease];
		[self addSubview:m_oBidTitleLabel];
		[m_oBidTitleLabel setTextAlignment:NSTextAlignmentLeft];
		m_oAskTitleLabel = [[[MHUILabel alloc] initWithFrame:CGRectMake(257+4, 0, 40, 21)] autorelease];
		[self addSubview:m_oAskTitleLabel];
		[m_oAskTitleLabel setTextAlignment:NSTextAlignmentLeft];
		
		[self reloadText];
		
		
		m_oBidPriceLabel.font =			MHStockView_m_oBidPriceLabel_font;
		m_oAskPriceLabel.font =			MHStockView_m_oAskPriceLabel_font;
		
		m_oBidTitleLabel.font =			MHStockView_m_oBidTitleLabel_font;
		m_oAskTitleLabel.font =			MHStockView_m_oAskTitleLabel_font;
		
		m_oChangeLabel.font	  =			MHStockView_m_oChangeLabel_font;
		m_oChangePctLabel.font =		MHStockView_m_oChangePctLabel_font;
		
		m_oNorminalPriceLabel.font =	MHStockView_m_oNorminalPriceLabel_font;
    }
    return self;
}

-(void)updateDisplay{
    
	[m_oAskPriceLabel setTextWithAnimationUseTextColor:[MHUtility floatPriceToString:m_fAsk market:MARKET_HONGKONG]
											   duration:Default_label_animation_second 
									  animateIfNoChange:NO];
	
	[m_oBidPriceLabel setTextWithAnimationUseTextColor:[MHUtility floatPriceToString:m_fBid market:MARKET_HONGKONG]
											  duration:Default_label_animation_second 
									 animateIfNoChange:NO];
	
	[m_oNorminalPriceLabel setTextWithAnimationUseTextColor:[MHUtility floatPriceToString:m_fNorminalPrice 
																			  market:MARKET_HONGKONG] 
											  duration:Default_label_animation_second 
									 animateIfNoChange:NO];

	NSString *sChange						= [MHUtility floatPriceChangeToString:m_fChange 
														  market:MARKET_HONGKONG];
	
	NSString *sChangePercentage				= [MHUtility floatPricePencentageChangeToString:m_fChangePercentage
																			market:MARKET_HONGKONG];
	

	
	if(m_fChange > 0){
		m_oChangeLabel.textColor			= Default_label_text_color_up;
	}else if (m_fChange < 0){
		m_oChangeLabel.textColor			= Default_label_text_color_down;
	}else {
		m_oChangeLabel.textColor			= Default_label_text_color_leveloff;
	}
	
	m_oChangePctLabel.textColor				= m_oChangeLabel.textColor;
	
	[m_oChangeLabel setTextWithAnimationUseTextColor:sChange
											  duration:Default_label_animation_second 
									 animateIfNoChange:NO];
	
	[m_oChangePctLabel setTextWithAnimationUseTextColor:sChangePercentage
											   duration:Default_label_animation_second
									  animateIfNoChange:NO];
}

-(void)cleanData{
	m_fBid			= 0;
	m_fAsk			= 0;
	m_fPreviousClose			= 0;
	m_fChangePercentage			= 0;
	m_fChange					= 0;
	
	m_oAskPriceLabel.text = @"";
	m_oBidPriceLabel.text = @"";
	m_oNorminalPriceLabel.text = @"";
	m_oChangeLabel.text = @"";
	m_oChangePctLabel.text = @"";
}

-(void)reloadText{
	[m_oBidTitleLabel setText:MHLocalizedString(@"MHStockView_m_oBidTitleLabel", nil)];
	[m_oAskTitleLabel setText:MHLocalizedString(@"MHStockView_m_oAskTitleLabel", nil)];

}

- (void)dealloc {
    [super dealloc];
}

@end
