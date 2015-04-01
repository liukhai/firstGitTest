/*
 *  MHBEAConstant.h
 *  BEA
 *
 *  Created by MegaHub on 06/07/2011.
 *  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
 *
 */

#define MHBEA_URL_REGISTION_STATUS_StockTrading			[MigrationSetting me].m_sURLRegStatusStockTrading
#define MHBEA_URL_BUY_StockTrading						[MigrationSetting me].m_sURLBuyStockTrading
#define MHBEA_URL_SELL_StockTrading						[MigrationSetting me].m_sURLSellStockTrading
#define MHBEA_URL_REGISTION_STATUS_EAS					[MigrationSetting me].m_sURLRegStatusEAS
#define MHBEA_URL_BUY_EAS								[MigrationSetting me].m_sURLBuyEAS
#define MHBEA_URL_SELL_EAS								[MigrationSetting me].m_sURLSellEAS
#define MHBEA_URL_REGISTER								[MigrationSetting me].m_sURLMBCYBLogonShow
#define MHBEA_URL_BACK									@"beaapp://backToAppStockWatch"

#define MHBEAFAQuotePageView_Chart_URL					@"http://charts.megahubhk.com/servlets/MHImageChart?sid=%@&cmode=%@&cperiod=%@000101&ctype=6&cwidth=%d&cheight=%d&tstyle=-1&ystyle=1&cr=%@&xstyle=3&pc=1&t=%@&key=%@"


#define MHBEA_LANG_zh_TW			@"zh_TW"
#define MHBEA_LANG_big5				@"Big5"

#define INTERVAL_GET_HSI				3
#define BEA_DEFAULT_STOCK				@"23"
#define MAX_WATCHLISH_COUNT				50

#define MHLanguage_BEAString			@"MHBEAString"

// save key 
#define SAVEKEY_STOCKWATCHLIST							@"savekey_stock_watchlist"
#define SAVEKEY_STOCKWATCHLIST_GAINLOSS					@"savekey_stock_watchlist_gainloss"
#define SAVEKEY_ISDETAILVIEWINWATCHLIST					@"isDetailViewInWatchlist"
#define SAVEKEY_IS_DETAILIVIEW_IN_IndexConstituent		@"isDetailViewInIndexConstituent"
#define SAVEKEY_IS_DETAILIVIEW_IN_SectorView			@"isDetailViewInSector"
#define SAVEKEY_IS_DETAILIVIEW_IN_TopRankView			@"isDetailViewInTopRank"
#define SAVEKEY_IS_DETAILIVIEW_IN_AHShareView			@"isDetailViewInAHShare"


typedef enum {
	LocalWatchlistTypeMetal			= 1,
	LocalWatchlistTypeForex			= 2,
	LocalWatchlistTypeStock			= 3,
	LocalWatchlistTypeSearch
} LocalWatchlistType;