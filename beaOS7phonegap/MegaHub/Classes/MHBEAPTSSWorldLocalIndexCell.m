//
//  PTWorldLocalIndexm
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHBEAPTSSWorldLocalIndexCell.h"
#import "StyleConstant.h"
#import "MHFeedXObjQuote.h"
#import "MHUtility.h"

@implementation MHBEAPTSSWorldLocalIndexCell

@synthesize m_oLabel_HSIName;
@synthesize m_oLabel_Nominal;
@synthesize m_oLabel_Change;
@synthesize m_oLabel_PChange;
@synthesize m_oGraphView;
@synthesize m_oAccessoryButton;

+ (CGFloat)getHeight {
	return 60;
}

+ (CGFloat)getHeightWithGraphic {
	return 190;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		[self setBackgroundColor:	[UIColor	clearColor]];
		
		m_oLabel_HSIName = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 152, 60)];
		m_oLabel_HSIName.textColor			= PTWorldLocalIndexCell_m_oLabel_HSIName_textColor;
		m_oLabel_HSIName.font				= PTWorldLocalIndexCell_m_oLabel_HSIName_font;
		m_oLabel_HSIName.backgroundColor	= [UIColor clearColor];
        m_oLabel_HSIName.numberOfLines      = 2;
		m_oLabel_HSIName.adjustsFontSizeToFitWidth	 = YES;
		m_oLabel_HSIName.tag				= 10;
		
		m_oLabel_Nominal = [[UILabel alloc] initWithFrame:CGRectMake(154, 2, 80, 60)];
		m_oLabel_Nominal.textColor			= PTWorldLocalIndexCell_m_oLabel_Nominal_textColor;
		m_oLabel_Nominal.font				= PTWorldLocalIndexCell_m_oLabel_Nominal_font;
		m_oLabel_Nominal.backgroundColor	= [UIColor clearColor];
		m_oLabel_Nominal.textAlignment		= NSTextAlignmentRight;
		m_oLabel_Nominal.tag				= 20;
		
		m_oLabel_Change = [[UILabel alloc] initWithFrame:CGRectMake(234, 5, 80, 25)];
		m_oLabel_Change.textColor			= PTWorldLocalIndexCell_m_oLabel_Change_textColor;
		m_oLabel_Change.font				= PTWorldLocalIndexCell_m_oLabel_Change_font;
		m_oLabel_Change.backgroundColor		= [UIColor clearColor];
        m_oLabel_Change.textAlignment		= NSTextAlignmentRight;
		m_oLabel_Change.tag					= 30;
		
		m_oLabel_PChange = [[UILabel alloc] initWithFrame:CGRectMake(234, 30, 80, 25)];
		m_oLabel_PChange.textColor			= PTWorldLocalIndexCell_m_oLabel_PChange_textColor;
		m_oLabel_PChange.font				= PTWorldLocalIndexCell_m_oLabel_PChange_font;
		m_oLabel_PChange.backgroundColor	= [UIColor clearColor];
		m_oLabel_PChange.textAlignment		= NSTextAlignmentRight;
		m_oLabel_PChange.tag				= 40;
		
		m_oGraphView						= [[UIImageView alloc] initWithFrame:CGRectMake(10, 65, 300, 120)];
		m_oGraphView.backgroundColor		= [UIColor clearColor];
		m_oGraphView.hidden					= YES;
		
		// Accessory button
		UIImage *btnImageUnpressed			= PTWorldLocalIndexCell_m_oAccessoryButton_unpressedImage;
		UIImage *btnImagePressed			= PTWorldLocalIndexCell_m_oAccessoryButton_pressedImage;
		m_oAccessoryButton					= [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oAccessoryButton setFrame:CGRectMake(self.frame.size.width-30-5, (60-30)/2, 30, 30)];
		[m_oAccessoryButton setImage:btnImageUnpressed forState:UIControlStateNormal];
		[m_oAccessoryButton setImage:btnImagePressed forState:UIControlStateSelected];
		[self addSubview:m_oAccessoryButton];
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		[self addSubview:m_oLabel_HSIName];
		[self addSubview:m_oLabel_Nominal];
		[self addSubview:m_oLabel_Change ];
		[self addSubview:m_oLabel_PChange];
		[self addSubview:m_oGraphView];
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
	[m_oLabel_HSIName	release];
	[m_oLabel_Nominal	release];
	[m_oLabel_Change	release];
	[m_oLabel_PChange	release];
	[m_oGraphView		release];
    [super dealloc];
}

// Override
- (void)setAccessoryType:(UITableViewCellAccessoryType)aType {
	if (aType == UITableViewCellAccessoryNone) {
		m_oAccessoryButton.hidden = YES;
	} else {
		m_oAccessoryButton.hidden = NO;
        
        m_oLabel_HSIName.frame  = CGRectMake(2, 2, 135, 60);
        m_oLabel_Nominal.frame  = CGRectMake(137, 2, 80, 60);
        m_oLabel_Change.frame   = CGRectMake(217, 5, 68, 25);
        m_oLabel_PChange.frame	= CGRectMake(217, 30, 68, 25);
        m_oGraphView.frame		= CGRectMake(10, 65, 300, 120);
        
	}

}

- (void)updateWithMHFeedXObjQuote:(MHFeedXObjQuote *)aQuote {
    
	m_oLabel_HSIName.text	= aQuote.m_sDesp;
	m_oLabel_Nominal.text	= [MHUtility removeComma: ([aQuote.m_sLast floatValue]>=0)?[MHUtility floatPriceToString:[aQuote.m_sLast floatValue] market:MARKET_HONGKONG]:@""];
	m_oLabel_Change.text	= [MHUtility floatPriceChangeToString:[aQuote.m_sChange floatValue] market:MARKET_HONGKONG];
	m_oLabel_PChange.text	= [MHUtility floatPricePencentageChangeToString:[aQuote.m_sPctChange floatValue] market:MARKET_HONGKONG];
    
	if ([aQuote.m_sChange doubleValue] > 0.0f) {
		m_oLabel_Change.textColor	= Default_label_text_color_up;			
		m_oLabel_PChange.textColor	= Default_label_text_color_up;		
		
	} else if ([aQuote.m_sChange doubleValue] < 0.0f){
		m_oLabel_Change.textColor	= Default_label_text_color_down;			
		m_oLabel_PChange.textColor	= Default_label_text_color_down;						
	} else {
		m_oLabel_Change.textColor	= Default_label_text_color_leveloff;			
		m_oLabel_PChange.textColor	= Default_label_text_color_leveloff;						
	}
}

@end