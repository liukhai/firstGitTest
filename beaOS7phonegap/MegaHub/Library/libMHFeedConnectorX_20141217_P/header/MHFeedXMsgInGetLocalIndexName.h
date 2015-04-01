//
//  MHFeedXMsgInGetLocalIndexName.h
//  MHFeedConnectorX
//
//  Created by MegaHub on 17/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInGetLocalIndexName : MHFeedXMsgIn {
	int					m_iTotalSector;
	NSMutableArray		*m_oIndexArray;
}

@property(nonatomic, readonly) int					m_iTotalSector;
@property(nonatomic, readonly) NSMutableArray		*m_oIndexArray;

- (id)init;
- (void)dealloc;
- (id)initWithData:(NSData *)rawMessage messageID:(unsigned int)aMessageID freeText:(NSString *)aFreeText ;

@end
