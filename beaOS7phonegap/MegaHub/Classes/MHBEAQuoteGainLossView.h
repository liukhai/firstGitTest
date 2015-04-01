//
//  MHBEAQuoteGainLossView.h
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MHBEAQuoteGainLossView : UIView {
	UILabel		*m_oBuyPriceTitleLabel;
	UILabel		*m_oQtyTitleLabel;
	UILabel		*m_oCostTitleLabel;
	UILabel		*m_oMarketValueTitleLabel;
	UILabel		*m_oGainLossTitleLabel;
	UILabel		*m_oGainLossPctTitleLabel;
	
	UILabel		*m_oBuyPriceValueLabel;
	UILabel		*m_oQtyValueLabel;
	UILabel		*m_oCostValueLabel;
	UILabel		*m_oMarketValueValueLabel;
	UILabel		*m_oGainLossValueLabel;
	UILabel		*m_oGainLossPctValueLabel;
}

@property(nonatomic, retain) UILabel		*m_oBuyPriceTitleLabel;
@property(nonatomic, retain) UILabel		*m_oQtyTitleLabel;
@property(nonatomic, retain) UILabel		*m_oCostTitleLabel;
@property(nonatomic, retain) UILabel		*m_oMarketValueTitleLabel;
@property(nonatomic, retain) UILabel		*m_oGainLossTitleLabel;
@property(nonatomic, retain) UILabel		*m_oGainLossPctTitleLabel;
@property(nonatomic, retain) UILabel		*m_oBuyPriceValueLabel;
@property(nonatomic, retain) UILabel		*m_oQtyValueLabel;
@property(nonatomic, retain) UILabel		*m_oCostValueLabel;
@property(nonatomic, retain) UILabel		*m_oMarketValueValueLabel;
@property(nonatomic, retain) UILabel		*m_oGainLossValueLabel;
@property(nonatomic, retain) UILabel		*m_oGainLossPctValueLabel;


- (id)initWithFrame:(CGRect)frame ;
- (void)dealloc ;
- (void)clean ;

- (void)reloadText ;

// update
- (void)updateWithBuyPrice:(NSString *)aBuyPrice qyt:(NSString *)aQty last:(NSString *)aLast;

@end