//
//  MHBEAWatchlistLv0ViewStockSearchCell.m
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAWatchlistLv0ViewStockSearchCell.h"
#import "MHFeedXObjQuote.h"
#import "MHBEAStyleConstant.h"
#import "MHLanguage.h"


@implementation MHBEAWatchlistLv0ViewStockSearchCell

@synthesize m_oAddButton;

// 44 height
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
		m_isShowingInputView = NO;
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
//		UIImageView *bgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//		bgV.image = MHBEAWatchlistLv0ViewStockCell_background_image;
//		[self addSubview:bgV];
//		[bgV release];
		
		
		// Symbol Label
		m_oSymbolLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 30)];
		[m_oSymbolLabel setTextColor:WFWatchlistRootViewStockSearchCell_m_oSymbolLabel_text_color];
		[m_oSymbolLabel setBackgroundColor:[UIColor clearColor]];
		[m_oSymbolLabel setTextAlignment:NSTextAlignmentRight];
		[self addSubview:m_oSymbolLabel];
		[m_oSymbolLabel release];
		
		// Desp Label
		m_oDespLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, 190, 30)];
		[m_oDespLabel setTextColor:WFWatchlistRootViewStockSearchCell_m_oDespLabel_text_color];
		[m_oDespLabel setBackgroundColor:[UIColor clearColor]];
		[m_oDespLabel setTextAlignment:NSTextAlignmentLeft];
		[self addSubview:m_oDespLabel];
		[m_oDespLabel release];
		
		// Add button
		// m_oAddButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		m_oAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oAddButton setBackgroundImage:[UIImage imageNamed:@"bea_watchlist_btn_add.png"] forState:UIControlStateNormal];
		[m_oAddButton setFrame:CGRectMake(280, 5, 25, 25)];
		[self addSubview:m_oAddButton];
		
		// Single Line String Label , for display no search result
		m_oSingleLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
		[m_oSingleLineLabel setTextColor:WFWatchlistRootViewStockSearchCell_m_oSymbolLabel_text_color];
		[m_oSingleLineLabel setBackgroundColor:[UIColor clearColor]];
		[m_oSingleLineLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:m_oSingleLineLabel];
		[m_oSingleLineLabel release];
		
    }
    return self;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Update functsion
- (void)updateWithMHFeedXObjQuote:(MHFeedXObjQuote *)aQuote {
	m_oSymbolLabel.text		= aQuote.m_sSymbol;
	m_oDespLabel.text		= aQuote.m_sDesp;
	
	[m_oSingleLineLabel setHidden:YES];
	[m_oSymbolLabel setHidden:NO];
	[m_oDespLabel setHidden:NO];
	[m_oAddButton setHidden:NO];	
}

- (void)updateWithSingleString:(NSString *)aString {
	m_oSingleLineLabel.text = aString;

	[m_oSingleLineLabel setHidden:NO];
	[m_oSymbolLabel setHidden:YES];
	[m_oDespLabel setHidden:YES];
	[m_oAddButton setHidden:YES];
}

@end
