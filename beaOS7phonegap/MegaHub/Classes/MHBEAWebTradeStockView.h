//
//  MHBEAWebTradeStockView.h
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

@interface MHBEAWebTradeStockView : UIView {
    MHBEAIndexQuoteView             *m_oMHBEAIndexQuoteView;
    MHBEABottomView                 *m_oMHBEABottomView;
    MHDisclaimerBarView             *m_oMHDisclaimerBarView;
	
	LoadingView						*m_oLoadingView;
    
    UIViewController                *controller;
}

@property (nonatomic, retain) MHBEAIndexQuoteView               *m_oMHBEAIndexQuoteView;
@property (nonatomic, retain) MHBEABottomView                   *m_oMHBEABottomView;
@property (nonatomic, retain) LoadingView						*m_oLoadingView;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController *)aController;
- (void)reloadText;
- (void)dealloc;
- (void)clean;
- (void)updateLastUpdateTime:(NSString *)updateTime;
- (void)startLoading;
- (void)stopLoading;

@end