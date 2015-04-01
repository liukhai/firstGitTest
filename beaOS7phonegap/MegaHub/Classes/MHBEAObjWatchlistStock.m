//
//  MHBEAObjWatchlistStock.m
//  MegaHub
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MHBEAObjWatchlistStock.h"


@implementation MHBEAObjWatchlistStock


@synthesize m_sSymbol;
@synthesize m_oQuote;
@synthesize m_sInputPrice;
@synthesize m_sInputQty;

- (id)initWithDictionary:(NSDictionary *)aDict {
	self = [super init];
	if (self == nil) {return nil;}
	
	m_sSymbol = [[aDict objectForKey:@"symbol"] retain];
	m_oQuote = [[aDict objectForKey:@"quote"] retain];
	m_sInputPrice = [[aDict objectForKey:@"price"] retain];
	m_sInputQty = [[aDict objectForKey:@"qty"] retain];
	
	
	return self;
}

- (NSDictionary *)toDictionary {
	NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
	
	if (m_sSymbol) {
		[dict setObject:[NSString stringWithFormat:@"%d",[m_sSymbol intValue]] forKey:@"symbol"];
	}
	if (m_oQuote) {
		[dict setObject:m_oQuote forKey:@"quote"];
	}
	if (m_sInputPrice) {
		[dict setObject:m_sInputPrice forKey:@"price"];
	}
	if (m_sInputQty) {
		[dict setObject:m_sInputQty forKey:@"qty"];
	}
	
	return dict;
}

- (void)dealloc {
	[m_sSymbol release];
	[m_oQuote release];
	[m_sInputPrice release];
	[m_sInputQty release];
	[super dealloc];
}


@end
