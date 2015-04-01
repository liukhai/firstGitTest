//
//  MHFeedXMsgInGetLiteQuote.h
//  MHFeedConnectorX
//
//  Created by Hong on 03/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInGetLiteQuote : MHFeedXMsgIn {
	int					m_iRealTime;
	int					m_iCurrentUsage;
	int					m_iCurrentBalance;
	int					m_iQuoteFreeToday;
	int					m_iQuoteUsedToday;
	NSString			*m_sTimeStamp;
	NSString			*m_sHKLastUpdate;
	NSString			*m_sCNLastUpdate;
	NSString			*m_sHKTZ;
	NSString			*m_sCNTZ;
	NSMutableArray		*m_oStockQuoteArray;
	NSString			*m_sError;
}

@property(nonatomic, readonly) int					m_iRealTime;
@property(nonatomic, readonly) int					m_iCurrentUsage;
@property(nonatomic, readonly) int					m_iCurrentBalance;
@property(nonatomic, readonly) int					m_iQuoteFreeToday;
@property(nonatomic, readonly) int					m_iQuoteUsedToday;
@property(nonatomic, readonly) NSString				*m_sTimeStamp;
@property(nonatomic, readonly) NSString				*m_sHKLastUpdate;
@property(nonatomic, readonly) NSString				*m_sCNLastUpdate;
@property(nonatomic, readonly) NSString				*m_sHKTZ;
@property(nonatomic, readonly) NSString				*m_sCNTZ;
@property(nonatomic, readonly) NSMutableArray		*m_oStockQuoteArray;

- (id)init;
- (void)dealloc;
- (id)initWithData:(NSData *)aData messageID:(unsigned int)aMessageID freeText:(NSString *)aFreeText;

@end
