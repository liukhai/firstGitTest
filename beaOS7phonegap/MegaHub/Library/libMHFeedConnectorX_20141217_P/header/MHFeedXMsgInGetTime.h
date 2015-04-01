//
//  MHFeedXMsgInGetTime.h
//  MHFeedConnectorX
//
//  Created by MegaHub on 26/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHFeedXMsgIn.h"

@interface MHFeedXMsgInGetTime : MHFeedXMsgIn {
    BOOL        m_isGetFromServer;
    NSString    *m_sDateTime;
    NSString    *m_sTimeMillis;    
    NSString    *m_sIP;
    
    NSObject    *m_oPara;
}
@property(nonatomic, readonly) BOOL          m_isGetFromServer;
@property(nonatomic, readonly) NSString      *m_sDateTime;
@property(nonatomic, readonly) NSString      *m_sTimeMillis;
@property(nonatomic, readonly) NSString      *m_sIP;
@property(nonatomic, readonly) NSObject      *m_oPara;

- (id)initWithData:(NSData *)aData para:(NSObject *)aPara;
- (void)dealloc ;

- (NSString *)description ;

@end
