//
//  MHStaticDataView.m
//  MagicTrader
//
//  Created by Megahub on 03/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHStaticDataView.h"
#import "MHUILabel.h"
#import "MHUtility.h"
#import "StyleConstant.h"
#import "ArrowImgView.h"
#import "MHFeedConnectorX.h"

@implementation MHStaticDataView

@synthesize m_oOpenTitleLabel;
@synthesize m_oPrevCloseTitleLabel;
@synthesize m_oAvgPriceTitleLabel;
@synthesize m_oVolumeTitleLabel;		
@synthesize m_oTurnoverTitleLabel;		
@synthesize m_oPETitleLabel;			
@synthesize m_oYieldTitleLabel;			
@synthesize m_oLotSizeTitleLabel;
@synthesize m_oOpenValueLabel;
@synthesize m_oPrevCloseValueLabel;
@synthesize m_oAvgPriceValueLabel;
@synthesize m_oVolumeValueLabel;		
@synthesize m_oTurnoverValueLabel;		
@synthesize m_oPEValueLabel;			
@synthesize m_oYieldValueLabel;			
@synthesize m_oLotSizeValueLabel;
@synthesize m_oPremiumTitleLabel;		
@synthesize m_oGearingTitleLabel;		
@synthesize m_oPremiumValueLabel;		
@synthesize m_oGearingValueLabel;		
@synthesize m_fLast;
@synthesize m_sEPSValue;				
@synthesize m_sDPSValue;				
@synthesize m_oBackgroundImageView;
@synthesize m_oRelatedStockButton;
@synthesize m_oRelatedStockValueLabel;
@synthesize m_isShowQuoteMeter;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = Default_MHStaticDataView_view_background_color;
		
		m_oBackgroundImageView = [[UIImageView alloc] initWithFrame:frame];
		m_oBackgroundImageView.image = MHStaticDataView_background_image;
		[self addSubview:m_oBackgroundImageView];
		
		//Speacial for warrnant & CBBC
		m_oPremiumTitleLabel = [[MHUILabel alloc] init];
		m_oGearingTitleLabel = [[MHUILabel alloc] init];
		
		m_oPremiumValueLabel = [[MHUILabel alloc] init];
		m_oGearingValueLabel = [[MHUILabel alloc] init];
		
		
		m_oOpenTitleLabel		= [[MHUILabel alloc] init];
		m_oPrevCloseTitleLabel	= [[MHUILabel alloc] init];
		m_oAvgPriceTitleLabel	= [[MHUILabel alloc] init];
		m_oVolumeTitleLabel		= [[MHUILabel alloc] init];
		m_oTurnoverTitleLabel	= [[MHUILabel alloc] init];
		m_oPETitleLabel			= [[MHUILabel alloc] init];
		m_oYieldTitleLabel		= [[MHUILabel alloc] init];
		m_oLotSizeTitleLabel	= [[MHUILabel alloc] init];
		
		NSArray *titleLabelArray = [[NSArray alloc] initWithObjects:
									m_oOpenTitleLabel,
									m_oPrevCloseTitleLabel,
									m_oAvgPriceTitleLabel,
									m_oVolumeTitleLabel,
									m_oTurnoverTitleLabel,
									m_oPETitleLabel,
									m_oYieldTitleLabel,
									m_oLotSizeTitleLabel,
									m_oPremiumTitleLabel,
									m_oGearingTitleLabel,
									nil];
		
		for (int i = 0; i < [titleLabelArray count]; i++) {
			MHUILabel *tmpUILabel = [titleLabelArray objectAtIndex:i];
			tmpUILabel.frame = CGRectMake(1, 4+(17*i), 28+5, 18);
			tmpUILabel.textAlignment   = NSTextAlignmentLeft;
			tmpUILabel.font			   = Default_MHStaticDataView_title_label_font;
			tmpUILabel.textColor	   = Default_MHStaticDataView_title_label_text_color;
            [self addSubview:tmpUILabel];
            
            if(i>=8){
                tmpUILabel.backgroundColor = (i%2==0)?MHStaticDataView_label_background_color_odd:MHStaticDataView_label_background_color_even;
            }else{
                tmpUILabel.backgroundColor = (i%2==0)?MHStaticDataView_label_background_color_even:MHStaticDataView_label_background_color_odd;
            }
		}
        
        //Snapshot only
        m_oYearHighTitleLabel       = [[MHUILabel alloc] init];
        m_oDayHighTitleLabel        = [[MHUILabel alloc] init];
        m_oRelatedStockTitleLabel   = [[MHUILabel alloc] init];
        m_oYearLowTitleLabel        = [[MHUILabel alloc] init];
        m_oDayLowTitleLabel         = [[MHUILabel alloc] init];
        
        NSArray *snapshotOnlyTitleLabelArray = [NSArray arrayWithObjects:
                                                m_oYearHighTitleLabel,
                                                m_oDayHighTitleLabel,
                                                m_oRelatedStockTitleLabel,
                                                m_oYearLowTitleLabel, 
                                                m_oDayLowTitleLabel, nil];
        
        int j = [titleLabelArray count]-1;
        
        [titleLabelArray release];
		
        for (int i = 0; i < [snapshotOnlyTitleLabelArray count]; i++) {
			MHUILabel *tmpUILabel = [snapshotOnlyTitleLabelArray objectAtIndex:i];
			tmpUILabel.frame = CGRectMake(1, 17*(j+i)-10, 28+5, 18);
			[self addSubview:tmpUILabel];
			tmpUILabel.textAlignment   = NSTextAlignmentLeft;
			tmpUILabel.font			   = Default_MHStaticDataView_title_label_font;
			tmpUILabel.textColor	   = Default_MHStaticDataView_title_label_text_color;
			
            tmpUILabel.backgroundColor = (i%2==0)?MHStaticDataView_label_background_color_even:MHStaticDataView_label_background_color_odd;
            
			tmpUILabel.hidden = YES;
		}
		
        m_oYearHighValueLabel       = [[MHUILabel alloc] init];
        m_oDayHighValueLabel        = [[MHUILabel alloc] init];
        m_oYearLowValueLabel        = [[MHUILabel alloc] init];
        m_oDayLowValueLabel         = [[MHUILabel alloc] init];
        m_oRelatedStockValueLabel   = [[MHUILabel alloc] init];
		
        NSArray *snapshotOnlyValueLabelArray = [NSArray arrayWithObjects:
                                                m_oYearHighValueLabel,
                                                m_oDayHighValueLabel,
                                                m_oYearLowValueLabel,
                                                m_oDayLowValueLabel,
                                                m_oRelatedStockValueLabel, nil];
        
        for (int i = 0; i < [snapshotOnlyValueLabelArray count]; i++) {
			MHUILabel *tmpUILabel = [snapshotOnlyValueLabelArray objectAtIndex:i];
			tmpUILabel.frame = CGRectMake(32, 17*(j+i)-10,  66, 18);
			[self addSubview:tmpUILabel];
            [tmpUILabel setAdjustsFontSizeToFitWidth:YES];
			tmpUILabel.textAlignment   = NSTextAlignmentLeft;
			tmpUILabel.font			   = Default_MHStaticDataView_title_label_font;
			tmpUILabel.textColor	   = Default_MHStaticDataView_title_label_text_color;
			
            tmpUILabel.backgroundColor = (i%2==0)?MHStaticDataView_label_background_color_even:MHStaticDataView_label_background_color_odd;
            
			tmpUILabel.hidden = YES;
		}

		
		m_oOpenValueLabel		= [[MHUILabel alloc] init];
		m_oPrevCloseValueLabel	= [[MHUILabel alloc] init];
		m_oAvgPriceValueLabel	= [[MHUILabel alloc] init];
		m_oVolumeValueLabel		= [[MHUILabel alloc] init];
		m_oTurnoverValueLabel	= [[MHUILabel alloc] init];
		m_oPEValueLabel			= [[MHUILabel alloc] init];
		m_oYieldValueLabel		= [[MHUILabel alloc] init];
		m_oLotSizeValueLabel	= [[MHUILabel alloc] init];
		
		NSArray *valueLabelArray = [[NSArray alloc] initWithObjects:
									m_oOpenValueLabel,
									m_oPrevCloseValueLabel,
									m_oAvgPriceValueLabel,
									m_oVolumeValueLabel,
									m_oTurnoverValueLabel,
									m_oPEValueLabel,
									m_oYieldValueLabel,
									m_oLotSizeValueLabel,
									m_oPremiumValueLabel,
									m_oGearingValueLabel,
									nil];
		
		for (int i = 0; i < [valueLabelArray count]; i++) {
			MHUILabel *tmpUILabel = [valueLabelArray objectAtIndex:i];
			tmpUILabel.frame = CGRectMake(32, 4+(17*i), 66, 18);
			[self addSubview:tmpUILabel];
            [tmpUILabel setAdjustsFontSizeToFitWidth:YES];
			tmpUILabel.textAlignment   = NSTextAlignmentRight;
			tmpUILabel.font			   = Default_MHStaticDataView_value_label_font;
			tmpUILabel.textColor	   = Default_MHStaticDataView_value_label_text_color;
            
            if(i>=8){
                tmpUILabel.backgroundColor = (i%2==0)?MHStaticDataView_label_background_color_odd:MHStaticDataView_label_background_color_even;
            }else{
                tmpUILabel.backgroundColor = (i%2==0)?MHStaticDataView_label_background_color_even:MHStaticDataView_label_background_color_odd;
            }
            
		}
		
		m_oQuoteMeterTitleLabel		= [[MHUILabel alloc] init];
		m_oQuoteMeterValueLabel		= [[MHUILabel alloc] init];
		m_oRelatedStockPriceValueLabel = [[MHUILabel alloc] init];
		
		
		NSArray *quoteMeterQrray = [[NSArray alloc] initWithObjects:
									m_oQuoteMeterTitleLabel,
									m_oQuoteMeterValueLabel,
									m_oRelatedStockPriceValueLabel,nil];
		
		for (int i = 0; i < [quoteMeterQrray count]; i++) {
			MHUILabel *tmpUILabel = [quoteMeterQrray objectAtIndex:i];
			tmpUILabel.frame = CGRectMake(1, 4+(17*([valueLabelArray count]+i+2)), 97, 18);
			[self addSubview:tmpUILabel];
			tmpUILabel.textAlignment   = NSTextAlignmentLeft;
			tmpUILabel.font			   = Default_MHStaticDataView_value_label_font;
			tmpUILabel.textColor	   = Default_MHStaticDataView_value_label_text_color;
            tmpUILabel.backgroundColor = (i%2==0)?MHStaticDataView_label_background_color_even:MHStaticDataView_label_background_color_odd;
		}
		
		m_oBackgroundImageView.hidden		  = YES;
		m_oUndelyingChangeImageView.hidden =	YES;
		[m_oQuoteMeterValueLabel setTextAlignment:NSTextAlignmentCenter];
		
		[m_oQuoteMeterTitleLabel setAdjustsFontSizeToFitWidth:YES];
		
		[quoteMeterQrray release];
		[valueLabelArray release];
		
		//Special handling for CBBC/Warrant
		m_oPremiumTitleLabel.frame = m_oPETitleLabel.frame;
		m_oGearingTitleLabel.frame = m_oYieldTitleLabel.frame;
		
		m_oPremiumValueLabel.frame = m_oPEValueLabel.frame;
		m_oGearingValueLabel.frame = m_oYieldValueLabel.frame;
		
		
		
		
		// set the frame of m_oQuoteMeterFreeTodayValueLabel
//=====================================================================		
#if BEHAVIOUR_MHStaticDataView_SHOW_TODAY_FREE
		
		
		[m_oQuoteMeterTitleLabel setFrame:CGRectMake(1, 208, 97, 13)];
		[m_oQuoteMeterTitleLabel setFont:[UIFont systemFontOfSize:10]];
		
		
		[m_oQuoteMeterValueLabel setFrame:CGRectMake(1, 208, 97, 13)];
		[m_oQuoteMeterValueLabel setTextAlignment:NSTextAlignmentRight];
		[m_oQuoteMeterValueLabel setFont:[UIFont systemFontOfSize:10]];
		
		[m_oQuoteMeterTitleLabel setFont:[UIFont systemFontOfSize:10]];
		[m_oQuoteMeterValueLabel setFont:[UIFont systemFontOfSize:10]];
		
		// Free today
		m_oQuoteMeterFreeTodayTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 221, 97, 13)];
		[m_oQuoteMeterFreeTodayTitleLabel setTextColor:Default_MHStaticDataView_title_label_text_color];
		[m_oQuoteMeterFreeTodayTitleLabel setFont:[UIFont systemFontOfSize:10]];
		[m_oQuoteMeterFreeTodayTitleLabel setBackgroundColor:[UIColor clearColor]];		
		[m_oQuoteMeterFreeTodayTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[self addSubview:m_oQuoteMeterFreeTodayTitleLabel];

		m_oQuoteMeterFreeTodayValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 221, 97, 13)];
		[m_oQuoteMeterFreeTodayValueLabel setTextColor:Default_MHStaticDataView_value_label_text_color];
		[m_oQuoteMeterFreeTodayValueLabel setFont:[UIFont systemFontOfSize:10]];
		[m_oQuoteMeterFreeTodayValueLabel setBackgroundColor:[UIColor clearColor]];
		[m_oQuoteMeterFreeTodayValueLabel setTextAlignment:NSTextAlignmentRight];
		[self addSubview:m_oQuoteMeterFreeTodayValueLabel];
		
		// Used Today
		m_oQuoteMeterUsedTodayTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 234, 97, 13)];
		[m_oQuoteMeterUsedTodayTitleLabel setTextColor:Default_MHStaticDataView_title_label_text_color];
		[m_oQuoteMeterUsedTodayTitleLabel setFont:[UIFont systemFontOfSize:10]];
		[m_oQuoteMeterUsedTodayTitleLabel setBackgroundColor:[UIColor clearColor]];
		[m_oQuoteMeterUsedTodayTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[self addSubview:m_oQuoteMeterUsedTodayTitleLabel];
		
		m_oQuoteMeterUsedTodayValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 234, 97, 13)];
		[m_oQuoteMeterUsedTodayValueLabel setTextColor:Default_MHStaticDataView_value_label_text_color];
		[m_oQuoteMeterUsedTodayValueLabel setFont:[UIFont systemFontOfSize:10]];
		[m_oQuoteMeterUsedTodayValueLabel setBackgroundColor:[UIColor clearColor]];
		[m_oQuoteMeterUsedTodayValueLabel setTextAlignment:NSTextAlignmentRight];
		[self addSubview:m_oQuoteMeterUsedTodayValueLabel];
		
#endif
//=====================================================================
		
		
		//Hide the related stuff until I know the type
		m_oPremiumTitleLabel.hidden = YES;
		m_oGearingTitleLabel.hidden = YES;
		
		m_oPremiumValueLabel.hidden = YES;
		m_oGearingValueLabel.hidden = YES;
		
		
		m_oPETitleLabel.hidden		= YES;
		m_oYieldTitleLabel.hidden	= YES;
		m_oPEValueLabel.hidden		= YES;
		m_oYieldValueLabel.hidden	= YES;
		
		m_oQuoteMeterTitleLabel.hidden = YES;
		m_oQuoteMeterValueLabel.hidden = YES;
		
#if BEHAVIOUR_MHStaticDataView_SHOW_TODAY_FREE
		m_oQuoteMeterFreeTodayTitleLabel.hidden = YES;
		m_oQuoteMeterFreeTodayValueLabel.hidden = YES;
		m_oQuoteMeterUsedTodayTitleLabel.hidden = YES;
		m_oQuoteMeterUsedTodayValueLabel.hidden = YES;
#endif
		
		m_sEPSValue					= [[NSString alloc] init];
		m_sDPSValue					= [[NSString alloc] init];
		
		m_oRelatedStockButton	= [[UIButton alloc] initWithFrame:CGRectMake(0, 174, 33+64, 18*2)];
		[self addSubview:m_oRelatedStockButton];
		
		m_oUndelyingChangeImageView = [[ArrowImgView alloc] initWithFrame:CGRectMake(70, 0, 17, 18)];
		[m_oUndelyingChangeImageView changeValue:0];
		[m_oUndelyingChangeImageView setBackgroundColor:[UIColor clearColor]];
		[m_oRelatedStockPriceValueLabel addSubview:m_oUndelyingChangeImageView];
		m_oRelatedStockPriceValueLabel.hidden = YES;
        
        m_isShowQuoteMeter = YES;

   }
	
	[self clean];
	[self reloadText];
    return self;
}

-(void)reloadText{
	m_oOpenTitleLabel.text			= MHLocalizedString(@"MHStaticDataView.m_oOpenTitleLabel.text", nil);
	m_oPrevCloseTitleLabel.text		= MHLocalizedString(@"MHStaticDataView.m_oPrevCloseTitleLabel.text", nil);
	m_oAvgPriceTitleLabel.text		= MHLocalizedString(@"MHStaticDataView.m_oAvgPriceTitleLabel.text", nil);
	m_oVolumeTitleLabel.text		= MHLocalizedString(@"MHStaticDataView.m_oVolumeTitleLabel.text", nil);
	m_oTurnoverTitleLabel.text		= MHLocalizedString(@"MHStaticDataView.m_oTurnoverTitleLabel.text", nil);
	m_oLotSizeTitleLabel.text		= MHLocalizedString(@"MHStaticDataView.m_oLotSizeTitleLabel.text", nil);
	
	//Only Stock
	m_oPETitleLabel.text			= MHLocalizedString(@"MHStaticDataView.m_oPETitleLabel.text", nil);
	m_oYieldTitleLabel.text			= MHLocalizedString(@"MHStaticDataView.m_oYieldTitleLabel.text", nil);
	
	//Only CBBC / Warrant
	m_oPremiumTitleLabel.text		= MHLocalizedString(@"MHStaticDataView.m_oPremiumTitleLabel.text", nil);
	m_oGearingTitleLabel.text		= MHLocalizedString(@"MHStaticDataView.m_oGearingTitleLabel.text", nil);
    
    
    //Snapshot only
    m_oYearHighTitleLabel.text           = MHLocalizedString(@"MHStaticDataView.m_oYearHighTitleLabel.text", nil);
    m_oDayHighTitleLabel.text            = MHLocalizedString(@"MHStaticDataView.m_oDayHighTitleLabel.text", nil);
	
    m_oRelatedStockTitleLabel.text       = MHLocalizedString(@"MHStaticDataView.m_oRelatedStockTitleLabel.text", nil);   
    m_oYearLowTitleLabel.text            = MHLocalizedString(@"MHStaticDataView.m_oYearLowTitleLabel.text", nil);   
    m_oDayLowTitleLabel.text             = MHLocalizedString(@"MHStaticDataView.m_oDayLowTitleLabel.text", nil);  
	
#if SHOW_CURRENT_USAGE
    m_oQuoteMeterTitleLabel.text         = MHLocalizedString(@"MHStaticDataView.m_oQuoteMeterTitleLabel.text.current_usage", nil);
#else 
	m_oQuoteMeterTitleLabel.text         = MHLocalizedString(@"MHStaticDataView.m_oQuoteMeterTitleLabel.text", nil);
#endif
    
#if BEHAVIOUR_MHStaticDataView_SHOW_TODAY_FREE
	m_oQuoteMeterFreeTodayTitleLabel.text = MHLocalizedString(@"MHStaticDataView.m_oQuoteMeterFreeTodayTitleLabel.text", nil);
	m_oQuoteMeterUsedTodayTitleLabel.text = MHLocalizedString(@"MHStaticDataView.m_oQuoteMeterUsedTodayTitleLabel.text", nil);
#endif
	
}

-(void)setSRMode:(BOOL)aIsEnableSRMode{
	if(aIsEnableSRMode){
		
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                                self.frame.size.width, 244);
		UIImage *aImage = MHStaticDataView_background_image;
		
		m_oBackgroundImageView.frame = CGRectMake(0, 0, aImage.size.width, aImage.size.height);
		UIImageView *anotherBackgroundImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0,  aImage.size.height, aImage.size.width, aImage.size.height)];
		anotherBackgroundImage.frame = self.frame;
		[self addSubview:anotherBackgroundImage];
		[anotherBackgroundImage release];
		
		
		NSArray *snapshotStockOnlyTitleLabelArray = [NSArray arrayWithObjects:
													 m_oOpenTitleLabel,
													 m_oPrevCloseTitleLabel,
													 m_oAvgPriceTitleLabel,
													 m_oDayHighTitleLabel,
													 m_oDayLowTitleLabel,
													 m_oVolumeTitleLabel,
													 m_oTurnoverTitleLabel,
													 m_oYearHighTitleLabel,
													 m_oYearLowTitleLabel,
													 m_oPETitleLabel,
													 m_oYieldTitleLabel,
													 m_oLotSizeTitleLabel,nil];
		
		for (int i = 0; i < [snapshotStockOnlyTitleLabelArray count]; i++) {
			MHUILabel *tmpUILabel = [snapshotStockOnlyTitleLabelArray objectAtIndex:i];
			tmpUILabel.frame = CGRectMake(1, 4+(17*i), 35, 18);
			[self addSubview:tmpUILabel];
			tmpUILabel.textAlignment   = NSTextAlignmentLeft;
			tmpUILabel.font			   = Default_MHStaticDataView_title_label_font;
			tmpUILabel.textColor	   = Default_MHStaticDataView_title_label_text_color;
            tmpUILabel.backgroundColor = (i%2==0)?MHStaticDataView_label_background_color_even:MHStaticDataView_label_background_color_odd;
			tmpUILabel.hidden			= NO;
		}
		
		NSArray *snapshotStockOnlyValueLabelArray = [NSArray arrayWithObjects:
													 m_oOpenValueLabel,
													 m_oPrevCloseValueLabel,
													 m_oAvgPriceValueLabel,
													 m_oDayHighValueLabel,
													 m_oDayLowValueLabel,
													 m_oVolumeValueLabel,
													 m_oTurnoverValueLabel,
													 m_oYearHighValueLabel,
													 m_oYearLowValueLabel,
													 m_oPEValueLabel,
													 m_oYieldValueLabel,
													 m_oLotSizeValueLabel,nil];
		
		for (int i = 0; i < [snapshotStockOnlyValueLabelArray count]; i++) {
			MHUILabel *tmpUILabel = [snapshotStockOnlyValueLabelArray objectAtIndex:i];
			tmpUILabel.frame = CGRectMake(36, 4+(17*i), 62, 18);
			[self addSubview:tmpUILabel];
			tmpUILabel.textAlignment   = NSTextAlignmentRight;
			tmpUILabel.font			   = Default_MHStaticDataView_title_label_font;
			tmpUILabel.textColor	   = Default_MHStaticDataView_title_label_text_color;
            tmpUILabel.backgroundColor = (i%2==0)?MHStaticDataView_label_background_color_even:MHStaticDataView_label_background_color_odd;
			tmpUILabel.hidden			= NO;
		}
		m_oPremiumTitleLabel.frame = m_oYearHighTitleLabel.frame;
		m_oPremiumValueLabel.frame = m_oYearHighValueLabel.frame;
		
		m_oGearingTitleLabel.frame = m_oYearLowTitleLabel.frame;
		m_oGearingValueLabel.frame = m_oYearLowValueLabel.frame;
		
		m_oRelatedStockTitleLabel.frame = CGRectMake(m_oYieldTitleLabel.frame.origin.x, m_oYieldTitleLabel.frame.origin.y, 99, m_oYieldTitleLabel.frame.size.height);
		m_oRelatedStockValueLabel.frame =  CGRectMake(1, 4+(17*11),99, 18);
		m_oRelatedStockValueLabel.textAlignment = NSTextAlignmentLeft;
		
	}
}

-(void)clean{
	m_oOpenValueLabel.text		= @"";
	m_oPrevCloseValueLabel.text	= @"";
	m_oAvgPriceValueLabel.text	= @"";
	m_oVolumeValueLabel.text	= @"";
	m_oTurnoverValueLabel.text	= @"";
	m_oLotSizeValueLabel.text	= @"";
	
	m_oYearHighValueLabel.text	= @"";
	m_oDayHighValueLabel.text	= @"";
	
	m_oYearLowValueLabel.text	= @"";
	m_oDayLowValueLabel.text	= @"";
	
	//Stock
	m_oPEValueLabel.text		= @"";
	m_oYieldValueLabel.text		= @"";
	
	m_oQuoteMeterValueLabel.text = @"";
#if BEHAVIOUR_MHStaticDataView_SHOW_TODAY_FREE
	m_oQuoteMeterFreeTodayValueLabel.text = @"";
	m_oQuoteMeterUsedTodayValueLabel.text = @"";
#endif
	
	self.m_sEPSValue					= @"";
	self.m_sDPSValue					= @"";
	
	m_fLast								= 0;
}


#pragma mark - SnapShot account
/************************************************************** SnapShot account **************************************************************/
- (void)updateStockInfo:(MHFeedXMsgInGetLiteQuote *)aQuote {
	
	MHFeedXObjStockQuote *stockQuote = [aQuote.m_oStockQuoteArray objectAtIndex:0];
	MHFeedXObjQuote *quoteValue = [stockQuote.m_oQuoteArray objectAtIndex:0];
	
    if(m_isShowQuoteMeter){
        m_oQuoteMeterTitleLabel.hidden = NO;
        m_oQuoteMeterValueLabel.hidden = NO;
        
#if BEHAVIOUR_MHStaticDataView_SHOW_TODAY_FREE
        m_oQuoteMeterFreeTodayTitleLabel.hidden = NO;
        m_oQuoteMeterFreeTodayValueLabel.hidden = NO; 
        m_oQuoteMeterUsedTodayTitleLabel.hidden = NO;
        m_oQuoteMeterUsedTodayValueLabel.hidden = NO;
        m_oQuoteMeterFreeTodayValueLabel.text = [NSString stringWithFormat:@"%d", aQuote.m_iQuoteFreeToday];
        m_oQuoteMeterUsedTodayValueLabel.text = [NSString stringWithFormat:@"%d", aQuote.m_iQuoteUsedToday];    
#endif
        
    }
    
#if SHOW_CURRENT_USAGE
    m_oQuoteMeterValueLabel.text = [NSString stringWithFormat:@"%d", aQuote.m_iCurrentUsage];
#else
	m_oQuoteMeterValueLabel.text = [NSString stringWithFormat:@"%d", aQuote.m_iCurrentBalance];
#endif
	
	m_oOpenValueLabel.text = [MHUtility floatOpenToString:[quoteValue.m_sOpen floatValue] market:MARKET_HONGKONG];
	m_oPrevCloseValueLabel.text = [MHUtility floatPrevCloseToString:[quoteValue.m_sPrevClose floatValue] market:MARKET_HONGKONG];
    if([quoteValue.m_sAvgPrice floatValue]>=0){
        m_oAvgPriceValueLabel.text = [MHUtility floatAvgPriceToString:[quoteValue.m_sAvgPrice floatValue] market:MARKET_HONGKONG];
    }else{
         m_oAvgPriceValueLabel.text = @"";
    }
    
    if([quoteValue.m_sVolume floatValue]>=0){
        m_oVolumeValueLabel.text = [MHUtility floatVolumeToString:[quoteValue.m_sVolume floatValue] market:MARKET_HONGKONG];
    }else{
        m_oVolumeValueLabel.text = @"0";
    }
	
    if([quoteValue.m_sTurnover floatValue]>=0){
        m_oTurnoverValueLabel.text = [MHUtility floatTurnoverToString:[quoteValue.m_sTurnover floatValue] market:MARKET_HONGKONG];
    }else{
        m_oTurnoverValueLabel.text = @"0";
    }
    
	m_oLotSizeValueLabel.text = quoteValue.m_sLotSize;
    
    if([quoteValue.m_sHigh floatValue]>0){
        m_oDayHighValueLabel.text = quoteValue.m_sHigh;
    }else{
        m_oDayHighValueLabel.text = @"";
    }
    
    if([quoteValue.m_sLow floatValue]>0){
        m_oDayLowValueLabel.text = quoteValue.m_sLow;
    }else{
        m_oDayLowValueLabel.text = @"";
    }
	
	if ([quoteValue.m_sStockType isEqualToString:STOCK_TYPE_SR_WARRANT] || [quoteValue.m_sStockType isEqualToString:STOCK_TYPE_SR_CBBC]) {
		
		m_oLotSizeTitleLabel.frame = CGRectMake(1, 157, 33, 18);
		m_oLotSizeValueLabel.frame = CGRectMake(34, 157, 64, 18);
		m_oYieldTitleLabel.hidden = YES;
		m_oYieldValueLabel.hidden = YES;
		m_oPETitleLabel.hidden = YES;
		m_oPEValueLabel.hidden = YES;
		m_oYearHighTitleLabel.hidden = YES;
		m_oYearHighValueLabel.hidden = YES;
		m_oYearLowTitleLabel.hidden = YES;
		m_oYearLowValueLabel.hidden = YES;
		
		m_oPremiumTitleLabel.hidden = NO;
		m_oPremiumValueLabel.hidden = NO;
		m_oPremiumValueLabel.text = [MHUtility floatPremiumToString:[quoteValue.m_sPremium floatValue] market:MARKET_HONGKONG];
		
		m_oGearingTitleLabel.hidden = NO;
		m_oGearingValueLabel.hidden = NO;
		m_oGearingValueLabel.text = [MHUtility floatGearingToString:[quoteValue.m_sGearing floatValue] market:MARKET_HONGKONG];
		
		m_oRelatedStockTitleLabel.hidden = NO;
		m_oRelatedStockValueLabel.hidden = NO;
		m_oRelatedStockValueLabel.text = quoteValue.m_sLinkIDStock;
		
	}else{
		
		m_oLotSizeTitleLabel.frame = CGRectMake(1, 191, 33, 18);
		m_oLotSizeValueLabel.frame = CGRectMake(34, 191, 64,18);
		
		m_oPremiumTitleLabel.hidden = YES;
		m_oPremiumValueLabel.hidden = YES;
		m_oGearingTitleLabel.hidden = YES;
		m_oGearingValueLabel.hidden = YES;
		m_oRelatedStockTitleLabel.hidden = YES;
		m_oRelatedStockValueLabel.hidden = YES;
        m_oRelatedStockValueLabel.text = @"";
		
		m_oYieldTitleLabel.hidden = NO;
		m_oYieldValueLabel.hidden = NO;
		m_oYieldValueLabel.text = [MHUtility floatYieldToString:[quoteValue.m_sYield floatValue] market:MARKET_HONGKONG];
		
		m_oPETitleLabel.hidden = NO;
		m_oPEValueLabel.hidden = NO;
		m_oPEValueLabel.text = [MHUtility floatPEToString:[quoteValue.m_sPERatio floatValue] market:MARKET_HONGKONG];
		
		m_oYearHighTitleLabel.hidden = NO;
		m_oYearHighValueLabel.hidden = NO;
		m_oYearHighValueLabel.text = quoteValue.m_sWeekHigh52W;
		
		m_oYearLowTitleLabel.hidden = NO;
		m_oYearLowValueLabel.hidden = NO;
		m_oYearLowValueLabel.text = quoteValue.m_sWeekLow52W;
		
	}
	
}
/************************************************************** SnapShot account **************************************************************/

- (void)dealloc {
	[m_oRelatedStockButton release];
	[m_oOpenTitleLabel release];
	[m_oPrevCloseTitleLabel release];
	[m_oAvgPriceTitleLabel release];
	[m_oVolumeTitleLabel release];
	[m_oTurnoverTitleLabel release];
	[m_oPETitleLabel release];
	[m_oYieldTitleLabel release];
	[m_oLotSizeTitleLabel release];
	[m_oOpenValueLabel release];
	[m_oPrevCloseValueLabel release];
	[m_oAvgPriceValueLabel release];
	[m_oVolumeValueLabel release];
	[m_oTurnoverValueLabel release];
	[m_oPEValueLabel release];
	[m_oYieldValueLabel release];
	[m_oLotSizeValueLabel release];
	[m_oPremiumTitleLabel release];
	[m_oGearingTitleLabel release];
	[m_oPremiumValueLabel release];
	[m_oGearingValueLabel release];
	[m_oYearHighTitleLabel release];
	[m_oYearHighValueLabel release];
	[m_oYearLowTitleLabel release];
	[m_oYearLowValueLabel release];
	[m_oDayHighTitleLabel release];
	[m_oDayHighValueLabel release];
	[m_oDayLowTitleLabel release];
	[m_oDayLowValueLabel release];
	[m_oQuoteMeterTitleLabel release];
	[m_oQuoteMeterValueLabel release];
	[m_oRelatedStockTitleLabel release];
	[m_oRelatedStockValueLabel release];
	[m_oRelatedStockPriceValueLabel release];
	[m_oBackgroundImageView release];
	[m_oUndelyingChangeImageView release];
	[m_sEPSValue release];
	[m_sDPSValue release];
	
#if BEHAVIOUR_MHStaticDataView_SHOW_TODAY_FREE
	[m_oQuoteMeterFreeTodayTitleLabel release];
	[m_oQuoteMeterFreeTodayValueLabel release];
	[m_oQuoteMeterUsedTodayTitleLabel release];
	[m_oQuoteMeterUsedTodayValueLabel release];	
#endif
	
	[super dealloc];

}

@end
