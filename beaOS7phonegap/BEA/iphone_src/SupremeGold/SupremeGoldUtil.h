//
//  SupremeGoldUtil.h
//  BEA
//
//  Created by Ledp944 on 14-9-10.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "SupremeGoldViewController.h"

@class SupremeGoldViewController;

@interface SupremeGoldUtil : NSObject <ASIHTTPRequestDelegate>{
    SupremeGoldViewController *SupremeGold_view_controller;
    NSString *strSend;
    NSString *frompage;
    NSString *revolvingLoanUrl;
}
@property (nonatomic, retain) SupremeGoldViewController *SupremeGold_view_controller;
@property (nonatomic, retain) NSString *strSend;
@property (nonatomic, retain) NSString *frompage;
@property (nonatomic, retain) NSString *revolvingLoanUrl;

+ (SupremeGoldUtil*) me;
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
-(void)showSupremeGoldViewController:(NSString*)lastScreenName
                             merchant:(NSDictionary*)merchant;

@end

