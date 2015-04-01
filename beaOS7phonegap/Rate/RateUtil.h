//
//  RateUtil.h
//  BEA
//
//  Created by NEO on 10/20/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "RateViewController.h"

@class RateViewController;

@interface RateUtil : NSObject {
    RateViewController *Rate_view_controller;
    NSString *serverFlag;
}

@property (nonatomic, retain) RateViewController *Rate_view_controller;
@property (nonatomic, retain) NSString *serverFlag;

+ (RateUtil*) me;
-(void)callToApply;
+ (BOOL) isValidUtil;
+ (BOOL) isLangOfChi;
-(NSString *) findRatePlistPath :(NSString*) rateType;


- (void)goHome;

+ (BOOL) FileExists;
+ (void) copyFile;
+ (BOOL)checkResponseData:(NSData*)datas 
                 rateType:(NSString*)rate;
+ (void)updateRateFile:(NSData*)datas 
              rateType:(NSString*) rate;
+ (NSString *)getDocTempFilePath;

-(void)alertAndBackToMain:(UIViewController*)outViewController;
-(void)alertAndBackToMain;

- (BOOL) checkRateSNExpired:(NSString *) ratePlistPath;

@end
