//
//  MHSubmenuItem.m
//  MagicTrader
//
//  Created by Megahub on 10/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHSubmenuItem.h"
#import "PTConstant.h"

#import "MHLanguage.h"
#import "MHUtility.h"

#import "StyleConstant.h"
#import "PTConstant.h"

@implementation MHSubmenuItem
@synthesize m_iMHSubmenuItemID;

-(id)initWithMHSubmenuItemID:(int)aSubmenuItemID withFrame:(CGRect)aframe{
	self = [super init];
	if(self){
		
		self.frame = aframe;
		
		m_iMHSubmenuItemID = aSubmenuItemID;
		
		[self reloadText];
		
		[self.titleLabel setFont:MHSubmenuItem_label_font];
		[self setTitleColor:MHSubmenuItem_label_textColor forState:UIControlStateNormal];
		[self.titleLabel setAdjustsFontSizeToFitWidth:YES];
		
		[self setTitleColor:MHSubmenuItem_selected_color forState:UIControlStateSelected];
	}
	
	return self;
}

+(NSString *)convertMHSubmenuItemIDToMHSubmenuItemString:(int)aSubmenuItemID{
	NSString *tempString = nil;
	switch (aSubmenuItemID) {
		case SUBMENU_ITEM_STOCK_RELATEDNEWS:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_STOCK_RELATEDNEWS", nil);}			
			break;
		case SUBMENU_ITEM_STOCK_RELATEDWARRANT:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_STOCK_RELATEDWARRANT", nil);}	
			break;
		case SUBMENU_ITEM_STOCK_RELATEDSECTOR:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_STOCK_RELATEDSECTOR", nil);}		
			break;
		case SUBMENU_ITEM_STOCK_RELATEDFUNDAMENTAL:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_STOCK_RELATEDFUNDAMENTAL", nil);}
			break;
		case SUBMENU_ITEM_STOCK_TRANSRECORD:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_STOCK_TRANSRECORD", nil);}
			break;
		case SUBMENU_ITEM_STOCK_MONEYFLOW:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_STOCK_MONEYFLOW", nil);}		
			break;
		case SUBMENU_ITEM_CBBC_UNDERLTING:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CBBC_UNDERLTING", nil);}		
			break;
		case SUBMENU_ITEM_CBBC_BALWARRANT:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CBBC_BALWARRANT", nil);}	
			break;
		case SUBMENU_ITEM_CBBC_RELATEDNEWS:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CBBC_RELATEDNEWS", nil);}		
			break;
		case SUBMENU_ITEM_CBBC_RELATEDSECTOR:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CBBC_RELATEDSECTOR", nil);}
			break;
		case SUBMENU_ITEM_CBBC_RELATEDFUNDAMENTAL:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CBBC_RELATEDFUNDAMENTAL", nil);}
			break;
		case SUBMENU_ITEM_CBBC_TRANSRECORD:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CBBC_TRANSRECORD", nil);}	
			break;
		case SUBMENU_ITEM_CBBC_MONEYFLOW:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CBBC_MONEYFLOW", nil);}	
			break;
		case SUBMENU_ITEM_WARRANT_UNDERLTING:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANT_UNDERLTING", nil);}	
			break;
		case SUBMENU_ITEM_WARRANT_BALWARRANT:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANT_BALWARRANT", nil);}	
			break;
		case SUBMENU_ITEM_WARRANT_RELATEDNEWS:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANT_RELATEDNEWS", nil);}	
			break;
		case SUBMENU_ITEM_WARRANT_RELATEDSECTOR:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANT_RELATEDSECTOR", nil);}
			break;
		case SUBMENU_ITEM_WARRANT_RELATEDFUNDAMENTAL:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANT_RELATEDFUNDAMENTAL", nil);}
			break;
		case SUBMENU_ITEM_WARRANT_TRANSRECORD:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANT_TRANSRECORD", nil);}
			break;
		case SUBMENU_ITEM_WARRANT_MONEYFLOW:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANT_MONEYFLOW", nil);}
			break;
		case SUBMENU_ITEM_INDICES:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_INDICES", nil);}		
			break;
		case SUBMENU_ITEM_SECTOR:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_SECTOR", nil);}		
			break;
		case SUBMENU_ITEM_RANKING:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_RANKING", nil);}
			break;
		case SUBMENU_ITEM_MARKETINGCALENDAR:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_MARKETINGCALENDAR", nil);}	
			break;
		case SUBMENU_ITEM_AH:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_AH", nil);}	
			break;
		case SUBMENU_ITEM_STOCK_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_STOCK_OPTION", nil);}					
			break;
		case SUBMENU_ITEM_CBBC_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CBBC_OPTION", nil);}
			break;
		case SUBMENU_ITEM_WARRANT_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANT_OPTION", nil);}	  	
			break;
		case SUBMENU_ITEM_WATCHLIST_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WATCHLIST_OPTION", nil);}  
			break;
		case SUBMENU_ITEM_INDEXFUTURE_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_INDEXFUTURE_OPTION", nil);} 	
			break;
		case SUBMENU_ITEM_INDEX_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_INDEX_OPTION", nil);}					   
			break;
		case SUBMENU_ITEM_INDEXCOMPONENT_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_INDEXCOMPONENT_OPTION", nil);}
			break;
		case SUBMENU_ITEM_SECTOR_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_SECTOR_OPTION", nil);}				  
			break;
		case SUBMENU_ITEM_AH_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_AH_OPTION", nil);}
			break;
		case SUBMENU_ITEM_FUNDAMENTAL_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_FUNDAMENTAL_OPTION", nil);}		
			break;
		case SUBMENU_ITEM_FX_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_FX_OPTION", nil);}
			break;
		case SUBMENU_ITEM_STOCKSEARCH_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_STOCKSEARCH_OPTION", nil);}		
			break;
		case SUBMENU_ITEM_WARRANTSEARCH_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANTSEARCH_OPTION", nil);}	
			break;
		case SUBMENU_ITEM_ALLNEWS:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_ALLNEWS", nil);}							   
			break;
		case SUBMENU_ITEM_CUSTOMNEWS:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CUSTOMNEWS", nil);}						
			break;
		case SUBMENU_ITEM_DJNEWS:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_DJNEWS", nil);}								   
			break;
		case SUBMENU_ITEM_HKEXNEWS:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_HKEXNEWS", nil);}							   
			break;
		case SUBMENU_ITEM_NEWS_OPTION:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_NEWS_OPTION", nil);}
			break;
		case SUBMENU_ITEM_NONE:{tempString =  MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_NONE", nil);}						
			break;
			
			// Top Rank sector
		case SUBMENU_ITEM_STOCK:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_STOCK", nil);				break;	}
		case SUBMENU_ITEM_HSCEI:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_HSCEI", nil);				break;	}
		case SUBMENU_ITEM_REDCHIPS:{		tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_REDCHIPS", nil);			break;	}
		case SUBMENU_ITEM_GEM:{				tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_GEM", nil);					break;	}
		case SUBMENU_ITEM_WARRANT:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_WARRANT", nil);				break;	}
		case SUBMENU_ITEM_CBBC:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CBBC", nil);				break;	}
		case SUBMENU_ITEM_TOPRANK_OPTION:{	tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_OPTION", nil);		break;	}
			
			// Top Rank Category
		case SUBMENU_ITEM_TOPRANK_CATEGORY_GAIN:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_CATEGORY_GAIN", nil);		break;	}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_LOSS:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_CATEGORY_LOSS", nil);		break;	}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_PGAIN:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_CATEGORY_PGAIN", nil);		break;	}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_PLOSS:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_CATEGORY_PLOSS", nil);		break;	}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_VOLUME:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_CATEGORY_VOLUME", nil);		break;	}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_TURNOVER:{		tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_CATEGORY_TURNOVER", nil);	break;	}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_52HIGH:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_CATEGORY_52HIGH", nil);		break;	}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_52LOW:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_CATEGORY_52LOW", nil);		break;	}
		case SUBMENU_ITEM_TOPRANK_CATEGORY_OPTION:{			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_TOPRANK_CATEGORY_OPTION", nil);		break;	}
			
			// Fundamental
		case SUBMENU_ITEM_MARKETDATA: {				tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_MARKETDATA", nil);		break;	}
		case SUBMENU_ITEM_COMPPROFILE: {			tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_COMPPROFILE", nil);		break;	}
		case SUBMENU_ITEM_CORPINFO: {				tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_CORPINFO", nil);		break;	}
		case SUBMENU_ITEM_BALSHEET: {				tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_BALSHEET", nil);		break;	}
		case SUBMENU_ITEM_PROFITLOSS: {				tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_PROFITLOSS", nil);		break;	}
		case SUBMENU_ITEM_FINRATIO: {				tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_FINRATIO", nil);		break;	}
		case SUBMENU_ITEM_DIVIDEND: {				tempString = MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_DIVIDEND", nil);		break;	}
			
			//TODO: +back the string
		case SUBMENU_ITEM_FUNDAMENTAL_DETAIL_OPTION:{
			tempString	= MHLocalizedString(@"MHSubmenu.SUBMENU_ITEM_FUNDAMENTAL_DETAIL_OPTION", nil);
			break;
		}
		default:
			break;
	}
	
	return tempString;
}

-(void)reloadText{
	NSString *aTitleString = [MHSubmenuItem convertMHSubmenuItemIDToMHSubmenuItemString:m_iMHSubmenuItemID];
	[self setTitle:aTitleString forState:UIControlStateNormal];
	[self setContentEdgeInsets:UIEdgeInsetsMake(-2, 0, +2, 0)];
}


- (void)dealloc {
    [super dealloc];
}


@end
