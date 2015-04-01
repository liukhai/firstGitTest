//
//  MHStockView.h
//  MegaHub
//
//  Created by MegaHub on 17/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHUILabel.h"
@class MHFeedXMsgInGetLiteQuote;
@class MHFeedXObjQuote;

@interface MHStockView : UIView {
	UIImageView		*m_oBackgroundImageView;
	
	MHUILabel		*m_oNorminalPriceLabel;
	
	MHUILabel		*m_oChangeLabel;
	MHUILabel		*m_oChangePctLabel;
	
	MHUILabel		*m_oBidTitleLabel;
	MHUILabel		*m_oBidPriceLabel;
	
	MHUILabel		*m_oAskTitleLabel;
	MHUILabel		*m_oAskPriceLabel;
	
	UIButton		*m_oCopyBidPriceButton;
	UIButton		*m_oCopyAskPriceButton;
	
	float						m_fBid;
	float						m_fAsk;
	
	float						m_fPreviousClose;
	
	float						m_fChangePercentage;
	float						m_fChange;
	float						m_fNorminalPrice;
}
@property (nonatomic, retain)UIImageView	*m_oBackgroundImageView;
@property(nonatomic, retain)MHUILabel		*m_oNorminalPriceLabel;
@property(nonatomic, retain)MHUILabel		*m_oChangeLabel;
@property(nonatomic, retain)MHUILabel		*m_oBidPriceLabel;
@property(nonatomic, retain)MHUILabel		*m_oAskPriceLabel;
@property(nonatomic, retain)UIButton		*m_oCopyBidPriceButton;
@property(nonatomic, retain)UIButton		*m_oCopyAskPriceButton;
@property(nonatomic, readonly)float			m_fNorminalPrice;
@property(nonatomic, readonly)float			m_fBid;
@property(nonatomic, readonly)float			m_fAsk;
@property(nonatomic, readonly)float			m_fPreviousClose;
@property(nonatomic, readonly)float			m_fChangePercentage;
@property(nonatomic, readonly)float			m_fChange;

- (id)initWithFrame:(CGRect)frame;
-(void)updateDisplay;
-(void)cleanData;
-(void)reloadText;
- (void)dealloc;

@end
