//
//  MHBidAskView.m
//  MagicTrader
//
//  Created by Megahub on 03/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHBidAskView.h"
#import "MHUILabel.h"
#import "MHLanguage.h"
#import "MHUtility.h"
#import "StyleConstant.h"
#import "MHBidAskTableCell.h"

@implementation MHBidAskView

@synthesize m_oBidTitleLabel;
@synthesize m_oAskTitleLabel;
@synthesize m_oBidValueLabel;
@synthesize m_oAskValueLabel;
@synthesize m_oBidView;
@synthesize m_oAskView;
@synthesize m_oBidAskGraphicView;
@synthesize m_oBidAskTableView;
@synthesize m_oBidStringArray;
@synthesize m_oAskStringArray;
@synthesize m_oBidQueueView;
@synthesize m_oAskQueueView;
@synthesize m_fCellHeight;
@synthesize m_oCompanyLogoImageView;
@synthesize m_idCopyPriceDelegate;
@synthesize m_oCopyBidButton;
@synthesize m_oCopyAskButton;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = MHBidAskView_view_background_color;
		
		float magicNumber = 18;
		
		//Row 1
		//Bid
		m_oBidView		= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, magicNumber*2)];
		m_oBidView.image = MHBidAskView_m_oBidView_background_image;
		[self addSubview:m_oBidView];		
		
		m_oBidTitleLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 2, 14+4, magicNumber)];
		[m_oBidTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oBidTitleLabel setTextColor:MHBidAskView_m_oBidTitleLabel_textColor];
		[m_oBidTitleLabel setFont:MHBidAskView_m_oBidTitleLabel_font];
		[self addSubview:m_oBidTitleLabel];
		
		m_oBidValueLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, magicNumber-4, frame.size.width/2-2, magicNumber+4)];
		m_oBidValueLabel.textAlignment = NSTextAlignmentRight;
		[m_oBidValueLabel setTextColor:MHBidAskView_m_oBidValueLabel_textColor];
		[m_oBidValueLabel setFont:MHBidAskView_m_oBidValueLabel_font];
		[self addSubview:m_oBidValueLabel];
		
		//Ask
		m_oAskView		= [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, magicNumber*2)];
		m_oAskView.image = MHBidAskView_m_oAskView_background_image;
		[self addSubview:m_oAskView];
		
		m_oAskTitleLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, 2, 14+4, magicNumber)];
		[m_oAskTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oAskTitleLabel setTextColor:MHBidAskView_m_oAskTitleLabel_textColor];
		[m_oAskTitleLabel setFont:MHBidAskView_m_oAskTitleLabel_font];
		[self addSubview:m_oAskTitleLabel];
		
		m_oAskValueLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, magicNumber-4, frame.size.width/2, magicNumber+4)];
		m_oAskValueLabel.textAlignment = NSTextAlignmentRight;
		[m_oAskValueLabel setTextColor:MHBidAskView_m_oAskValueLabel_textColor];
		[m_oAskValueLabel setFont:MHBidAskView_m_oAskValueLabel_font];
		[self addSubview:m_oAskValueLabel];
		
		//Row 2

		
		//Row 3
		m_oBidQueueView = [[UIImageView alloc] initWithFrame:CGRectMake(0, magicNumber*3, frame.size.width/2, 245)];
		m_oBidQueueView.image = MHBidAskView_m_oBidQueueView_image;
		m_oBidQueueView.backgroundColor = [UIColor redColor];
		[self addSubview:m_oBidQueueView];
		
		m_oAskQueueView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2, magicNumber*3, frame.size.width/2, 245)];
		m_oAskQueueView.image = MHBidAskView_m_oAskQueueView_image;
		m_oAskQueueView.backgroundColor = [UIColor whiteColor];
		[self addSubview:m_oAskQueueView];
		
		m_oCompanyLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, magicNumber*2, frame.size.width, magicNumber+ magicNumber*5)];
		m_oCompanyLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:m_oCompanyLogoImageView];
		
		m_oBidAskTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, magicNumber*3, frame.size.width, magicNumber*10)];
		m_oBidAskTableView.backgroundColor = [UIColor clearColor];
		m_oBidAskTableView.separatorColor = [UIColor clearColor];
		[m_oBidAskTableView setScrollEnabled:NO];
		[m_oBidAskTableView setDataSource:self];
		[m_oBidAskTableView setDelegate:self];
		[self addSubview:m_oBidAskTableView];
		
		m_fCellHeight = magicNumber*10/NUMBER_BID_ASK_QUEUE;
		
		[self reloadText];
		
		//Data 
		m_oBidStringArray = [[NSMutableArray alloc] init];
		m_oAskStringArray = [[NSMutableArray alloc] init];
		
		for (int i = 0; i< NUMBER_BID_ASK_QUEUE; i++) {
			[m_oBidStringArray addObject:@""];
			[m_oAskStringArray addObject:@""];
		}
		
		// ***************************** Trading *****************************
		m_oCopyBidButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, magicNumber*2)];
		[m_oCopyBidButton addTarget:self action:@selector(onCopyBidButtonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oCopyBidButton];
		
		m_oCopyAskButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, magicNumber*2)];
		[m_oCopyAskButton addTarget:self action:@selector(onCopyAskButtonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oCopyAskButton];
		// ***************************** Trading *****************************
		
		[self setClipsToBounds:YES];
		
    }
    return self;
}

-(void)reloadText{
	m_oBidTitleLabel.text = MHLocalizedString(@"MHBidAskView.m_oBidTitleLabel.text", nil);
	m_oAskTitleLabel.text = MHLocalizedString(@"MHBidAskView.m_oAskTitleLabel.text", nil);
}

-(void)clean{
	m_oBidValueLabel.text = @"";
	m_oAskValueLabel.text = @"";
	
	[m_oBidStringArray removeAllObjects];
	[m_oAskStringArray removeAllObjects];
	
	for (int i = 0; i< NUMBER_BID_ASK_QUEUE; i++) {
		[m_oBidStringArray addObject:@""];
		[m_oAskStringArray addObject:@""];
	}
	
	[m_oBidAskTableView reloadData];
}

#pragma mark -
#pragma mark tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return	m_fCellHeight;
}

//************Trading ************//

-(void)onCopyBidButtonIsPressed:(id)aSender{
	if ([(NSObject *)m_idCopyPriceDelegate respondsToSelector:@selector(PTCopyPriceDelegateCallback:)]) {
		[(NSObject *)m_idCopyPriceDelegate performSelector:@selector(PTCopyPriceDelegateCallback:) withObject:aSender];
	}
}

-(void)onCopyAskButtonIsPressed:(id)aSender{
	if ([(NSObject *)m_idCopyPriceDelegate respondsToSelector:@selector(PTCopyPriceDelegateCallback:)]) {
		[(NSObject *)m_idCopyPriceDelegate performSelector:@selector(PTCopyPriceDelegateCallback:) withObject:aSender];
	}
}

//************Trading ************//


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"MHBidAskTableCell";
	
    MHBidAskTableCell *cell = (MHBidAskTableCell *)[m_oBidAskTableView dequeueReusableCellWithIdentifier:CellIdentifier];	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;	//Disable select
	
	if (cell == nil) { 
        cell = [[[MHBidAskTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	switch ([indexPath row]) {
		case 0:
			[cell setTag:TAG_LEVEL1_Bid_AskLabel];
			break;
		case 1:
			[cell setTag:TAG_LEVEL2_Bid_AskLabel];
			break;
		case 2:
			[cell setTag:TAG_LEVEL3_Bid_AskLabel];
			break;
		case 3:
			[cell setTag:TAG_LEVEL4_Bid_AskLabel];
			break;
		case 4:
			[cell setTag:TAG_LEVEL5_Bid_AskLabel];
			break;
		case 5:
			[cell setTag:TAG_LEVEL6_Bid_AskLabel];
			break;
		case 6:
			[cell setTag:TAG_LEVEL7_Bid_AskLabel];
			break;
		case 7:
			[cell setTag:TAG_LEVEL8_Bid_AskLabel];
			break;
		case 8:
			[cell setTag:TAG_LEVEL9_Bid_AskLabel];
			break;
		case 9:
			[cell setTag:TAG_LEVEL10_Bid_AskLabel];
			break;
		default:
			break;
	}
	
	// Bid queue
	[cell setBidStringWithAnimation:[m_oBidStringArray objectAtIndex:[indexPath row]]];
	
	// Ask queue
	[cell setAskStringWithAnimation:[m_oAskStringArray objectAtIndex:[indexPath row]]];
	
	[cell setBidString:[m_oBidStringArray objectAtIndex:[indexPath row]] askString:[m_oAskStringArray objectAtIndex:[indexPath row]]];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return NUMBER_BID_ASK_QUEUE;
}

- (void)dealloc {
    [m_oBidTitleLabel release];
	[m_oAskTitleLabel release];
	[m_oBidValueLabel release];
	[m_oAskValueLabel release];
	[m_oBidAskGraphicView release];
	[m_oBidView release];
	[m_oAskView release];
	[m_oCompanyLogoImageView release];
	[m_oBidQueueView release];
	[m_oAskQueueView release];
	[m_oCopyBidButton release];
	[m_oCopyAskButton release];
	[m_oBidAskTableView release];
	[m_oBidStringArray release];
	[m_oAskStringArray release];
    [super dealloc];
}

@end