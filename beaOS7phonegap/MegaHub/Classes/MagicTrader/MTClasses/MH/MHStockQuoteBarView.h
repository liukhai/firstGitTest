//
//  StockQuoteBar.h
//  PhoneStream
//
//  Created by Megahub on 16/02/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHUILabel;
@class MHFeedXObjQuote;

@interface MHStockQuoteBarView : UIView{
	
	MHUILabel				*m_oPriceLabel;
	MHUILabel				*m_oChangeLabel;
	MHUILabel				*m_oChangePercentageLabel;
	
	UITextField				*m_oSymbolTextField;
	UIButton				*m_oQuoteButton;
	
	//This value is used to calculate the change and percentage change	
	float					m_fPreviousClose;
	float					m_fNominalPrice;
	
	UIButton				*m_oCopyPriceButton;

}

@property (retain, nonatomic) UIButton		*m_oQuoteButton;
@property (retain, nonatomic) UITextField	*m_oSymbolTextField;
@property (retain, nonatomic) MHUILabel		*m_oPriceLabel;
@property (retain, nonatomic) UIButton		*m_oCopyPriceButton;
@property (nonatomic, assign) id			m_idCopyPriceDelegate;

- (id)initWithFrame:(CGRect)frame;
-(void)reloadText;
-(void)clean;
-(void)showDataWithNominal:(float)aNominalPrice previousClose:(float)aPreviousClose liveUpdate:(BOOL)aLiveUpdate;
-(void)displayInvalidStock;
-(void)onCopyPriceButtonIsPressed:(id)aSender;

@end
