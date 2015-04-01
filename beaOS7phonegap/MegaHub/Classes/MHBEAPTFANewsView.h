//
//  MHBEAPTFANewsView.h
//  BEA
//
//  Created by hong on 10/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHPickerTextField;

@interface MHBEAPTFANewsView : UIView {
	UIImageView				*m_oSearchBarBg;
	MHPickerTextField		*m_oNewsGroupTextField;
	UITextField				*m_oStockSymbolTextField;
	UIButton				*m_oSearchButton;
	UIWebView				*m_oWebView;
}

@property (nonatomic, retain) MHPickerTextField		*m_oNewsGroupTextField;
@property (nonatomic, retain) UITextField			*m_oStockSymbolTextField;
@property (nonatomic, retain) UIButton				*m_oSearchButton;
@property (nonatomic, retain) UIWebView				*m_oWebView;

- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;
- (void)reloadText;
- (void)loadURLString:(NSString *)aURLString;

@end