//
//  MHStaticDataView.h
//  MagicTrader
//
//  Created by Megahub on 03/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrokerConf.h"

@class MHUILabel;
@class ArrowImgView;
@class PTPMsgInSBasicQuote;
@class PTPMsgInSStaticNumeBasic;
@class PTPMsgInSTechInfo;
@class PTPMsgInSPrevClose;
@class PTPMsgInSBasicQuote;
@class PTPMsgInLTechInfo;
@class PTPMsgInLBasicQuote;
@class MHFeedXMsgInGetLiteQuote;

@interface MHStaticDataView : UIView {
	UIButton			*m_oRelatedStockButton;
	
	MHUILabel			*m_oOpenTitleLabel;
	MHUILabel			*m_oPrevCloseTitleLabel;
	MHUILabel			*m_oAvgPriceTitleLabel;
	MHUILabel			*m_oVolumeTitleLabel;		//成交量
	MHUILabel			*m_oTurnoverTitleLabel;		//成交額
	MHUILabel			*m_oPETitleLabel;			//If Stock
	MHUILabel			*m_oYieldTitleLabel;		//If Stock
	MHUILabel			*m_oLotSizeTitleLabel;
	
	MHUILabel			*m_oOpenValueLabel;
	MHUILabel			*m_oPrevCloseValueLabel;
	MHUILabel			*m_oAvgPriceValueLabel;
	MHUILabel			*m_oVolumeValueLabel;		//成交量
	MHUILabel			*m_oTurnoverValueLabel;		//成交額
	MHUILabel			*m_oPEValueLabel;			//If Stock
	MHUILabel			*m_oYieldValueLabel;		//If Stock
	MHUILabel			*m_oLotSizeValueLabel;
	
	//Warrant + CBBC special handling
	MHUILabel			*m_oPremiumTitleLabel;		//If Warrant/CBBC, replace m_oPETitleLabel		//溢價
	MHUILabel			*m_oGearingTitleLabel;		//If Warrant/CBBC, replace m_oYieldTitleLabel
	MHUILabel			*m_oPremiumValueLabel;		//If Warrant/CBBC, replace m_oPEValueLabel
	MHUILabel			*m_oGearingValueLabel;		//If Warrant/CBBC, replace m_oYieldValueLabel
    
    //Snapshot
    //Stock
    MHUILabel           *m_oYearHighTitleLabel;
    MHUILabel           *m_oYearHighValueLabel;
    MHUILabel           *m_oYearLowTitleLabel;
    MHUILabel           *m_oYearLowValueLabel;
    
    //General
    MHUILabel           *m_oDayHighTitleLabel;
    MHUILabel           *m_oDayHighValueLabel;
    MHUILabel           *m_oDayLowTitleLabel;
    MHUILabel           *m_oDayLowValueLabel;
	
	MHUILabel			*m_oQuoteMeterTitleLabel;
	MHUILabel			*m_oQuoteMeterValueLabel;
	
#if BEHAVIOUR_MHStaticDataView_SHOW_TODAY_FREE
	UILabel				*m_oQuoteMeterFreeTodayTitleLabel;
	UILabel				*m_oQuoteMeterFreeTodayValueLabel;
	UILabel				*m_oQuoteMeterUsedTodayTitleLabel;
	UILabel				*m_oQuoteMeterUsedTodayValueLabel;	
#endif
    
	//Warrant + CBBC special handling
    MHUILabel           *m_oRelatedStockTitleLabel;
    MHUILabel           *m_oRelatedStockValueLabel;
	
	MHUILabel			*m_oRelatedStockPriceValueLabel;
	
	
	//尼三個數係拎來計數架!
	float				m_fLast;
	
	NSString			*m_sEPSValue;				//每股盈利 
	NSString			*m_sDPSValue;				//每股派息
	
	/*	PE:           Last / EPS
	 Yeild:			  DPS / Last * 100*/
	
	UIImageView				*m_oBackgroundImageView;
	ArrowImgView			*m_oUndelyingChangeImageView;
	
	unsigned int			m_uiRelatedStockMsgId;
    
    BOOL                    m_isShowQuoteMeter;

}

@property (nonatomic, retain) MHUILabel			*m_oOpenTitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oPrevCloseTitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oAvgPriceTitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oVolumeTitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oTurnoverTitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oPETitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oYieldTitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oLotSizeTitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oOpenValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oPrevCloseValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oAvgPriceValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oVolumeValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oTurnoverValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oPEValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oYieldValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oLotSizeValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oRelatedStockValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oPremiumTitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oGearingTitleLabel;
@property (nonatomic, retain) MHUILabel			*m_oPremiumValueLabel;
@property (nonatomic, retain) MHUILabel			*m_oGearingValueLabel;
@property (nonatomic, assign) float				m_fLast;
@property (nonatomic, retain) NSString			*m_sEPSValue;
@property (nonatomic, retain) NSString			*m_sDPSValue;
@property (nonatomic, retain) UIImageView		*m_oBackgroundImageView;
@property (nonatomic, retain) UIButton			*m_oRelatedStockButton;
@property (nonatomic, assign) BOOL              m_isShowQuoteMeter;

- (id)initWithFrame:(CGRect)frame;
- (void)reloadText;
- (void)setSRMode:(BOOL)aIsEnableSRMode;
- (void)clean;
- (void)updateStockInfo:(MHFeedXMsgInGetLiteQuote *)aQuote ;
- (void)dealloc;

@end
