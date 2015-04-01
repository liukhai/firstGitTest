//
//  InstalmentLoanUtil.h
//  BEA
//
//  Created by NEO on 01/12/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "InstalmentLoanViewController.h"

@interface InstalmentLoanUtil : NSObject <ASIHTTPRequestDelegate>{
    NSString *strSend;
    InstalmentLoanViewController *_InstalmentLoanViewController;
}
@property (nonatomic, retain) InstalmentLoanViewController *_InstalmentLoanViewController;
@property (nonatomic, retain) NSString *strSend;
+(void)showTNC;
+(void)showLoanOffers;
//+(void)showRepaymentTable;
-(void)callToApply;
+ (BOOL) isValidUtil;
+ (InstalmentLoanUtil*) me;
-(BOOL)isSend;
+(void)showTNC;
+(void)showLoanOffers;
+(void)showRepaymentTable;
@end
