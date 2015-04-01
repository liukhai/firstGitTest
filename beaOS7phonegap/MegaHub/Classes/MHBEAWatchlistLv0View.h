//
//  MHBEAWatchlistLv0View.h
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

@interface MHBEAWatchlistLv0View : UIView {
    MHBEAIndexQuoteView             *m_oMHBEAIndexQuoteView;
    MHBEABottomView                 *m_oMHBEABottomView;
    MHDisclaimerBarView             *m_oMHDisclaimerBarView;
    
    UIImageView						*m_oSearchImageView;
    UITextField                     *m_oTextField;
    UIButton                        *m_oSearchButton;
    
	UITableView						*m_oTableView;
	UIButton						*m_oHideSearchKeyBoardButton;
    
    UIButton						*m_oBackButton;	// back to stock watchlist button
	UIButton						*m_oEditButton;
	UIButton						*m_oReloadButton;
	UIButton						*m_oReorderButton;
	
	UIView							*m_oStockTotalValueView;
	UIImageView						*m_oStockTotalBackground;
	UILabel							*m_oStockTotalValueTitle;
	UILabel							*m_oStockTotalValueValue;
	
	LoadingView						*m_oLoadingView;
    
    UIViewController                *controller;
}

@property (nonatomic, retain) MHBEAIndexQuoteView               *m_oMHBEAIndexQuoteView;
@property (nonatomic, retain) UITextField						*m_oTextField;
@property (nonatomic, retain) UIButton                          *m_oSearchButton;
@property (nonatomic, retain) UITableView						*m_oTableView;
@property (nonatomic, retain) UIButton							*m_oHideSearchKeyBoardButton;
@property (nonatomic, retain) UIView							*m_oStockTotalValueView;
@property (nonatomic, retain) UIImageView						*m_oStockTotalBackground;
@property (nonatomic, retain) UILabel							*m_oStockTotalValueTitle;
@property (nonatomic, retain) UILabel							*m_oStockTotalValueValue;
@property (nonatomic, retain) LoadingView						*m_oLoadingView;
@property (nonatomic, retain) UIButton							*m_oBackButton;
@property (nonatomic, retain) UIButton							*m_oEditButton;
@property (nonatomic, retain) UIButton							*m_oReloadButton;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController *)aController;
- (void)reloadText;
- (void)dealloc;
- (void)setHiddenIndexQuoteView:(BOOL)isHidden;
- (void)clean;
- (void)displayStockTotalValueView:(BOOL)show;
- (void)displayBackButton:(BOOL)show;
- (void)updateStockTotalValueLabel:(double)aTotalValue;
- (void)updateLastUpdateTime:(NSString *)updateTime;
- (void)onHideSearchKeyBoardButtonPressed:(id)sender;
- (void)startLoading;
- (void)stopLoading;

@end