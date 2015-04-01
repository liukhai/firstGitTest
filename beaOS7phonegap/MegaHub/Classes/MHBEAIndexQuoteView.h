//
//  MHBEAIndexQuoteView.h
//  BEA
//
//  Created by MegaHub on 09/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHUILabel;
@class MHFeedXObjQuote;
@class ObjStockQuote;
@class ObjStockInfo;
@class MHFeedXMsgInGetLiteQuote;

@interface MHBEAIndexQuoteView : UIView <UITextFieldDelegate> {
	UILabel             *m_oIndexDespLabel;
	UILabel             *m_oIndexNomialLabel;
	UILabel             *m_oIndexChangeLabel;
	UILabel             *m_oIndexPChangeLabel;
	
	MHUILabel           *m_oStockPriceLabel;
	MHUILabel           *m_oStockChangeLabel;
	MHUILabel           *m_oStockChangePercentageLabel;
    UILabel             *m_oStockChangeImageLabel;
	
	UITextField         *m_oSymbolTextField;
	UIButton            *m_oQuoteButton;
	UIButton            *m_oAddButton;
    
    UIViewController    *m_oController;
    
    unsigned int        m_uiMsgIDStockInfo;
    unsigned int        m_uiMsgIDIndex;
    
    BOOL                isAddedWatchlist;
    
    CGRect              changeDefaultFrame;
    CGRect              percentChangeDefaultFrame;

}

@property(nonatomic, retain) UILabel			*m_oIndexDespLabel;
@property(nonatomic, retain) UILabel			*m_oIndexNomialLabel;
@property(nonatomic, retain) UILabel			*m_oIndexChangeLabel;
@property(nonatomic, retain) UILabel			*m_oIndexPChangeLabel;
@property(nonatomic, retain) MHUILabel			*m_oStockPriceLabel;
@property(nonatomic, retain) MHUILabel			*m_oStockChangeLabel;
@property(nonatomic, retain) MHUILabel			*m_oStockChangePercentageLabel;
@property(nonatomic, retain) UILabel            *m_oStockChangeImageLabel;
@property(nonatomic, retain) UITextField		*m_oSymbolTextField;
@property(nonatomic, retain) UIButton			*m_oQuoteButton;
@property(nonatomic, retain) UIButton			*m_oAddButton;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController*)aController;
- (void)dealloc;
- (void)reloadText;
- (void)cleanIndex;
- (void)cleanStock;
- (void)displayInvalidStock;
- (void)syncStockCode;
- (void)onQuoteButtonPressed:(id)sender;
- (void)onAddButtonPressed:(id)sender;
- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)msg;
- (void)onMHFeedXMsgInGetLiteQuote:(NSNotification *)n;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end