//
//  InsuranceUtil.h
//  BEA
//
//  Created by NEO on 03/01/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "InsuranceViewController.h"
#import "InsuranceListViewController.h"
#import "InsuranceNewsViewController.h"
#import "InsuranceOffersViewController.h"
#import "InsuranceEnquiryViewController.h"

@class InsuranceViewController;

@interface InsuranceUtil : NSObject <ASIHTTPRequestDelegate>{
    InsuranceViewController *Insurance_view_controller;
    id _InsuranceListViewController;
    NSString *strSend;
    NSString *strSendPromo;
    NSString *frompage;
    NSString *reqfor;
    NSString *revolvingLoanUrl;
    NSString *quoteAndApply;
    NSString *nextTab;
    NSString *animate;
     Boolean isInIns;
}
@property (nonatomic, retain) id _InsuranceListViewController;
@property (nonatomic, retain) InsuranceViewController *Insurance_view_controller;
@property (nonatomic, retain) NSString *strSend;
@property (nonatomic, retain) NSString *strSendPromo;
@property (nonatomic, retain) NSString *frompage;
@property (nonatomic, retain) NSString *reqfor;
@property (nonatomic, retain) NSString *revolvingLoanUrl;
@property (nonatomic, retain) NSString *quoteAndApply;
@property (nonatomic, retain) NSString *nextTab;
@property (nonatomic, retain) NSString *animate;
@property Boolean isInIns;
+ (InsuranceUtil*) me;
-(void)callToApply;
+ (BOOL) isLangOfChi;
-(BOOL) isSend;
-(void)backToFromPage;
-(void)showNearBy;
-(NSString *) findPlistPaths;
+ (BOOL) FileExists;
+ (void) copyFile ;
- (void)requestFinished:(ASIHTTPRequest *)request ;
+ (void) updateFundPriceFile:(NSData*)datas;
- (void)requestFailed:(ASIHTTPRequest *)request ;
-(void) sendRequest:(NSString*) date_stamp
 listViewController:(id)p_InsuranceListViewController;
-(NSString *) findPlistPathsPromo;
-(BOOL)isSendPromo;
+ (BOOL) FileExistsPromo;
+ (void) copyFilePromo;
-(void) sendRequestPromo:(NSString*) date_stamp
      listViewController:(id)p_InsuranceNewsViewController;
-(void)showInsuranceOffersViewController:(NSString*)url hotline:(NSString*)hotline btnLanel:(NSString*) btnLabel;
-(void)showInsuranceViewController:(NSString*) lastScreenName url:(NSString*)url hotline:(NSString*)hotline btnLanel:(NSString*) btnLabel;
-(void)showInsuranceViewController:(NSString*)targeturl hotline:(NSString*)hotline caption: (NSString*)caption type:(int)type;
@end
