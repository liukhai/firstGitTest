//
//  HotlineUtil.h
//  BEA
//
//  Created by yelong on 3/3/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HotlineUtil : NSObject {
	NSString *hotline;
	NSNumber* mvflag2;
}

@property (retain,nonatomic) NSString *hotline;
@property(nonatomic, retain) NSNumber* mvflag2;

+(HotlineUtil*) me;
-(void) call: (NSString *)num;
-(void) call:(NSString *)num
        name:(NSString*)name;
- (void)increaseMvflag2;
- (NSString *)getDocHotlinePath;

@end
