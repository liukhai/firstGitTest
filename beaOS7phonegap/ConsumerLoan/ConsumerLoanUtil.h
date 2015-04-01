//
//  ConsumerLoanUtil.h
//  BEA
//
//  Created by NEO on 11/14/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "ConsumerLoanViewController.h"

@class ConsumerLoanViewController;

@interface ConsumerLoanUtil : NSObject <ASIHTTPRequestDelegate>{
    ConsumerLoanViewController *ConsumerLoan_view_controller;
    NSString *strSend;
    NSString *frompage;
    NSString *revolvingLoanUrl;
}
@property (nonatomic, retain) ConsumerLoanViewController *ConsumerLoan_view_controller;
@property (nonatomic, retain) NSString *strSend;
@property (nonatomic, retain) NSString *frompage;
@property (nonatomic, retain) NSString *revolvingLoanUrl;

+ (ConsumerLoanUtil*) me;
-(void)callToApply;
+ (BOOL) isLangOfChi;
-(BOOL) isSend;
//-(void)showConsumerLoanOffersViewController:(NSString*)url
//                                    hotline:(NSString*)hotline
//                                   btnLanel:(NSString*)btnLabel
//                                        tnc:(NSString*)tnc;
-(void)backToFromPage;
-(void)showNearBy;
//-(void)showConsumerLoanViewController:(NSString*)lastScreenName
//                                  url:(NSString*)url
//                              hotline:(NSString*)hotline
//                             btnLanel:(NSString*)btnLabel//added by jasen on 20111118
//                                  tnc:(NSString*)tncurl
//                                 url2:(NSString*)url2
//                            url2label:(NSString*)url2label;
-(void)showConsumerLoanViewController:(NSString*)lastScreenName
                             merchant:(NSDictionary*)merchant;

@end
