//
//  MHFeedConnectorXConstant.h
//  MHFeedConnectorX
//
//  Created by Megahub on 01/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define MHFEEDCONNECTORX_BUILD_MODE         'P'

#define URL_VERSION_1_0                     @"1_0"

#define String_XML_TopRank_Sector_Stock		@"S"
#define String_XML_TopRank_Sector_CBBC		@"C"
#define String_XML_TopRank_Sector_Warrant	@"W"
#define String_XML_TopRank_Sector_RedChips	@"R"
#define String_XML_TopRank_Sector_HShares	@"H"
#define String_XML_TopRank_Sector_GEM		@"G"

#define String_XML_TopRank_Category_GAIN		@"GAIN"
#define String_XML_TopRank_Category_LOSS		@"LOSS"
#define String_XML_TopRank_Category_PGAIN		@"PGAIN"
#define String_XML_TopRank_Category_PLOSS		@"PLOSS"
#define String_XML_TopRank_Category_VOLUME		@"VOLUME"
#define String_XML_TopRank_Category_TURNOVER	@"TURNOVER"
#define String_XML_TopRank_Category_52HIGH		@"52HIGH"
#define String_XML_TopRank_Category_52LOW		@"52LOW"
#define String_XML_TopRank_Category_STOCK_ID    @"STOCK_ID"

#define MaxConcurrentOperationCount			10

// Lite Quote
#define Parameter_Desp						@"A1"
#define Parameter_Stock_Type				@"A2"	
#define Parameter_Lot_Size					@"A3"	
#define Parameter_Currency					@"A4"	
#define Parameter_Suspension				@"A5"	
#define Parameter_1MonthHighLow				@"A6"
#define Parameter_1MonthHighLowClose        @"A6"
#define Parameter_52WeekHighLow				@"A7"       
#define Parameter_52WeekHighLowClose        @"A7"
#define Parameter_SpreadType				@"A8"	
#define Parameter_MonthHighLow3M			@"A9"
#define Parameter_MonthHighLow3MClose       @"A9"
#define Parameter_CurrencyDesp              @"A10"
#define Parameter_2MonthHighLowClose        @"A11"

#define Parameter_Last_Update				@"Q1"	
#define Parameter_QuoteMeter				@"Q2"	
#define Parameter_Last						@"Q3"	
#define Parameter_BidandAsk					@"Q4"	
#define Parameter_Prev_Close				@"Q5"	
#define Parameter_Open						@"Q6"	
#define Parameter_High						@"Q7"	
#define Parameter_Low						@"Q8"	
#define Parameter_Volume					@"Q9"	
#define Parameter_Turnover					@"Q10"	
#define Parameter_Change					@"Q11"	
#define Parameter_Pct_Change				@"Q12"	
#define Parameter_AvgPrice					@"Q13"
#define Parameter_BidAskSpread				@"Q14"
#define Parameter_TradeCount                @"Q17"

#define Parameter_IEVOrIEP					@"T1"	
#define Parameter_Volatility30				@"T2"	
#define Parameter_Volatility120				@"T3"	
#define Parameter_Volatility250				@"T4"	
#define Parameter_STC10						@"T5"	
#define Parameter_STC14						@"T6"	
#define Parameter_STC20						@"T7"	
#define Parameter_SMA10						@"T8"	
#define Parameter_SMA20						@"T9"	
#define Parameter_SMA50						@"T10"	
#define Parameter_SMA100					@"T11"	
#define Parameter_SMA250					@"T12"	
#define Parameter_RSI9						@"T13"	
#define Parameter_RSI10						@"T14"	
#define Parameter_RSI14						@"T15"	
#define Parameter_RSI20						@"T16"	
#define Parameter_MACD817					@"T17"	
#define Parameter_MACD1225					@"T18"	
#define Parameter_MACD1226					@"T19"	

#define Parameter_AuthCap					@"S1"	
#define Parameter_Shares_Issued				@"S2"	
#define Parameter_Market_Cap				@"S3"	
#define Parameter_NAV						@"S4"	
#define Parameter_Yeild						@"S5"	
#define Parameter_PE						@"S6"	
#define Parameter_EPS						@"S7"	
#define Parameter_DPS						@"S8"	

#define Parameter_Call_Put					@"W1"	
#define Parameter_Maturity					@"W2"	
#define Parameter_Strike					@"W3"	
#define Parameter_Call_Price				@"W4"	
#define Parameter_Issuer					@"W5"	
#define Parameter_Entitlement_Ratio			@"W6"	
#define Parameter_Outstanding_QtyPencentage	@"W7"	
#define Parameter_Premium					@"W8"	
#define Parameter_Gearing					@"W9"	
#define Parameter_Imp_Vol					@"W10"	
#define Parameter_Delta						@"W11"	
#define Parameter_Effective_Gearing			@"W12"	
#define Parameter_Moneyness					@"W13"	
#define Parameter_Spot_vs_call				@"W14"	

#define Parameter_Underlying_Code			@"U1"	
#define Parameter_Underlying_Desp			@"U2"	
#define Parameter_Underlying_Price			@"U3"	
#define Parameter_Underlying_Change			@"U4"	
#define Parameter_Underlying_PctChange		@"U5"	

#define MHFEEDX_PERMISSION_MT_AH_SHARES2						@"MT_AH_SHARES2"
#define MHFEEDX_PERMISSION_MT_CHART								@"MT_CHART"
#define MHFEEDX_PERMISSION_MT_CHINA_DISCOUNT					@"MT_CHINA_DISCOUNT"
#define MHFEEDX_PERMISSION_MT_COMPANY_PROFILE					@"MT_COMPANY_PROFILE"
#define MHFEEDX_PERMISSION_MT_FX								@"MT_FX"
#define MHFEEDX_PERMISSION_MT_INDEX_FUTURES						@"MT_INDEX_FUTURES"
#define MHFEEDX_PERMISSION_MT_JAPANESE							@"MT_JAPANESE"
#define MHFEEDX_PERMISSION_MT_LOCAL_INDEX2						@"MT_LOCAL_INDEX2"
#define MHFEEDX_PERMISSION_MT_NEWS_BUTTON						@"MT_NEWS_BUTTON"
#define MHFEEDX_PERMISSION_MT_SECTOR							@"MT_SECTOR"
#define MHFEEDX_PERMISSION_MT_SNAPSHOT_I						@"MT_SNAPSHOT_I"
#define MHFEEDX_PERMISSION_MT_STOCK_WATCH						@"MT_STOCK_WATCH"
#define MHFEEDX_PERMISSION_MT_TELETEXT							@"MT_TELETEXT"
#define MHFEEDX_PERMISSION_MT_TOP_RANK							@"MT_TOP_RANK"
#define MHFEEDX_PERMISSION_MT_TRANSACTION						@"MT_TRANSACTION"
#define MHFEEDX_PERMISSION_MT_WORLD_INDEX2						@"MT_WORLD_INDEX2"
#define MHFEEDX_PERMISSION_MT_SNAPSHOT_DELAY                    @"MT_SNAPSHOT_DELAY"
#define MHFEEDX_PERMISSION_MT_IPO                               @"MT_IPO"
#define MHFEEDX_PERMISSION_MT_DIVIDEND                          @"MT_DIVIDEND"
#define MHFEEDX_PERMISSION_MT_DELAY_FUTURES                     @"MT_DELAY_FUTURES"

#define String_XML_Stock_Name_Search_All                        @"ALL"
#define String_XML_Stock_Name_Search_Stock                      @"STOCK"
#define String_XML_Stock_Name_Search_Warrant                    @"WARRANT"
#define String_XML_Stock_Name_Search_Cbbc                       @"CBBC"

typedef enum {
	PTNewsSourceIDCustom			= -9999,
	PTNewsSourceIDUnknown			= -1,
	PTNewsSourceIDAllNews			= 0,
	PTNewsSourceIDInfocase			= 1,
	PTNewsSourceIDHKExchange		= 2,
	PTNewsSourceIDDowJowns			= 3,
} PTNewsSourceID;


#define debugprint(__x__)   if ([[MHFeedConnectorX sharedMHFeedConnectorX] getDebugMessage]) { NSLog(__x__); }