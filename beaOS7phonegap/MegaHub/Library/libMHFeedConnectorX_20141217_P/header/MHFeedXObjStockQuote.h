//
//  MHFeedXObjStockQuote.h
//  MHFeedConnectorX
//
//  Created by Hong on 03/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MHFeedXObjStockQuote : NSObject {
	NSString			*m_sInput;
	
	NSMutableArray		*m_oQuoteArray;
}

@property(nonatomic, retain) NSString			*m_sInput;	
@property(nonatomic, retain) NSMutableArray		*m_oQuoteArray;

- (id)initWithXMLDictionary:(NSDictionary *)aDict;

@end
