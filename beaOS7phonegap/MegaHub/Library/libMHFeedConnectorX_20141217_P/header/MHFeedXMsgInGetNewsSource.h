//
//  MHFeedXMsgInGetNewsSource.h
//  MHFeedConnectorX
//
//  Created by Hong on 09/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInGetNewsSource : MHFeedXMsgIn {
	NSArray			*m_oSourceArray;
}

@property(nonatomic, retain) NSArray	*m_oSourceArray;

- (id)init;
- (void)dealloc;
- (id)initWithData:(NSData *)aData messageID:(unsigned int)aMessageID freeText:(NSString *)aFreeText;


@end
