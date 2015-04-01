//
//  MHBEAFAQuoteView.h
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MHBEAIndexQuoteView.h"
#import "MHBEABasicDataView.h"
#import "MHDisclaimerBarView.h"
#import "MHBEAQuoteGainLossView.h"
#import "MHBEABottomView.h"

@class MHStaticDataView;
@class MHFeedXObjQuote;
@class LoadingView;
@class MHBEAIndexQuoteView;
@class MHFeedXMsgInGetTime;

@interface MHBEAFAQuoteView : UIView {
	MHBEAIndexQuoteView			*m_oMHBEAIndexQuoteView;
	UIScrollView				*m_oScrollView;
	MHDisclaimerBarView			*m_oMHDisclaimerBarView;
	
	// page1
	UILabel						*m_oDespLabel;
	MHStaticDataView            *m_oMHStaticDataView;
	UIImageView					*m_oBidView;
	UIImageView					*m_oAskView;

	MHUILabel					*m_oBidTitleLabel;
	MHUILabel					*m_oAskTitleLabel;
	MHUILabel					*m_oBidValueLabel;
	MHUILabel					*m_oAskValueLabel;
	UIButton					*m_oCopyBidButton;
	UIButton					*m_oCopyAskButton;
	
	UIImageView					*m_oChartImageView;
	UIImageView					*m_oTurnDeviceLandscapeImageView;
	LoadingView					*m_oChartLoadingView;
	UIImageView					*m_oSuspendImage;
	
	MHBEAQuoteGainLossView		*m_oMHBEAQuoteGainLossView;
    
    // page2
	MHBEABasicDataView          *m_oMHBEABasicDataView;
    
    MHBEABottomView             *m_oMHBEABottomView;
    
    UIButton                    *m_oBottomLeftButton;
    UIButton                    *m_oBottomRightButton;

	NSString					*m_sLastUpdateTime;
	
}

@property(nonatomic, retain) MHBEAIndexQuoteView		*m_oMHBEAIndexQuoteView;
@property(nonatomic, retain) UIScrollView				*m_oScrollView;
@property(nonatomic, retain) UILabel					*m_oDespLabel;
@property(nonatomic, retain) MHStaticDataView           *m_oMHStaticDataView;
@property(nonatomic, retain) MHBEABasicDataView         *m_oMHBEABasicDataView;
@property(nonatomic, retain) UIImageView				*m_oBidView;
@property(nonatomic, retain) UIImageView				*m_oAskView;
@property(nonatomic, retain) MHUILabel					*m_oBidTitleLabel;
@property(nonatomic, retain) MHUILabel					*m_oAskTitleLabel;
@property(nonatomic, retain) MHUILabel					*m_oBidValueLabel;
@property(nonatomic, retain) MHUILabel					*m_oAskValueLabel;
@property(nonatomic, retain) UIButton					*m_oCopyBidButton;
@property(nonatomic, retain) UIButton					*m_oCopyAskButton;
@property(nonatomic, retain) UIImageView				*m_oChartImageView;
@property(nonatomic, retain) UIImageView				*m_oTurnDeviceLandscapeImageView;
@property(nonatomic, retain) LoadingView				*m_oCharLoadingView;
@property(nonatomic, retain) MHBEAQuoteGainLossView		*m_oMHBEAQuoteGainLossView;
@property(nonatomic, retain) MHBEABottomView            *m_oMHBEABottomView;
@property(nonatomic, retain) UIButton                   *m_oBottomLeftButton;
@property(nonatomic, retain) UIButton                   *m_oBottomRightButton;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController*)aController;
- (void)dealloc;
- (void)clean;
- (void)reloadText;
- (void)switchToPage:(int)page;
- (void)onQuoteButtonPressed:(id)sender;
- (void)onChartGetTime:(MHFeedXMsgInGetTime *)aMsg;
- (void)onChartGetTimeInBackground:(MHFeedXMsgInGetTime *)aMsg;
- (void)displayChartInBackground:(NSString *)sSymbol;
- (void)performChartUpdateTasks:(UIImage *)chartImage;
- (void)updateStockInfo:(MHFeedXMsgInGetLiteQuote *)msg;
- (void)displaySuspend:(BOOL)display;
- (void)turnDeviceLandscapeImageViewDidAnimated;

@end