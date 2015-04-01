//
//  MHBEAQuoteGainLossView.m
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAQuoteGainLossView.h"
#import "MHBEAConstant.h"
#import "PTConstant.h"
#import "MHUtility.h"

@implementation MHBEAQuoteGainLossView

@synthesize m_oBuyPriceTitleLabel;
@synthesize m_oQtyTitleLabel;
@synthesize m_oCostTitleLabel;
@synthesize m_oGainLossTitleLabel;
@synthesize m_oMarketValueTitleLabel;
@synthesize m_oGainLossPctTitleLabel;
@synthesize m_oBuyPriceValueLabel;
@synthesize m_oQtyValueLabel;
@synthesize m_oCostValueLabel;
@synthesize m_oMarketValueValueLabel;
@synthesize m_oGainLossValueLabel;
@synthesize m_oGainLossPctValueLabel;

// Best size 220 * 34
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        int fontSize = 8;
		
		// row 1
		// Buy Price
		m_oBuyPriceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 11)];
		[m_oBuyPriceTitleLabel setBackgroundColor:[UIColor clearColor]];
		[m_oBuyPriceTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oBuyPriceTitleLabel setFont:[UIFont systemFontOfSize:fontSize]];
		[m_oBuyPriceTitleLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oBuyPriceTitleLabel];
		[m_oBuyPriceTitleLabel release];
		
		// Qty
		m_oQtyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(113, 0, 40, 11)];
		[m_oQtyTitleLabel setBackgroundColor:[UIColor clearColor]];
		[m_oQtyTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oQtyTitleLabel setFont:[UIFont systemFontOfSize:fontSize]];
		[m_oQtyTitleLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oQtyTitleLabel];
		[m_oQtyTitleLabel release];

		
		// row 2
		// Cose
		m_oCostTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 40, 11)];
		[m_oCostTitleLabel setBackgroundColor:[UIColor clearColor]];
		[m_oCostTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oCostTitleLabel setFont:[UIFont systemFontOfSize:fontSize]];
		[m_oCostTitleLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oCostTitleLabel];
		[m_oCostTitleLabel release];
		
		m_oGainLossTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(113, 11, 40, 11)];
		[m_oGainLossTitleLabel setBackgroundColor:[UIColor clearColor]];
		[m_oGainLossTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oGainLossTitleLabel setFont:[UIFont systemFontOfSize:fontSize]];
		[m_oGainLossTitleLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oGainLossTitleLabel];
		[m_oGainLossTitleLabel release];

		
		// row 3
		// MarketValue
		m_oMarketValueTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 40, 11)];
		[m_oMarketValueTitleLabel setBackgroundColor:[UIColor clearColor]];
		[m_oMarketValueTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oMarketValueTitleLabel setFont:[UIFont systemFontOfSize:fontSize]];
		[m_oMarketValueTitleLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oMarketValueTitleLabel];
		[m_oMarketValueTitleLabel release];
		
		// GainLostt
		m_oGainLossPctTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(113, 22, 40, 11)];
		[m_oGainLossPctTitleLabel setBackgroundColor:[UIColor clearColor]];
		[m_oGainLossPctTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oGainLossPctTitleLabel setFont:[UIFont systemFontOfSize:fontSize]];
		[m_oGainLossPctTitleLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oGainLossPctTitleLabel];
		[m_oGainLossPctTitleLabel release];

		
		//============================
		// row 1
		m_oBuyPriceValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 70, 11)];
		[m_oBuyPriceValueLabel setBackgroundColor:[UIColor clearColor]];
		[m_oBuyPriceValueLabel setTextAlignment:NSTextAlignmentRight];
		[m_oBuyPriceValueLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
		[m_oBuyPriceValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oBuyPriceValueLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oBuyPriceValueLabel];
		[m_oBuyPriceValueLabel release];
		
		m_oQtyValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(143, 0, 75, 11)];
		[m_oQtyValueLabel setBackgroundColor:[UIColor clearColor]];
		[m_oQtyValueLabel setTextAlignment:NSTextAlignmentRight];
		[m_oQtyValueLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
		[m_oQtyValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oQtyValueLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oQtyValueLabel];
		[m_oQtyValueLabel release];
		
		
		// row 2
		m_oCostValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 11, 70, 11)];
		[m_oCostValueLabel setBackgroundColor:[UIColor clearColor]];
		[m_oCostValueLabel setTextAlignment:NSTextAlignmentRight];
		[m_oCostValueLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
		[m_oCostValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oCostValueLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oCostValueLabel];
		[m_oCostValueLabel release];
				
		m_oGainLossValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(143, 11, 75, 11)];
		[m_oGainLossValueLabel setBackgroundColor:[UIColor clearColor]];
		[m_oGainLossValueLabel setTextAlignment:NSTextAlignmentRight];
		[m_oGainLossValueLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
		[m_oGainLossValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oGainLossValueLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oGainLossValueLabel];
		[m_oGainLossValueLabel release];
		
				
		// row 3
		m_oMarketValueValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 22, 70, 11)];
		[m_oMarketValueValueLabel setBackgroundColor:[UIColor clearColor]];
		[m_oMarketValueValueLabel setTextAlignment:NSTextAlignmentRight];
		[m_oMarketValueValueLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
		[m_oMarketValueValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oMarketValueValueLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oMarketValueValueLabel];
		[m_oMarketValueValueLabel release];
		
		
		m_oGainLossPctValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(143, 22, 75, 11)];
		[m_oGainLossPctValueLabel setBackgroundColor:[UIColor clearColor]];
		[m_oGainLossPctValueLabel setTextAlignment:NSTextAlignmentRight];
		[m_oGainLossPctValueLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
		[m_oGainLossPctValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oGainLossPctValueLabel setTextColor:[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]];
		[self addSubview:m_oGainLossPctValueLabel];
		[m_oGainLossPctValueLabel release];

    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)clean {
	m_oBuyPriceValueLabel.text = @"--";	
	m_oQtyValueLabel.text = @"--";	
	m_oCostValueLabel.text = @"--";	
	m_oMarketValueValueLabel.text = @"--";	
	m_oGainLossValueLabel.text = @"--";	
	m_oGainLossPctValueLabel.text = @"--";	
}

#pragma mark -
- (void)reloadText {
	//TODO:String
	m_oBuyPriceTitleLabel.text		= MHLocalizedStringFile(@"MHBEAQuoteGainLossView.m_oBuyPriceTitleLabel", nil, MHLanguage_BEAString);	// @"Buy Price";
	m_oQtyTitleLabel.text			= MHLocalizedStringFile(@"MHBEAQuoteGainLossView.m_oQtyTitleLabel", nil, MHLanguage_BEAString);			// @"Qty";
	m_oCostTitleLabel.text			= MHLocalizedStringFile(@"MHBEAQuoteGainLossView.m_oCostTitleLabel", nil, MHLanguage_BEAString);		// @"Cost";
	m_oGainLossTitleLabel.text		= MHLocalizedStringFile(@"MHBEAQuoteGainLossView.m_oGainLossTitleLabel", nil, MHLanguage_BEAString);	// @"G/L";
	m_oMarketValueTitleLabel.text	= MHLocalizedStringFile(@"MHBEAQuoteGainLossView.m_oMarketValueTitleLabel", nil, MHLanguage_BEAString); // @"Mkt. Val.";
	m_oGainLossPctTitleLabel.text	= MHLocalizedStringFile(@"MHBEAQuoteGainLossView.m_oGainLossPctTitleLabel", nil, MHLanguage_BEAString); // @"G/L %";
}

#pragma mark -
#pragma mark Update Functions
- (void)updateWithBuyPrice:(NSString *)aBuyPrice qyt:(NSString *)aQty last:(NSString *)aLast {
    
    double buy = [aBuyPrice doubleValue];
    long long qty = [aQty longLongValue];
    double last = [aLast doubleValue];
    
	double cost = buy * qty;
	double gl = (last - buy) * qty;
	double mktV = last * qty;
	double ptGL = (buy == 0) ? 0 : ((last - buy) / buy) * 100;

    if([aBuyPrice length] == 0){
        m_oBuyPriceValueLabel.text = @"0.000";
    }else if(buy < LLONG_MAX){
        m_oBuyPriceValueLabel.text = [MHUtility doublePriceToString:buy market:MARKET_HONGKONG];
    }else{
        m_oBuyPriceValueLabel.text = aBuyPrice;
    }
    
	m_oQtyValueLabel.text = [aQty length] == 0 ? @"0.000" : aQty;
	m_oCostValueLabel.text = [MHUtility longlongPriceToString:cost market:MARKET_HONGKONG];
	m_oMarketValueValueLabel.text = [MHUtility longlongPriceToString:mktV market:MARKET_HONGKONG];
	m_oGainLossValueLabel.text = [MHUtility longlongPriceToString:gl market:MARKET_HONGKONG];
	m_oGainLossPctValueLabel.text = [NSString stringWithFormat:@"%.2f%%", ptGL];
}

@end