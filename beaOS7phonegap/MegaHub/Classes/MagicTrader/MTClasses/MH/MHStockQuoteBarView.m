//
//  StockQuoteBar.m
//  PhoneStream
//
//  Created by Megahub on 16/02/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHStockQuoteBarView.h"
#import "PTConstant.h"
#import "StyleConstant.h"
#import "MHFeedConnectorX.h"
#import "MHUtility.h"
#import "MHUILabel.h"
#import "MHFeedXObjQuote.h"

@implementation MHStockQuoteBarView
@synthesize m_oQuoteButton, m_oSymbolTextField, m_oPriceLabel, m_oCopyPriceButton, m_idCopyPriceDelegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    if (self) {
		self.backgroundColor		= MHStockQuoteBarView_view_background_color;
		m_oPriceLabel				= [[MHUILabel alloc] initWithFrame:CGRectMake(4, 3, 121, 30)];
		[m_oPriceLabel setTextColor:MHStockQuoteBarView_m_oPriceLabel_text_color];
		[m_oPriceLabel setTextAlignment:NSTextAlignmentCenter];
		[m_oPriceLabel setFont:MHStockQuoteBarView_m_oPriceLabel_font];
		[m_oPriceLabel setBackgroundColor:[UIColor clearColor]];
		[self addSubview:m_oPriceLabel];
		[m_oPriceLabel release];
		
		m_oChangeLabel				= [[MHUILabel alloc] initWithFrame:CGRectMake(121+4, 3, 78-4, 15)];
		[m_oChangeLabel setTextAlignment:NSTextAlignmentCenter];
		[m_oChangeLabel setFont:MHStockQuoteBarView_m_oChangeLabel_font];
		[m_oChangeLabel setBackgroundColor:[UIColor clearColor]];
		[self addSubview:m_oChangeLabel];
		[m_oChangeLabel release];
		
		m_oChangePercentageLabel	= [[MHUILabel alloc] initWithFrame:CGRectMake(121+4, 18, 78-4, 15)];
		[m_oChangePercentageLabel setTextAlignment:NSTextAlignmentCenter];
		[m_oChangePercentageLabel setFont:MHStockQuoteBarView_m_oChangePercentageLabel_font];
		[m_oChangePercentageLabel setBackgroundColor:[UIColor clearColor]];
		[self addSubview:m_oChangePercentageLabel];
		[m_oChangePercentageLabel release];
		
		m_oSymbolTextField						= [[UITextField alloc] initWithFrame:CGRectMake(206-4, (frame.size.height-25)/2, 68, 25)];
		[m_oSymbolTextField setFont:MHStockQuoteBarView_m_oSymbolTextField_font];
		m_oSymbolTextField.borderStyle			= UITextBorderStyleRoundedRect;
		m_oSymbolTextField.autocorrectionType	= UITextAutocorrectionTypeNo;
		[m_oSymbolTextField setTextAlignment:NSTextAlignmentRight];
		[m_oSymbolTextField setClearsOnBeginEditing:YES];
		[m_oSymbolTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[self addSubview:m_oSymbolTextField];
		[m_oSymbolTextField release];
		
		m_oQuoteButton				= [[UIButton alloc] initWithFrame:CGRectMake(263, (frame.size.height-25)/2, 51, 25)];
		m_oQuoteButton.titleLabel.font = MHStockQuoteBarView_m_oQuoteButton_font;
		[m_oQuoteButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
		[m_oQuoteButton setBackgroundImage:MHStockQuoteBarView_m_oQuoteButton_image forState:UIControlStateNormal];
		[self addSubview:m_oQuoteButton];
		[m_oQuoteButton release];
		
		m_oCopyPriceButton			= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 121+78-4, 30)];
		[self addSubview:m_oCopyPriceButton];
		[m_oCopyPriceButton addTarget:self action:@selector(onCopyPriceButtonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
		[m_oCopyPriceButton release];
		m_oCopyPriceButton.userInteractionEnabled = YES;
		
		
		
		[self reloadText];
		
		m_fPreviousClose = -1;
		m_fNominalPrice = -1;
    }
    return self;
}

-(void)reloadText{
	[m_oQuoteButton setTitle:MHLocalizedString(@"MHStockQuoteBarView_m_oQuoteButton", nil) forState:UIControlStateNormal];
}

-(void)clean{
    m_fPreviousClose = -1;
    m_fNominalPrice = -1;
	m_oPriceLabel.text				= @"";
	m_oChangeLabel.text				= @"";
	m_oChangePercentageLabel.text	= @"";
	[m_oSymbolTextField setPlaceholder:@""];
	
}

- (void)showDataWithNominal:(float)aNominalPrice previousClose:(float)aPreviousClose liveUpdate:(BOOL)aLiveUpdate {
	
	// Below two if statements are required because the notification is seperated
	if(aPreviousClose != -1){
		m_fPreviousClose = aPreviousClose;
	}
	
	if(aNominalPrice != -1){
		m_fNominalPrice = aNominalPrice;
	}
	
	if(m_fPreviousClose != -1 && m_fNominalPrice != -1){
		m_oChangeLabel.hidden			= NO;
		m_oChangePercentageLabel.hidden	= NO;
		m_oCopyPriceButton.userInteractionEnabled = YES;
		
		float priceChange = m_fNominalPrice - m_fPreviousClose;
		float priceChangePercentage = m_fPreviousClose>0?priceChange/m_fPreviousClose*100:0;
		
		NSString *sPrice						= [MHUtility floatPriceToString:m_fNominalPrice market:MARKET_HONGKONG];
		NSString *sChange						= [MHUtility floatPriceChangeToString:priceChange market:MARKET_HONGKONG];
		NSString *sChangePercentage				= [MHUtility floatPricePencentageChangeToString:priceChangePercentage market:MARKET_HONGKONG];
		
		m_oPriceLabel.text						= sPrice;
        m_oChangeLabel.text						= m_fPreviousClose>0?sChange:@"";
        m_oChangePercentageLabel.text			= m_fPreviousClose>0?sChangePercentage:@"";
		
		if(priceChange > 0){
			m_oChangePercentageLabel.textColor	= MHStockQuoteBarView_m_oChangePercentageLabel_text_color_up;
			m_oChangeLabel.textColor			= MHStockQuoteBarView_m_oChangeLabel_text_color_up;
		}else if (priceChange < 0){
			m_oChangePercentageLabel.textColor	= MHStockQuoteBarView_m_oChangePercentageLabel_text_color_down;
			m_oChangeLabel.textColor			= MHStockQuoteBarView_m_oChangeLabel_text_color_down;
		}else {
			m_oChangePercentageLabel.textColor	= MHStockQuoteBarView_m_oChangePercentageLabel_text_color_leveloff;
			m_oChangeLabel.textColor			= MHStockQuoteBarView_m_oChangeLabel_text_color_leveloff;
		}
		
		//animation
		if(aLiveUpdate){
			[m_oPriceLabel setTextWithAnimation:sPrice color:m_oPriceLabel.textColor duration:MHStockQuoteBarView_m_oPriceLabel_animate_second animateIfNoChange:NO];
            if(m_fPreviousClose > 0){
                [m_oChangeLabel setTextWithAnimation:sChange color:m_oChangeLabel.textColor duration:MHStockQuoteBarView_m_oChangeLabel_animate_second animateIfNoChange:NO];
                [m_oChangePercentageLabel setTextWithAnimation:sChangePercentage color:m_oChangePercentageLabel.textColor duration:MHStockQuoteBarView_m_oChangePercentageLabel_animate_second animateIfNoChange:NO];
            }
		}
	}else{
        m_oChangeLabel.text                     = @"";
        m_oChangePercentageLabel.text           = @"";
    }
	
}

-(void)displayInvalidStock{
	[self clean];
	m_oSymbolTextField.text	= @"";
}

-(void)onCopyPriceButtonIsPressed:(id)aSender{
	if ([[MHFeedConnectorX sharedMHFeedConnectorX] getPermission:MHFEEDX_PERMISSION_MT_TELETEXT]) {
		if ([(NSObject *)m_idCopyPriceDelegate respondsToSelector:@selector(PTCopyPriceDelegateCallback:)]) {
			[(NSObject *)m_idCopyPriceDelegate performSelector:@selector(PTCopyPriceDelegateCallback:) withObject:aSender];
		}
	}else{
		if ([(NSObject *)m_idCopyPriceDelegate respondsToSelector:@selector(PTSRCopyPriceDelegateCallback:)]) {
			[(NSObject *)m_idCopyPriceDelegate performSelector:@selector(PTSRCopyPriceDelegateCallback:) withObject:aSender];
		}
	}
}

- (void)dealloc {
    [super dealloc];
}

@end
