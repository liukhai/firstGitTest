//
//  MPFUtil.h
//  BEA
//
//  Created by YAO JASEN on 10/20/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "MPFViewController.h"
#import "MPFPromoListViewController.h"
#import "MPFPromoViewController.h"

@class MPFPromoListViewController;
@class MPFImportantNoticeViewController;
@class MPFViewController;

@interface MPFUtil : NSObject <UIWebViewDelegate, ASIHTTPRequestDelegate>
{
    MPFImportantNoticeViewController* _MPFImportantNoticeViewController;
    MPFViewController *MPF_view_controller;
    NSString *serviceFlag;
    UIViewController* caller;
    NSString *MPFserverFlag;
    ASIHTTPRequest *fund_request,*mt_request,*ind_request;
    BOOL isFundPlistValid ;
    BOOL isNotemtPlistValid ;
    BOOL isNoteindPlistValid ;
    BOOL isEnquiryPlistValid;
    BOOL isImportantNoticePlistValid;
    NSString *callMBKMPF;
    NSString *callMBKMPFBalance;
    NSString *strSend;
    NSString *strSendImportantNotice;
    NSString *strSendEnquiry;
}

@property(nonatomic, retain) MPFImportantNoticeViewController* _MPFImportantNoticeViewController;
@property (nonatomic, retain) MPFViewController *MPF_view_controller;
@property (nonatomic, retain) NSString *serviceFlag;
@property (nonatomic, retain) UIViewController* caller;
@property (nonatomic, retain) NSString *MPFserverFlag;
@property (nonatomic, retain) ASIHTTPRequest *fund_request,*mt_request,*ind_request;
@property (nonatomic, retain) NSString *callMBKMPF;
@property (nonatomic, retain) NSString *callMBKMPFBalance;
@property (nonatomic, retain) NSString *strSend;
@property (nonatomic, retain) NSString *strSendImportantNotice;
@property (nonatomic, retain) NSString *strSendEnquiry;

+ (MPFUtil*) me;

+(void)showLoanOffers;
//+(void)showRepaymentTable;
-(void)callToApply;
+ (BOOL) isValidUtil;
-(NSString *) findFundPricePlistPath;

/*
 * Update datas from server to local plish file.
 */
+ (void) updateFundPriceFile:(NSData*)datas;
+ (BOOL) checkPlistValid:(NSData*)datas 
               plistFlag:(NSString*)flag;
+ (void) updateFootNotePriceFile:(NSData*)datas;
-(NSString *) findFundPriceNotePlistPath;

-(void)alertAndBackToMain;
-(void)alertAndBackToMain:(UIViewController*)outViewController;
-(void)alertAndBackToMBKMPF;
-(void) openMBK;

- (void)goHome;

- (void) checkingMPFServerReady:(UIViewController *) caller;
- (void) loadImportantNotice:(UIViewController *) caller;
-(void) sendRequest;
- (void)updateData:(ASIHTTPRequest *)request;

-(void) releaseResource;

-(BOOL) is_callMBKMPF;
-(BOOL) is_callMBKMPFBalance;
-(NSString*) getReqParam;
-(void)do_callMBKMPFBalance;
-(void)call_Logintomobilebanking;
-(void)call_CallMPFhotline;

-(NSString *) findMPFPromoPlistPath;
-(BOOL)isSend;
-(void) sendRequestMPFPromoPlist:(NSString*) date_stamp
              listViewController:(MPFPromoListViewController*)p_AccProListViewController;

-(NSString *) findImportantNoticePlistPath;
-(NSString *) findEnquiryPlistPath;
- (void) loadImportantNotice:(UIViewController *) pcaller;
- (void) loadEnquiry:(UIViewController *) pcaller;

@end
