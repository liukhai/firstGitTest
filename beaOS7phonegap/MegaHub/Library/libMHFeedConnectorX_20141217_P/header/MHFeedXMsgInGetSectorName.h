//
//  MHFeedXMsgInGetSectorName.h
//  MHFeedConnectorX
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInGetSectorName : MHFeedXMsgIn {
	unsigned int		m_uiTotalSector;
	NSArray				*m_oSectorArray;
}

@property (nonatomic, readonly) unsigned int	m_uiTotalSector;
@property (nonatomic, readonly) NSArray			*m_oSectorArray;

- (void)dealloc;
- (id)initWithData:(NSData *)aData messageID:(unsigned int)aMessageID freeText:(NSString *)aFreeText;
- (NSString *)description;

@end
