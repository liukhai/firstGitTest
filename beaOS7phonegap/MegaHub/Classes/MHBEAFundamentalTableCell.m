    //
//  MHBEAFundamentalTableCell.m
//  BEA
//
//  Created by Samuel Ma on 16/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAFundamentalTableCell.h"
#import "StyleConstant.h"

@implementation MHBEAFundamentalTableCell

@synthesize m_isOneSetDataOnly;
@synthesize m_oLeftImageView, m_oRightImageView;

#define cellHeight  35

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        m_isOneSetDataOnly = NO;
		
		m_oLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		[self addSubview:m_oLeftImageView];
		[m_oLeftImageView release];
		
		m_oRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		[self addSubview:m_oRightImageView];
		[m_oRightImageView release];
		
		//Left
		m_oLeftTitleLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		m_oLeftValueLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		m_oLeftTitleLabel.font  = MHFundamentalTableCell_m_oLeftTitleLabel_font;
		m_oLeftValueLabel.font  = MHFundamentalTableCell_m_oLeftValueLabel_font;
		[m_oLeftTitleLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oLeftValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oLeftValueLabel setTextAlignment:NSTextAlignmentRight];
		
		[m_oLeftTitleLabel setBackgroundColor:[UIColor clearColor]];
		[m_oLeftValueLabel setBackgroundColor:[UIColor clearColor]];
		
		[self addSubview:m_oLeftTitleLabel];
		[self addSubview:m_oLeftValueLabel];
		
		[m_oLeftTitleLabel release];
		[m_oLeftValueLabel release];
		
		//Right
		m_oRightTitleLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		m_oRightValueLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		m_oRightTitleLabel.font  = MHFundamentalTableCell_m_oRightTitleLabel_font;
		m_oRightValueLabel.font  = MHFundamentalTableCell_m_oRightValueLabel_font;
		[m_oRightTitleLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oRightValueLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oRightValueLabel setTextAlignment:NSTextAlignmentRight];
		
		[m_oRightTitleLabel setBackgroundColor:[UIColor clearColor]];
		[m_oRightValueLabel setBackgroundColor:[UIColor clearColor]];
		
		[self addSubview:m_oRightTitleLabel];
		[self addSubview:m_oRightValueLabel];
		
		[m_oRightTitleLabel release];
		[m_oRightValueLabel release];
        
		[self setIsOneSetDataOnly:m_isOneSetDataOnly];
		
		
		m_oLeftTitleLabel.textColor =  MHFundamentalTableCell_m_oLeftTitleLabel_textColor;
		m_oLeftValueLabel.textColor =  MHFundamentalTableCell_m_oLeftValueLabel_textColor;
		
		m_oRightTitleLabel.textColor = MHFundamentalTableCell_m_oRightTitleLabel_textColor;
		m_oRightValueLabel.textColor = MHFundamentalTableCell_m_oRightValueLabel_textColor;
        
    }
    return self;
}

-(void)setOneSetData:(NSString *)aTitleString value:(NSString *)aValueString{
	[self setIsOneSetDataOnly:YES];
	
	m_oLeftTitleLabel.text	= aTitleString;
	m_oLeftValueLabel.text	= aValueString;
	
}

-(void)setTwoSetData:(NSString *)aLeftTitleString value:(NSString *)aLeftValueString rightTitle:(NSString *)aRightTitleString value:(NSString *)aRightValueString{
	[self setIsOneSetDataOnly:NO];
	
	m_oLeftTitleLabel.text	= aLeftTitleString;
	m_oLeftValueLabel.text	= aLeftValueString;
	
	m_oRightTitleLabel.text	= aRightTitleString;
	m_oRightValueLabel.text	= aRightValueString;
}


-(void)setOneSetDataWithAnimation:(NSString *)aTitleString value:(NSString *)aValueString{
	[self setIsOneSetDataOnly:YES];
	
	m_oLeftTitleLabel.text	= aTitleString;
	
	if([m_oLeftValueLabel.text length]>0 && [aValueString length]>0){
		[m_oLeftValueLabel setTextWithAnimationUseTextColor:aValueString
												   duration:MHBidAskTableCell_label_animate_second
										  animateIfNoChange:NO];
	}else{
		m_oLeftValueLabel.text	= aValueString;
	}
}

-(void)setTwoSetDataWithLeftStringWithAnimation:(NSString *)aLeftTitleString value:(NSString *)aLeftValueString{
	
	m_oLeftTitleLabel.text	= aLeftTitleString;
	
	// Left
	if([m_oLeftValueLabel.text length]>0 && [aLeftValueString length]>0){
		
		[m_oLeftValueLabel setTextWithAnimationUseTextColor:aLeftValueString
												   duration:MHBidAskTableCell_label_animate_second
										  animateIfNoChange:NO];
		
	}else{
		m_oLeftValueLabel.text	= aLeftValueString;
	}
    
}

-(void)setTwoSetDataWithRightStringWithAnimation:(NSString *)aRightTitleString value:(NSString *)aRightValueString{
	
	m_oRightTitleLabel.text	= aRightTitleString;
	
	// Right
	if([m_oRightValueLabel.text length]>0 && [aRightValueString length]>0){
		
		[m_oRightValueLabel setTextWithAnimationUseTextColor:aRightValueString
													duration:MHBidAskTableCell_label_animate_second
										   animateIfNoChange:NO];
		
	}else{
		m_oRightValueLabel.text	= aRightValueString;
	}
}

//Internal Use Only
-(void)setIsOneSetDataOnly:(BOOL)isOneSetData{
	m_isOneSetDataOnly = isOneSetData;
	
	if(isOneSetData){
		m_oRightTitleLabel.hidden = YES;
		m_oRightValueLabel.hidden = YES;
		//hide the right
		float labelWidth = (300/2);
		
		m_oLeftTitleLabel.frame = CGRectMake(labelWidth*0+5, 0, labelWidth, cellHeight);
		m_oLeftValueLabel.frame = CGRectMake(labelWidth*1+12, 0, labelWidth, cellHeight);
		
		m_oLeftImageView.frame	= CGRectMake(0, 0, 320, cellHeight);
		m_oRightImageView.frame	= CGRectMake(0, 0, 0, 0);
	}else {
		m_oRightTitleLabel.hidden = NO;
		m_oRightValueLabel.hidden = NO;
		
		float labelWidth = 300/4;
		
		m_oLeftImageView.frame	= CGRectMake(0, 0, labelWidth*2, cellHeight);
		m_oRightImageView.frame	= CGRectMake(labelWidth*2, 0, labelWidth*2+20, cellHeight);
		
		m_oLeftTitleLabel.frame = CGRectMake(labelWidth*0+5, 0, labelWidth, cellHeight);
		m_oLeftValueLabel.frame = CGRectMake(labelWidth*1+2, 0, labelWidth, cellHeight);
		
		m_oRightTitleLabel.frame = CGRectMake(labelWidth*2+10, 0, labelWidth, cellHeight);
		m_oRightValueLabel.frame = CGRectMake(labelWidth*3+12, 0, labelWidth, cellHeight);
	}
}

- (void)dealloc {
    [super dealloc];
}

@end
