//
//  MHBEABottomView.h
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

@interface MHBEABottomView : UIView <ASIHTTPRequestDelegate>{
    UIButton            *m_oBuyButton;
	UIButton            *m_oQuoteButton;
    UIButton            *m_oNewsButton;
    UIButton            *m_oStockButton;
    UIButton            *m_oSellButton;
    
    BOOL                isNewsView;
    BOOL                isQuoteView;
    BOOL                isGoToBuyView;
}

@property(nonatomic, retain) UIButton            *m_oBuyButton;
@property(nonatomic, retain) UIButton            *m_oQuoteButton;
@property(nonatomic, retain) UIButton            *m_oNewsButton;
@property(nonatomic, retain) UIButton            *m_oStockButton;
@property(nonatomic, retain) UIButton            *m_oSellButton;

- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;
- (void)reloadText;
- (void)setSelectedIndex:(int)index;
- (void)setShowFiveButtons:(BOOL)isSHowFiveButtons;
- (void)onQuoteButtonPressed;
- (void)onNewsButtonPressed;
- (void)onStockButtonPressed;
- (void)onBuyButtonPressed;
- (void)onSellButtonPressed;

@end