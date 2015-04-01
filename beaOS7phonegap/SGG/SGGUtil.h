//
//  SGGUtil.h
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGGViewController.h"
#import "SGGIntroViewController.h"
#import "SGGGameViewController.h"
#import "SGGRetryViewController.h"
#import "SGGPIViewController.h"
#import "SGGTNCViewController.h"

@class SGGViewController;

@interface SGGUtil : NSObject <ASIHTTPRequestDelegate>{
    SGGViewController *_SGGViewController;
    NSString *serverFlag;
    NSString *inModule;
}
@property (nonatomic, retain) SGGViewController *_SGGViewController;
@property (nonatomic, retain) NSString *serverFlag;
@property (nonatomic, retain) NSString *inModule;

+ (SGGUtil *)me;
+ (BOOL) isValidUtil;
-(void)alertAndBackToMain;
-(void)goHome;
-(void)showMainViewController;
+ (void) setInModule;
+ (void) setOutModule;
+ (BOOL) isInModule;
-(void)goOut;
-(void)goIn;

@end
