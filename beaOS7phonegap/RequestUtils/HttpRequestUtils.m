//
//  HttpRequestUtils.m
//  BEA
//
//  Created by yufei on 5/19/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "HttpRequestUtils.h"

@implementation HttpRequestUtils

+(ASIFormDataRequest*) getPostRequest:(NSObject<ASIHTTPRequestDelegate>*)delegate
                                  url:(NSURL*) url
                              forKeys:(NSArray*)keys
                            forValues:(NSArray*)values
                              isHttps:(BOOL)isHttps
{
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    
#ifdef DEBUGON
    NSLog(@"getPostRequest, url=%@", [url description]);
    NSLog(@"is send by HTTPS:%d",isHttps);
#endif
    
    if (isHttps) {
        [request setUsername:@"iphone"];
        [request setPassword:@"iphone"];
        [request setValidatesSecureCertificate:NO];
    }
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:40];
    [request setDelegate:delegate];
    
    for (int i=0; i < [keys count]; i++) {
        NSString *key = [keys objectAtIndex:i];
        NSObject *value = [values objectAtIndex:i];
        [request setPostValue:value forKey:key];
        
#ifdef DEBUGON
        NSLog(@"the %d param:%@=%@",i,key,value);
#endif
        
    }
    return request;
}

+(ASIFormDataRequest*) getPostRequest:(NSObject<ASIHTTPRequestDelegate>*)delegate
                                  url:(NSURL*) url
                              isHttps:(BOOL)isHttps
                    requestParameters:(NSDictionary*)param
{//added by jasen at 20110523
    if (!param) {
        NSLog(@"getPostRequest, error, param==nil");
        return nil;
    }
    
    NSString* key;
    NSString* value;
    
#ifdef DEBUGON
    NSLog(@"getPostRequest, delegate=%@", delegate);
    NSLog(@"getPostRequest, url=%@", [url description]);
    NSLog(@"getPostRequest, s=%d",isHttps);
#endif
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    if (isHttps) {
        [request setUsername:@"iphone"];
        [request setPassword:@"iphone"];
        [request setValidatesSecureCertificate:NO];
    }
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:40];
    [request setDelegate:delegate];
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        [request setPostValue:value forKey:key];
        
#ifdef DEBUGON
        NSLog(@"getPostRequest, param:%@=%@",key,value);
#endif
        
    }
    return request;
}


+(NSMutableDictionary*) getBasicPostDatas
{//added by jasen at 20110523
    NSMutableDictionary* param= [NSMutableDictionary new];
    [param setValue:[MBKUtil getMobileNoFromSetting] forKey:@"MobileNo"];
    [param setValue:[CoreData sharedCoreData].lang forKey:@"lang"];
    [param setValue:[CoreData sharedCoreData].UDID forKey:@"UUID"];
    [param setValue:[CoreData sharedCoreData].OS forKey:@"OS"];
    [param setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"Version"];
    
    [param setValue:[MBKUtil getKS] forKey:@"ks"];
    
    return param;
}

#pragma mark

+(ASIFormDataRequest*) getPostRequest4checkMBKRegStatus:(NSObject<ASIHTTPRequestDelegate>*)delegate
{//added by jasen at 20110523
    /*
     NSURL *url = [NSURL URLWithString:[MBKUtil getCheckRegStatusURL]];
     asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
     NSLog(@"BEAViewController checkMBKRegStatus url:%@",asi_request.url);
     [asi_request setUsername:@"iphone"];
     [asi_request setPassword:@"iphone"];
     [asi_request setValidatesSecureCertificate:NO];
     asi_request.delegate = self;
     [[CoreData sharedCoreData].queue addOperation:asi_request];
     */
    /*
     @refer to [MBKUtil getCheckRegStatusURL]
     urlString = [urlString stringByAppendingFormat:@"?act=CRS&MobileNo=%@&lang=%@&UUID=%@&ks=%@", mobileno, [CoreData sharedCoreData].lang, [CoreData sharedCoreData].UDID, keyStr];
     */
    NSURL *url = [NSURL URLWithString:[MigrationSetting me].CheckRegStatusURL];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    [param setValue:@"CRS" forKey:@"act"];
    
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    return request;
}

+(ASIFormDataRequest*) getPostRequest4stepone:(NSObject<ASIHTTPRequestDelegate>*)delegate
{//added by jasen at 20110523
    /*
     NSURL *url = [NSURL URLWithString:[MBKUtil getURLOfgetATMListOTA]];
     asi_request = nil;
     asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
     NSLog(@"stepone url:%@",asi_request.url);
     [asi_request setUsername:@"iphone"];
     [asi_request setPassword:@"iphone"];
     [asi_request setValidatesSecureCertificate:NO];
     asi_request.delegate = self;
     [[CoreData sharedCoreData].queue addOperation:asi_request];
     */
    /*
     @refer to [MBKUtil getURLOfgetATMListOTA]
     urlString = [urlString stringByAppendingFormat:@"?act=GAL&SN=%@&%@", [[MBKUtil me] getATMListSNFromLocal], [MBKUtil getKeyString4Req]];
     
     */
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfgetATMListOTA];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    [param setValue:@"GAL" forKey:@"act"];
    [param setValue:[[MBKUtil me] getATMListSNFromLocal] forKey:@"SN"];
    
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    NSLog(@"debug getPostRequest4stepone:%@",request.url);

    return request;
}

+(ASIFormDataRequest*) getPostRequest4steponeCMS:(NSObject<ASIHTTPRequestDelegate>*)delegate
{
    NSString *urlStr = [MigrationSetting me].mTelDomain;
    urlStr=[urlStr stringByAppendingString:@"getbranch.api?lang=2&cat=2"];
    NSURL *url = [NSURL URLWithString:urlStr];

    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    NSLog(@"debug getPostRequest4stepone:%@",request.url);

    return request;
}

+(ASIFormDataRequest*) getPostRequestHotline:(NSObject<ASIHTTPRequestDelegate>*)delegate
{//added by jasen at 20110523
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfgetHotlineOTA];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    [param setValue:@"HOT" forKey:@"act"];
    [param setValue:[[MBKUtil me] getHotlineSNFromLocal] forKey:@"SN"];
    
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

#pragma mark

+(ASIFormDataRequest*) getRequestForMPFRate:(NSObject<ASIHTTPRequestDelegate>*)delegate function:(NSString*)function
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfMPFRate];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"MPFRate" forKey:@"act"];
    [param setValue:function forKey:@"sub"];
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

+(ASIFormDataRequest*) getRequestForFundPricePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfFundPrice];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"mpfp" forKey:@"sub"];
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

+(ASIFormDataRequest*) getRequestForLatestPromoPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfLatestPromo];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"promo" forKey:@"sub"];
    [param setValue:date_stamp forKey:@"SN"];
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

+(ASIFormDataRequest*) getRequestForMPFPromoPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfMPFPromoPlist];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"mpfpromo" forKey:@"sub"];
    [param setValue:date_stamp forKey:@"SN"];
    
#ifdef DEBUGON
    NSLog(@"getRequestForMPFPromoPlist:%@--%@",url,param);
#endif

    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

+(ASIFormDataRequest*) getRequestForMPFImportantNoticePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfMPFPromoPlist];

    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"mpfin" forKey:@"sub"];
    [param setValue:date_stamp forKey:@"SN"];

#ifdef DEBUGON
    NSLog(@"getRequestForMPFImportantNoticePlist:%@--%@",url,param);
#endif

    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;

    return request;
}

+(ASIFormDataRequest*) getRequestForMPFEnquiryPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfMPFPromoPlist];

    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"mpfen" forKey:@"sub"];
    [param setValue:date_stamp forKey:@"SN"];

#ifdef DEBUGON
    NSLog(@"getRequestForMPFEnquiryPlist:%@--%@",url,param);
#endif

    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;

    return request;
}

+(ASIFormDataRequest*) getRequestForBannerPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfBannerPlist];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"banner" forKey:@"act"];
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

+(ASIFormDataRequest*) getRequestForConsumerLoanPlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfConsumerLoanPromo];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"loanPlist" forKey:@"sub"];
    [param setValue:date_stamp forKey:@"SN"];
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

+(ASIFormDataRequest*) getRequestForInsurancePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfInsurancePlist];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"insProduct" forKey:@"sub"];
    [param setValue:date_stamp forKey:@"SN"];
    
#ifdef DEBUGON
    NSLog(@"getRequestForInsurancePlist:%@--%@",url,param);
#endif

    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

+(ASIFormDataRequest*) getRequestForInsurancePlistPromo:(NSObject<ASIHTTPRequestDelegate>*)delegate SN:(NSString*)date_stamp
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfInsurancePlist];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"insPromo" forKey:@"sub"];
    [param setValue:date_stamp forKey:@"SN"];
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    return request;
}

+(ASIFormDataRequest*) getRequestForFootNotePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate plistFlag:(NSString*)flag
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfFundPrice];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"mpfn" forKey:@"sub"];
    [param setValue:flag forKey:@"type"];
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

+(ASIFormDataRequest*) getRequestForRatePlist:(NSObject<ASIHTTPRequestDelegate>*)delegate
                                         rate:(NSString*)rate
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfRateEnquiriesBase];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:rate forKey:@"sub"];
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}

+(ASIFormDataRequest*) getPostRequest4MPFPre:(NSObject<ASIHTTPRequestDelegate>*)delegate
{
    NSURL *url = [NSURL URLWithString:[MigrationSetting me].URLOfMPFNewsPre];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    [param setValue:@"iphone" forKey:@"act"];
    //    [param setValue:@"NEWSPRE" forKey:@"sub"];
    
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    return request;
}

+(NSMutableURLRequest*) getPostRequest4MPFNews{
    NSString *urlStr = [MigrationSetting me].URLOfMPFNews;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
#ifdef DEBUGON
    NSLog(@"getPostRequest4MPFNews, url:%@",url);
#endif
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"newsList" forKey:@"sub"];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
    }
    
#ifdef DEBUGON
    NSLog(@"getPostRequest4MPFNews, post:%@",post);
#endif
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    
    return request;
}

#pragma mark

+(ASIFormDataRequest*) getPostRequest4checkMobileTradingRegStatus:(NSObject<ASIHTTPRequestDelegate>*)delegate
{//added by jasen at 20110523
    /*
     
     NSURL *url = [NSURL URLWithString:[self getCheckMobileTradingURL]];
     asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
     NSLog(@"MobileTradingUtil checkMobileTradingRegStatus url:%@",asi_request.url);
     [asi_request setUsername:@"iphone"];
     [asi_request setPassword:@"iphone"];
     [asi_request setValidatesSecureCertificate:NO];
     asi_request.delegate = self;
     [[CoreData sharedCoreData].queue addOperation:asi_request];
     */
    /*
     @refer to [MobileTradingUtil getCheckMobileTradingURL]
     urlString = [urlString stringByAppendingFormat:@"?act=CME&MobileNo=%@&lang=%@&UUID=%@&ks=%@", mobileno, [CoreData sharedCoreData].lang, [CoreData sharedCoreData].UDID, keyStr];
     */
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].CheckMobileTradingURL];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    [param setValue:@"CME" forKey:@"act"];
    
    ASIFormDataRequest *request = [HttpRequestUtils getPostRequest:delegate
                                                               url:url
                                                           isHttps:true
                                                 requestParameters:param] ;
    
    return request;
}

#pragma mark
#pragma MBAIOLogonShow
+(NSMutableURLRequest*) getPostRequest4MBAIOLogonShow:(BOOL) hasMobileNo{
    
    NSURL *url = [NSURL URLWithString:[MigrationSetting me].URLOfMBAIOLogonShow];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]
                                    initWithURL:url];
    NSMutableDictionary* param= [HttpRequestUtils getMBAIOLogonParams:hasMobileNo];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
        //       NSLog(@"getPostRequest, param:%@=%@",key,value);
    }
       NSLog(@"getPostRequest, post:%@",post);
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    
    return request;
    
    
}

//added by yufei at 20110526
+(NSMutableDictionary*) getMBAIOLogonParams:(BOOL) hasMobileNo
{
    //req=ME&Lang=Eng&MobileNo=&UUID
    NSMutableDictionary* param= [NSMutableDictionary new];
    if (hasMobileNo) {
        [param setValue:[MBKUtil getMobileNoFromSetting] forKey:@"MobileNo"];
    }
    [param setValue:@"ME" forKey:@"req"];
    if ([[CoreData sharedCoreData].lang isEqualToString:@"zh_TW"]) {
        [param setValue:@"Big5" forKey:@"Lang"];
    }else{
        [param setValue:@"Eng" forKey:@"Lang"];
    }
    [param setValue:[CoreData sharedCoreData].UDID forKey:@"UUID"];
    return param;
}

#pragma mark

+(NSMutableURLRequest*) getPostRequest4BasePromotionNews{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfBasePromotionPage_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfBasePromotionPage_en];
    }
    //    NSLog(@"getPostRequest4BasePromotionNews url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest4AccProDefaultPage{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfAccProDefaultPage_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfAccProDefaultPage_en];
    }
    //    NSLog(@"getPostRequest4AccProDefaultPage url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest4LatestOfferCall{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLatestOfferCall_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLatestOfferCall_e];
    }
    //    NSLog(@"getPostRequest4AccProDefaultPage url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest4ConsumerLoanOffersCall{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfConsumerLoanOffersCall_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfConsumerLoanOffersCall_e];
    }
    //    NSLog(@"getPostRequest4AccProDefaultPage url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest4EnquiriesPage{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfEnquiriesPage_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfEnquiriesPage_e];
    }
    //    NSLog(@"getPostRequest4AccProDefaultPage url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest4ConsumerLoanEnquiriesPage{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfConsumerLoanEnquiriesPage_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfConsumerLoanEnquiriesPage_e];
    }
    //    NSLog(@"getPostRequest4AccProDefaultPage url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest4InsuranceEnquiriesPage{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfInsuranceEnquiriesPage_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfInsuranceEnquiriesPage_e];
    }
    //    NSLog(@"getPostRequest4AccProDefaultPage url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}


+(NSMutableURLRequest*) getPostRequest4AccProOffersView{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfAccProOffersPage_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfAccProOffersPage_en];
    }
    //    NSLog(@"getPostRequest4AccProOffersView url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"offersList" forKey:@"sub"];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
        //        NSLog(@"getPostRequest, param:%@=%@",key,value);
    }
    //    NSLog(@"getPostRequest, post:%@",post);
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    
    return request;
}

+(NSMutableURLRequest*) getPostRequest4AccProApplicationView{//static page
    
    NSURL *url = NULL;
    
    url = [NSURL URLWithString:[MigrationSetting me].URLOfAccProApplicationView];
    
    //    NSLog(@"getPostRequest4AccProApplicationView url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
        //        NSLog(@"getPostRequest, param:%@=%@",key,value);
    }
    //    NSLog(@"getPostRequest, post:%@",post);
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    
    return request;
}

+(NSMutableURLRequest*) getPostRequest4ConsumerLoanApplicationView{//static page
    
    NSURL *url = NULL;
    
    url = [NSURL URLWithString:[MigrationSetting me].URLOfConsumerLoanApplicationView];
    
//    NSLog(@"getPostRequest4ConsumerLoanApplicationView url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
//        NSLog(@"getPostRequest, param:%@=%@",key,value);
    }
    //    NSLog(@"getPostRequest, post:%@",post);
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    
    return request;
}

+(NSMutableURLRequest*) getPostRequest4SupremeGoldApplicationView{//static page
    
    NSURL *url = NULL;
    
    url = [NSURL URLWithString:[MigrationSetting me].URLOfSupremeGoldApplicationView];
    
    //    NSLog(@"getPostRequest4ConsumerLoanApplicationView url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
        //        NSLog(@"getPostRequest, param:%@=%@",key,value);
    }
    //    NSLog(@"getPostRequest, post:%@",post);
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    
    return request;
}

+(NSMutableURLRequest*) getPostRequest4InsuranceNewsView{//static page
    
    NSURL *url = NULL;
    
    url = [NSURL URLWithString:[MigrationSetting me].URLOfInsuranceNewsView];
    
    NSLog(@"getPostRequest4InsuranceNewsView url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
        NSLog(@"getPostRequest, param:%@=%@",key,value);
    }
    //    NSLog(@"getPostRequest, post:%@",post);
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    
    return request;
}

+(NSMutableURLRequest*) getPostRequest4InsuranceApplicationView{//static page
    
    NSURL *url = NULL;
    
    url = [NSURL URLWithString:[MigrationSetting me].URLOfInsuranceApplicationView];
    
    NSLog(@"getPostRequest4InsuranceApplicationView url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
        NSLog(@"getPostRequest, param:%@=%@",key,value);
    }
NSLog(@"getPostRequest, post:%@",post);
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    
    NSLog(@"getPostRequest, request:%@",request);
    return request;
}

+(NSMutableURLRequest*) getPostRequest4InsuranceApplicationLanding{
    
    NSURL *url = NULL;
    
    url = [NSURL URLWithString:[MigrationSetting me].URLOfInsuranceApplicationLanding];
    
    NSLog(@"getPostRequest4InsuranceApplicationLanding url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
        NSLog(@"getPostRequest, param:%@=%@",key,value);
    }
    NSLog(@"getPostRequest, post:%@",post);
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    return request;
}


+(NSMutableURLRequest*) getPostRequest4AccProOffersTNC{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfAccProApplicationTNC_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfAccProApplicationTNC_e];
    }
    //    NSLog(@"getPostRequest4AccProOffersTNC url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}


+(NSMutableURLRequest*) getPostRequest4AccProOffersNotes{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfAccProApplicationNotes_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfAccProApplicationNotes_e];
    }
    //    NSLog(@"getPostRequest4AccProOffersNotes url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest_loanBanner{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLoanBanner_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLoanBanner_en];
    }
    //NSLog(@"getPostRequest4AccProOffersView url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest_loanOffer{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLoanOffer_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLoanOffer_en];
    }
    //NSLog(@"getPostRequest4AccProOffersView url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest_loanTNC{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLoanTNC_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLoanTNC_en];
    }
    //NSLog(@"getPostRequest4AccProOffersView url: %@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(ASIFormDataRequest*) getRequest:(NSObject<ASIHTTPRequestDelegate>*)delegate
                              url:(NSURL*) url
                          isHttps:(BOOL)isHttps
{
    
    //    NSLog(@"getRequest, delegate=%@", delegate);
    //NSLog(@"getRequest, url=%@", [url description]);
    //    NSLog(@"getRequest, s=%d",isHttps);
	
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    if (isHttps) {
        [request setUsername:@"iphone"];
        [request setPassword:@"iphone"];
        [request setValidatesSecureCertificate:NO];
    }
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:40];
    [request setDelegate:delegate];
    
    return request;
}

+(NSMutableURLRequest*) getPostRequest4LToffer{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLT_offer_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLT_offer_en];
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest4InstalmentLoanOffers{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfInstalmentLoan_offer_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfInstalmentLoan_offer_en];
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest4InstalmentLoanRepay{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfInstalmentLoan_repay_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfInstalmentLoan_repay_en];
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}


+(NSMutableURLRequest*) getPostRequest4InstalmentLoanTNC{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfInstalmentLoan_tc_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfInstalmentLoan_tc_en];
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}


+(NSMutableURLRequest*) getPostRequest4LTtc{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLT_tc_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLT_tc_en];
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSMutableURLRequest*) getPostRequest4LTrepay{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLT_repay_zh];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfLT_repay_en];
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

//NewBranch
+(ASIFormDataRequest*) getPostRequest4NewBranch:(NSObject<ASIHTTPRequestDelegate>*)delegate
{
    NSURL *url = [[NSURL alloc] initWithString:[MigrationSetting me].URLOfNewBranch];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"branch" forKey:@"sub"];
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    
    return request;
}
//StockGameCentre
+(NSMutableURLRequest*) getPostRequest4StockGameCentre{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfStockGameCentre_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfStockGameCentre_e];
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

//MKGeCard
+(NSMutableURLRequest*) getPostRequest4MKGeCard{//static page
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfMKGeCard_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfMKGeCard_e];
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

//SGG
+(ASIFormDataRequest*) getPostRequest4SGGANS:(NSObject<ASIHTTPRequestDelegate>*)delegate
                                      answer:(NSString*)answer
{
    NSURL *url = [NSURL URLWithString:[MigrationSetting me].URLOfSGGANS];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    [param setValue:@"iphone" forKey:@"act"];
    [param setValue:@"sggans" forKey:@"sub"];
    [param setValue:answer forKey:@"ans"];
    
    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest:delegate
                                                              url:url
                                                          isHttps:true
                                                requestParameters:param] ;
    return request;
}

+(NSMutableURLRequest*) getPostRequest4SGG
{
    
    NSURL *url = NULL;
    
    url = [NSURL URLWithString:[MigrationSetting me].URLOfSGG];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    NSString* key;
    NSString* value;
    NSString* post=@"";
    
    
    for (key in param) {
        value = (NSString*)[param valueForKey:key];
        post = [post stringByAppendingFormat:@"&%@=%@", key, value];
    }
    
    NSData *myRequestData = [NSData dataWithBytes:[post UTF8String]
                                           length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:myRequestData];
    
    return request;
}

+(NSMutableURLRequest*) getPostRequest4SGGTNC
{
    
    NSURL *url = NULL;
    if ([MBKUtil isLangOfChi]) {
        url = [NSURL URLWithString:[MigrationSetting me].URLOfSGGTNC_c];
    }else{
        url = [NSURL URLWithString:[MigrationSetting me].URLOfSGGTNC_e];
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPMethod:@"GET"];
    return request;
}

+(NSString*) getUrlStr4ifc:(NSString*)url
{
    NSString* urlStr = nil;
    
    //requirement of ifc
    //&lc=[en|zh_TW|zh_CN]&dc=[uuid]
    //English: en
    //Trad. Chinese: zh_TW
    //Simp. Chinese: zh_CN
    
    //3 types of output of [MBKUtil getLangPref]
    //en
	//zh-Hant
    //zh-Hans
    
    //handling the problem of Localizable.strings
    NSString* lang=[[LangUtil me] getLangPref];
    if([lang isEqualToString:@"zh"]){
        lang = @"zh_TW";
    }else if([lang isEqualToString:@"zh-Hans"]){
        lang = @"zh_CN";
    }else if([lang isEqualToString:@"zh-Hant"]){
        lang = @"zh_TW";
    }else {
        lang = @"en";
    }
    NSString* urlParam = [NSString stringWithFormat:@"&lc=%@&dc=%@", lang, [CoreData sharedCoreData].UDID];
    urlStr = [NSString stringWithFormat:@"%@%@", url, urlParam];
    
    NSLog(@"debug getUrlStr4ifc:%@", urlStr);
    
    return urlStr;
}
@end
