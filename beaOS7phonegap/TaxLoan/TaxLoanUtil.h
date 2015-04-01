//
//  TaxLoanUtil.h
//  BEA
//
//  Created by YAO JASEN on 10/20/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "TaxLoanViewController.h"
#import "ConsumerLoanListViewController.h"

@class TaxLoanViewController;
@class ConsumerLoanListViewController;

@interface TaxLoanUtil : NSObject <ASIHTTPRequestDelegate>{
    TaxLoanViewController *taxLoanViewController;
    NSString *strSend;
    ConsumerLoanListViewController *_ConsumerLoanListViewController;
}

@property (nonatomic, retain) TaxLoanViewController *taxLoanViewController;
@property (nonatomic, retain) NSString *strSend;
@property (nonatomic, retain) ConsumerLoanListViewController *_ConsumerLoanListViewController;

+(void)showTNC;
+(void)showLoanOffers;
//+(void)showRepaymentTable;
-(void)callToApply;
+ (BOOL) isValidUtil;
+ (BOOL) FileExists;
+ (void) copyFile;
+ (TaxLoanUtil*) me;
-(NSString *) findPlistPaths;

-(void) sendRequest:(NSString*) date_stamp
 listViewController:(ConsumerLoanListViewController*)p_ConsumerLoanListViewController;
-(BOOL)isSend;

@end
