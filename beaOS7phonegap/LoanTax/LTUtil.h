//
//  LTUtil.h
//  BEA
//
//  Created by YAO JASEN on 10/20/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "LTViewController.h"
#import "LTTNCViewController.h"

@class LTViewController;

@interface LTUtil : NSObject {
    LTViewController *lTViewController;
}
@property (nonatomic, retain) LTViewController *lTViewController;
+ (LTUtil *)me;
+(void)showTNC;
+(void)showLoanOffers;
+(void)showRepaymentTable;
-(void)callToApply;

@end
