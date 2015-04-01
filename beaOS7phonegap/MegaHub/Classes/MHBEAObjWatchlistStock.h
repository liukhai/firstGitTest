//
//  MHBEAObjWatchlistStock.h
//  MegaHub
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MHFeedXObjQuote;

@interface MHBEAObjWatchlistStock : NSObject {
	NSString			*m_sSymbol;
	MHFeedXObjQuote		*m_oQuote;
	
	NSString			*m_sInputPrice;
	NSString			*m_sInputQty;
}

@property(nonatomic, retain) NSString			*m_sSymbol;
@property(nonatomic, retain) MHFeedXObjQuote	*m_oQuote;
@property(nonatomic, retain) NSString			*m_sInputPrice;
@property(nonatomic, retain) NSString			*m_sInputQty;

- (id)initWithDictionary:(NSDictionary *)aDict;
- (NSDictionary *)toDictionary;
- (void)dealloc;


@end
