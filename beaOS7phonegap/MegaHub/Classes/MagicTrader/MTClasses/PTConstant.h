//
//  PTConstant.h
//  MagicTrader
//
//  Created by Megahub on 25/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#define Notification_MagicTraderMultiLogin		@"Notification_MagicTraderMultiLogin"
#define Notification_MagicTraderDisconnect      @"Notification_MagicTraderDisconnect"

#define PT_WEBVIEW_STYLE						[(MagicTraderAppDelegate *)[MagicTraderAppDelegate sharedMagicTraderAppDelegate] loadDetailStyleString]
#define PT_WEBVIEW_REALTIME						@"1"
#define PT_WEBVIEW_DELAY						@"0"
#define PT_WEBVIEW_QUOTE_COUT					@"1"
#define PT_WEBVIEW_QUOTE_UNCOUT					@"0"

#define PT_WEBVIEW_ACTION_202					@"2"
#define PT_ACTION_GET_TGT						@"1"
#define PTP_ACTION_LOGIN						@"1"
#define PTP_ACTION_OTHER						@"2"

#define DEFAULT_TGT								@"TGT-DEFAULT_USER"

#define Show_IPO_Listing            1
#define IPO_Listing_Event_ID        @"11"
#define Show_IPO_Start              1
#define IPO_Start_Event_ID          @"12"
#define Show_IPO_End                1
#define IPO_End_Event_ID            @"13"
#define Show_HK_Holiday             0
#define HK_Holiday_ID               @"1"
#define Last_Data_Event_Date        201201
#define End_Data_Event_Date         204601
#define Within_Num_Of_Year_Start    1
#define Within_Num_Of_Year_Ended    1
#define ENABLE_BOUNDARY_CHECK       1

#define VERSION_NUMBER							@"1114"

#define DEBUG_MODE								NO

#define TIME_OUT_SECOND							10
#define PT_LOGING_TIME_OUT						30

#define DECIMALPLACE_STOCK_SYMBOL				5

#define MT_DELEGATE								((MagicTraderAppDelegate *)[MagicTraderAppDelegate sharedMagicTraderAppDelegate])
//Refresh Interval
#define Time_FX_Refresh_Interval				600
#define Time_Quote_Stock_Data_Page_Interval		5
#define Time_WorldIndex_Interval				30
#define Time_PollingNewPTValid_Interval			30



//後路
#define ENABLE_WARRANT						NO
#define ENABLE_MKT_CALENDAR					NO
#define ENABLE_LANDSCAPE_LOCAL_INDEX_CHART	0

#define MEGAHUB_PHONE_NUMBER				@"28032997"
#define MEGAHUB_WEBSITE						@"http://www.megahubhk.com/"
#define MEGAHUB_MAIL_ADDRESS				@"cs@megahubhk.com"
#define MEGAHUB_JP_MAIL_ADDRESS				@"JapanSupport@megahubhk.com"
#define MEGAHUB_FACEBOOK					@"http://www.facebook.com/megahub"

#define SAVEKEY_USERNAME					@"username"
#define SAVEKEY_PASSWORD					@"password"

#define SAVEKEY_ISDETAILVIEWINWATCHLIST					@"isDetailViewInWatchlist"
#define SAVEKEY_IS_DETAILIVIEW_IN_IndexConstituent		@"isDetailViewInIndexConstituent"
#define SAVEKEY_IS_DETAILIVIEW_IN_SectorView			@"isDetailViewInSector"
#define SAVEKEY_IS_DETAILIVIEW_IN_TopRankView			@"isDetailViewInTopRank"
#define SAVEKEY_IS_DETAILIVIEW_IN_AHShareView			@"isDetailViewInAHShare"

#define SAVEKEY_DEFAULTWATCHLIST			@"defaultWatchlistName30"
#define SAVEKEY_DEFAULT_STYLE				@"defaultStyle"
#define SAVEKEY_DEFAULT_TABBARNAME			@"defaultTabbarName"

#define SAVEKEY_IS_SAVE_USERID_PASSWORD		@"isSaveUserIDPassword"
#define SAVEKEY_IS_AUTO_LOGIN				@"isAutoLogin"
#define SAVEKEY_NEWS_SOURCE_SELECTION		@"newsSourceSelection"
#define SAVEKEY_FLASHCOLOR					@"flashflashColor"


#define SETTING_LANG_ENG				0
#define SETTING_LANG_ZH_TW				1
#define SETTING_LANG_CN					2


#define MARKET_HONGKONG				@"HK"
#define STOCK_QUOTE_LINK_PREFIX		@"stockclick"
#define DISCLAIMER_PREFIX			@"disclaimer"




//--------------------------------------------------------

#define IndexAttribute_Value					0
#define IndexAttribute_Change					1
#define IndexAttribute_ChangePencentage			2

#define INVALID_INDEX_NUMBER					-9999
#define NUMBER_QUOTE_PAGE						3

#define TAG_Translog_View						200
#define TAG_BrokerQueue_Bid_Label				100
#define TAG_BrokerQueue_Bid2_Label				101
#define TAG_BrokerQueue_Ask_Label				110
#define TAG_BrokerQueue_Ask2_Label				111


#define TAG_LEVEL1_Bid_AskLabel					300
#define TAG_LEVEL2_Bid_AskLabel					301
#define TAG_LEVEL3_Bid_AskLabel					302
#define TAG_LEVEL4_Bid_AskLabel					303
#define TAG_LEVEL5_Bid_AskLabel					304
#define TAG_LEVEL6_Bid_AskLabel					305
#define TAG_LEVEL7_Bid_AskLabel					306
#define TAG_LEVEL8_Bid_AskLabel					307
#define TAG_LEVEL9_Bid_AskLabel					308
#define TAG_LEVEL10_Bid_AskLabel				309

#define TAG_CELL_Bid_Ask						333

#define TAG_CELL_Type						334

/**************************** PTP ****************************/
// For MHBasicDataView
// Basic Data
#define Obj_Key_Stock_Type			@"Obj_Key_Stock_Type"
#define Obj_Key_IEP					@"Obj_Key_IEP"
#define Obj_Key_IEV					@"Obj_Key_IEV"
#define Obj_Key_Volatility			@"Obj_Key_Volatility"
#define Obj_Key_EPS					@"Obj_Key_EPS"
#define Obj_Key_DPS					@"Obj_Key_DPS"
#define Obj_Key_Currency			@"Obj_Key_Currency"
#define Obj_Key_Issuer				@"Obj_Key_Issuer"
#define Obj_Key_Entitlement_Ratio	@"Obj_Key_Entitlement_Ratio"
#define Obj_Key_Strike				@"Obj_Key_Strike"
#define Obj_Key_Moneyness			@"Obj_Key_Moneyness"
#define Obj_Key_Call_Level			@"Obj_Key_Call_Level"
#define Obj_Key_Percent_To_Call		@"Obj_Key_Percent_To_Call"
#define Obj_Key_Month_Hi			@"Obj_Key_Month_Hi"
#define Obj_Key_Month_Lo			@"Obj_Key_Month_Lo"
#define Obj_Key_Auth_Cap			@"Obj_Key_Auth_Cap"
#define Obj_Key_Shares_Issued		@"Obj_Key_Shares_Issued"
#define Obj_Key_Market_Cap			@"Obj_Key_Market_Cap"
#define Obj_Key_NAV					@"Obj_Key_NAV"
#define Obj_Key_Outstanding			@"Obj_Key_Outstanding"
#define Obj_Key_Eff_Gearing			@"Obj_Key_Eff_Gearing"
#define Obj_Key_Imp_Vol				@"Obj_Key_Imp_Vol"
#define Obj_Key_Delta				@"Obj_Key_Delta"
#define Obj_Key_Last_Update			@"Obj_Key_Last_Update"
#define Obj_Key_Exp_Date			@"Obj_Key_Exp_Date"
#define Obj_Key_Bid_Spread			@"Obj_Key_Bid_Spread"
#define Obj_Key_Ask_Spread			@"Obj_Key_Ask_Spread"

// Technical
#define	Obj_Key_SMA10				@"Obj_Key_SMA10"
#define	Obj_Key_SMA20				@"Obj_Key_SMA20"
#define	Obj_Key_SMA50				@"Obj_Key_SMA50"
#define	Obj_Key_SMA100				@"Obj_Key_SMA100"
#define	Obj_Key_SMA250				@"Obj_Key_SMA250"
#define	Obj_Key_MACD817				@"Obj_Key_MACD817"
#define	Obj_Key_MACD1225			@"Obj_Key_MACD1225"
#define	Obj_Key_RSI9				@"Obj_Key_RSI9"
#define	Obj_Key_RSI14				@"Obj_Key_RSI14"
#define	Obj_Key_RSI20				@"Obj_Key_RSI20"
#define	Obj_Key_STC10				@"Obj_Key_STC10"
#define	Obj_Key_STC14				@"Obj_Key_STC14"
#define	Obj_Key_STC20				@"Obj_Key_STC20"
/**************************** PTP ****************************/

#define SPECIAL_BIDID						11008
#define SPECIAL_ASKID						11520

#define NUMBER_BID_ASK_QUEUE				10

#define STOCK_TYPE_STOCK					1
#define STOCK_TYPE_WARRANT					2
#define STOCK_TYPE_CBBC						3

#define STOCK_TYPE_SR_STOCK					@"S"
#define STOCK_TYPE_SR_WARRANT				@"W"
#define STOCK_TYPE_SR_CBBC					@"C"

#define STOCK_TYPE_UNKOWN					nil

#define STOCK_DATA_NOT_SELECT				-1
#define STOCK_DATA_FUNDAMENTAL_DATA			0
#define STOCK_DATA_TECHNICAL_DATA			1
#define STOCK_DATA_RELATED_STOCK_DATA		2

#define PAGE_NUMBER_DATA					0
#define PAGE_NUMBER_BROKER_QUEUE			2
#define PAGE_NUMBER_STOCKQUOTE				1

#define DEFAULT_SELECT_STOCK_DATA			STOCK_DATA_FUNDAMENTAL_DATA

#define STOCK_DATA_FUNDAMENTAL_DATA_STOCK_TABLE_COUNT						8
#define STOCK_DATA_FUNDAMENTAL_DATA_CBBC_TABLE_COUNT						12
#define STOCK_DATA_FUNDAMENTAL_DATA_WARRANT_TABLE_COUNT						10


#define STOCK_DATA_TECHNICAL_DATA_STOCK_TABLE_COUNT							10
#define STOCK_DATA_TECHNICAL_DATA_WARRANT_OR_CBBC_TABLE_COUNT				10


// A+H
#define JAVASCRIPT_AHSHARES_DETAIL											@"showAll()"
#define JAVASCRIPT_SECTOR_DETAIL											@"showAll()"
#define JAVASCRIPT_TOPRANK_DETAIL											@"showAll()"

#define PTLocalIndexViewController_URL_INDEX_GRAPH							@"http://charts.megahubhk.com/servlets/MHImageChart?sid=%@&cmode=2&cperiod=2000101&ctype=6&cwidth=%d&cheight=%d&fsize=12&lang=%@&vol=0&tstyle=-1&intTech1=0&it1p1=&it1p2=&it1p3=&it1p4=&it1p5=&cr=%@"

//REFRESH
#define REFESH_RATE_REALTED_STOCK							10

//MODULE
#define MODULE_QUOTE_STOCK									1

#define MODULE_QUOTE_WARRANT_CBBC							100
#define MODULE_QUOTE_WARRANT								2
#define MODULE_QUOTE_CBBC									3

#define MODULE_WATCHLIST									6
#define MODULE_INDEXFUTURE									7
#define MODULE_INDEX										8
#define MODULE_INDEXCOMPONENT								9
#define MODULE_SECTOR										10
#define MODULE_AH											11
#define MODULE_FUNDAMENTAL									12
#define MODULE_FX											13
#define MODULE_STOCKSEARCH									14
#define MODULE_WARRANTSEARCH								15
#define MODULE_TOPRANK_SECTOR								16
#define MODULE_NEWS											17
#define MODULE_SETTING										18
#define MODULE_MARKETDAILY									19
#define MODULE_TOPRANK_CATEGORY                             20
#define MODULE_FUNDAMENTAL_DETAIL							21
#define MODULE_TRADE										22
#define MODULE_IPO                                          23
#define MODULE_DIVIDEND                                     24
#define MODULE_IPO_FUNDAMENTAL                              25


#define KEY_SUBMENU                                                 @"submenubarbarbarbar"


#define PLIST_PT_SUBMENUORDER										@"ptsubmenuorder"
//你會問:喂, 點解禁長ge....我話, 唔會撞ma.
#define KEY_TABBARMENU												@"tabtabtabtabtabtabtabbar" 
#define KEY_DEFAULT_TABBARMENU										@"DefaultTabbarbarbarbarbarbarbar"
#define KEY_VERSION_NUMBER											@"Version"

//MODULE_QUOTE_STOCK
#define SUBMENU_ITEM_STOCK_RELATEDNEWS							1001
#define SUBMENU_ITEM_STOCK_RELATEDWARRANT						1101
#define SUBMENU_ITEM_STOCK_RELATEDSECTOR						1201
#define SUBMENU_ITEM_STOCK_RELATEDFUNDAMENTAL					1301
#define SUBMENU_ITEM_STOCK_TRANSRECORD							1401
#define SUBMENU_ITEM_STOCK_MONEYFLOW							1501

//MODULE_QUOTE_WARRANT_CBBC
#define SUBMENU_ITEM_WARRANT_CBBC_UNDERLTING					1101
#define SUBMENU_ITEM_WARRANT_CBBC_RELATEDNEWS                   1102
#define SUBMENU_ITEM_WARRANT_CBBC_RELATEDSECTOR					1103
#define SUBMENU_ITEM_WARRANT_CBBC_RELATEDFUNDAMENTAL			1104
#define SUBMENU_ITEM_WARRANT_CBBC_TRANSRECORD					1105
#define SUBMENU_ITEM_WARRANT_CBBC_MONEYFLOW						1106
#define SUBMENU_ITEM_WARRANT_CBBC_OPTION                        1107

#define SUBMENU_ITEM_CBBC_UNDERLTING							1002
#define SUBMENU_ITEM_CBBC_BALWARRANT							1102
#define SUBMENU_ITEM_CBBC_RELATEDNEWS							1202
#define SUBMENU_ITEM_CBBC_RELATEDSECTOR							1302
#define SUBMENU_ITEM_CBBC_RELATEDFUNDAMENTAL					1402
#define SUBMENU_ITEM_CBBC_TRANSRECORD							1502
#define SUBMENU_ITEM_CBBC_MONEYFLOW								1602

#define SUBMENU_ITEM_WARRANT_UNDERLTING							1003
#define SUBMENU_ITEM_WARRANT_BALWARRANT							1103
#define SUBMENU_ITEM_WARRANT_RELATEDNEWS						1203
#define SUBMENU_ITEM_WARRANT_RELATEDSECTOR						1303
#define SUBMENU_ITEM_WARRANT_RELATEDFUNDAMENTAL					1403
#define SUBMENU_ITEM_WARRANT_TRANSRECORD						1503
#define SUBMENU_ITEM_WARRANT_MONEYFLOW							1603

#define SUBMENU_ITEM_STOCK_OPTION							1601
#define SUBMENU_ITEM_CBBC_OPTION							1702
#define SUBMENU_ITEM_WARRANT_OPTION							1703 

#define SUBMENU_ITEM_INDICES								20
#define SUBMENU_ITEM_SECTOR									21
#define SUBMENU_ITEM_RANKING								22
#define SUBMENU_ITEM_MARKETINGCALENDAR						23
#define SUBMENU_ITEM_AH										24

#define SUBMENU_ITEM_WATCHLIST_OPTION						30

#define SUBMENU_ITEM_INDEXFUTURE_OPTION						40 //It should have same behaviour as 40-130
#define SUBMENU_ITEM_INDEX_OPTION							50
#define SUBMENU_ITEM_INDEXCOMPONENT_OPTION					60
#define SUBMENU_ITEM_SECTOR_OPTION							70
#define SUBMENU_ITEM_AH_OPTION								90
#define SUBMENU_ITEM_FUNDAMENTAL_OPTION						100
#define SUBMENU_ITEM_FX_OPTION								110
#define SUBMENU_ITEM_STOCKSEARCH_OPTION						120
#define SUBMENU_ITEM_WARRANTSEARCH_OPTION					130

//MODULE_TOPRANK_SECTOR
#define SUBMENU_ITEM_STOCK									140
#define SUBMENU_ITEM_HSCEI									141
#define SUBMENU_ITEM_REDCHIPS								142
#define SUBMENU_ITEM_GEM									143
#define SUBMENU_ITEM_WARRANT								144
#define SUBMENU_ITEM_CBBC									145
#define SUBMENU_ITEM_TOPRANK_OPTION							146

//MODULE_NEWS
#define SUBMENU_ITEM_ALLNEWS								150
#define SUBMENU_ITEM_CUSTOMNEWS								151
#define SUBMENU_ITEM_DJNEWS									152
#define SUBMENU_ITEM_HKEXNEWS								153
#define SUBMENU_ITEM_NEWS_OPTION							154

//MODULE_TOPRANK_CATEGORY
#define SUBMENU_ITEM_TOPRANK_CATEGORY_GAIN					156
#define SUBMENU_ITEM_TOPRANK_CATEGORY_LOSS					157
#define SUBMENU_ITEM_TOPRANK_CATEGORY_PGAIN					158
#define SUBMENU_ITEM_TOPRANK_CATEGORY_PLOSS					159
#define SUBMENU_ITEM_TOPRANK_CATEGORY_VOLUME				160
#define SUBMENU_ITEM_TOPRANK_CATEGORY_TURNOVER				161
#define SUBMENU_ITEM_TOPRANK_CATEGORY_52HIGH				162
#define SUBMENU_ITEM_TOPRANK_CATEGORY_52LOW					163
#define SUBMENU_ITEM_TOPRANK_CATEGORY_OPTION				171

// MODULE_FUNDAMENTAL_DETAIL
#define SUBMENU_ITEM_MARKETDATA								164
#define SUBMENU_ITEM_COMPPROFILE							165
#define SUBMENU_ITEM_CORPINFO								166
#define SUBMENU_ITEM_BALSHEET								167
#define SUBMENU_ITEM_PROFITLOSS								168
#define SUBMENU_ITEM_FINRATIO								169
#define SUBMENU_ITEM_DIVIDEND								170
#define SUBMENU_ITEM_FUNDAMENTAL_DETAIL_OPTION				172


#define SUBMENU_ITEM_MY_ACCOUNT								173
#define SUBMENU_ITEM_ACCOUNT_POSITION						174
#define SUBMENU_ITEM_ACCOUNT_HISTOTY						175
#define SUBMENU_ITEM_OUTSTANDING_ORDER						176

//MODULE_IPO
#define SUBMENU_ITEM_IPO_CURRENT                                1801
#define SUBMENU_ITEM_IPO_UPCOMING                               1802
#define SUBMENU_ITEM_IPO_LISTED                                 1803
#define SUBMENU_ITEM_IPO_CALENDAR                               1804
#define SUBMENU_ITEM_IPO_OPTION                                 1805
#define SUBMENU_ITEM_IPO_INFO                                   1806
#define SUBMENU_ITEM_IPO_FUNDAMENTAL_OPTION                     1807

//MODULE_Dividend
#define SUBMENU_ITEM_DIVIDEND_STOCK                             1901
#define SUBMENU_ITEM_DIVIDEND_NONSTOCK                          1902
#define SUBMENU_ITEM_DIVIDEND_OPTION                            1903



//MODULE_SETTING	
//MODULE_MARKETDAILY
#define SUBMENU_ITEM_NONE									-1


//FreeText
#define SUBMENU_ITEM_NONE									-1


	//Related View
#define RELATED_VIEW_TRANSLOG								0
#define RELATED_VIEW_MONEYFLOW								1
#define RELATED_VIEW_NEWS									2
#define RELATED_VIEW_SECTOR									3
#define RELATED_VIEW_FUNDAMENTAL							4

//Frame
#define FRAME_RELATED_VIEW									CGRectMake(0,98,320,300)
#define FRAME_QUOTE_RELATED_VIEW							CGRectMake(0,0,320,268)

#define BROKER_PREFIX										@""



#define MAX_NUMBER_PORTFOLIO								20
#define MAX_NUMBER_WATCHLIST_IN_PORTFOLIO					20
#define	MAX_NUMBER_WATCHLIST_PORTFOLIO_NAME					10

//FX
#define TimeOutFXSecond										30
#define DefaultSelectedCurrency								0
#define	Index_CurrencyUS									0
#define	Index_CurrencyHK									1



typedef enum {
	PTIndexViewControllerPageNumberNone				= -1,
	PTIndexViewControllerPageNumberIndex			= 0,
	PTIndexViewControllerPageNumberSector			= 1,
	PTIndexViewControllerPageNumberTopRank			= 2,
	PTIndexViewControllerPageNumberMarketCalender	= 4,
	PTIndexViewControllerPageNumberAHShares			= 3
}PTIndexViewControllerPageNumber;


#define ApplicationMode_Snapshot_WithLogin_WithoutTrading							0
#define ApplicationMode_Snapshot_WithoutLogin_WithTrading							1
#define ApplicationMode_Snapshot_WithLogin_WithTrading								2
#define ApplicationMode_Snapshot_WithoutLogin_WithoutTrading						3

#define ApplicationMode_Streamer_WithLogin_WithoutTrading							4
#define ApplicationMode_Streamer_WithoutLogin_WithTrading							5
#define ApplicationMode_Streamer_WithLogin_WithTrading								6
#define ApplicationMode_Streamer_WithoutLogin_WithoutTrading						7


//放番係Project Constant
#define ENABLE_COMPANY_PROMOTION_TEXT												NO
