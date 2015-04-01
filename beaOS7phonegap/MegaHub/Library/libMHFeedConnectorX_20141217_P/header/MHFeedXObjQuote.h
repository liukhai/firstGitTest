//
//  MHFeedXObjQuote.h
//  MHFeedConnectorX
//
//  Created by Megahub on 01/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHFeedXObjQuote : NSObject {
	
	NSString *m_sSymbol;
	
	// <!---- A ----
	NSString *m_sDesp;			
	NSString *m_sStockType;	
	NSString *m_sLotSize;	
	NSString *m_sCurrency;		
	NSString *m_sSuspension;
	NSString *m_sMonthHigh1M;	//1MonthHighLow
	NSString *m_sMonthLow1M;	//1MonthHighLow
    NSString *m_sMonthClose1M;
	NSString *m_sWeekHigh52W;	//52WeekHighLow
	NSString *m_sWeekLow52W;	//52WeekHighLow
    NSString *m_sWeekClose52W;
	NSString *m_sSpreadType;
    NSString *m_sMonthHigh3M;
    NSString *m_sMonthLow3M;
    NSString *m_sMonthClose3M;
    NSString *m_sCurrencyDesp;
    NSString *m_sMonthHigh2M;
    NSString *m_sMonthLow2M;
    NSString *m_sMonthClose2M;
	// ---- A ----!>
	
	// <!---- Q ----
	NSString *m_sLastUpdate;				
	NSString *m_sQuoteMeterLog;				//QuoteMeter
	NSString *m_sQuoteMeterSuspensionLog;	//QuoteMeter
	NSString *m_sLast;						
	NSString *m_sBid;						//Bid / Ask
	NSString *m_sAsk;						//Bid / Ask
	NSString *m_sPrevClose;				
	NSString *m_sOpen;						
	NSString *m_sHigh;						
	NSString *m_sLow;						
	NSString *m_sVolume;					
	NSString *m_sTurnover;
	NSString *m_sChange;					
	NSString *m_sPctChange;	
	NSString *m_sAvgPrice;
	NSString *m_sBidSpread;
	NSString *m_sAskSpread;
    NSString *m_sTradeCount;
	// ---- Q ----!>
	
	// <!---- T ----
	NSString *m_sIEV;					//IEV/IEP
	NSString *m_sIEP;					//IEV/IEP
	NSString *m_sVolatility30;				
	NSString *m_sVolatility120;				
	NSString *m_sVolatility250;				
	NSString *m_sSTC10;						
	NSString *m_sSTC14;						
	NSString *m_sSTC20;						
	NSString *m_sSMA10;						
	NSString *m_sSMA20;						
	NSString *m_sSMA50;						
	NSString *m_sSMA100;					
	NSString *m_sSMA250;					
	NSString *m_sRSI9;						
	NSString *m_sRSI10;						
	NSString *m_sRSI14;						
	NSString *m_sRSI20;						
	NSString *m_sMACD817;					
	NSString *m_sMACD1225;					
	NSString *m_sMACD1226;
	// ---- T ----!>
	
	
	// <!---- S ----
	NSString *m_sAuthShares;				//Auth.Cap
	NSString *m_sSharesIssued;				
	NSString *m_sMarketCap;				
	NSString *m_sNAV;						
	NSString *m_sYield;						//Yeild
	NSString *m_sPERatio;					//PE	
	NSString *m_sEPS;						
	NSString *m_sDPS;
	// ---- S ----!>
	
	
	// <!---- W ----
	NSString *m_sCallOrPut;					
	NSString *m_sExpDate;				//Maturity	
	NSString *m_sStrike;				
	NSString *m_sCallLevel;				//Call Price
	NSString *m_sIssuer;					
	NSString *m_sEntitlementRatio;		//Entitlement Ratio	
	NSString *m_sOutstandingPct;		//Outstanding Qty(%)
	NSString *m_sPremium;					
	NSString *m_sGearing;					
	NSString *m_sImpVol;					
	NSString *m_sDelta;						
	NSString *m_sEffGearing;			//Effective Gearing	
	NSString *m_sMoneyness;					
	NSString *m_sSpotPrice;				//Spot vs call
	// ---- W ----!>
	
	
	// <!---- U ----
	NSString *m_sLinkIDStock;			//Underlying Code
	NSString *m_sUnderlyingDesp;		//Underlying Desp
	NSString *m_sUnderlyingPrice;		//Underlying Price	
	NSString *m_sUnderlyingChange;		//Underlying Change	
	NSString *m_sUnderlyingPctChange;	//Underlying Pct Change	
	// ---- U ----!>
	


}

@property(nonatomic, retain)NSString *m_sSymbol;

@property(nonatomic, retain)NSString *m_sDesp;			
@property(nonatomic, retain)NSString *m_sStockType;	
@property(nonatomic, retain)NSString *m_sLotSize;	
@property(nonatomic, retain)NSString *m_sCurrency;		
@property(nonatomic, retain)NSString *m_sSuspension;
@property(nonatomic, retain)NSString *m_sMonthHigh1M;
@property(nonatomic, retain)NSString *m_sMonthLow1M;
@property(nonatomic, retain)NSString *m_sMonthClose1M;
@property(nonatomic, retain)NSString *m_sWeekHigh52W;
@property(nonatomic, retain)NSString *m_sWeekLow52W;
@property(nonatomic, retain)NSString *m_sWeekClose52W;
@property(nonatomic, retain)NSString *m_sSpreadType;    
@property(nonatomic, retain)NSString *m_sMonthHigh3M;
@property(nonatomic, retain)NSString *m_sMonthLow3M;
@property(nonatomic, retain)NSString *m_sMonthClose3M;
@property(nonatomic, retain)NSString *m_sCurrencyDesp;
@property(nonatomic, retain)NSString *m_sMonthHigh2M;
@property(nonatomic, retain)NSString *m_sMonthLow2M;
@property(nonatomic, retain)NSString *m_sMonthClose2M;

@property(nonatomic, retain)NSString *m_sLastUpdate;				
@property(nonatomic, retain)NSString *m_sQuoteMeterLog;	
@property(nonatomic, retain)NSString *m_sQuoteMeterSuspensionLog;
@property(nonatomic, retain)NSString *m_sLast;						
@property(nonatomic, retain)NSString *m_sBid;	
@property(nonatomic, retain)NSString *m_sAsk;					
@property(nonatomic, retain)NSString *m_sPrevClose;				
@property(nonatomic, retain)NSString *m_sOpen;						
@property(nonatomic, retain)NSString *m_sHigh;						
@property(nonatomic, retain)NSString *m_sLow;						
@property(nonatomic, retain)NSString *m_sVolume;					
@property(nonatomic, retain)NSString *m_sTurnover;					
@property(nonatomic, retain)NSString *m_sChange;					
@property(nonatomic, retain)NSString *m_sPctChange;	
@property(nonatomic, retain)NSString *m_sAvgPrice;
@property(nonatomic, retain)NSString *m_sBidSpread;
@property(nonatomic, retain)NSString *m_sAskSpread;
@property(nonatomic, retain)NSString *m_sTradeCount;

// T
@property(nonatomic, retain)NSString *m_sIEV;	
@property(nonatomic, retain)NSString *m_sIEP;					
@property(nonatomic, retain)NSString *m_sVolatility30;				
@property(nonatomic, retain)NSString *m_sVolatility120;				
@property(nonatomic, retain)NSString *m_sVolatility250;				
@property(nonatomic, retain)NSString *m_sSTC10;						
@property(nonatomic, retain)NSString *m_sSTC14;						
@property(nonatomic, retain)NSString *m_sSTC20;						
@property(nonatomic, retain)NSString *m_sSMA10;						
@property(nonatomic, retain)NSString *m_sSMA20;						
@property(nonatomic, retain)NSString *m_sSMA50;						
@property(nonatomic, retain)NSString *m_sSMA100;					
@property(nonatomic, retain)NSString *m_sSMA250;					
@property(nonatomic, retain)NSString *m_sRSI9;						
@property(nonatomic, retain)NSString *m_sRSI10;						
@property(nonatomic, retain)NSString *m_sRSI14;						
@property(nonatomic, retain)NSString *m_sRSI20;						
@property(nonatomic, retain)NSString *m_sMACD817;					
@property(nonatomic, retain)NSString *m_sMACD1225;					
@property(nonatomic, retain)NSString *m_sMACD1226;

// S
@property(nonatomic, retain)NSString *m_sAuthShares;					
@property(nonatomic, retain)NSString *m_sSharesIssued;				
@property(nonatomic, retain)NSString *m_sMarketCap;				
@property(nonatomic, retain)NSString *m_sNAV;						
@property(nonatomic, retain)NSString *m_sYield;						
@property(nonatomic, retain)NSString *m_sPERatio;						
@property(nonatomic, retain)NSString *m_sEPS;						
@property(nonatomic, retain)NSString *m_sDPS;

@property(nonatomic, retain)NSString *m_sCallOrPut;					
@property(nonatomic, retain)NSString *m_sExpDate;					
@property(nonatomic, retain)NSString *m_sStrike;				
@property(nonatomic, retain)NSString *m_sCallLevel;				
@property(nonatomic, retain)NSString *m_sIssuer;					
@property(nonatomic, retain)NSString *m_sEntitlementRatio;			
@property(nonatomic, retain)NSString *m_sOutstandingPct;	
@property(nonatomic, retain)NSString *m_sPremium;					
@property(nonatomic, retain)NSString *m_sGearing;					
@property(nonatomic, retain)NSString *m_sImpVol;					
@property(nonatomic, retain)NSString *m_sDelta;						
@property(nonatomic, retain)NSString *m_sEffGearing;			
@property(nonatomic, retain)NSString *m_sMoneyness;					
@property(nonatomic, retain)NSString *m_sSpotPrice;	

@property(nonatomic, retain)NSString *m_sLinkIDStock;			
@property(nonatomic, retain)NSString *m_sUnderlyingDesp;			
@property(nonatomic, retain)NSString *m_sUnderlyingPrice;			
@property(nonatomic, retain)NSString *m_sUnderlyingChange;			
@property(nonatomic, retain)NSString *m_sUnderlyingPctChange;		

- (void)dealloc ;
- (id)initWithXMLDictionary:(NSDictionary *)aDict ;
- (NSString *)description ;

@end