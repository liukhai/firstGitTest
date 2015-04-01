//
//  MHFeedXMsgIn.h
//  MHFeedConnectorX
//
//  Created by Hong on 03/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MHFeedXMsgIn : NSObject {
	unsigned int		m_uiMessageID;
	NSString			*m_sFreeText;
}

@property(nonatomic, readonly) unsigned int		m_uiMessageID;
@property(nonatomic, readonly) NSString			*m_sFreeText;

- (id)initWithData:(NSData *)aData messageID:(unsigned int)aMessageID;
- (void)dealloc;
- (NSString *)description;

@end
