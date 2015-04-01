//
//  MHBEABasicDataView.m
//  MagicTrader
//
//  Created by Megahub on 07/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHBEABasicDataView.h"
#import "MHBEAFundamentalTableCell.h"
#import "PTConstant.h"
#import "MHUtility.h"
#import "MHLanguage.h"
#import "MHFeedXObjQuote.h"
#import "MHBEAFundamentalTableCell.h"
#import "MHFeedConnectorX.h"
#import "MHRelatedStockDataView.h"
#import "StyleConstant.h"
#import "SegmentedButton.h"
#import "MHSolutionProviderView.h"

@implementation MHBEABasicDataView

@synthesize m_oStockFundamentalTitleDataArray;
@synthesize m_oStockTechnicalTitleDataArray;
@synthesize m_oCBBCTitleDataArray;
@synthesize m_oCBBCTechnicalTitleDataArray;
@synthesize m_oWarrantTitleDataArray;
@synthesize m_oWarrantTechnicalTitleDataArray;
@synthesize m_oRelateStockDataView;
@synthesize m_oStockDataSegmentedButton;
@synthesize m_oLastUpdateLabel;
@synthesize m_oLastUpdateString;
@synthesize m_oBasicDataDictionary;
@synthesize m_oTechDataDictionary;
@synthesize m_iSpreadType;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor clearColor];
		
		UIImageView *aBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		aBackgroundImageView.image = MHStockDataView_aBackgroundImageView_image;
		[self addSubview:aBackgroundImageView];
		[aBackgroundImageView release];
		
		m_oLastUpdateBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 18)];
		m_oLastUpdateBackgroundImageView.image = MHStockDataView_m_oLastUpdateBackgroundImageView_image;
		[self addSubview:m_oLastUpdateBackgroundImageView];
		
		m_oLastUpdateLabel = [[MHUILabel alloc] initWithFrame:m_oLastUpdateBackgroundImageView.frame];
		m_oLastUpdateLabel.font			= MHStockDataView_m_oLastUpdateLabel_font;
		m_oLastUpdateLabel.textAlignment = NSTextAlignmentRight;
		m_oLastUpdateLabel.textColor = MHStockDataView_m_oLastUpdateLabel_text_color;
		[self addSubview:m_oLastUpdateLabel];
        m_oLastUpdateLabel.hidden = YES;
		
		[self loadTitleStringArray];
		
		
		m_oStockDataSegmentedButton = [[SegmentedButton alloc] initWithFrame:CGRectMake(0, 0, 320, 30) items:
									   [NSArray arrayWithObjects:
										MHLocalizedString(@"MHStockDataView.m_oStockDataSegmentedControl.FundamentalData", nil),
										MHLocalizedString(@"MHStockDataView.m_oStockDataSegmentedControl.TechnicalData", nil),
										MHLocalizedString(@"MHStockDataView.m_oStockDataSegmentedControl.RelatedStockData", nil)
										, nil]];
		
		[m_oStockDataSegmentedButton setButtonSelectedColor:MHStockDataView_m_oStockDataSegmentedButton_selectedColor unselectedColor:MHStockDataView_m_oStockDataSegmentedButton_unselectedColor];
		[m_oStockDataSegmentedButton setButtonSelectedImage:MHStockDataView_m_oStockDataSegmentedButton_selectedImage];
		[m_oStockDataSegmentedButton setButtonUnSelectedImage:MHStockDataView_m_oStockDataSegmentedButton_unselectedImage];
		[m_oStockDataSegmentedButton setRightButtonSelectedImage:MHStockDataView_m_oStockDataSegmentedButton_right_selectedImage];
		[m_oStockDataSegmentedButton setRightButtonUnSelectedImage:MHStockDataView_m_oStockDataSegmentedButton_right_unselectedImage];
		[m_oStockDataSegmentedButton setLeftButtonSelectedImage:MHStockDataView_m_oStockDataSegmentedButton_left_selectedImage];
		[m_oStockDataSegmentedButton setLeftButtonUnSelectedImage:MHStockDataView_m_oStockDataSegmentedButton_left_unselectedImage];
		[m_oStockDataSegmentedButton setBackgroundImage:MHStockDataView_m_oStockDataSegmentedButton_background_image];
		[m_oStockDataSegmentedButton setSelectedButtonIndex:0];
		[m_oStockDataSegmentedButton addTarget:self action:@selector(onStockDataSegmentedButtonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oStockDataSegmentedButton];
		
		[self setSelectSelectStockData:STOCK_DATA_FUNDAMENTAL_DATA];
		
		//m_oStockDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30+11+2, 320, 210-15)];
        CGFloat height = frame.size.height - 15 - 48 + 5;
        m_oStockDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 320, height)];
		m_oStockDataTableView.backgroundColor = [UIColor clearColor];
		[m_oStockDataTableView setSeparatorColor:MHStockDataView_m_oStockDataTableView_seperator_color];
        if([MHUtility checkVersionGreater:@"7"]){
            [m_oStockDataTableView setSeparatorInset:UIEdgeInsetsZero];
        }
		[m_oStockDataTableView setDelegate:self];
		[m_oStockDataTableView setDataSource:self];
		[self addSubview:m_oStockDataTableView];
		
		//m_oRelateStockDataView = [[MHRelatedStockDataView alloc] initWithFrame:CGRectMake(0,  30+11+2, 320, 226)];
        m_oRelateStockDataView = [[MHRelatedStockDataView alloc] initWithFrame:CGRectMake(0,  30, 320, height)];
		[self addSubview:m_oRelateStockDataView];
		m_oRelateStockDataView.hidden = YES;
		
		m_oMHSolutionProviderView = [[MHSolutionProviderView alloc] initWithFrame:CGRectMake(0, 0, 320, MHSolutionProviderView_MiniModeHeight) setMiniMode:YES];
		
		m_oBasicDataDictionary = [[NSMutableDictionary alloc] init];
		m_oTechDataDictionary = [[NSMutableDictionary alloc] init];
		
		m_iSpreadType = -1;
		
    }
    return self;
}

- (void)dealloc {
	[m_oLastUpdateBackgroundImageView release];
	[m_oStockDataSegmentedButton release];
	[m_oStockDataTableView release];
	[m_oRelateStockDataView release];
	[m_oMHSolutionProviderView release];
	[m_oLastUpdateLabel release];
    [m_oStockFundamentalTitleDataArray release];
    [m_oStockTechnicalTitleDataArray release];
    [m_oCBBCTitleDataArray release];
    [m_oCBBCTechnicalTitleDataArray release];
    [m_oWarrantTitleDataArray release];
    [m_oWarrantTechnicalTitleDataArray release];
    [m_oLastUpdateString release];
    [m_oBasicDataDictionary release];
    [m_oTechDataDictionary release];
    [super dealloc];
}

//You can customized this
-(void)setSelectSelectStockData:(int)aStockData{
	switch (aStockData) {
		case STOCK_DATA_FUNDAMENTAL_DATA:
			m_oRelateStockDataView.hidden = YES;
			m_oStockDataTableView.hidden = NO;
			break;
			
		case STOCK_DATA_TECHNICAL_DATA:
			m_oRelateStockDataView.hidden = YES;
			m_oStockDataTableView.hidden = NO;
			break;
			
		case STOCK_DATA_RELATED_STOCK_DATA:
			m_oRelateStockDataView.hidden = NO;
			m_oStockDataTableView.hidden = YES;
			break;
			
		default:
			break;
	}
}

-(int)getSelectStockDataPageIndex{
	int result = -9999;
	
	switch (m_oStockDataSegmentedButton.m_iSelectedIndex) {
		case 0:
			result = STOCK_DATA_FUNDAMENTAL_DATA;
			break;
			
		case 1:
			result = STOCK_DATA_TECHNICAL_DATA;
			break;
			
		case 2:
			result = STOCK_DATA_RELATED_STOCK_DATA;
			break;
			
		default:
			break;
	}
	
	return result;
}

-(void)loadTitleStringArray{
	
	//Stock
	//Tag Name
	//TODO: rename the MHLocalizedString
	self.m_oStockFundamentalTitleDataArray  = [NSArray arrayWithObjects:
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.IEP", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.IEV", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Volatility30", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Currency", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.AuthShares", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.SharesIssued", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.MarketCap", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.NAV", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.EPS", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.DPS", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.BidAskSpread", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.MonthHigh1MMonthLow1M", nil),
											   MHLocalizedString(@"MHStockDataView.lastUpdateTitle", nil),
											   nil];
	
	//BidAskSpread need to sceaming update
	//Tag Name
	self.m_oStockTechnicalTitleDataArray		= [NSArray arrayWithObjects:
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.SMA10", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.SMA20", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.SMA50", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.SMA100", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.SMA250", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.MACD817", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.MACD1225", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.RSI9", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.RSI14", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.RSI20", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.STC10", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.STC14", nil),
												   MHLocalizedString(@"MHStockDataView.m_oStockTechnicalTitleDataArray.STC20", nil),
												   MHLocalizedString(@"MHStockDataView.lastUpdateTitle", nil),
												   nil];
	
	//CBBC or Warrant
	//Tag name
	self.m_oCBBCTitleDataArray		= [NSArray arrayWithObjects:
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.IEP", nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.IEV", nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Currency", nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Issuer", nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.EntitlementRatio", nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Strike", nil),
									   
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.OutstandingPct", nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.EffGearing", nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.ImpVol", nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Delta", nil),
									   
									   
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.ExpDate", nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Moneyness",nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.CallLevel",nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.SpotPrice",nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.BidAskSpread",nil),
									   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.MonthHigh1MMonthLow1M", nil),
									   
									   MHLocalizedString(@"MHStockDataView.lastUpdateTitle", nil),
									   nil];
	//BidAskSpread need to sceaming update
	//Tag name
	self.m_oCBBCTechnicalTitleDataArray		= [NSArray arrayWithObjects:
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA10", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA20", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA50", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA100", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA250", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.MACD817", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.MACD1225", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.RSI9", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.RSI14", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.RSI20", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.STC10", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.STC14", nil),
											   MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.STC20", nil),
											   MHLocalizedString(@"MHStockDataView.lastUpdateTitle", nil),
											   nil];
	
	
	self.m_oWarrantTitleDataArray			= [NSArray arrayWithObjects:
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.IEP", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.IEV", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Currency", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Issuer", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.EntitlementRatio", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Strike", nil),
											   
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.OutstandingPct", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.EffGearing", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.ImpVol", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Delta", nil),
											   
											   
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.ExpDate", nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.Moneyness",nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.BidAskSpread",nil),
											   MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.MonthHigh1MMonthLow1M", nil),
											   
											   MHLocalizedString(@"MHStockDataView.lastUpdateTitle", nil),
											   nil];
	
	self.m_oWarrantTechnicalTitleDataArray = [NSArray arrayWithObjects:
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA10", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA20", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA50", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA100", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.SMA250", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.MACD817", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.MACD1225", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.RSI9", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.RSI14", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.RSI20", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.STC10", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.STC14", nil),
											  MHLocalizedString(@"MHStockDataView.m_oCBBCTechnicalTitleDataArray.STC20", nil),
											  MHLocalizedString(@"MHStockDataView.lastUpdateTitle", nil),
											  nil];
	
}

// On Main Thread
-(void)performReloadTable{
	[m_oStockDataTableView reloadData];
}

-(void)reloadText{
	[self loadTitleStringArray];
	[m_oRelateStockDataView reloadText];
	[m_oStockDataSegmentedButton setButtonTitle:[NSArray arrayWithObjects:
												 MHLocalizedString(@"MHStockDataView.m_oStockDataSegmentedControl.FundamentalData", nil),
												 MHLocalizedString(@"MHStockDataView.m_oStockDataSegmentedControl.TechnicalData", nil),
												 MHLocalizedString(@"MHStockDataView.m_oStockDataSegmentedControl.RelatedStockData", nil)
												 , nil]];
	[m_oMHSolutionProviderView reloadText];
	m_oLastUpdateLabel.text = [NSString stringWithFormat:@"%@%@",MHLocalizedString(@"MHStockDataView.m_oLastUpdateLabel.text", nil),m_oLastUpdateString];
	[self performSelectorOnMainThread:@selector(performReloadTable) withObject:nil waitUntilDone:NO];
}

-(void)clean{
	m_iSpreadType = -1;
	m_oLastUpdateLabel.text	= @"";
	[m_oBasicDataDictionary removeAllObjects];
	[m_oTechDataDictionary removeAllObjects];
	[self performSelectorOnMainThread:@selector(performReloadTable) withObject:nil waitUntilDone:NO];
}


#pragma mark -
#pragma mark Button callback functions
- (void)onStockDataSegmentedButtonIsPressed:(id)sender {
   	[self setSelectSelectStockData:m_oStockDataSegmentedButton.m_iSelectedIndex];
    [m_oStockDataTableView setContentOffset:CGPointMake(0, 0)];
	[self performReloadTable];
}

#pragma mark -
#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"MHBEAFundamentalTableCell";
	
    MHBEAFundamentalTableCell *cell = (MHBEAFundamentalTableCell *)[m_oStockDataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;	//Disable select
	
	if (cell == nil) { 
        cell = [[[MHBEAFundamentalTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	switch ([self getSelectStockDataPageIndex]) {
			
		case STOCK_DATA_FUNDAMENTAL_DATA:
			
			if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_STOCK) {
				//This is a stock
				cell.tag = TAG_CELL_Type+[indexPath row];
				
				if([indexPath row] > 3){
					//One set data
					int targetIndex = [indexPath row]+STOCK_DATA_FUNDAMENTAL_DATA_STOCK_TABLE_COUNT/2;
					
					NSString *dataString = nil;
					
					switch (targetIndex) {
						case 8:
							dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_EPS];
							break;
						case 9:
							dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_DPS];
							break;
						case 10:
							[self setSpread:cell];
							break;
						case 11:
							dataString = [NSString stringWithFormat:@"%@ - %@", 
										  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo], 
										  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi]];
							break;
						case 12:	
							dataString =[m_oBasicDataDictionary objectForKey:Obj_Key_Last_Update];
							break;
						default:
							break;
					}
					
					// Skip update spread because update spread in setSpread function
					if(targetIndex!=10){
						[cell setOneSetData:[m_oStockFundamentalTitleDataArray objectAtIndex:targetIndex] value:dataString];
					}
					
				}else{
					//Two set data
					int leftIndex	= [indexPath row];
					int rightIndex	= [indexPath row]+STOCK_DATA_FUNDAMENTAL_DATA_STOCK_TABLE_COUNT/2;
					
					NSString *leftString = nil;
					NSString *rightString = nil;
					
					switch (leftIndex) {
						case 0:
							leftString = [MHUtility stringIEPToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEP] market:MARKET_HONGKONG];
							break;
						case 1:
							leftString = [MHUtility stringIEVToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEV] market:MARKET_HONGKONG];
							break;
						case 2:
							leftString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Volatility]intValue]<0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Volatility];
							break;
						case 3:
                            if(![[m_oBasicDataDictionary objectForKey:Obj_Key_Currency]isEqualToString:@"(null)"]){
                                leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Currency];
                            }else{
                                leftString = @"";
                            }
							break;
					}
					
					switch (rightIndex) {
						case 4:
							rightString = [MHUtility stringAuthSharesToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_Auth_Cap] market:MARKET_HONGKONG];
							break;
						case 5:
							rightString = [MHUtility stringSharesIssuedToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_Shares_Issued] market:MARKET_HONGKONG];
							break;
						case 6:
                            if([[m_oBasicDataDictionary objectForKey:Obj_Key_Market_Cap] floatValue] == -1){
                                rightString = @"";
                            }else{
                                rightString = [MHUtility stringMarketCapToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_Market_Cap] market:MARKET_HONGKONG];
                            }
							break;
						case 7:
							rightString = [MHUtility stringMarketCapToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_NAV] market:MARKET_HONGKONG];
						default:
							break;
					}
					
					[cell setTwoSetData:[m_oStockFundamentalTitleDataArray objectAtIndex:leftIndex] value:leftString rightTitle:[m_oStockFundamentalTitleDataArray objectAtIndex:rightIndex] value:rightString];
				}
			}else if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_CBBC) {
				//This is a CBBC
				cell.tag = TAG_CELL_Type+[indexPath row];
				
				if([indexPath row] > 5){
					int targetIndex = [indexPath row]+4;
					NSString *dataString = nil;
					
					switch (targetIndex) {
						case 10:
                            if([[m_oBasicDataDictionary objectForKey:Obj_Key_Exp_Date]intValue] > 0){
                                dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Exp_Date];
                            }else{
                                dataString = @"";
                            }
							break;
						case 11:
                            if([[MHUtility removeComma:[m_oBasicDataDictionary objectForKey:Obj_Key_Moneyness]]floatValue]!=999999){
                                dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Moneyness];
                            }else{
                                dataString = @"";
                            }
							break;
						case 12:
							dataString =  [m_oBasicDataDictionary objectForKey:Obj_Key_Call_Level];
							break;
						case 13:
							dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Percent_To_Call];
							break;
						case 14:
							[self setSpread:cell];
							break;
						case 15:
							dataString = [NSString stringWithFormat:@"%@ - %@", 
										  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo], 
										  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi]];
							break;
						default:
							break;
					}
					
					// Skip update spread because update spread in setSpread function
					if(targetIndex!=14){
						[cell setOneSetData:[m_oCBBCTitleDataArray objectAtIndex:targetIndex] value:dataString];
					}
				}else {
					int leftIndex	= [indexPath row];
					int rightIndex	= [indexPath row]+STOCK_DATA_FUNDAMENTAL_DATA_CBBC_TABLE_COUNT/2;
					
					NSString *leftString = nil;
					NSString *rightString = nil;
					
					switch (leftIndex) {
						case 0:
							leftString = [MHUtility stringIEPToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEP] market:MARKET_HONGKONG];
							break;
						case 1:
							leftString = [MHUtility stringIEVToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEV] market:MARKET_HONGKONG];
							break;
						case 2:
                            if(![[m_oBasicDataDictionary objectForKey:Obj_Key_Currency]isEqualToString:@"(null)"]){
                                leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Currency];
                            }else{
                                leftString = @"";
                            }
							break;
						case 3: 
                            leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Issuer];
                            break;
						case 4:
                            if([[m_oBasicDataDictionary objectForKey:Obj_Key_Entitlement_Ratio]floatValue]>0){
                                leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Entitlement_Ratio];
                            }else{
                                leftString = @"";
                            }
							break;
						case 5:
                            if([[m_oBasicDataDictionary objectForKey:Obj_Key_Strike]floatValue]>0){
                                leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Strike];
                            }else{
                                leftString = @"";
                            }
							break;	
						default:
							break;
					}
					switch (rightIndex) {
						case 6:
							rightString = [m_oBasicDataDictionary objectForKey:Obj_Key_Outstanding];
							break;
						case 7:
							rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Eff_Gearing]floatValue]<999999?[MHUtility floatPriceToString:[[m_oBasicDataDictionary objectForKey:Obj_Key_Eff_Gearing]floatValue] market:MARKET_HONGKONG]:@"";
							break;
						case 8:
							rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Imp_Vol]floatValue]<0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Imp_Vol];
							break;
						case 9:
							rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Delta]floatValue]<999999?[MHUtility floatPriceToString:[[m_oBasicDataDictionary objectForKey:Obj_Key_Delta]floatValue] market:MARKET_HONGKONG]:@"";
							break;
						default:
							break;
					}
					
					[cell setTwoSetData:[m_oCBBCTitleDataArray objectAtIndex:leftIndex] value:leftString rightTitle:[m_oCBBCTitleDataArray objectAtIndex:rightIndex]  value:rightString];
					if(rightIndex > 9){
						[cell setTwoSetData:[m_oCBBCTitleDataArray objectAtIndex:leftIndex] value:leftString rightTitle:@""  value:@""];			
					}
					
				}
			}else if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_WARRANT){
				cell.tag = TAG_CELL_Type+[indexPath row];
				
				if([indexPath row] > 5){
					int targetIndex = [indexPath row]+4;
					NSString *dataString = nil;
					
					switch (targetIndex) {
						case 10:
                            if([[m_oBasicDataDictionary objectForKey:Obj_Key_Exp_Date]intValue] > 0){
                                dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Exp_Date];
                            }else{
                                dataString = @"";
                            }
							break;
						case 11:
                            if([[MHUtility removeComma:[m_oBasicDataDictionary objectForKey:Obj_Key_Moneyness]]floatValue]!=999999){
                                dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Moneyness];
                            }else{
                                dataString = @"";
                            }
							break;
						case 12:
							[self setSpread:cell];
							break;
						case 13:
							dataString = [NSString stringWithFormat:@"%@ - %@", 
										  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo], 
										  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi]];
							break;
						default:
							break;
					}
					
					// Skip update spread because update spread in setSpread function
					if(targetIndex!=12){
						[cell setOneSetData:[m_oWarrantTitleDataArray objectAtIndex:targetIndex] value:dataString];
					}
					
				}else {
					int leftIndex	= [indexPath row];
					int rightIndex	= [indexPath row]+STOCK_DATA_FUNDAMENTAL_DATA_CBBC_TABLE_COUNT/2;
					
					NSString *leftString = nil;
					NSString *rightString = nil;
					
					switch (leftIndex) {
						case 0:
							leftString = [MHUtility stringIEPToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEP] market:MARKET_HONGKONG];
							break;
						case 1:
							leftString = [MHUtility stringIEVToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEV] market:MARKET_HONGKONG];
							break;
						case 2:
                            if(![[m_oBasicDataDictionary objectForKey:Obj_Key_Currency]isEqualToString:@"(null)"]){
                                leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Currency];
                            }else{
                                leftString = @"";
                            }
							break;
						case 3:
                            leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Issuer];
                            break;
						case 4:
                            if([[m_oBasicDataDictionary objectForKey:Obj_Key_Entitlement_Ratio]floatValue]>0){
                                leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Entitlement_Ratio];
                            }else{
                                leftString = @"";
                            }
							break;
						case 5:
                            if([[m_oBasicDataDictionary objectForKey:Obj_Key_Strike]floatValue]>0){
                                leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Strike];
                            }else{
                                leftString = @"";
                            }
							break;	
						default:
							
							break;
					}
					switch (rightIndex) {
						case 6:
							rightString = [m_oBasicDataDictionary objectForKey:Obj_Key_Outstanding];
							break;
						case 7:
							rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Eff_Gearing]floatValue]<999999?[MHUtility floatPriceToString:[[m_oBasicDataDictionary objectForKey:Obj_Key_Eff_Gearing]floatValue] market:MARKET_HONGKONG]:@"";
							break;
						case 8:
							rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Imp_Vol]floatValue]<0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Imp_Vol];
							break;
						case 9:
							rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Delta]floatValue]<999999?[MHUtility floatPriceToString:[[m_oBasicDataDictionary objectForKey:Obj_Key_Delta]floatValue] market:MARKET_HONGKONG]:@"";
							break;
						default:
							break;
					}
					
					[cell setTwoSetData:[m_oWarrantTitleDataArray objectAtIndex:leftIndex] value:leftString rightTitle:[m_oWarrantTitleDataArray objectAtIndex:rightIndex]  value:rightString];
					if(rightIndex > 9){
						[cell setTwoSetData:[m_oWarrantTitleDataArray objectAtIndex:leftIndex] value:leftString rightTitle:@""  value:@""];			
					}
					
				}
			}
			break;
			
			//if Technical data, it will generate....
		case STOCK_DATA_TECHNICAL_DATA:
			cell.tag = TAG_CELL_Type+[indexPath row];
			
			if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_STOCK ||
				[[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_CBBC ||
				[[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_WARRANT){
				
				if([indexPath row] < 7){
					int targetIndex = [indexPath row];
					NSString *targetString = nil;
					
					switch (targetIndex) {
						case 0:
							targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA10]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA10];
							break;
						case 1:
							targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA20]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA20];
							break;
						case 2:
							targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA50]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA50];
							break;
						case 3:
							targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA100]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA100];
							break;
						case 4:
							targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA250]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA250];
							break;
						case 5:
							targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_MACD817]floatValue]<999999?[MHUtility floatPriceToString:[[m_oTechDataDictionary objectForKey:Obj_Key_MACD817]floatValue] market:MARKET_HONGKONG]:@"";
							break;
						case 6:
							targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_MACD1225]floatValue]<999999?[MHUtility floatPriceToString:[[m_oTechDataDictionary objectForKey:Obj_Key_MACD1225]floatValue] market:MARKET_HONGKONG]:@"";
							break;
						default:
							break;
					}
					
					[cell setOneSetData:[m_oStockTechnicalTitleDataArray objectAtIndex:targetIndex] value:targetString];
					
				}else {
					int leftIndex = [indexPath row];
					int rightIndex = [indexPath row]+3;	
					
					NSString *leftString = nil;
					NSString *rightString = nil;
					
					switch (leftIndex) {
						case 7:
							leftString = [[m_oTechDataDictionary objectForKey:Obj_Key_RSI9]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_RSI9];
							break;
						case 8:
							leftString = [[m_oTechDataDictionary objectForKey:Obj_Key_RSI14]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_RSI14];
							break;
						case 9:
							leftString = [[m_oTechDataDictionary objectForKey:Obj_Key_RSI20]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_RSI20];
							break;
						default:
							break;
					}
					
					switch (rightIndex) {
						case 10:
							rightString = [[m_oTechDataDictionary objectForKey:Obj_Key_STC10]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_STC10];
							break;
						case 11:
							rightString = [[m_oTechDataDictionary objectForKey:Obj_Key_STC14]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_STC14];
							break;
						case 12:
							rightString = [[m_oTechDataDictionary objectForKey:Obj_Key_STC20]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_STC20];
							break;
						default:
							break;
					}
					
					[cell setTwoSetData:[m_oStockTechnicalTitleDataArray objectAtIndex:leftIndex] value:leftString rightTitle:[m_oStockTechnicalTitleDataArray objectAtIndex:rightIndex] value:rightString];
				}
				
				break;
			}
			
		default:
			break;
	}
	
	return cell;
}

- (void)setSpread:(MHBEAFundamentalTableCell*)aCell{
	double bidSpread = 0.0;
	double askSpread = 0.0;
	
	if([m_oBasicDataDictionary objectForKey:Obj_Key_Bid_Spread]!=nil && [m_oBasicDataDictionary objectForKey:Obj_Key_Ask_Spread]!=nil){
		bidSpread = [[m_oBasicDataDictionary objectForKey:Obj_Key_Bid_Spread] doubleValue];
		askSpread = [[m_oBasicDataDictionary objectForKey:Obj_Key_Ask_Spread] doubleValue];
	}
	
	[aCell setOneSetData:MHLocalizedString(@"MHStockDataView.m_oFundamentalTitleDataArray.BidAskSpread", nil)
				   value:[NSString stringWithFormat:@"%@/%@",
						  bidSpread==0?@"-":[MHUtility doublePriceToString:bidSpread market:MARKET_HONGKONG],
						  askSpread==0?@"-":[MHUtility doublePriceToString:askSpread market:MARKET_HONGKONG]]];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 1){
		return;
	}
	
	if(((MHBEAFundamentalTableCell *)cell).m_isOneSetDataOnly){
		UIImageView *i = nil;
		if([indexPath row]%2 == 0){
			i = [[UIImageView alloc] initWithImage:MHStockDataView_m_oneSetData_even_image];
		}else {
			i = [[UIImageView alloc] initWithImage:MHStockDataView_m_oneSetData_odd_image];
		}
		
		((MHBEAFundamentalTableCell *)cell).m_oLeftImageView.image = i.image;
		[i release];
		
	}else {
		UIImageView *i = nil;
		if([indexPath row]%2 == 0){
            //			i = [[UIImageView alloc] initWithImage:MHStockDataView_m_notOneSetData_even_image];
            i = [[UIImageView alloc] initWithImage:MHStockDataView_m_oneSetData_even_image];
		}else {
            //			i = [[UIImageView alloc] initWithImage:MHStockDataView_m_notOneSetData_odd_image];
            i = [[UIImageView alloc] initWithImage:MHStockDataView_m_oneSetData_odd_image];
		}
		
		((MHBEAFundamentalTableCell *)cell).m_oLeftImageView.image = i.image;
		((MHBEAFundamentalTableCell *)cell).m_oRightImageView.image = i.image;
		[i release];
	}
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (section == 1) {
		return 1;
	}
	
	int count = 0;
	
	// if reveive all basic data, then show
	switch ([self getSelectStockDataPageIndex]) {
		case STOCK_DATA_FUNDAMENTAL_DATA:
			if([m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type]!=nil){
				if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_STOCK) {
					count = STOCK_DATA_FUNDAMENTAL_DATA_STOCK_TABLE_COUNT;
				}else if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_CBBC){
					count = STOCK_DATA_FUNDAMENTAL_DATA_CBBC_TABLE_COUNT;
				} else if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_WARRANT) {
					count = STOCK_DATA_FUNDAMENTAL_DATA_WARRANT_TABLE_COUNT;
				}
			}
			break;
		case STOCK_DATA_TECHNICAL_DATA:
			if([m_oTechDataDictionary objectForKey:Obj_Key_Stock_Type]!=nil){
				if ([[m_oTechDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_STOCK) {
					count = STOCK_DATA_TECHNICAL_DATA_STOCK_TABLE_COUNT;
				}else if ([[m_oTechDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_CBBC ||
						  [[m_oTechDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_WARRANT) {
					count = STOCK_DATA_TECHNICAL_DATA_WARRANT_OR_CBBC_TABLE_COUNT;
				}
			}
			break;
	}
	return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 1) {
		return MHSolutionProviderView_MiniModeHeight;
	} else {
		return Default_table_cell_height;
	}
}

- (void)setTextAnimation{
	switch ([self getSelectStockDataPageIndex]) {
			
		case STOCK_DATA_FUNDAMENTAL_DATA:
			if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_STOCK) {
				//This is a stock
				
				for(int i=0;i<13;i++){
					int viewTag = TAG_CELL_Type;
					
					//One set data
					if(i > 7){
						viewTag=viewTag+i-4;
						
						NSString *dataString = nil;
						
						switch (i) {
							case 8:
								dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_EPS];
								break;
							case 9:
								dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_DPS];
								break;
							case 10:{
								double bidSpread = 0.0;
								double askSpread = 0.0;
								
								dataString = [NSString stringWithFormat:@"%@ / %@",
											  bidSpread==0?@"-":[MHUtility doublePriceToString:bidSpread market:MARKET_HONGKONG],
											  askSpread==0?@"-":[MHUtility doublePriceToString:askSpread market:MARKET_HONGKONG]];
								
							}break;
							case 11:
								dataString = [NSString stringWithFormat:@"%@ - %@",
											  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo],
											  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi]];
								break;
							case 12:
								dataString =[m_oBasicDataDictionary objectForKey:Obj_Key_Last_Update];
								break;
							default:
								break;
						}
						
						if([[self viewWithTag:viewTag] isKindOfClass:[MHBEAFundamentalTableCell class]]){
							
							MHBEAFundamentalTableCell *aCell = (MHBEAFundamentalTableCell *)[self viewWithTag:viewTag];
							
							NSIndexPath *indexPath = [m_oStockDataTableView indexPathForCell:aCell];
							int targetIndex = [indexPath row]+STOCK_DATA_FUNDAMENTAL_DATA_STOCK_TABLE_COUNT/2;
							
							[aCell setOneSetDataWithAnimation:[m_oStockFundamentalTitleDataArray objectAtIndex:targetIndex] value:dataString];
							
						}
						
					}else{
						//Two set data
						if(i<4){
							viewTag=viewTag+i;
						}else{
							viewTag=viewTag+i-4;
						}
						
						NSString *leftString = nil;
						NSString *rightString = nil;
						
						switch (i) {
							case 0:
								leftString = [MHUtility stringIEPToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEP] market:MARKET_HONGKONG];
								break;
							case 1:
								leftString = [MHUtility stringIEVToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEV] market:MARKET_HONGKONG];
								break;
							case 2:
								leftString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Volatility]intValue]<0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Volatility];
								break;
							case 3:
                                if(![[m_oBasicDataDictionary objectForKey:Obj_Key_Currency]isEqualToString:@"(null)"]){
                                    leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Currency];
                                }else{
                                    leftString = @"";
                                }
								break;
							case 4:
								rightString = [MHUtility stringAuthSharesToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_Auth_Cap] market:MARKET_HONGKONG];
								break;
							case 5:
								rightString = [MHUtility stringSharesIssuedToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_Shares_Issued] market:MARKET_HONGKONG];
								break;
							case 6:
                                if([[m_oBasicDataDictionary objectForKey:Obj_Key_Market_Cap] floatValue] == -1){
                                    rightString = @"";
                                }else{
                                    rightString = [MHUtility stringMarketCapToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_Market_Cap] market:MARKET_HONGKONG];
                                }
								break;
							case 7:
								rightString = [MHUtility stringMarketCapToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_NAV] market:MARKET_HONGKONG];
							default:
								break;
						}
						
						if([[self viewWithTag:viewTag] isKindOfClass:[MHBEAFundamentalTableCell class]]){
							
							MHBEAFundamentalTableCell *aCell = (MHBEAFundamentalTableCell *)[self viewWithTag:viewTag];
							
							NSIndexPath *indexPath = [m_oStockDataTableView indexPathForCell:aCell];
							int leftIndex	= [indexPath row];
							int rightIndex	= [indexPath row]+STOCK_DATA_FUNDAMENTAL_DATA_STOCK_TABLE_COUNT/2;
							
							if([leftString length]>0){
								[aCell setTwoSetDataWithLeftStringWithAnimation:[m_oStockFundamentalTitleDataArray objectAtIndex:leftIndex] value:leftString];
							}else{
								[aCell setTwoSetDataWithRightStringWithAnimation:[m_oStockFundamentalTitleDataArray objectAtIndex:rightIndex] value:rightString];
							}
						}
						
					}
				}
			}else if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_CBBC) {
				
				//This is a CBBC
				for(int i=0;i<16;i++){
					int viewTag = TAG_CELL_Type;
					
					if(i > 9){
						
						viewTag=viewTag+i-4;
						
						NSString *dataString = nil;
						
						switch (i) {
							case 10:
                                if([[m_oBasicDataDictionary objectForKey:Obj_Key_Exp_Date]intValue] > 0){
                                    dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Exp_Date];
                                }else{
                                    dataString = @"";
                                }
								break;
							case 11:
                                if([[MHUtility removeComma:[m_oBasicDataDictionary objectForKey:Obj_Key_Moneyness]]floatValue]!=999999){
                                    dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Moneyness];
                                }else{
                                    dataString = @"";
                                }
								break;
							case 12:
								dataString =  [m_oBasicDataDictionary objectForKey:Obj_Key_Call_Level];
								break;
							case 13:
								dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Percent_To_Call];
								break;
							case 14:{
								double bidSpread = 0.0;
								double askSpread = 0.0;
								
								dataString = [NSString stringWithFormat:@"%@ / %@",
											  bidSpread==0?@"-":[MHUtility doublePriceToString:bidSpread market:MARKET_HONGKONG],
											  askSpread==0?@"-":[MHUtility doublePriceToString:askSpread market:MARKET_HONGKONG]];
								
							}break;
							case 15:
								dataString = [NSString stringWithFormat:@"%@ - %@",
											  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo],
											  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi]];
								break;
							default:
								break;
						}
						
						if([[self viewWithTag:viewTag] isKindOfClass:[MHBEAFundamentalTableCell class]]){
							
							MHBEAFundamentalTableCell *aCell = (MHBEAFundamentalTableCell *)[self viewWithTag:viewTag];
							
							NSIndexPath *indexPath = [m_oStockDataTableView indexPathForCell:aCell];
							int targetIndex = [indexPath row]+4;
							
							[aCell setOneSetDataWithAnimation:[m_oCBBCTitleDataArray objectAtIndex:targetIndex] value:dataString];
							
						}
						
					}else {
						
						if(i<6){
							viewTag=viewTag+i;
						}else{
							viewTag=viewTag+i-6;
						}
						
						NSString *leftString = nil;
						NSString *rightString = nil;
						
						switch (i) {
							case 0:
								leftString = [MHUtility stringIEPToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEP] market:MARKET_HONGKONG];
								break;
							case 1:
								leftString = [MHUtility stringIEVToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEV] market:MARKET_HONGKONG];
								break;
							case 2:
                                if(![[m_oBasicDataDictionary objectForKey:Obj_Key_Currency]isEqualToString:@"(null)"]){
                                    leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Currency];
                                }else{
                                    leftString = @"";
                                }
								break;
							case 3: {
                                leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Issuer];
							} break;
							case 4:
                                if([[m_oBasicDataDictionary objectForKey:Obj_Key_Entitlement_Ratio]floatValue]>0){
                                    leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Entitlement_Ratio];
                                }else{
                                    leftString = @"";
                                }
								break;
							case 5:
                                if([[m_oBasicDataDictionary objectForKey:Obj_Key_Strike]floatValue]>0){
                                    leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Strike];
                                }else{
                                    leftString = @"";
                                }
								break;
							case 6:
								rightString = [m_oBasicDataDictionary objectForKey:Obj_Key_Outstanding];
								break;
							case 7:
								rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Eff_Gearing]floatValue]<999999?[MHUtility floatPriceToString:[[m_oBasicDataDictionary objectForKey:Obj_Key_Eff_Gearing]floatValue] market:MARKET_HONGKONG]:@"";
								break;
							case 8:
								rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Imp_Vol]floatValue]<0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Imp_Vol];
								break;
							case 9:
								rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Delta]floatValue]<999999?[MHUtility floatPriceToString:[[m_oBasicDataDictionary objectForKey:Obj_Key_Delta]floatValue] market:MARKET_HONGKONG]:@"";
								break;
							default:
								break;
						}
						
						if([[self viewWithTag:viewTag] isKindOfClass:[MHBEAFundamentalTableCell class]]){
							
							MHBEAFundamentalTableCell *aCell = (MHBEAFundamentalTableCell *)[self viewWithTag:viewTag];
							
							NSIndexPath *indexPath = [m_oStockDataTableView indexPathForCell:aCell];
							int leftIndex	= [indexPath row];
							int rightIndex	= [indexPath row]+STOCK_DATA_FUNDAMENTAL_DATA_CBBC_TABLE_COUNT/2;
							
							if([leftString length]>0){
								[aCell setTwoSetDataWithLeftStringWithAnimation:[m_oCBBCTitleDataArray objectAtIndex:leftIndex] value:leftString];
							}else{
								[aCell setTwoSetDataWithRightStringWithAnimation:[m_oCBBCTitleDataArray objectAtIndex:rightIndex] value:rightString];
							}
							
							if(rightIndex > 9){
								[aCell setTwoSetData:[m_oCBBCTitleDataArray objectAtIndex:leftIndex] value:leftString rightTitle:@""  value:@""];
							}
							
						}
						
						
					}
				}
			}else if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_WARRANT){
				
				for(int i=0;i<14;i++){
					int viewTag = TAG_CELL_Type;
					
					if(i > 9){
						
						viewTag=viewTag+i-4;
						
						NSString *dataString = nil;
						
						switch (i) {
							case 10:
                                if([[m_oBasicDataDictionary objectForKey:Obj_Key_Exp_Date]intValue] > 0){
                                    dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Exp_Date];
                                }else{
                                    dataString = @"";
                                }
								break;
							case 11:
                                if([[MHUtility removeComma:[m_oBasicDataDictionary objectForKey:Obj_Key_Moneyness]]floatValue]!=999999){
                                    dataString = [m_oBasicDataDictionary objectForKey:Obj_Key_Moneyness];
                                }else{
                                    dataString = @"";
                                }
								break;
							case 12:{
								double bidSpread = 0.0;
								double askSpread = 0.0;
								
								dataString = [NSString stringWithFormat:@"%@ / %@",
											  bidSpread==0?@"-":[MHUtility doublePriceToString:bidSpread market:MARKET_HONGKONG],
											  askSpread==0?@"-":[MHUtility doublePriceToString:askSpread market:MARKET_HONGKONG]];
								
							}break;
							case 13:
								dataString = [NSString stringWithFormat:@"%@ - %@",
											  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Lo],
											  [[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi] length]==0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Month_Hi]];
								break;
							default:
								break;
						}
						
						if([[self viewWithTag:viewTag] isKindOfClass:[MHBEAFundamentalTableCell class]]){
							
							MHBEAFundamentalTableCell *aCell = (MHBEAFundamentalTableCell *)[self viewWithTag:viewTag];
							
							NSIndexPath *indexPath = [m_oStockDataTableView indexPathForCell:aCell];
							int targetIndex = [indexPath row]+4;
							
							[aCell setOneSetDataWithAnimation:[m_oWarrantTitleDataArray objectAtIndex:targetIndex] value:dataString];
							
						}
						
					}else {
						
						if(i<6){
							viewTag=viewTag+i;
						}else{
							viewTag=viewTag+i-6;
						}
						
						NSString *leftString = nil;
						NSString *rightString = nil;
						
						switch (i) {
							case 0:
								leftString = [MHUtility stringIEPToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEP] market:MARKET_HONGKONG];
								break;
							case 1:
								leftString = [MHUtility stringIEVToDisplayableString:[m_oBasicDataDictionary objectForKey:Obj_Key_IEV] market:MARKET_HONGKONG];
								break;
							case 2:
                                if(![[m_oBasicDataDictionary objectForKey:Obj_Key_Currency]isEqualToString:@"(null)"]){
                                    leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Currency];
                                }else{
                                    leftString = @"";
                                }
								break;
							case 3:{
                                leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Issuer];
							} break;
							case 4:
                                if([[m_oBasicDataDictionary objectForKey:Obj_Key_Entitlement_Ratio]floatValue]>0){
                                    leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Entitlement_Ratio];
                                }else{
                                    leftString = @"";
                                }
								break;
							case 5:
                                if([[m_oBasicDataDictionary objectForKey:Obj_Key_Strike]floatValue]>0){
                                    leftString = [m_oBasicDataDictionary objectForKey:Obj_Key_Strike];
                                }else{
                                    leftString = @"";
                                }
								break;
							case 6:
								rightString = [m_oBasicDataDictionary objectForKey:Obj_Key_Outstanding];
								break;
							case 7:
								rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Eff_Gearing]floatValue]<999999?[MHUtility floatPriceToString:[[m_oBasicDataDictionary objectForKey:Obj_Key_Eff_Gearing]floatValue] market:MARKET_HONGKONG]:@"";
								break;
							case 8:
								rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Imp_Vol]floatValue]<0?@"":[m_oBasicDataDictionary objectForKey:Obj_Key_Imp_Vol];
								break;
							case 9:
								rightString = [[m_oBasicDataDictionary objectForKey:Obj_Key_Delta]floatValue]<999999?[MHUtility floatPriceToString:[[m_oBasicDataDictionary objectForKey:Obj_Key_Delta]floatValue] market:MARKET_HONGKONG]:@"";
								break;
							default:
								break;
						}
						
						if([[self viewWithTag:viewTag] isKindOfClass:[MHBEAFundamentalTableCell class]]){
							
							MHBEAFundamentalTableCell *aCell = (MHBEAFundamentalTableCell *)[self viewWithTag:viewTag];
							
							NSIndexPath *indexPath = [m_oStockDataTableView indexPathForCell:aCell];
							int leftIndex	= [indexPath row];
							int rightIndex	= [indexPath row]+STOCK_DATA_FUNDAMENTAL_DATA_CBBC_TABLE_COUNT/2;
							
							if([leftString length]>0){
								[aCell setTwoSetDataWithLeftStringWithAnimation:[m_oWarrantTitleDataArray objectAtIndex:leftIndex] value:leftString];
							}else{
								[aCell setTwoSetDataWithRightStringWithAnimation:[m_oWarrantTitleDataArray objectAtIndex:rightIndex] value:rightString];
							}
							
							if(rightIndex > 9){
								[aCell setTwoSetData:[m_oWarrantTitleDataArray objectAtIndex:leftIndex] value:leftString rightTitle:@"" value:@""];
							}
							
						}
					}
				}
			}
			break;
			
			//if Technical data, it will generate....
		case STOCK_DATA_TECHNICAL_DATA:
			if ([[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_STOCK ||
				[[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_CBBC ||
				[[m_oBasicDataDictionary objectForKey:Obj_Key_Stock_Type] intValue] == STOCK_TYPE_WARRANT){
				
				for(int i=0;i<13;i++){
					int viewTag = TAG_CELL_Type;
					
					if(i < 7){
						
						viewTag=viewTag+i;
						
						NSString *targetString = nil;
						
						switch (i) {
							case 0:
								targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA10]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA10];
								break;
							case 1:
								targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA20]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA20];
								break;
							case 2:
								targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA50]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA50];
								break;
							case 3:
								targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA100]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA100];
								break;
							case 4:
								targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_SMA250]floatValue]<0.0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_SMA250];
								break;
							case 5:
								targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_MACD817]floatValue]<999999?[MHUtility floatPriceToString:[[m_oTechDataDictionary objectForKey:Obj_Key_MACD817]floatValue] market:MARKET_HONGKONG]:@"";
								break;
							case 6:
								targetString = [[m_oTechDataDictionary objectForKey:Obj_Key_MACD1225]floatValue]<999999?[MHUtility floatPriceToString:[[m_oTechDataDictionary objectForKey:Obj_Key_MACD1225]floatValue] market:MARKET_HONGKONG]:@"";
								break;
							default:
								break;
						}
						
						if([[self viewWithTag:viewTag] isKindOfClass:[MHBEAFundamentalTableCell class]]){
							
							MHBEAFundamentalTableCell *aCell = (MHBEAFundamentalTableCell *)[self viewWithTag:viewTag];
							
							NSIndexPath *indexPath = [m_oStockDataTableView indexPathForCell:aCell];
							int targetIndex = [indexPath row];
							
							[aCell setOneSetDataWithAnimation:[m_oStockTechnicalTitleDataArray objectAtIndex:targetIndex] value:targetString];
							
						}
						
					}else {
						
						if(i<10){
							viewTag=viewTag+i;
						}else{
							viewTag=viewTag+i-3;
						}
						
						NSString *leftString = nil;
						NSString *rightString = nil;
						
						switch (i) {
							case 7:
								leftString = [[m_oTechDataDictionary objectForKey:Obj_Key_RSI9]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_RSI9];
								break;
							case 8:
								leftString = [[m_oTechDataDictionary objectForKey:Obj_Key_RSI14]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_RSI14];
								break;
							case 9:
								leftString = [[m_oTechDataDictionary objectForKey:Obj_Key_RSI20]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_RSI20];
								break;
							case 10:
								rightString = [[m_oTechDataDictionary objectForKey:Obj_Key_STC10]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_STC10];
								break;
							case 11:
								rightString = [[m_oTechDataDictionary objectForKey:Obj_Key_STC14]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_STC14];
								break;
							case 12:
								rightString = [[m_oTechDataDictionary objectForKey:Obj_Key_STC20]floatValue]<0?@"":[m_oTechDataDictionary objectForKey:Obj_Key_STC20];
								break;
							default:
								break;
						}
						
						if([[self viewWithTag:viewTag] isKindOfClass:[MHBEAFundamentalTableCell class]]){
							
							MHBEAFundamentalTableCell *aCell = (MHBEAFundamentalTableCell *)[self viewWithTag:viewTag];
							
							NSIndexPath *indexPath = [m_oStockDataTableView indexPathForCell:aCell];
							int leftIndex = [indexPath row];
							int rightIndex = [indexPath row]+3;
							
							if([leftString length]>0){
								[aCell setTwoSetDataWithLeftStringWithAnimation:[m_oStockTechnicalTitleDataArray objectAtIndex:leftIndex] value:leftString];
							}else{
								[aCell setTwoSetDataWithRightStringWithAnimation:[m_oStockTechnicalTitleDataArray objectAtIndex:rightIndex] value:rightString];
							}
						}
						
					}
				}
				
				break;
			}
			
		default:
			break;
	}
	
}

- (void)updatePriceToCall:(float)aPriceToCall {
    [m_oBasicDataDictionary setValue:[MHUtility floatPremiumToString:aPriceToCall market:MARKET_HONGKONG] forKey:Obj_Key_Percent_To_Call];
    [self performSelectorOnMainThread:@selector(performReloadTable) withObject:nil waitUntilDone:NO];
}


#pragma mark - SNAPSHOT Account
/************************************** SNAPSHOT Account**************************************/
- (void)updateLastUpdate:(NSString *)aText {
    self.m_oLastUpdateString = aText;
    m_oLastUpdateLabel.text = [NSString stringWithFormat:@"%@%@",MHLocalizedString(@"MHStockDataView.m_oLastUpdateLabel.text", nil),m_oLastUpdateString];
}

- (void)updateSRData:(MHFeedXObjQuote*)quoteData{
	[m_oBasicDataDictionary setValue:quoteData.m_sIEP forKey:Obj_Key_IEP];
	[m_oBasicDataDictionary setValue:quoteData.m_sIEV forKey:Obj_Key_IEV];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sMonthHigh1M decPlace:3] forKey:Obj_Key_Month_Hi];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sMonthLow1M decPlace:3] forKey:Obj_Key_Month_Lo];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sNAV decPlace:3] forKey:Obj_Key_NAV];
	
	if([quoteData.m_sStockType isEqualToString:STOCK_TYPE_SR_STOCK]){
		[m_oBasicDataDictionary setValue:[NSString stringWithFormat:@"%d",STOCK_TYPE_STOCK] forKey:Obj_Key_Stock_Type];
		[m_oTechDataDictionary setValue:[NSString stringWithFormat:@"%d",STOCK_TYPE_STOCK] forKey:Obj_Key_Stock_Type];
	}else if([quoteData.m_sStockType isEqualToString:STOCK_TYPE_SR_WARRANT]){
		[m_oBasicDataDictionary setValue:[NSString stringWithFormat:@"%d",STOCK_TYPE_WARRANT] forKey:Obj_Key_Stock_Type];
		[m_oTechDataDictionary setValue:[NSString stringWithFormat:@"%d",STOCK_TYPE_WARRANT] forKey:Obj_Key_Stock_Type];
	}else if([quoteData.m_sStockType isEqualToString:STOCK_TYPE_SR_CBBC]){
		[m_oBasicDataDictionary setValue:[NSString stringWithFormat:@"%d",STOCK_TYPE_CBBC] forKey:Obj_Key_Stock_Type];
		[m_oTechDataDictionary setValue:[NSString stringWithFormat:@"%d",STOCK_TYPE_CBBC] forKey:Obj_Key_Stock_Type];
	}
	
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sCallLevel decPlace:3] forKey:Obj_Key_Call_Level];
	[m_oBasicDataDictionary setValue:quoteData.m_sCurrency forKey:Obj_Key_Currency];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sDPS decPlace:3] forKey:Obj_Key_DPS];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sEntitlementRatio decPlace:3] forKey:Obj_Key_Entitlement_Ratio];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sEPS decPlace:3] forKey:Obj_Key_EPS];
	[m_oBasicDataDictionary setValue:quoteData.m_sExpDate forKey:Obj_Key_Exp_Date];
	[m_oBasicDataDictionary setValue:quoteData.m_sIssuer forKey:Obj_Key_Issuer];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sOutstandingPct decPlace:3] forKey:Obj_Key_Outstanding];
	[m_oBasicDataDictionary setValue:quoteData.m_sSharesIssued forKey:Obj_Key_Shares_Issued];
	[m_oBasicDataDictionary setValue:quoteData.m_sAuthShares forKey:Obj_Key_Auth_Cap];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sStrike decPlace:3] forKey:Obj_Key_Strike];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sVolatility30 decPlace:3] forKey:Obj_Key_Volatility];
	[m_oBasicDataDictionary setValue:quoteData.m_sMarketCap forKey:Obj_Key_Market_Cap];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sMoneyness decPlace:3] forKey:Obj_Key_Moneyness];
    [m_oBasicDataDictionary setValue:[NSString stringWithFormat:@"%@%%", quoteData.m_sSpotPrice] forKey:Obj_Key_Percent_To_Call];
	[m_oBasicDataDictionary setValue:quoteData.m_sEffGearing forKey:Obj_Key_Eff_Gearing];
	[m_oBasicDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sImpVol decPlace:3] forKey:Obj_Key_Imp_Vol];
	[m_oBasicDataDictionary setValue:quoteData.m_sDelta forKey:Obj_Key_Delta];
	[m_oBasicDataDictionary setValue:quoteData.m_sBidSpread forKey:Obj_Key_Bid_Spread];
	[m_oBasicDataDictionary setValue:quoteData.m_sAskSpread forKey:Obj_Key_Ask_Spread];
	
	[m_oTechDataDictionary setValue:quoteData.m_sMACD1225 forKey:Obj_Key_MACD1225];
	[m_oTechDataDictionary setValue:quoteData.m_sMACD817 forKey:Obj_Key_MACD817];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sRSI14 decPlace:3] forKey:Obj_Key_RSI14];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sRSI20 decPlace:3] forKey:Obj_Key_RSI20];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sRSI9 decPlace:3] forKey:Obj_Key_RSI9];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sSMA10 decPlace:3] forKey:Obj_Key_SMA10];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sSMA100 decPlace:3] forKey:Obj_Key_SMA100];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sSMA20 decPlace:3] forKey:Obj_Key_SMA20];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sSMA250 decPlace:3] forKey:Obj_Key_SMA250];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sSMA50 decPlace:3] forKey:Obj_Key_SMA50];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sSTC10 decPlace:3] forKey:Obj_Key_STC10];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sSTC14 decPlace:3] forKey:Obj_Key_STC14];
	[m_oTechDataDictionary setValue:[MHUtility formatDecimalString:quoteData.m_sSTC20 decPlace:3] forKey:Obj_Key_STC20];
    
	[self performSelectorOnMainThread:@selector(performReloadTable) withObject:nil waitUntilDone:NO];
}
/************************************** SNAPSHOT Account**************************************/

@end