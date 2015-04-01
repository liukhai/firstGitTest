//
//  MHFeedXIndexName.h
//  MHFeedConnectorX
//
//  Created by MegaHub on 17/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MHFeedXObjIndexName : NSObject {
	int			m_iID;
	NSString	*m_sSymbol;
	NSString	*m_sDesp;
	int			m_iType;
	int			m_iConsti;
}

@property(nonatomic, assign) int		m_iID;
@property(nonatomic, retain) NSString	*m_sSymbol;
@property(nonatomic, retain) NSString	*m_sDesp;
@property(nonatomic, assign) int		m_iType;
@property(nonatomic, assign) int		m_iConsti;

- (id)init;
- (void)dealloc;
- (id)initWithXMLDictionary:(NSDictionary *)aDict ;

@end
