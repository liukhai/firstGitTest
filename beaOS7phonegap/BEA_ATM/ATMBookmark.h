//
//  ATMBookmark.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月25日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistOperator.h"

@interface ATMBookmark : NSObject {
	NSMutableDictionary *data;
}

+(void)removeExpiredBookmark;
-(void)addBookmark:(NSDictionary *)bookmark ToGroup:(int)group;
-(void)removeBookmark:(NSDictionary *)bookmark InGroup:(int)group;
-(BOOL)isOfferExist:(NSDictionary *)bookmark InGroup:(int)group;
-(NSString *)listOfferIdInGroup:(int)group;

@end
