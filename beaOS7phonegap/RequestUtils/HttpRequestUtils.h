//
//  HttpRequestUtils.h
//  BEA
//
//  Created by yufei on 5/19/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "MigrationSetting.h"
#import "MBKUtil.h"
#import "CoreData.h"

@interface HttpRequestUtils : NSObject {
    
}

+(ASIFormDataRequest*) getPostRequest:(NSObject<ASIHTTPRequestDelegate>*)delegate url:(NSURL*) url  
                              forKeys:(NSArray*)keys forValues:(NSArray*)values isHttps:(BOOL)isHttps;


+(ASIFormDataRequest*) getPostRequest:(NSObject<ASIHTTPRequestDelegate>*)delegate
                                  url:(NSURL*) url  
                              isHttps:(BOOL)isHttps
                    requestParameters:(NSDictionary*)param;

+(NSMutableDictionary*) getBasicPostDatas;



+(ASIFormDataRequest*) getPostRequest4checkMBKRegStatus:(NSObject<ASIHTTPRequestDelegate>*)delegate;

+(ASIFormDataRequest*) getPostRequest4stepone:(NSObject<ASIHTTPRequestDelegate>*)delegate;
+(ASIFormDataRequest*) getPostRequestHotline:(NSObject<ASIHTTPRequestDelegate>*)delegate;

+(ASIFormDataRequest*) getPostRequest4checkMobileTradingRegStatus:(NSObject<ASIHTTPRequestDelegate>*)delegate;

+(NSMutableURLRequest*) getPostRequest4MBAIOLogonShow:(BOOL) hasMobileNo;
+(NSMutableDictionary*) getMBAIOLogonParams:(BOOL) hasMobileNo;

/*
 * Return post request for get the lastest fund price file from server.
 */
+(ASIFormDataRequest*) getRequestForMPFRate:(NSObject<ASIHTTPRequestDelegate>*)delegate function:(NSString*)function;
+(ASIFormDataRequest*) getRequestForFundPricePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate;
+(ASIFormDataRequest*) getPostRequest4MPFPre:(NSObject<ASIHTTPRequestDelegate>*)delegate;
+(NSMutableURLRequest*) getPostRequest4MPFNews;

//MPF promotion plist
+(ASIFormDataRequest*) getRequestForMPFPromoPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp;


+(NSMutableURLRequest*) getPostRequest4BasePromotionNews;
+(NSMutableURLRequest*) getPostRequest4AccProOffersView;
+(NSMutableURLRequest*) getPostRequest4AccProDefaultPage;
+(NSMutableURLRequest*) getPostRequest4AccProOffersTNC;
+(NSMutableURLRequest*) getPostRequest4AccProOffersNotes;
+(NSMutableURLRequest*) getPostRequest4AccProApplicationView;
+(NSMutableURLRequest*) getPostRequest4LatestOfferCall;
+(NSMutableURLRequest*) getPostRequest4EnquiriesPage;
+(NSMutableURLRequest*) getPostRequest4ConsumerLoanOffersCall;

+(NSMutableURLRequest*) getPostRequest_loanBanner;
+(NSMutableURLRequest*) getPostRequest_loanOffer;
+(NSMutableURLRequest*) getPostRequest_loanTNC;


+(ASIFormDataRequest*) getRequestForLatestPromoPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate  
                                                  SN:(NSString*)date_stamp;
+(ASIFormDataRequest*) getRequestForConsumerLoanPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp;
+(ASIFormDataRequest*) getRequestForRatePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate
                                         rate:(NSString*)rate;
+(ASIFormDataRequest*) getRequestForFootNotePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate plistFlag:(NSString*)flag;

+(NSMutableURLRequest*) getPostRequest4LToffer;
+(NSMutableURLRequest*) getPostRequest4LTtc;
+(NSMutableURLRequest*) getPostRequest4LTrepay;

// MegaHub Added
+(ASIFormDataRequest*) getRequest:(NSObject<ASIHTTPRequestDelegate>*)delegate
							  url:(NSURL*) url  
						  isHttps:(BOOL)isHttps;

//NewBranch
+(ASIFormDataRequest*) getPostRequest4NewBranch:(NSObject<ASIHTTPRequestDelegate>*)delegate;
//StockGameCentre
+(NSMutableURLRequest*) getPostRequest4StockGameCentre;

+(NSMutableURLRequest*) getPostRequest4ConsumerLoanEnquiriesPage;

+(NSMutableURLRequest*) getPostRequest4ConsumerLoanApplicationView;

+(NSMutableURLRequest*) getPostRequest4SupremeGoldApplicationView;

+(NSMutableURLRequest*) getPostRequest4MKGeCard;

//Instalment
+(NSMutableURLRequest*) getPostRequest4InstalmentLoanOffers;
+(NSMutableURLRequest*) getPostRequest4InstalmentLoanRepay;
+(NSMutableURLRequest*) getPostRequest4InstalmentLoanTNC;

+(ASIFormDataRequest*) getRequestForBannerPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate;

+(ASIFormDataRequest*) getPostRequest4SGGANS:(NSObject<ASIHTTPRequestDelegate>*)delegate
                                      answer:(NSString*)answer;
+(NSMutableURLRequest*) getPostRequest4SGG;
+(NSMutableURLRequest*) getPostRequest4SGGTNC;

//Insurance
+(NSMutableURLRequest*) getPostRequest4InsuranceEnquiriesPage;
+(NSMutableURLRequest*) getPostRequest4InsuranceApplicationView;
+(NSMutableURLRequest*) getPostRequest4InsuranceNewsView;
+(ASIFormDataRequest*) getRequestForInsurancePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp;
+(ASIFormDataRequest*) getRequestForInsurancePlistPromo:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp;
+(NSMutableURLRequest*) getPostRequest4InsuranceApplicationLanding;

+(NSString*) getUrlStr4ifc:(NSString*)url;

+(ASIFormDataRequest*) getRequestForMPFImportantNoticePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp;
+(ASIFormDataRequest*) getRequestForMPFEnquiryPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp;

@end
