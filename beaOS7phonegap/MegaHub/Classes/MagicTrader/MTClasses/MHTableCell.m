//
//  MHTableCell.m
//  MagicTrader
//
//  Created by Megahub on 14/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHTableCell.h"
#import "MHUILabel.h"
#import "MHLanguage.h"
#import "MHUtility.h"
//#import "MHStreamerStock.h"

#import "StyleConstant.h"
#import "PTConstant.h"
#import "MHFeedXObjQuote.h"

#import <QuartzCore/QuartzCore.h>

@implementation MHTableCell
@synthesize m_isDetailMode;
@synthesize m_oDescriptionLabel;
@synthesize m_oSymbolLabel;
@synthesize m_oFlashView;
@synthesize m_oPriceLabel;
@synthesize m_oTapButton;
@synthesize m_oChangeLabel;
@synthesize m_oBidAskLabel;
@synthesize m_oVolumeLabel;
@synthesize m_oTurnoverLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		m_oFlashView				= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
		m_oFlashView.backgroundColor = [UIColor clearColor];
		[self addSubview:m_oFlashView];
		
		m_isDetailMode				= YES;
		self.backgroundColor		= Default_view_background_color;
		m_oSymbolLabel				= [[MHUILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
		m_oDescriptionLabel			= [[MHUILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
		m_oPriceLabel				= [[MHUILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
		m_oChangeLabel				= [[MHUILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
		m_oChangeLabel.textAlignment = NSTextAlignmentRight;
		m_oBidAskLabel				= [[MHUILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
		m_oVolumeLabel				= [[MHUILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];	
		m_oTurnoverLabel			= [[MHUILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
		m_oTurnoverLabel.textAlignment = NSTextAlignmentRight;
		m_oTapButton				= [UIButton buttonWithType:UIButtonTypeCustom];
		NSArray *m_aLotOfLabel = [[NSArray alloc] initWithObjects:m_oSymbolLabel,
																m_oDescriptionLabel, 
																m_oPriceLabel, 
																m_oChangeLabel, 
																m_oBidAskLabel, 
																m_oVolumeLabel, 
																m_oTurnoverLabel, nil];
		for (int i = 0; i < [m_aLotOfLabel count]; i++) {
			MHUILabel *aLabel = [m_aLotOfLabel objectAtIndex:i];
			aLabel.font  = MHTableCell_label_font;
			[aLabel setTextColor:[UIColor whiteColor]];
			[self addSubview:aLabel];
		}
		m_oSymbolLabel.textColor		= MHTableCell_m_oSymbolLabel_textColor;
		m_oDescriptionLabel.textColor	= MHTableCell_m_oDescriptionLabel_textColor;
		m_oTurnoverLabel.textColor		= MHTableCell_m_oTurnoverLabel_textColor;
		m_oVolumeLabel.textColor		= MHTableCell_m_oVolumeLabel_textColor;
		m_oBidAskLabel.textColor		= MHTableCell_m_oBidAskLabel_textColor;
		[m_aLotOfLabel release];
		[self addSubview:m_oTapButton];
    }
    return self;
}

- (void)dealloc {
    [m_oDescriptionLabel release];
    [m_oSymbolLabel release];
    [m_oFlashView release];
    [m_oPriceLabel release];
    [m_oChangeLabel release];
    [m_oBidAskLabel release];
    [m_oVolumeLabel release];
    [m_oTurnoverLabel release];
    [super dealloc];
}

+(CGFloat)getHeaderHeight:(BOOL)aIsDetail{
	CGFloat theHeight;
	if(aIsDetail){
		theHeight = 39;
	}else {
		theHeight = 39/2;
	}
	return theHeight;
}

+(CGFloat)getCellHeight:(BOOL)aIsDetail{
	CGFloat theHeight;
	if(aIsDetail){
		theHeight = 64;
	}else {
		theHeight = 44;
	}
	return theHeight;
}

-(void)displayHeader:(BOOL)isDetail{
	m_oSymbolLabel.frame			= CGRectMake(8, 0, 57, 21);
	m_oDescriptionLabel.frame		= CGRectMake(70, 0, 230, 21);
	m_oPriceLabel.frame				= CGRectMake(8, 21, 76, 21);
	m_oChangeLabel.frame			= CGRectMake(150, 21, 320-150-3, 21);
	m_oBidAskLabel.frame			= CGRectMake(8, 42, 150, 21);
	m_oVolumeLabel.frame			= CGRectMake(158, 42, 77, 21); 
	m_oTurnoverLabel.frame			= CGRectMake(236, 42, 77, 21); 

	m_oSymbolLabel.hidden		= YES;
	m_oDescriptionLabel.hidden	= YES;
		
	[MHUtility UIViewsMoveY:-23 uiView:m_oPriceLabel, m_oChangeLabel, nil];
	[MHUtility UIViewsMoveY:-23 uiView:m_oBidAskLabel, m_oVolumeLabel, m_oTurnoverLabel,  nil];

	m_oSymbolLabel.text			= MHLocalizedString(@"MHTableCell.header.m_oSymbolLabel.text", nil);
	m_oDescriptionLabel.text	= MHLocalizedString(@"MHTableCell.header.m_oDescriptionLabel.text", nil);
	m_oPriceLabel.text			= MHLocalizedString(@"MHTableCell.header.m_oPriceLabel.text", nil);
	m_oChangeLabel.text			= MHLocalizedString(@"MHTableCell.header.m_oChangeLabel.text", nil);
	m_oBidAskLabel.text			= MHLocalizedString(@"MHTableCell.header.m_oBidAskLabel.text", nil);
	m_oVolumeLabel.text			= MHLocalizedString(@"MHTableCell.header.m_oVolumeLabel.text", nil);
	m_oTurnoverLabel.text		= MHLocalizedString(@"MHTableCell.header.m_oTurnoverLabel.text", nil);	
}

-(void)displayDetailView:(BOOL)isDetail{
	if(isDetail){
		m_oBidAskLabel.hidden = NO;
		m_oVolumeLabel.hidden = NO;
		m_oTurnoverLabel.hidden = NO;
		self.backgroundColor = [UIColor colorWithPatternImage:MHTableCell_detailView_backgroundImage];
	}else{
		m_oBidAskLabel.hidden = YES;
		m_oVolumeLabel.hidden = YES;
		m_oTurnoverLabel.hidden = YES;
		self.backgroundColor = [UIColor colorWithPatternImage:MHTableCell_normalView_backgroundImage];
	}
}

-(void)displayStreamerStock{
	m_oSymbolLabel.frame			= CGRectMake(8, 0, 57, 21);
	m_oDescriptionLabel.frame		= CGRectMake(70, 0, 230, 21);
	m_oPriceLabel.frame				= CGRectMake(8, 21, 76, 21);
	m_oChangeLabel.frame			= CGRectMake(158+5, 21, 129, 21);
	m_oBidAskLabel.frame			= CGRectMake(8, 42, 150, 21);
	m_oVolumeLabel.frame			= CGRectMake(158+5, 42, 77, 21); 
	m_oTurnoverLabel.frame			= CGRectMake(158+5+77, 42, 77, 21); 
	m_oChangeLabel.frame			= CGRectMake(150, 21, 320-150-3, 21);
	
	if(!m_isDetailMode){
		m_oVolumeLabel.hidden		= YES;
		m_oTurnoverLabel.hidden		= YES;
		m_oBidAskLabel.hidden		= YES;
		m_oTapButton.frame = CGRectMake(0, 0, 320, 44);
	}else{
		m_oVolumeLabel.hidden		= NO;
		m_oTurnoverLabel.hidden		= NO;
		m_oBidAskLabel.hidden		= NO;
		m_oTapButton.frame = CGRectMake(0, 0, 320, 64);
	}
}

-(void)displayUpdateMHStreamerStock{
	[self displayAnimationWithDuration:0.3];
	[self displayStreamerStock];
}

-(void)displayAnimationWithDuration:(double)second{

	CABasicAnimation *theAnimation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
	theAnimation.duration = second;
	theAnimation.toValue = (id)[MHUtility uicolorWithHexValueString:[MT_DELEGATE loadFlashColor]].CGColor;
	[m_oFlashView.layer addAnimation:theAnimation forKey:nil];

}

-(void)displayMHFeedXObjQuote:(MHFeedXObjQuote *)aMHFeedXObjQuote{

	[aMHFeedXObjQuote retain];
	
	m_oDescriptionLabel.text	= aMHFeedXObjQuote.m_sDesp;
	m_oSymbolLabel.text			= [MHUtility intSymbolToDisplayableString:[aMHFeedXObjQuote.m_sSymbol intValue] market:MARKET_HONGKONG];
	m_oBidAskLabel.text			= [NSString stringWithFormat:@"%@ / %@", aMHFeedXObjQuote.m_sBid, aMHFeedXObjQuote.m_sAsk];
	m_oVolumeLabel.text			= [MHUtility floatVolumeToString:[aMHFeedXObjQuote.m_sVolume floatValue] market:MARKET_HONGKONG];
	m_oChangeLabel.text			= [NSString stringWithFormat:@"%@ %@", 
								   [MHUtility floatPriceToString:[aMHFeedXObjQuote.m_sChange floatValue] market:MARKET_HONGKONG],
								   [MHUtility floatPricePencentageChangeToString:[aMHFeedXObjQuote.m_sPctChange floatValue] market:MARKET_HONGKONG]];
	m_oTurnoverLabel.text		=  [MHUtility doubleTurnoverToString:[aMHFeedXObjQuote.m_sTurnover doubleValue] market:MARKET_HONGKONG];
	m_oPriceLabel.text			=	[MHUtility floatPriceToString:[aMHFeedXObjQuote.m_sLast floatValue] market:MARKET_HONGKONG];
	
	if([aMHFeedXObjQuote.m_sPctChange floatValue] > 0){
		m_oChangeLabel.textColor = Default_label_text_color_up;
	}else if([aMHFeedXObjQuote.m_sPctChange floatValue] < 0){
		m_oChangeLabel.textColor = Default_label_text_color_down;
	}else{
		m_oChangeLabel.textColor = Default_label_text_color_leveloff;
	}
	
	m_oPriceLabel.textColor		 = MTableCell_m_oPriceLabel_color;

	m_oSymbolLabel.frame			= CGRectMake(8, 0, 57, 21);
	m_oDescriptionLabel.frame		= CGRectMake(70, 0, 230, 21);
	m_oPriceLabel.frame				= CGRectMake(8, 21, 76, 21);
	m_oChangeLabel.frame			= CGRectMake(158+5, 21, 129, 21);
	m_oBidAskLabel.frame			= CGRectMake(8, 42, 150, 21);
	m_oVolumeLabel.frame			= CGRectMake(158+5, 42, 77, 21); 
	m_oTurnoverLabel.frame			= CGRectMake(158+5+77, 42, 77, 21); 
	m_oChangeLabel.frame			= CGRectMake(150, 21, 320-150-3, 21);
	if(!m_isDetailMode){
		m_oVolumeLabel.hidden		= YES;
		m_oTurnoverLabel.hidden		= YES;
		m_oBidAskLabel.hidden		= YES;
		m_oTapButton.frame = CGRectMake(0, 0, 320, 44);
	}else{
		m_oVolumeLabel.hidden		= NO;
		m_oTurnoverLabel.hidden		= NO;
		m_oBidAskLabel.hidden		= NO;
		m_oTapButton.frame = CGRectMake(0, 0, 320, 64);
	}
	[aMHFeedXObjQuote release];
}

-(void)displaySymbol:(NSString *)aSymbol {
	[aSymbol retain];
	m_oDescriptionLabel.text	= @"";
	m_oSymbolLabel.text			= [MHUtility intSymbolToDisplayableString:[aSymbol intValue] market:MARKET_HONGKONG];
	m_oBidAskLabel.text			= @"";
	m_oVolumeLabel.text			= @"";
	m_oChangeLabel.text			= @"";
	m_oTurnoverLabel.text		= @"";
	m_oPriceLabel.text			= @"";
	m_oSymbolLabel.frame			= CGRectMake(8, 0, 57, 21);
	m_oDescriptionLabel.frame		= CGRectMake(70, 0, 230, 21);
	m_oPriceLabel.frame				= CGRectMake(8, 21, 76, 21);
	m_oChangeLabel.frame			= CGRectMake(158+5, 21, 129, 21);
	m_oBidAskLabel.frame			= CGRectMake(8, 42, 150, 21);
	m_oVolumeLabel.frame			= CGRectMake(158+5, 42, 77, 21); 
	m_oTurnoverLabel.frame			= CGRectMake(158+5+77, 42, 77, 21); 
	m_oChangeLabel.frame			= CGRectMake(150, 21, 320-150-3, 21);
	if(!m_isDetailMode){
		m_oVolumeLabel.hidden		= YES;
		m_oTurnoverLabel.hidden		= YES;
		m_oBidAskLabel.hidden		= YES;
		m_oTapButton.frame = CGRectMake(0, 0, 320, 44);
	}else{
		m_oVolumeLabel.hidden		= NO;
		m_oTurnoverLabel.hidden		= NO;
		m_oBidAskLabel.hidden		= NO;
		m_oTapButton.frame = CGRectMake(0, 0, 320, 64);
	}
	[aSymbol release];
}

-(void)setDetailMode:(BOOL)aIsDetailMode{
	m_isDetailMode = aIsDetailMode;
}

@end
