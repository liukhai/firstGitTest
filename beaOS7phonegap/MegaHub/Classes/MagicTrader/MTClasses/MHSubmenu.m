//
//  MHSubmenu.m
//  MagicTrader
//
//  Created by Megahub on 10/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//
#import "MHSubmenu.h"
#import "PTConstant.h"
#import "MHSubmenuItem.h"
#import "StyleConstant.h"
#import "MHUtility.h"
#import "BrokerConf.h"

#import "MagicTraderAppDelegate.h"

#import "ViewControllerDirectorParameter.h"
#import "ViewControllerDirector.h"

#define arrow_width			15
#define BUTTON_DISTANCE		15


@implementation MHSubmenu
@synthesize m_oSubmenuItemArray;
@synthesize m_idDelegate;


//花生Class
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:Default_view_background_color];
		m_oBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 27)];
		m_oBackgroundImageView.image = MHSubmenuItem_background_image;
		[self addSubview:m_oBackgroundImageView];
		
		m_oScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(arrow_width, 0, self.frame.size.width-arrow_width-arrow_width, self.frame.size.height)];
		m_oScrollView.delegate = self;
		[m_oScrollView setShowsVerticalScrollIndicator:NO];
		[m_oScrollView setShowsHorizontalScrollIndicator:NO];
		[m_oScrollView setBackgroundColor:[UIColor clearColor]];
		[self addSubview:m_oScrollView];
		
		m_oLeftArrowImageView	= [[UIImageView alloc] initWithFrame:CGRectMake(0, -3, arrow_width, self.frame.size.height)];
		m_oLeftArrowImageView.image = MHSubmenuItem_m_oLeftArrowImageView_image;
		[self addSubview:m_oLeftArrowImageView];
		
		m_oRightArrowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-arrow_width, -3, arrow_width, self.frame.size.height)];
		m_oRightArrowImageView.image = MHSubmenuItem_m_oRightArrowImageView_image;
		[self addSubview:m_oRightArrowImageView];

		m_oSubmenuItemArray = [[NSMutableArray alloc] init];
		
    }
    return self;
}

- (void)dealloc {
	[m_oSubmenuItemArray release];
	[m_oLeftArrowImageView release];
	[m_oRightArrowImageView release];
	[m_oScrollView release];
	[m_oBackgroundImageView release];
    [super dealloc];
}

- (void)reloadText {
	CGFloat rightMostPosition = 0;
	CGSize lastAddedButtonSize = CGSizeZero;
	float totalWidth = 0;

	for (int i = 0; i < [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *aSubmenuItem = [m_oSubmenuItemArray objectAtIndex:i];
		[aSubmenuItem reloadText];
		lastAddedButtonSize =  [aSubmenuItem.titleLabel.text sizeWithFont:aSubmenuItem.titleLabel.font];
		aSubmenuItem.frame  = CGRectMake(rightMostPosition, 0, lastAddedButtonSize.width + BUTTON_DISTANCE, self.frame.size.height);
		rightMostPosition += lastAddedButtonSize.width + BUTTON_DISTANCE;
		totalWidth += (lastAddedButtonSize.width + BUTTON_DISTANCE);
	}	
	
	[m_oScrollView setContentSize:CGSizeMake(totalWidth, m_oScrollView.frame.size.height)];
	
	if (m_oScrollView.contentSize.width < m_oScrollView.frame.size.width) {
		lastAddedButtonSize = CGSizeMake(m_oScrollView.frame.size.width/[m_oSubmenuItemArray count], m_oScrollView.frame.size.height);
		
		for (int i=0; i<[m_oSubmenuItemArray count]; i++) {
			MHSubmenuItem *aSubmenuItem = [m_oSubmenuItemArray objectAtIndex:i];
			[aSubmenuItem setFrame:CGRectMake(lastAddedButtonSize.width*i, 0, lastAddedButtonSize.width, lastAddedButtonSize.height)];
		}
		
		m_oLeftArrowImageView.hidden = YES;
		m_oRightArrowImageView.hidden = YES;
	}
	
	m_oLeftArrowImageView.hidden = NO;
	m_oRightArrowImageView.hidden = NO;
	
}

-(void)removeSubmenuItem:(int)aSubmenuId{
	int removeIndex = -1;
	
	for (int i = 0; i < [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *aa = (MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:i];
		if (aa.m_iMHSubmenuItemID == aSubmenuId) {
			removeIndex = i;
			break;
		}
	}
	
	if(removeIndex > -1){
		MHSubmenuItem *aSubmenuItem = [(MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:removeIndex] retain];
		[aSubmenuItem removeFromSuperview];
		[m_oSubmenuItemArray removeObjectAtIndex:removeIndex];
		[aSubmenuItem release];
	}
	
	for (int i = 0; i < [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *aSubmenuItem = [(MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:i] retain];
		[aSubmenuItem removeFromSuperview];
		[aSubmenuItem release];
	}
		
	[self loadReorderSequence:m_iModuleId];
}

-(void)removeAllSubmenuItems{
	if([m_oSubmenuItemArray count] > 0){
		for (int i = 0; i < [m_oSubmenuItemArray count]; i++) {
			MHSubmenuItem *aSubmenuItem = [(MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:i] retain];
			[aSubmenuItem removeFromSuperview];
			[aSubmenuItem release];
		}
		
		[m_oSubmenuItemArray removeAllObjects];
	}
}

-(void)loadReorderSequence:(int)aModuleId{
	NSDictionary *plistDictionary = [MT_DELEGATE loadSubmenuReorderSetting];
	
	NSArray *valueArray = [plistDictionary objectForKey:[NSString stringWithFormat:@"%d", aModuleId]];
	NSMutableArray *m_reorderedSubmenuArray = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < [valueArray count]; i++) {
		
		for (int j = 0; j < [m_oSubmenuItemArray count]; j++) {
			int seedMenuItemId = [[valueArray objectAtIndex:i] intValue];
			int submenuItemId = ((MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:j]).m_iMHSubmenuItemID;
			
			//exist
			if (seedMenuItemId == submenuItemId) {
				MHSubmenuItem *aMHSubmenuItem = [[MHSubmenuItem alloc] initWithMHSubmenuItemID: seedMenuItemId withFrame: CGRectMake(0, 0, MHSubmenuItem_width, self.frame.size.height)]; 
				[m_reorderedSubmenuArray addObject:aMHSubmenuItem];
				[aMHSubmenuItem release];
			}
			
		}
		
	}
	
	[m_oSubmenuItemArray removeAllObjects];
	[m_oSubmenuItemArray addObjectsFromArray:m_reorderedSubmenuArray];
	
	[m_reorderedSubmenuArray release];
	
	[self updateUI];
}

- (void)loadModule:(int)aModuleId{
	[self removeAllSubmenuItems];
	m_iModuleId = aModuleId;
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	switch (aModuleId) {
		case MODULE_QUOTE_STOCK:
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_STOCK_RELATEDNEWS]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_STOCK_RELATEDWARRANT]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_STOCK_RELATEDSECTOR]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_STOCK_RELATEDFUNDAMENTAL]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_STOCK_TRANSRECORD]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_STOCK_MONEYFLOW]];
#if MHSubmenu_HAVE_REORDER
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_STOCK_OPTION]];
#endif
			
			break;
			
		case MODULE_QUOTE_WARRANT:
		case MODULE_QUOTE_CBBC:
			m_iModuleId = MODULE_QUOTE_WARRANT;
			//If same, use warrant
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WARRANT_UNDERLTING]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WARRANT_BALWARRANT]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WARRANT_RELATEDNEWS]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WARRANT_RELATEDSECTOR]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WARRANT_RELATEDFUNDAMENTAL]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WARRANT_TRANSRECORD]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WARRANT_MONEYFLOW]];
#if MHSubmenu_HAVE_REORDER
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WARRANT_OPTION]];
#endif
			
			break;
		case MODULE_WATCHLIST:
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_INDICES]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_SECTOR]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_RANKING]];
			//TODO: uncomment in future version
			if(ENABLE_MKT_CALENDAR){
				[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_MARKETINGCALENDAR]];
			}
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_AH]];
#if MHSubmenu_HAVE_REORDER			
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WATCHLIST_OPTION]];
#endif
			
			break;
			
		case MODULE_INDEXFUTURE:	
		case MODULE_SECTOR:
		case MODULE_INDEX:
		case MODULE_INDEXCOMPONENT:						
		case MODULE_AH:				
		case MODULE_FUNDAMENTAL:		
		case MODULE_FX:				
		case MODULE_STOCKSEARCH:		
		case MODULE_WARRANTSEARCH:		
			m_iModuleId = MODULE_INDEXFUTURE;

			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_INDICES]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_SECTOR]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_RANKING]];
			//TODO: uncomment in future version
			if(ENABLE_MKT_CALENDAR){
				[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_MARKETINGCALENDAR]];
			}
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_AH]];
#if MHSubmenu_HAVE_REORDER
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_INDEXFUTURE_OPTION]];
#endif
			
			break;
		case MODULE_FUNDAMENTAL_DETAIL:
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_MARKETDATA]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_COMPPROFILE]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_CORPINFO]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_BALSHEET]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_PROFITLOSS]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_FINRATIO]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_DIVIDEND]];
#if MHSubmenu_HAVE_REORDER
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_FUNDAMENTAL_DETAIL_OPTION]];
#endif
		break;	
			

		case MODULE_TOPRANK_SECTOR:
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_STOCK]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_HSCEI]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_REDCHIPS]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_GEM]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_WARRANT]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_CBBC]];
#if MHSubmenu_HAVE_REORDER			
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_OPTION]];
#endif
			break;
		case MODULE_TOPRANK_CATEGORY: {
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_CATEGORY_GAIN]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_CATEGORY_LOSS]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_CATEGORY_PGAIN]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_CATEGORY_PLOSS]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_CATEGORY_VOLUME]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_CATEGORY_TURNOVER]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_CATEGORY_52HIGH]];	
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_CATEGORY_52LOW]];
#if MHSubmenu_HAVE_REORDER			
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_TOPRANK_CATEGORY_OPTION]];	
#endif			
			break;
		}
		case MODULE_NEWS:{
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_ALLNEWS]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_CUSTOMNEWS]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_DJNEWS]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_HKEXNEWS]];
#if MHSubmenu_HAVE_REORDER			
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_NEWS_OPTION]];
#endif			
			break;
		}
		case MODULE_SETTING:
		case MODULE_MARKETDAILY:
			
			break;
			
		case MODULE_TRADE:{
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_MY_ACCOUNT]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_ACCOUNT_POSITION]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_ACCOUNT_HISTOTY]];
			[tempArray  addObject:[NSString stringWithFormat:@"%d", SUBMENU_ITEM_OUTSTANDING_ORDER]];

			break;
		}

		default:
			break;
	}
	
	for (int i = 0; i < [tempArray count]; i++) {
		MHSubmenuItem *aMHSubmenuItem = [[MHSubmenuItem alloc] initWithMHSubmenuItemID: [[tempArray objectAtIndex:i] intValue] withFrame: CGRectMake(MHSubmenuItem_width*i, 0, MHSubmenuItem_width, self.frame.size.height)]; 
		[m_oSubmenuItemArray addObject:aMHSubmenuItem];
		[aMHSubmenuItem release];
	}
	[tempArray release];
	
    [self loadReorderSequence:m_iModuleId];
	
	//後路
	//TODO: uncomment this when do warrant
	//all the warrant & cbbc use the warrant at this moment
	if(!ENABLE_WARRANT && m_iModuleId == MODULE_QUOTE_WARRANT){
		[self removeSubmenuItem:SUBMENU_ITEM_WARRANT_BALWARRANT];
	}
	
	if(!ENABLE_WARRANT && m_iModuleId == MODULE_QUOTE_STOCK){
		[self removeSubmenuItem:SUBMENU_ITEM_STOCK_RELATEDWARRANT];
	}
	
	//TODO: uncomment this when do Mkt_Calendar / Market Calendar
	if(!ENABLE_MKT_CALENDAR && m_iModuleId == MODULE_WATCHLIST){
		[self removeSubmenuItem:SUBMENU_ITEM_MARKETINGCALENDAR];
	}
	
	//All index future, index page, A+H, FX.... use the module index future at this moment
	if(!ENABLE_MKT_CALENDAR && m_iModuleId == MODULE_INDEXFUTURE){
		[self removeSubmenuItem:SUBMENU_ITEM_MARKETINGCALENDAR];
	}
	
	[self reloadText];
	
}


-(void)updateUI{
	//Clean all the button  first	
	for (int i = 0; i < [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *aSubmenuItem = [(MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:i] retain];
		[aSubmenuItem removeFromSuperview];
		[aSubmenuItem release];
	}	
	
	CGFloat rightMostPosition = 0;
	CGSize lastAddedButtonSize = CGSizeZero;

	float totalWidth = 0;
	
	//draw back the button
	for (int i = 0; i < [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *aSubmenuItem = [(MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:i] retain];
		[aSubmenuItem addTarget:self action:@selector(onSubmenuItemIsClicked:) forControlEvents:UIControlEventTouchUpInside];
		lastAddedButtonSize =  [aSubmenuItem.titleLabel.text sizeWithFont:aSubmenuItem.titleLabel.font];
		aSubmenuItem.frame  = CGRectMake(rightMostPosition, 0, lastAddedButtonSize.width + BUTTON_DISTANCE, self.frame.size.height);
		rightMostPosition += lastAddedButtonSize.width + BUTTON_DISTANCE;
		[m_oScrollView addSubview:aSubmenuItem];
		[aSubmenuItem release];
		
		totalWidth += (lastAddedButtonSize.width + BUTTON_DISTANCE);
	}
	
	[m_oScrollView setContentSize:CGSizeMake(totalWidth, m_oScrollView.frame.size.height)];
}

-(void)clearAllSelected{
	for (int i = 0; i< [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *anotherSubmenuItem = [m_oSubmenuItemArray objectAtIndex:i];
		[anotherSubmenuItem setSelected:NO];
	}
}

-(void)setDisableSubmenu:(int)aSubmenuId{
	for (int i = 0; i< [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *anotherSubmenuItem = [m_oSubmenuItemArray objectAtIndex:i];
		if(anotherSubmenuItem.m_iMHSubmenuItemID == aSubmenuId){
			[anotherSubmenuItem.titleLabel setTextColor:[UIColor grayColor]];
			[anotherSubmenuItem setUserInteractionEnabled:NO];
			break;
		}
	}

}

-(void)setSelectedSubmenu:(int)aSubmenuId{
	for (int i = 0; i< [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *anotherSubmenuItem = [m_oSubmenuItemArray objectAtIndex:i];
		if(anotherSubmenuItem.m_iMHSubmenuItemID == aSubmenuId){
			[anotherSubmenuItem setSelected:YES];
			break;
		}
	}
	
	int disableSubmenuItem = -1;
	
	for (int i = 0; i < [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *aSubmenuItem = [(MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:i] retain];
		if(aSubmenuItem.userInteractionEnabled == NO){
			disableSubmenuItem = aSubmenuItem.m_iMHSubmenuItemID;
		}
		[aSubmenuItem release];
	}
	
	if(disableSubmenuItem != -1){
		[self setDisableSubmenu:disableSubmenuItem];
	}
}

-(void)onSubmenuItemIsClicked:(id)sender{
	//Send to the delegate to popout
	MHSubmenuItem *aSubmenuItem = (MHSubmenuItem *)sender;
	[self clearAllSelected];	
	[aSubmenuItem setSelected:YES];
	
	if ([(NSObject *)m_idDelegate respondsToSelector:@selector(MHSubmenuDelegateCallback:)]) {
		[(NSObject *)m_idDelegate performSelector:@selector(MHSubmenuDelegateCallback:) withObject:[NSNumber numberWithInt:aSubmenuItem.m_iMHSubmenuItemID]];
	}
	
	
	switch (aSubmenuItem.m_iMHSubmenuItemID) {
		case SUBMENU_ITEM_STOCK_OPTION:
		{
			ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
			para.m_iInt0 = MODULE_QUOTE_STOCK;
			para.m_oObject = (NSObject *)m_idDelegate;
			[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDReorder para:para];
			[para release];
		}			
			break;
			
		case SUBMENU_ITEM_WARRANT_OPTION:
		{
			ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
			para.m_iInt0 = MODULE_QUOTE_WARRANT;
			para.m_oObject = (NSObject *)m_idDelegate;
			[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDReorder para:para];
			[para release];
		}	
			break;
			
		case SUBMENU_ITEM_WATCHLIST_OPTION:
		{
			ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
			para.m_iInt0 = MODULE_WATCHLIST;
			para.m_oObject = (NSObject *)m_idDelegate;
			[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDReorder para:para];
			[para release];
		}	
			break;	
			
		case SUBMENU_ITEM_INDEXFUTURE_OPTION:
		{
			ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
			para.m_iInt0 = MODULE_INDEXFUTURE;
			para.m_oObject = (NSObject *)m_idDelegate;
			[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDReorder para:para];
			[para release];
		}	
			break;	

		case SUBMENU_ITEM_TOPRANK_OPTION:
		{
			ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
			para.m_iInt0 = MODULE_TOPRANK_SECTOR;
			para.m_oObject = (NSObject *)m_idDelegate;
			[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDReorder para:para];
			[para release];
		}	
			break;	
			
		case SUBMENU_ITEM_TOPRANK_CATEGORY_OPTION:
		{
			ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
			para.m_iInt0 = MODULE_TOPRANK_CATEGORY;
			para.m_oObject = (NSObject *)m_idDelegate;
			[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDReorder para:para];
			[para release];
		}
			break;
			
		case SUBMENU_ITEM_NEWS_OPTION:
		{
			ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
			para.m_iInt0 = MODULE_NEWS;
			para.m_oObject = (NSObject *)m_idDelegate;
			[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDReorder para:para];
			[para release];
		}	
			break;			
			
		case SUBMENU_ITEM_FUNDAMENTAL_DETAIL_OPTION:
		{
			ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
			para.m_iInt0 = MODULE_FUNDAMENTAL_DETAIL;
			para.m_oObject = (NSObject *)m_idDelegate;
			[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDReorder para:para];
			[para release];
		}	
			break;		
			
		default:
			break;
	}
	
	int disableSubmenuItem = -1;

	
	for (int i = 0; i < [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *aSubmenuItem = [(MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:i] retain];
		if(aSubmenuItem.userInteractionEnabled == NO){
			disableSubmenuItem = aSubmenuItem.m_iMHSubmenuItemID;
		}
		[aSubmenuItem release];
	}
	
	if(disableSubmenuItem != -1){
		[self setDisableSubmenu:disableSubmenuItem];
	}
}


-(void)MHReorderViewControllerDelegateCallback:(id)aSender{
	[self clearAllSelected];
	//TODO: need to fix
	int disableSubmenuItem = -1;
	
	for (int i = 0; i < [m_oSubmenuItemArray count]; i++) {
		MHSubmenuItem *aSubmenuItem = [(MHSubmenuItem *)[m_oSubmenuItemArray objectAtIndex:i] retain];
		if(aSubmenuItem.userInteractionEnabled == NO){
			disableSubmenuItem = aSubmenuItem.m_iMHSubmenuItemID;
		}
		
		[aSubmenuItem removeFromSuperview];
		[aSubmenuItem release];
	}
	[self loadReorderSequence:m_iModuleId];
	
	if(disableSubmenuItem != -1){
		[self setDisableSubmenu:disableSubmenuItem];
	}
}


@end
