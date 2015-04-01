//
//  MHFeedXMsgInLogin.h
//  MHFeedConnectorX
//
//  Created by Megahub on 06/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInLogin : MHFeedXMsgIn {
	NSString	*m_sTGT;
	NSString	*m_sBrokerID;
	NSString	*m_sUserID;
}

@property (nonatomic, retain) NSString *m_sTGT;
@property (nonatomic, retain) NSString *m_sBrokerID;
@property (nonatomic, retain) NSString *m_sUserID;


- (id)init;
- (id)initWithTGT: (NSString *)aTGT
		messageID: (unsigned int)aMessageID
		 freeText: (NSString *)aFreeText
		 brokerID: (NSString *)aBrokerID
		   userID: (NSString *)aUserID;

- (id)initWithData:(NSData *)rawMessage 
		 messageID:(unsigned int)aMessageID 
		  freeText:(NSString *)aFreeText
		  brokerID:(NSString *)aBrokerID
			userID:(NSString *)aUserID;
- (void) dealloc;

@end
