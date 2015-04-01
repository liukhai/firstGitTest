//
//  MHBEAWatchlistLv0ViewStockCell.h
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHFeedXObjQuote;
@class MHBEAWatchlistLv0ViewStockCell;

@protocol MHBEAWatchlistLv0ViewStockCellDelegate
- (void)inputPriceTextFieldShouldBeginEditing:(UITextField *)aTextField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
- (void)qtyTextFieldShouldBeginEditing:(UITextField *)aTextField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;

- (BOOL)inputPriceTextFieldShouldReturn:(UITextField *)aTextField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
- (void)inputPriceTextFieldDidEndEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;

- (BOOL)qtyTextFieldShouldReturn:(UITextField *)aTextField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
- (void)qtyTextFieldDidEndEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
@end

@interface MHBEAWatchlistLv0ViewStockCell : UITableViewCell <UITextFieldDelegate> {

	UILabel				*m_oSymbolLabel;
	UILabel				*m_oDesp;
	
	UILabel				*m_oBidLabel;
	UILabel				*m_oLastLabel;
	UILabel				*m_oAskLabel;
	
	UILabel				*m_oChangedLabel;
	UILabel				*m_oPChangeLabel;
	UILabel				*m_oGainLossLabel;
	UILabel				*m_oPGainLossLabel;
	
	UIButton			*m_oGainLossButton;
	
	UIView				*m_oInputView;
	UITextField			*m_oInputPriceTextField;
	UITextField			*m_oQtyTextField;
	
	BOOL				m_isShowingInputView;
	BOOL				m_isShowingGainLoss;
	
	UIImageView			*m_oHighLowBackground;
	UIImageView			*m_oArrowImageView;
	
	MHFeedXObjQuote									*m_oQuote;
	id<MHBEAWatchlistLv0ViewStockCellDelegate>		m_idDelegate;
}

@property (nonatomic, retain) UILabel				*m_oSymbolLabel;
@property (nonatomic, retain) UILabel				*m_oDesp;
@property (nonatomic, retain) UILabel				*m_oBidLabel;
@property (nonatomic, retain) UILabel				*m_oLastLabel;
@property (nonatomic, retain) UILabel				*m_oAskLabel;
@property (nonatomic, retain) UILabel				*m_oChangedLabel;
@property (nonatomic, retain) UILabel				*m_oPChangeLabel;
@property (nonatomic, retain) UILabel				*m_oGainLossLabel;
@property (nonatomic, retain) UILabel				*m_oPGainLossLabel;
@property (nonatomic, retain) UIButton				*m_oGainLossButton;

@property (nonatomic, retain) UITextField			*m_oInputPriceTextField;
@property (nonatomic, retain) UITextField			*m_oQtyTextField;

@property (nonatomic, retain) UIImageView			*m_oHighLowBackground;

+ (CGFloat)getHeightHeader;
+ (UIView *)getHeaderViewInput;
+ (UIView *)getHeaderViewChange:(BOOL)isChange;
+ (CGFloat)getHeight;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)dealloc;
- (void)reloadText;
- (void)clean;
- (void)updateColor;
- (void)updateWithMHFeedXObjQuote:(MHFeedXObjQuote *)aQuote;

- (void)displayGainLossLabel:(BOOL)show;
- (void)displayInputView;
- (void)displayChangeView;
- (void)toggleInputView;

// Setter
- (void)setM_idDelegate:(id<MHBEAWatchlistLv0ViewStockCellDelegate>)aDelegate;

// TextField Delegate functions
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;

- (void)setGainLoss:(double)aGainLoss pGainLoss:(double)aPGainLoss;

@end