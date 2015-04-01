//
//  MHBidAskTableCell.m
//  MagicTrader
//
//  Created by Megahub on 04/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHBidAskTableCell.h"
#import "StyleConstant.h"
#import "PTConstant.h"

@implementation MHBidAskTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		m_oBidLabel = [[MHUILabel alloc] initWithFrame:
					   CGRectMake(0, 0, 210/2, 198/NUMBER_BID_ASK_QUEUE)];
		
		m_oAskLabel = [[MHUILabel alloc] initWithFrame:
					   CGRectMake(210/2, 0, 210/2, 198/NUMBER_BID_ASK_QUEUE)];

		[m_oBidLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oAskLabel setAdjustsFontSizeToFitWidth:YES];
		
		[m_oBidLabel setTextAlignment:NSTextAlignmentCenter];
		[m_oAskLabel setTextAlignment:NSTextAlignmentCenter];
		
		[m_oBidLabel setTextColor:MHBidAskTableCell_m_oBidLabel_text_color];
		[m_oAskLabel setTextColor:MHBidAskTableCell_m_oAskLabel_text_color];
		[m_oBidLabel setFont:MHBidAskTableCell_m_oBidLabel_font];
		[m_oAskLabel setFont:MHBidAskTableCell_m_oAskLabel_font];

		
		[self addSubview:m_oBidLabel];
		[self addSubview:m_oAskLabel];
		
		[m_oBidLabel release];
		[m_oAskLabel release];
		//欲速則不達, 財不入急門
    }
    return self;
}

-(void)setBidStringWithAnimation:(NSString *)aBidString{
	[m_oBidLabel setTextWithAnimationUseTextColor:aBidString
										 duration:MHBidAskTableCell_label_animate_second
								animateIfNoChange:NO];
}

-(void)setAskStringWithAnimation:(NSString *)aAskString{
	[m_oAskLabel setTextWithAnimationUseTextColor:aAskString
										 duration:MHBidAskTableCell_label_animate_second
								animateIfNoChange:NO];
}

-(void)setBidString:(NSString *)aBidString askString:(NSString *)aAskString{
	m_oBidLabel.text	= aBidString;
	m_oAskLabel.text	= aAskString;
}

- (void)dealloc {
    [super dealloc];
}


@end
