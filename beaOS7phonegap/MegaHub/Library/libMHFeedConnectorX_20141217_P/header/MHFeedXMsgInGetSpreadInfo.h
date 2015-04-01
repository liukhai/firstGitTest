//
//  MHFeedXMsgInGetSpreadInfo.h
//  MHFeedConnectorX
//
//  Created by Hong on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInGetSpreadInfo : MHFeedXMsgIn {
	NSMutableDictionary *m_oSpreadArrayDictionary;
}

@property(nonatomic, readonly) NSMutableDictionary		*m_oSpreadArrayDictionary;

- (id)init ;
- (void)dealloc;
- (id)initWithData:(NSData *)aData messageID:(unsigned int)aMessageID freeText:(NSString *)aFreeText;
- (NSString *)description;

@end
