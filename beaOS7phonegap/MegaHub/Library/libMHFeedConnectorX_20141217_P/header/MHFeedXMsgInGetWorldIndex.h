//
//  MHFeedXMsgInGetWorldIndex.h
//  MHFeedConnectorX
//
//  Created by Hong on 07/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInGetWorldIndex : MHFeedXMsgIn {
	
	NSString			*m_sLastUpd;
	NSMutableArray		*m_oIndexArray;
}

@property (nonatomic, retain) NSString			*m_sLastUpd;
@property (nonatomic, retain) NSMutableArray	*m_oIndexArray;

- (id)init;
- (id)initWithData:(NSData *)rawMessage messageID:(unsigned int)aMessageID freeText:(NSString *)aFreeText;
- (void)dealloc;
- (NSString *)description;

@end
