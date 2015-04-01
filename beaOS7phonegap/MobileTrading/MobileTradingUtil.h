//
//  MobileTradingUtil.h
//  BEA
//
//  Created by yufei on 3/16/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "CoreData.h"

@interface MobileTradingUtil : NSObject<ASIHTTPRequestDelegate> {
    NSString* requestServer;
}

@property(nonatomic, retain) NSString* requestServer;

+ (MobileTradingUtil*) me;//added by jasen
- (NSString*) getCheckMobileTradingURL;
- (void) checkMobileTradingRegStatus;
- (NSURL*) getURLCYTMBKREG;

@end
