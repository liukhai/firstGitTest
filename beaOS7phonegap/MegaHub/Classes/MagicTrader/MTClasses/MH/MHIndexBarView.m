//
//  MHIndexBar.m
//  PhoneStream
//
//  Created by Megahub on 16/02/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHIndexBarView.h"
#import "MagicTraderAppDelegate.h"
#import "MHFeedConnectorX.h"
#import "StyleConstant.h"
#import "PTConstant.h"
#import "MHLanguage.h"
#import "MHUILabel.h"
#import "MHUtility.h"

// size 320 * 38
@implementation MHIndexBarView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
		m_oBasicQuoteDict = [[NSMutableDictionary alloc] init];
		m_oPrevCloseDict = [[NSMutableDictionary alloc] init];
		
		// background image
		m_oImageView			= [[UIImageView alloc] initWithFrame:frame];
		m_oImageView.image		= MHIndexBarView_view_background_image; 
		[self addSubview:m_oImageView];
		
		// HSI
		m_oHSIDescpLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(1, 1, 29, 21)];
		[m_oHSIDescpLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oHSIDescpLabel setFont:Default_MHIndexBarView_label_font];
		[m_oHSIDescpLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oHSIDescpLabel setTextColor:MHIndexBarView_m_oIndexDescriptionLabel_text_color]; 
		[m_oHSIDescpLabel setTextAlignment:NSTextAlignmentLeft];
		[self addSubview:m_oHSIDescpLabel];
		
		
		m_oHSINominalLabel  = [[MHUILabel alloc] initWithFrame:CGRectMake(30, 1, 67, 21)];
		[m_oHSINominalLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oHSINominalLabel setFont:Default_MHIndexBarView_label_font];
		[m_oHSINominalLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oHSINominalLabel setTextAlignment:NSTextAlignmentCenter];
		[m_oHSINominalLabel setTextColor:MHIndexBarView_m_oIndexValueLabel_text_color];
		[self addSubview:m_oHSINominalLabel];
		
		
		m_oHSIChangeLabel  = [[MHUILabel alloc] initWithFrame:CGRectMake(99, 1, 120, 21)];
		[m_oHSIChangeLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oHSIChangeLabel setFont:Default_MHIndexBarView_label_font];
		[m_oHSIChangeLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oHSIChangeLabel setTextColor:MHIndexBarView_m_oIndexChangeLabel_text_color];
		[m_oHSIChangeLabel setTextAlignment:NSTextAlignmentLeft];
		[self addSubview:m_oHSIChangeLabel];
		

		m_oHSITurnoverLabel	= [[MHUILabel alloc] initWithFrame:CGRectMake(227, 1, 92, 21)];
		[m_oHSITurnoverLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oHSITurnoverLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oHSITurnoverLabel setFont:Default_MHIndexBarView_label_font];
		[m_oHSITurnoverLabel setTextAlignment:NSTextAlignmentRight];
		[self addSubview:m_oHSITurnoverLabel];
		
		
		// China enterprice
		m_oChinaEnterpriseDescriptionLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(152, 19, 42, 18)];
		[m_oChinaEnterpriseDescriptionLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oChinaEnterpriseDescriptionLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oChinaEnterpriseDescriptionLabel setFont:Default_MHIndexBarView_label_font];
		[m_oChinaEnterpriseDescriptionLabel setTextAlignment:NSTextAlignmentRight];
		[self addSubview:m_oChinaEnterpriseDescriptionLabel];
		
		
		m_oChinaEnterpriseValueLabel	= [[MHUILabel alloc] initWithFrame:CGRectMake(194, 19, 63, 18)];
		[m_oChinaEnterpriseValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oChinaEnterpriseValueLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oChinaEnterpriseValueLabel setFont:Default_MHIndexBarView_label_font];
		[m_oChinaEnterpriseValueLabel setTextAlignment:NSTextAlignmentRight];
		[self addSubview:m_oChinaEnterpriseValueLabel];
		
		
		m_oChinaEnterpriseChangeLabel   = [[MHUILabel alloc] initWithFrame:CGRectMake(257, 19, 63, 18)];
		[m_oChinaEnterpriseChangeLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oChinaEnterpriseChangeLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oChinaEnterpriseChangeLabel setFont:Default_MHIndexBarView_label_font];
		[m_oChinaEnterpriseChangeLabel setTextAlignment:NSTextAlignmentRight];
		[self addSubview:m_oChinaEnterpriseChangeLabel];
		
		//Future
		m_oHSIFutureDescriptionLabel	= [[MHUILabel alloc] initWithFrame:CGRectMake(1, 19, 29, 18)];
		[m_oHSIFutureDescriptionLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oHSIFutureDescriptionLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oHSIFutureDescriptionLabel setFont:Default_MHIndexBarView_label_font];
		[m_oHSIFutureDescriptionLabel setTextAlignment:NSTextAlignmentLeft];
		[self addSubview:m_oHSIFutureDescriptionLabel];
		
		
		m_oHSIFutureValueLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(29, 19, 60, 18)];
		[m_oHSIFutureValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oHSIFutureValueLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oHSIFutureValueLabel setFont:Default_MHIndexBarView_label_font];
		[m_oHSIFutureValueLabel setTextAlignment:NSTextAlignmentRight];
		[self addSubview:m_oHSIFutureValueLabel];
		
		
		m_oHSIFutureChangeLabel	= [[MHUILabel alloc] initWithFrame:CGRectMake(99, 19, 50, 18)];
		[m_oHSIFutureChangeLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oHSIFutureChangeLabel setBackgroundColor:Default_MHIndexBarView_label_background_color];
		[m_oHSIFutureChangeLabel setFont:Default_MHIndexBarView_label_font];
		[m_oHSIFutureChangeLabel setTextAlignment:NSTextAlignmentLeft];
		[self addSubview:m_oHSIFutureChangeLabel];
		
		
		m_oLastUpdateLabel				= [[MHUILabel alloc] initWithFrame:m_oHSITurnoverLabel.frame];
		m_oLastUpdateLabel.hidden = YES;
		[self addSubview:m_oLastUpdateLabel];
		
				
		[self clean];
		[self reloadText];
        
        [[MHFeedConnectorX sharedMHFeedConnectorX] addGetLiteQuoteObserver:self action:@selector(onMHFeedXMsgInGetLiteQuote:)];
    }
	

    return self;
}

- (void)dealloc {
    [[MHFeedConnectorX sharedMHFeedConnectorX] removeGetLiteQuoteObserver:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[m_oImageView release];
	[m_oHSIDescpLabel release];
	[m_oHSINominalLabel release];
	[m_oHSIChangeLabel release];
	[m_oHSITurnoverLabel release];
	[m_oChinaEnterpriseDescriptionLabel release];
	[m_oChinaEnterpriseValueLabel release];
	[m_oChinaEnterpriseChangeLabel release];
	[m_oHSIFutureDescriptionLabel release];
	[m_oHSIFutureValueLabel release];
	[m_oHSIFutureChangeLabel release];
	[m_oLastUpdateLabel release];
	[m_oBasicQuoteDict release];
	[m_oPrevCloseDict release]; 
	[super dealloc];
}

-(void)reloadText{
	//Description
	m_oHSIDescpLabel.text						= MHLocalizedString(@"MHIndexBarView.m_oIndexDescriptionLabel.HSI.text", nil);
	m_oChinaEnterpriseDescriptionLabel.text		= MHLocalizedString(@"MHIndexBarView.m_oIndexDescriptionLabel.ChinaEnterprise.text", nil);
	m_oHSIFutureDescriptionLabel.text			= MHLocalizedString(@"MHIndexBarView.m_oIndexDescriptionLabel.HSIFuture.text", nil);
	m_oLastUpdateLabel.text						= MHLocalizedString(@"MHIndexBarView.m_oLastUpdateLabel.text", nil);
	
}

-(void)clean{
	//HSI  or general
	m_oHSINominalLabel.text		= @"";
	m_oHSIChangeLabel.text		= @"0.000";
	m_oHSITurnoverLabel.text	= @"0";
	
	//China Enterprise
	m_oChinaEnterpriseValueLabel.text		= @"";
	m_oChinaEnterpriseChangeLabel.text		= @"0.000 (0.00%)";
	
	//HSI Future
	m_oHSIFutureValueLabel.text				= @"";
	m_oHSIFutureChangeLabel.text			= @"";
}



- (void)updateHSI:(float)aNominal prevClose:(float)aPrevClose turnover:(float)aTurnover {
	float priceChange = (aPrevClose > 0 && aNominal >= 0)?(aNominal - aPrevClose):0;
	float priceChangePtg = (aPrevClose > 0 && aNominal >= 0)?priceChange/aPrevClose*100:0;
	float turnover = (aTurnover >= 0)?aTurnover:0;
	
	NSString *nominalStr = (aNominal>=0)?[MHUtility floatIndexToString:aNominal market:MARKET_HONGKONG]:@"";
	NSString *changeStr = [NSString stringWithFormat:@"%@ (%@)", 
						   [MHUtility floatIndexChangeToString:priceChange market:MARKET_HONGKONG],
						   [MHUtility floatIndexPencentageChangeToString:priceChangePtg market:MARKET_HONGKONG]];
	NSString * turnoverStr = [MHUtility floatVolumeToString:turnover market:MARKET_HONGKONG];

	[m_oHSINominalLabel setTextWithAnimationUseTextColor:nominalStr duration:MHIndexBarView_m_oIndexValueLabel_animate_second animateIfNoChange:NO];	
	[m_oHSIChangeLabel setTextWithAnimationUseTextColor:changeStr duration:MHIndexBarView_m_oIndexChangeLabel_animate_second animateIfNoChange:NO];
	[m_oHSITurnoverLabel setTextWithAnimationUseTextColor:turnoverStr duration:MHIndexBarView_m_oIndexVolumeLabel_animate_second animateIfNoChange:NO];
	
	if(priceChange == 0){
		m_oHSIChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
	}else if(priceChange < 0){
		m_oHSIChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
	}else if(priceChange > 0){
		m_oHSIChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;		
	}
}

- (void)updateHSF:(float)aNominal prevClose:(float)aPrevClose {
	if ([[MHFeedConnectorX sharedMHFeedConnectorX] getPermission:MHFEEDX_PERMISSION_MT_INDEX_FUTURES] == NO) {
		return ;
	}
	float priceChange = (aPrevClose > 0 && aNominal >= 0)?(aNominal - aPrevClose):0;
//	float priceChangePtg = (aPrevClose > 0 && aNominal >= 0)?priceChange/aPrevClose*100:0;
	
	NSString *nominalStr = (aNominal>=0)?[MHUtility floatIndexToString:aNominal market:MARKET_HONGKONG]:@"";
	NSString *changeStr = [NSString stringWithFormat:@"%@",
						   [MHUtility floatIndexChangeToString:priceChange market:MARKET_HONGKONG]];
	
	// update color
	if(priceChange == 0){
		m_oHSIFutureChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
	}else if(priceChange < 0){
		m_oHSIFutureChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
	}else if(priceChange > 0){
		m_oHSIFutureChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;		
	}

	// set Text
	[m_oHSIFutureValueLabel setTextWithAnimationUseTextColor:nominalStr duration:MHIndexBarView_m_oIndexValueLabel_animate_second animateIfNoChange:NO];	
	[m_oHSIFutureChangeLabel setTextWithAnimationUseTextColor:changeStr duration:MHIndexBarView_m_oIndexChangeLabel_animate_second animateIfNoChange:NO];

}

- (void)updateHSCEI:(float)aNominal prevClose:(float)aPrevClose {
	float priceChange = (aPrevClose > 0 && aNominal >= 0)?(aNominal - aPrevClose):0;
	float priceChangePtg = (aPrevClose > 0 && aNominal >= 0)?priceChange/aPrevClose*100:0;
	
	NSString *displayValueString    = (aNominal>=0)?[MHUtility floatIndexToString:aNominal market:MARKET_HONGKONG]:@"";
	NSString *displayChangeString	= [MHUtility floatIndexPencentageChangeToString:priceChangePtg market:MARKET_HONGKONG];
	
	if(priceChange == 0){
		m_oChinaEnterpriseChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
	}else if(priceChange < 0){
		m_oChinaEnterpriseChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
	}else if(priceChange > 0){
		m_oChinaEnterpriseChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;		
	}
	
	
	[m_oChinaEnterpriseChangeLabel setTextWithAnimationUseTextColor:displayChangeString duration:MHIndexBarView_m_oIndexChangeLabel_animate_second animateIfNoChange:NO];
	[m_oChinaEnterpriseValueLabel setTextWithAnimationUseTextColor:displayValueString duration:MHIndexBarView_m_oIndexValueLabel_animate_second animateIfNoChange:NO];
	
}


#pragma mark -
#pragma mark MHFeedX callback function
- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)aMHFeedMsgInGetLiteQuote {
	[aMHFeedMsgInGetLiteQuote retain];
	
	//Snapshot
	m_oHSITurnoverLabel.frame = CGRectMake(m_oHSIChangeLabel.frame.origin.x+m_oHSIChangeLabel.frame.size.width-20,
											 m_oHSIChangeLabel.frame.origin.y,
											 55, m_oHSIChangeLabel.frame.size.height);
	
	m_oLastUpdateLabel.frame = CGRectMake(m_oHSITurnoverLabel.frame.origin.x+m_oHSITurnoverLabel.frame.size.width+8+5,
										  m_oHSIChangeLabel.frame.origin.y,
										  55, m_oHSIChangeLabel.frame.size.height);
	[m_oLastUpdateLabel setFont:MHIndexBarView_m_oLastUpdateLabel_font];
	m_oLastUpdateLabel.numberOfLines	= 2;
	m_oLastUpdateLabel.textAlignment	= NSTextAlignmentCenter;
	m_oLastUpdateLabel.hidden = NO;

	

	for (int i = 0; i < [aMHFeedMsgInGetLiteQuote.m_oStockQuoteArray count]; i++) {
		MHFeedXObjStockQuote *mm = [aMHFeedMsgInGetLiteQuote.m_oStockQuoteArray objectAtIndex:i];
		if([mm.m_oQuoteArray count] == 1){
			MHFeedXObjQuote *quote	= [mm.m_oQuoteArray objectAtIndex:0];
			if([MHUtility equalsIgnoreCase:quote.m_sSymbol
							 anotherString:@"HSI"]){
				
				float fLast			= [quote.m_sLast floatValue];
				float fChg			= [quote.m_sChange floatValue];
				float fPChg         = [quote.m_sPctChange floatValue];
				
				NSString *sTurnover = [MHUtility floatVolumeToString:[quote.m_sTurnover floatValue] market:MARKET_HONGKONG];
				NSString *sLast		= [MHUtility floatIndexToString:fLast market:MARKET_HONGKONG];
				NSString *sChg		= [NSString stringWithFormat:@"%@ (%@)", 
                                       [MHUtility floatIndexChangeToString:fChg market:MARKET_HONGKONG],
                                       [MHUtility floatIndexPencentageChangeToString:fPChg market:MARKET_HONGKONG]];
				
				
				if(fChg == 0){
					m_oHSIChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
				}else if(fChg < 0){
					m_oHSIChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
				}else if(fChg > 0){
					m_oHSIChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;		
				}
				
				
				
				[m_oHSIChangeLabel setTextWithAnimationUseTextColor:sChg duration:MHIndexBarView_m_oIndexChangeLabel_animate_second animateIfNoChange:NO];
				[m_oHSINominalLabel setTextWithAnimationUseTextColor:sLast duration:MHIndexBarView_m_oIndexValueLabel_animate_second animateIfNoChange:NO];
				[m_oHSITurnoverLabel setTextWithAnimationUseTextColor:sTurnover duration:MHIndexBarView_m_oIndexVolumeLabel_animate_second animateIfNoChange:NO];
				
			}else if([MHUtility equalsIgnoreCase:quote.m_sSymbol anotherString:@"HSCEI"]){
				
				
				float fLast         = [quote.m_sLast floatValue];
				float fChg			= [quote.m_sChange floatValue];
				float fPChg         = [quote.m_sPctChange floatValue];
				NSString *sLast		= [MHUtility floatIndexToString:fLast market:MARKET_HONGKONG];
				NSString *sChg		= [MHUtility floatIndexPencentageChangeToString:fPChg market:MARKET_HONGKONG];
								
				if(fChg == 0){
					m_oChinaEnterpriseChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
				}else if(fChg < 0){
					m_oChinaEnterpriseChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
				}else if(fChg > 0){
					m_oChinaEnterpriseChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;		
				}
				
				
				[m_oChinaEnterpriseChangeLabel setTextWithAnimationUseTextColor:sChg duration:MHIndexBarView_m_oIndexChangeLabel_animate_second animateIfNoChange:NO];
				[m_oChinaEnterpriseValueLabel setTextWithAnimationUseTextColor:sLast duration:MHIndexBarView_m_oIndexValueLabel_animate_second animateIfNoChange:NO];
				
			}
		}
	}
	
	//Snaptshot don't have futre
	m_oHSIFutureChangeLabel.text = @"";
	m_oHSIFutureValueLabel.text	 = @"";
	
	[aMHFeedMsgInGetLiteQuote release];
}

- (void)onMHFeedXMsgInGetLiteQuote:(NSNotification *)n {
	MHFeedXMsgInGetLiteQuote *msg = [n object];
	MHFeedXObjStockQuote *stockQuote = nil;
	
	// Start checking if the stock is valid or not
	if(msg.m_oStockQuoteArray == nil || [msg.m_oStockQuoteArray count] <= 0) {  // Invalid
		return;
	}	
	stockQuote = [msg.m_oStockQuoteArray objectAtIndex:0];
	
	if(stockQuote.m_oQuoteArray == nil || [stockQuote.m_oQuoteArray count] <= 0){
		return;
	}
	// End of checking if the stock is valid or not
	
	[self performSelectorOnMainThread:@selector(performMHFeedXMsgInGetLiteQuote:) withObject:msg waitUntilDone:NO];
}

@end
