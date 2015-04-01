//
//  MHFeedXObjSector.h
//  MHFeedConnectorX
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MHFeedXObjSector : NSObject {
	NSString			*m_sC;
	NSString			*m_sDesp;
}

@property(nonatomic, retain) NSString			*m_sC;
@property(nonatomic, retain) NSString			*m_sDesp;


- (void)dealloc;
- (id)initWithXMLDictionary:(NSDictionary *)aDict;
- (NSString *)description;

@end
