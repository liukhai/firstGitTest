//
//  MHBEAWatchlistLv0ViewStockSearchCell.h
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHFeedXObjQuote;

@interface MHBEAWatchlistLv0ViewStockSearchCell : UITableViewCell {

	UILabel			*m_oSymbolLabel;
	UILabel			*m_oDespLabel;
	UIButton		*m_oAddButton;
	UILabel			*m_oSingleLineLabel;
	
	BOOL			m_isShowingInputView;
}

@property (nonatomic, retain) UIButton		*m_oAddButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
- (void)dealloc ;


- (void)updateWithMHFeedXObjQuote:(MHFeedXObjQuote *)aQuote;
- (void)updateWithSingleString:(NSString *)aString ;

@end
