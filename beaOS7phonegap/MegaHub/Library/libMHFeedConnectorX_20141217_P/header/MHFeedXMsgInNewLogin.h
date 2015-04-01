//
//  MHFeedXMsgInNewLogin.h
//  MHFeedConnectorX
//
//  Created by MegaHub on 11/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInNewLogin : MHFeedXMsgIn {
    int         m_iAuthenticate;
    NSString    *m_sBroker;
    NSString    *m_sUser;
    NSString    *m_sTGT;
    NSString    *m_sModule;
    NSString    *m_sError;
    NSString    *m_sIP;
}

@property(nonatomic,readonly) int         m_iAuthenticate;
@property(nonatomic,readonly) NSString    *m_sBroker;
@property(nonatomic,readonly) NSString    *m_sUser;
@property(nonatomic,readonly) NSString    *m_sTGT;
@property(nonatomic,readonly) NSString    *m_sModule;
@property(nonatomic,readonly) NSString    *m_sError;
@property(nonatomic,readonly) NSString    *m_sIP;

- (id)initWithTGT:(NSString *)aTGT messageID:(unsigned int)aMsgID freeText:(NSString *)aFreeText brokerID:(NSString *)aBrokerID userID:(NSString *)aUserID ;
- (id)initWithData:(NSData *)aData messageID:(unsigned int)aMsgID freeText:(NSString *)aFreeText ;
- (void)dealloc;

@end
