//
//  MHFeedXObjWorldIndex.h
//  MHFeedConnectorX
//
//  Created by Hong on 07/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MHFeedXObjWorldIndex : NSObject {
	
	NSString		*m_sSymbol;
	NSString		*m_sDesp;
	NSString		*m_sChiDesp;
	NSString		*m_sCnDesp;
	NSString		*m_sJpDesp;
	NSString		*m_sShortDesp;
	NSString		*m_sChiShortDesp;
	NSString		*m_sCnShortDesp;
	NSString		*m_sLast;
	NSString		*m_sChange;
	NSString		*m_sPctChange;
	NSString		*m_sOpen;
	NSString		*m_sHigh;
	NSString		*m_sLow;
	NSString		*m_sVolume;
    NSString        *m_sRegion;
}

@property (nonatomic, retain) NSString *m_sSymbol;
@property (nonatomic, retain) NSString *m_sDesp;
@property (nonatomic, retain) NSString *m_sChiDesp;
@property (nonatomic, retain) NSString *m_sCnDesp;
@property (nonatomic, retain) NSString *m_sJpDesp;
@property (nonatomic, retain) NSString *m_sShortDesp;
@property (nonatomic, retain) NSString *m_sChiShortDesp;
@property (nonatomic, retain) NSString *m_sCnShortDesp;
@property (nonatomic, retain) NSString *m_sLast;
@property (nonatomic, retain) NSString *m_sChange;
@property (nonatomic, retain) NSString *m_sPctChange;
@property (nonatomic, retain) NSString *m_sOpen;
@property (nonatomic, retain) NSString *m_sHigh;
@property (nonatomic, retain) NSString *m_sLow;
@property (nonatomic, retain) NSString *m_sVolume;
@property (nonatomic, retain) NSString *m_sRegion;

- (id) initWithSingleOrderNode:(NSDictionary *)aSingleOrderNode;
- (void)dealloc;

- (NSString *)description;

@end
