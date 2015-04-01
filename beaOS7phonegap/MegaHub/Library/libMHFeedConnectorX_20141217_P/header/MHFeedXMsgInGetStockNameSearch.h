//
//  MHFeedXMsgInGetStockNameSearch.h
//  MHFeedConnectorX
//
//  Created by Hong on 28/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInGetStockNameSearch : MHFeedXMsgIn {
	NSString		*m_sSearchKey;
	NSString		*m_sTotalStock;
	NSMutableArray	*m_oStockQuoteArray;
}

@property (nonatomic,readonly) NSString			*m_sSearchKey;
@property (nonatomic,readonly) NSString			*m_sTotalStock;
@property (nonatomic,readonly) NSMutableArray	*m_oStockQuoteArray;

- (id)init;
- (id)initWithData:(NSData *)aData messageID:(unsigned int)aMessageID freeText:(NSString *)aFreeText;
- (void) dealloc;


@end
