//
//  MHFeedXObjForex.h
//  MHFeedConnectorX
//
//  Created by Hong on 25/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MHFeedXObjForex : NSObject {
    NSString		*m_sSymbol;
	NSString		*m_sDesp;
	NSString		*m_sChiDesp;
	NSString		*m_sCnDesp;
	NSString		*m_sJpDesp;
	NSString		*m_sBid;
	NSString		*m_sAsk;
	NSString		*m_sBidHigh;
	NSString		*m_sBidLow;
	NSString		*m_sAskHigh;
	NSString		*m_sAskLow;
	NSString		*m_sPrevClose;
	
}

@property (nonatomic, retain) NSString		*m_sSymbol;
@property (nonatomic, retain) NSString		*m_sDesp;
@property (nonatomic, retain) NSString		*m_sChiDesp;
@property (nonatomic, retain) NSString		*m_sCnDesp;
@property (nonatomic, retain) NSString		*m_sJpDesp;
@property (nonatomic, retain) NSString		*m_sBid;
@property (nonatomic, retain) NSString		*m_sAsk;
@property (nonatomic, retain) NSString		*m_sBidHigh;
@property (nonatomic, retain) NSString		*m_sBidLow;
@property (nonatomic, retain) NSString		*m_sAskHigh;
@property (nonatomic, retain) NSString		*m_sAskLow;
@property (nonatomic, retain) NSString		*m_sPrevClose;

- (id) initWithForexNode:(NSDictionary *)aForexNode;
- (void) dealloc;

@end
