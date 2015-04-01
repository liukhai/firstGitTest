//
//  ATMUtil.h
//  BEA
//
//  Created by yaojzy on 7/26/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBKUtil.h"
#import "HttpRequestUtils.h"

@interface ATMUtil : NSObject<ASIHTTPRequestDelegate> {
	NSString* request_type;
    
}

+ (ATMUtil*) me;

+(void)moveForwardItemsByKey:(NSMutableArray *)items_data;
-(void)sortItemsAlphabetically:(NSMutableArray *)items_data;

-(void)stepone;
- (void) checkATMListDelta:(NSData*)datas;

@end
