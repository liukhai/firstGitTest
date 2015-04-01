//
//  MHBEABuySellStockView.h
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHBEAIndexQuoteView;
@class MHDisclaimerBarView;
@class MHBEABottomView;
@class LoadingView;

@interface MHBEABuySellStockView : UIView {
    MHBEAIndexQuoteView             *m_oMHBEAIndexQuoteView;
    MHBEABottomView                 *m_oMHBEABottomView;
    MHDisclaimerBarView             *m_oMHDisclaimerBarView;
    
	UILabel                         *m_oBuySellLabel;
	UIButton                        *m_oBuySellButton;
	UITableView						*m_oTableView;
	
	UILabel							*m_oStockTotalValueLabel;
	UIImageView						*m_oStockTotalBackground;
	UILabel							*m_oStockTotalValueTitle;
	UILabel							*m_oStockTotalValueValue;
	
	LoadingView						*m_oLoadingView;
    
    UIViewController                *controller;
}

@property (nonatomic, retain) MHBEAIndexQuoteView               *m_oMHBEAIndexQuoteView;
@property (nonatomic, retain) MHBEABottomView                   *m_oMHBEABottomView;
@property (nonatomic, retain) UITableView						*m_oTableView;
@property (nonatomic, retain) UILabel							*m_oStockTotalValueLabel;
@property (nonatomic, retain) UIImageView						*m_oStockTotalBackground;
@property (nonatomic, retain) UILabel							*m_oStockTotalValueTitle;
@property (nonatomic, retain) UILabel							*m_oStockTotalValueValue;
@property (nonatomic, retain) LoadingView						*m_oLoadingView;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController *)aController;
- (void)reloadText;
- (void)dealloc;
- (void)clean;
- (void)displayStockTotalValueView:(BOOL)show;
- (void)updateStockTotalValueLabel:(double)aTotalValue;
- (void)updateLastUpdateTime:(NSString *)updateTime;
- (void)startLoading;
- (void)stopLoading;

@end