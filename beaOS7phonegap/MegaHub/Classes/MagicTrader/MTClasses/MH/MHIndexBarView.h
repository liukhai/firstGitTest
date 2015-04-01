//
//  MHIndexBar.h
//  PhoneStream
//
//  Created by Megahub on 16/02/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class ObjIndices;
//@class ObjFutureInfo;

@class MHUILabel;
@class MHFeedXMsgInGetLiteQuote;


@interface MHIndexBarView : UIView {
	UIImageView			*m_oImageView;
	
	//Use for HSI, if one line mode, 
	//it will share with China Enterprise & HSI Future
	MHUILabel			*m_oHSIDescpLabel;
	MHUILabel			*m_oHSINominalLabel;
	MHUILabel			*m_oHSIChangeLabel; //change included change value and percentage
	
	//This is used for the non-oneline mode
	MHUILabel			*m_oHSITurnoverLabel; //for HSI only
	
	//China Enterprise
	MHUILabel			*m_oChinaEnterpriseDescriptionLabel;
	MHUILabel			*m_oChinaEnterpriseValueLabel;
	MHUILabel			*m_oChinaEnterpriseChangeLabel;	//just percentage
	
	//HSI Future
	MHUILabel			*m_oHSIFutureDescriptionLabel;
	MHUILabel			*m_oHSIFutureValueLabel;
	MHUILabel			*m_oHSIFutureChangeLabel;	//just percentage

	//Last update
	MHUILabel			*m_oLastUpdateLabel;
	

	//Internal logic
	int					m_iCurrentDisplayIndex;
	short				m_windowID;
	
	NSMutableDictionary		*m_oBasicQuoteDict;	// object:PTPMsgInSBasicQuote key:StockID in NSNumber format
	NSMutableDictionary		*m_oPrevCloseDict;	// object:prevClose in NSNumber format key:StockID in NSNumber format

}


- (id)initWithFrame:(CGRect)frame ;
- (void)dealloc ;

- (void)reloadText;
- (void)clean;

// PTPStreamer callback function
- (void)updateHSI:(float)aNominal prevClose:(float)aPrevClose turnover:(float)aTurnover ;
- (void)updateHSF:(float)aNominal prevClose:(float)aPrevClose ;
- (void)updateHSCEI:(float)aNominal prevClose:(float)aPrevClose ;

// FeedX callback function
- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)aMHFeedMsgInGetLiteQuote ;
- (void)onMHFeedXMsgInGetLiteQuote:(NSNotification*)aMHFeedMsgInGetLiteQuote ;

@end