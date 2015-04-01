//
//  MHBEAWatchlistLv0ViewStockCell.m
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAWatchlistLv0ViewStockCell.h"
#import "MHNumberKeyboardView.h"
#import "MHFeedXObjQuote.h"
#import "MHLanguage.h"
#import "StyleConstant.h"
#import "MHUtility.h"
#import "PTConstant.h"
#import "MHBEAConstant.h"
#import "MHBEAStyleConstant.h"

#define MHBEAWatchlistLv0ViewStockCell_height		50.0

@implementation MHBEAWatchlistLv0ViewStockCell

@synthesize m_oHighLowBackground;
@synthesize m_oSymbolLabel;
@synthesize m_oDesp;
@synthesize m_oBidLabel;
@synthesize m_oLastLabel;
@synthesize m_oAskLabel;
@synthesize m_oChangedLabel;
@synthesize m_oPChangeLabel;
@synthesize m_oGainLossLabel;
@synthesize m_oPGainLossLabel;
@synthesize m_oGainLossButton;

@synthesize m_oInputPriceTextField;
@synthesize m_oQtyTextField;


+ (CGFloat)getHeightHeader {
	return 20;
}

+ (UIView *)getHeaderViewInput {
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, MHBEAWatchlistLv0ViewStockCell_height/2)];
	headerView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
	
	UILabel *symbolDespLabel = nil;
	UILabel *buy_Label = nil;
	UILabel *cal_p_l_Label = nil;
    
	// Symbol
	symbolDespLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 150, 20)];
	[symbolDespLabel setTextColor:MHBEAWatchlistLv0ViewStockCell_header_text_color];
	[symbolDespLabel setBackgroundColor:[UIColor clearColor]];
	[symbolDespLabel setFont:[UIFont systemFontOfSize:13]];
	[headerView addSubview:symbolDespLabel];
	[symbolDespLabel release];
    
    symbolDespLabel.text = [NSString stringWithFormat:@"%@/%@",
							MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.symbolLabel", nil, MHLanguage_BEAString),
							MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.despLabel", nil, MHLanguage_BEAString)];
	
    // Buy
	buy_Label = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 80, 20)];
	[buy_Label setBackgroundColor:[UIColor clearColor]];
	[buy_Label setTextColor:MHBEAWatchlistLv0ViewStockCell_header_text_color];
	[buy_Label setTextAlignment:NSTextAlignmentRight];
	[buy_Label setFont:[UIFont systemFontOfSize:13]];
	[headerView addSubview:buy_Label];
	[buy_Label release];
	
	buy_Label.text = MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.buy_Label", nil, MHLanguage_BEAString);
	
    // Cal
    cal_p_l_Label = [[UILabel alloc] initWithFrame:CGRectMake(165, 0, 150, 20)];
	[cal_p_l_Label setBackgroundColor:[UIColor clearColor]];
	[cal_p_l_Label setTextColor:MHBEAWatchlistLv0ViewStockCell_header_text_color];
	[cal_p_l_Label setTextAlignment:NSTextAlignmentRight];
	[cal_p_l_Label setFont:[UIFont systemFontOfSize:13]];
	[headerView addSubview:cal_p_l_Label];
	[cal_p_l_Label release];
	
	cal_p_l_Label.text = MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.cal_p_l_Label", nil, MHLanguage_BEAString);
    
	return [headerView autorelease];
	
}

+ (UIView *)getHeaderViewChange:(BOOL)isChange {	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, MHBEAWatchlistLv0ViewStockCell_height/2)];
	headerView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
		
	UILabel *symbolDespLabel = nil;
	UILabel *lastLabel = nil;
	UILabel *changeLabel = nil;
	
	
	// Symbol
	symbolDespLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 150, 20)];
	[symbolDespLabel setTextColor:MHBEAWatchlistLv0ViewStockCell_header_text_color];
	[symbolDespLabel setBackgroundColor:[UIColor clearColor]];
	[symbolDespLabel setFont:[UIFont systemFontOfSize:13]];
	[headerView addSubview:symbolDespLabel];
	[symbolDespLabel release];
	
	
	// last
	lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 0, 80, 20)];
	[lastLabel setBackgroundColor:[UIColor clearColor]];
	[lastLabel setTextColor:MHBEAWatchlistLv0ViewStockCell_header_text_color];
	[lastLabel setTextAlignment:NSTextAlignmentRight];
	[lastLabel setFont:[UIFont systemFontOfSize:13]];
	[headerView addSubview:lastLabel];
	[lastLabel release];
	
	
	// m_oChangedLabel
	changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 0, 150, 20)];
	[changeLabel setBackgroundColor:[UIColor clearColor]];
	[changeLabel setTextColor:MHBEAWatchlistLv0ViewStockCell_header_text_color];
	[changeLabel setTextAlignment:NSTextAlignmentRight];
	[changeLabel setFont:[UIFont systemFontOfSize:13]];
	[headerView addSubview:changeLabel];
	[changeLabel release];
    
	
	symbolDespLabel.text = [NSString stringWithFormat:@"%@/%@", 
							MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.symbolLabel", nil, MHLanguage_BEAString),
							MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.despLabel", nil, MHLanguage_BEAString)];
	lastLabel.text = MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.lastLabel", nil, MHLanguage_BEAString);
	
	if (isChange) {
		changeLabel.text = [NSString stringWithFormat:@"%@ (%@)",
							MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.changeLabel", nil, MHLanguage_BEAString),
							MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.pChangeLabel", nil, MHLanguage_BEAString)];
	} else {
		changeLabel.text = [NSString stringWithFormat:@"%@ (%@)",
							MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.changeLabel.gainloss", nil, MHLanguage_BEAString),
							MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.pChangeLabel.pgainloss", nil, MHLanguage_BEAString)];
	}
	
	
	return [headerView autorelease];
}

+ (CGFloat)getHeight {
	return MHBEAWatchlistLv0ViewStockCell_height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		[self setEditingAccessoryType:UITableViewCellAccessoryNone];
		[self setEditingAccessoryView:nil];
		
		CGFloat col0_width = 120,
		col1_width = 80,
		col2_width = 60;
		
		CGFloat col0 = 13,
		col1 = col0_width + col0,
		col2 = col1_width + col1+20;
//		col3 = col2_width + col2+10;
		
		CGFloat row0 = 0,
		row1 = 25,
		row0_height = 25,
		row1_height = 25;
		
		// Backgound image of the cell
//		UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, MHBEAWatchlistLv0ViewStockCell_height)];
//		[bgView setImage:MHBEAWatchlistLv0ViewStockCell_background_image];
//		[self addSubview:bgView];
//		[bgView release];
		
		// background image of bid/Ask or change/Pchange
		m_oHighLowBackground = [[UIImageView alloc] initWithFrame:CGRectMake(col2-5, (44-28)/2, col2_width+15, 33)];
		[self addSubview:m_oHighLowBackground];
		[m_oHighLowBackground release];
		
		
		// Symbol
		m_oSymbolLabel = [[UILabel alloc] initWithFrame:CGRectMake(col0, row0, 190, row0_height)];
		[m_oSymbolLabel setTextColor:MHBEAWatchlistLv0ViewStockCell_m_oSymbolLabel_text_color];
		[m_oSymbolLabel setBackgroundColor:[UIColor clearColor]];
		[self addSubview:m_oSymbolLabel];
		[m_oSymbolLabel release];
		
		// Desp
		m_oDesp = [[UILabel alloc] initWithFrame:CGRectMake(col0, row1, 190, row1_height)];
		[m_oDesp setTextColor:MHBEAWatchlistLv0ViewStockCell_m_oDesp_text_color];
		[m_oDesp setBackgroundColor:[UIColor clearColor]];
		[m_oDesp setFont:[UIFont systemFontOfSize:13]];
		[m_oDesp setAdjustsFontSizeToFitWidth:YES];
		[m_oDesp setNumberOfLines:2];
		[self addSubview:m_oDesp];
		[m_oDesp release];
		
		// Bid
		//		m_oBidLabel = [[UILabel alloc] initWithFrame:CGRectMake(col1, 0, col1_width, 15)];
		//		[m_oBidLabel setBackgroundColor:[UIColor clearColor]];
		//		[m_oBidLabel setTextColor:[UIColor whiteColor]];
		//		[m_oBidLabel setTextAlignment:NSTextAlignmentRight];
		//		[m_oBidLabel setFont:[UIFont systemFontOfSize:12]];
		//		[self addSubview:m_oBidLabel];
		//		[m_oBidLabel release];
		
		// last
		m_oLastLabel = [[UILabel alloc] initWithFrame:CGRectMake(col1-15,
																 0,
																 col1_width+10,
																 self.frame.size.height)];
		[m_oLastLabel setBackgroundColor:[UIColor clearColor]];
		[m_oLastLabel setTextColor:MHBEAWatchlistLv0ViewStockCell_m_oLastLabel_text_color];
		[m_oLastLabel setTextAlignment:NSTextAlignmentRight];
		[m_oLastLabel setFont:[UIFont boldSystemFontOfSize:20]];
		[self addSubview:m_oLastLabel];
		[m_oLastLabel release];
		
		// Ask
		//		m_oAskLabel = [[UILabel alloc] initWithFrame:CGRectMake(col1, 30, col1_width, 15)];
		//		[m_oAskLabel setBackgroundColor:[UIColor clearColor]];
		//		[m_oAskLabel setTextColor:[UIColor whiteColor]];
		//		[m_oAskLabel setTextAlignment:NSTextAlignmentRight];
		//		[m_oAskLabel setFont:[UIFont systemFontOfSize:12]];
		//		[self addSubview:m_oAskLabel];
		//		[m_oAskLabel release];
		
		
		// m_oChangedLabel
		m_oChangedLabel = [[UILabel alloc] initWithFrame:CGRectMake(col2, 10, col2_width, 15)];
		[m_oChangedLabel setBackgroundColor:[UIColor clearColor]];
		[m_oChangedLabel setTextColor:MHBEA_color_bea_white];
		[m_oChangedLabel setTextAlignment:NSTextAlignmentRight];
		[m_oChangedLabel setFont:[UIFont systemFontOfSize:13]];
		[self addSubview:m_oChangedLabel];
		[m_oChangedLabel release];
		
		// m_oPChangeLabel
		m_oPChangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(col2, 25, col2_width, 15)];
		[m_oPChangeLabel setBackgroundColor:[UIColor clearColor]];
		[m_oPChangeLabel setTextColor:MHBEA_color_bea_white];
		[m_oPChangeLabel setTextAlignment:NSTextAlignmentRight];
		[m_oPChangeLabel setFont:[UIFont systemFontOfSize:12]];
		[self addSubview:m_oPChangeLabel];
		[m_oPChangeLabel release];
		
		
		// Gain and loss label
		m_oGainLossLabel = [[UILabel alloc] initWithFrame:m_oChangedLabel.frame];
		[m_oGainLossLabel setBackgroundColor:[UIColor clearColor]];
		[m_oGainLossLabel setTextColor:[UIColor whiteColor]];
		[m_oGainLossLabel setTextAlignment:NSTextAlignmentRight];
		[m_oGainLossLabel setFont:[UIFont systemFontOfSize:13]];
		[m_oGainLossLabel setHidden:YES];
		[self addSubview:m_oGainLossLabel];
		[m_oGainLossLabel release];
		
		// m_oPChangeLabel
		m_oPGainLossLabel = [[UILabel alloc] initWithFrame:m_oPChangeLabel.frame];
		[m_oPGainLossLabel setBackgroundColor:[UIColor clearColor]];
		[m_oPGainLossLabel setTextColor:[UIColor whiteColor]];
		[m_oPGainLossLabel setTextAlignment:NSTextAlignmentRight];
		[m_oPGainLossLabel setFont:[UIFont systemFontOfSize:11]];
		[m_oPGainLossLabel setHidden:YES];
		[self addSubview:m_oPGainLossLabel];
		[m_oPGainLossLabel release];
		
		// change to gain&loss or change&change% button
		m_oGainLossButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oGainLossButton setFrame:CGRectMake(col2, 0, col2_width, MHBEAWatchlistLv0ViewStockCell_height)];
		[self addSubview:m_oGainLossButton];
		
		//----------------------------------------
		m_isShowingInputView = NO;
		m_oInputView = [[UIView alloc] initWithFrame:CGRectMake(col1+30, 0, 125, MHBEAWatchlistLv0ViewStockCell_height)];
		[m_oInputView setBackgroundColor:[UIColor clearColor]];
		[m_oInputView setHidden:YES];
		[self addSubview:m_oInputView];
		[m_oInputView release];
		
		m_oInputPriceTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 15, 70, 25)];
		[m_oInputPriceTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [m_oInputPriceTextField setTextAlignment:NSTextAlignmentCenter];
		[m_oInputPriceTextField setFont:[UIFont systemFontOfSize:12]];
		[m_oInputView addSubview:m_oInputPriceTextField];
		[m_oInputPriceTextField setDelegate:self];
		[m_oInputPriceTextField release];
		
		m_oQtyTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 15, 75, 25)];
		[m_oQtyTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [m_oQtyTextField setTextAlignment:NSTextAlignmentCenter];
		[m_oQtyTextField setFont:[UIFont systemFontOfSize:12]];
		[m_oInputView addSubview:m_oQtyTextField];
		[m_oQtyTextField setDelegate:self];
		[m_oQtyTextField release];
		
		
		[self reloadText];
    }
    return self;
}


- (void)dealloc {
	[m_oQuote release];
    [super dealloc];
}

- (void)reloadText {
	m_oInputPriceTextField.placeholder		= MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.m_oInputPriceTextField.placeholder", nil, MHLanguage_BEAString);
	m_oQtyTextField.placeholder				= MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewStockCell.m_oQtyTextField.placeholder", nil, MHLanguage_BEAString);
}

- (void)clean {
	m_oSymbolLabel.text		= @"";
	m_oDesp.text			= @"";
	m_oBidLabel.text		= @"";
	m_oLastLabel.text		= @"";
	m_oAskLabel.text		= @"";
	m_oChangedLabel.text	= @"";
	m_oPChangeLabel.text	= @"";
}

- (void)updateColor {
	double change = m_isShowingGainLoss?[m_oGainLossLabel.text doubleValue]:[m_oChangedLabel.text doubleValue];
	
	if ( change == 0) {
		[m_oHighLowBackground setImage:MHBEAWatchlistLv0ViewStockCell_bid_ask_background_image_leveloff];
		m_oArrowImageView.image = nil;
		[m_oLastLabel setTextColor:MHIndexBarView_m_oChangeLabel_text_color_leveloff];
	} else if (change < 0) {
		[m_oHighLowBackground setImage:MHBEAWatchlistLv0ViewStockCell_bid_ask_background_image_down];	
		m_oArrowImageView.image = MHBEAWatchlistLv0ViewStockCell_m_oArrowImageView_down;
		[m_oLastLabel setTextColor:MHIndexBarView_m_oChangeLabel_text_color_down];
	} else if (change > 0) {
		[m_oHighLowBackground setImage:MHBEAWatchlistLv0ViewStockCell_bid_ask_background_image_up];	
		m_oArrowImageView.image	= MHBEAWatchlistLv0ViewStockCell_m_oArrowImageView_up;
		[m_oLastLabel setTextColor:MHIndexBarView_m_oChangeLabel_text_color_up];
	}
}

- (void)updateWithMHFeedXObjQuote:(MHFeedXObjQuote *)aQuote {
	if (m_oQuote) {
		[m_oQuote release];
		m_oQuote = nil;
	}
	m_oQuote = [aQuote retain];
	
	m_oSymbolLabel.text		= aQuote.m_sSymbol;
	m_oDesp.text			= aQuote.m_sDesp;
	m_oBidLabel.text		= [MHUtility doublePriceToString:[aQuote.m_sBid doubleValue] market:MARKET_HONGKONG];
	m_oLastLabel.text		= [MHUtility doublePriceToString:[aQuote.m_sLast doubleValue] market:MARKET_HONGKONG];
	m_oAskLabel.text		= [MHUtility doublePriceToString:[aQuote.m_sAsk doubleValue] market:MARKET_HONGKONG];
    
    if([aQuote.m_sPrevClose floatValue] > 0){
        m_oChangedLabel.text= [MHUtility floatPriceChangeToString:[aQuote.m_sChange floatValue] market:MARKET_HONGKONG];
        m_oPChangeLabel.text= [MHUtility floatPricePencentageChangeToString:[aQuote.m_sPctChange floatValue] market:MARKET_HONGKONG];
    }else{
        m_oChangedLabel.text= @"";
        m_oPChangeLabel.text= @"(%)";
    }
	
	[self updateColor];
}

- (void)displayGainLossLabel:(BOOL)show {
	m_isShowingGainLoss = show;
	
	if (m_isShowingInputView) {
		m_oChangedLabel.hidden = YES;
		m_oPChangeLabel.hidden = YES;
		m_oGainLossLabel.hidden = YES;
		m_oPGainLossLabel.hidden = YES;
		m_oArrowImageView.hidden = YES;
	} else {
		m_oChangedLabel.hidden = show;
		m_oPChangeLabel.hidden = show;
		m_oArrowImageView.hidden = NO;//show;		
		m_oGainLossLabel.hidden = !show;
		m_oPGainLossLabel.hidden = !show;
	}
	
	[self updateColor];
}


- (void)displayInputView {
	m_isShowingInputView = YES;
	
	m_oBidLabel.hidden = YES;
	m_oLastLabel.hidden = YES;
	m_oAskLabel.hidden = YES;
	m_oChangedLabel.hidden = YES;
	m_oPChangeLabel.hidden = YES;
	m_oGainLossLabel.hidden = YES;
	m_oPGainLossLabel.hidden = YES;
	m_oGainLossButton.hidden = YES;
	m_oHighLowBackground.hidden = YES;
	m_oArrowImageView.hidden = YES;
	
	m_oInputView.hidden = NO;
	
}

- (void)displayChangeView {
	m_isShowingInputView = NO;
	m_isShowingGainLoss = NO;
	
	m_oBidLabel.hidden = NO;
	m_oLastLabel.hidden = NO;
	m_oAskLabel.hidden = NO;
	m_oChangedLabel.hidden = NO;
	m_oPChangeLabel.hidden = NO;
	m_oGainLossLabel.hidden = NO;
	m_oPGainLossLabel.hidden = NO;
	m_oGainLossButton.hidden = NO;
	m_oHighLowBackground.hidden = NO;
	m_oArrowImageView.hidden = NO;
	
	m_oInputView.hidden = YES;
	
	[self updateColor];
}

- (void)toggleInputView {
	m_isShowingInputView = !m_isShowingInputView;
	if(m_isShowingInputView){
		[self displayInputView];
	}else {
		[self displayChangeView];		
	}
}




#pragma mark -
#pragma mark TextField delegate functions
- (void)setM_idDelegate:(id<MHBEAWatchlistLv0ViewStockCellDelegate>)aDelegate {
	m_idDelegate = aDelegate;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if ([textField isEqual:m_oInputPriceTextField]) {
		[textField resignFirstResponder];
		[MHNumberKeyboardView setDecimalPlace:3];		
		if ([(NSObject *)m_idDelegate respondsToSelector:@selector(inputPriceTextFieldShouldBeginEditing:cell:)]) {
			[m_idDelegate inputPriceTextFieldShouldBeginEditing:m_oInputPriceTextField cell:self];
		}		
		
		return [MHNumberKeyboardView show:textField];		
		
	} else if ([textField isEqual:m_oQtyTextField]) {
		[textField resignFirstResponder];
		[MHNumberKeyboardView setDecimalPlace:0];
		if ([(NSObject *)m_idDelegate respondsToSelector:@selector(qtyTextFieldShouldBeginEditing:cell:)]) {
			[m_idDelegate qtyTextFieldShouldBeginEditing:m_oQtyTextField cell:self];
		}				
		
		return [MHNumberKeyboardView show:textField];		
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	
	if ([textField isEqual:m_oInputPriceTextField]) {
		if ([(NSObject *)m_idDelegate respondsToSelector:@selector(inputPriceTextFieldShouldReturn:cell:)]) {
			[m_idDelegate inputPriceTextFieldShouldReturn:m_oInputPriceTextField cell:self];
		}
		
	} else if ([textField isEqual:m_oQtyTextField]) {
		if ([(NSObject *)m_idDelegate respondsToSelector:@selector(qtyTextFieldShouldReturn:cell:)]) {
			[m_idDelegate qtyTextFieldShouldReturn:m_oQtyTextField cell:self];
		}
		
	}
	
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[textField resignFirstResponder];
	
	if ([textField isEqual:m_oInputPriceTextField]) {
		if ([(NSObject *)m_idDelegate respondsToSelector:@selector(inputPriceTextFieldDidEndEditing:cell:)]) {
			[m_idDelegate inputPriceTextFieldDidEndEditing:m_oInputPriceTextField cell:self];
		}
	} else if ([textField isEqual:m_oQtyTextField]) {
		if ([(NSObject *)m_idDelegate respondsToSelector:@selector(qtyTextFieldDidEndEditing:cell:)]) {
			[m_idDelegate qtyTextFieldDidEndEditing:m_oQtyTextField cell:self];
		}
	}	
}

- (void)setGainLoss:(double)aGainLoss pGainLoss:(double)aPGainLoss {
	m_oGainLossLabel.text = [MHUtility floatPriceChangeToString:aGainLoss market:MARKET_HONGKONG];
	m_oPGainLossLabel.text = [MHUtility floatPricePencentageChangeToString:aPGainLoss market:MARKET_HONGKONG];
	[self updateColor];
}

@end