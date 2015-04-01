//
//  MobileTradingUtil.m
//  BEA
//
//  Created by yufei on 3/16/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MobileTradingUtil.h"


@implementation MobileTradingUtil

@synthesize  requestServer;

+ (MobileTradingUtil *)me//added by jasen
{
	static MobileTradingUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[MobileTradingUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"MobileTradingUtil init");
    self = [super init];
    if (self) {
		self.requestServer=@"";
    }
    return self;
}

-(NSString*)getCheckMobileTradingURL{
    
    NSString *urlString = [[MigrationSetting me] CheckMobileTradingURL];
	
	NSString *mobileno = [NSString stringWithFormat:@""];
//	NSData *banking;
	NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	
	if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
//		banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
//		[MBKUtil transform:banking];
//		mobileno =[[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding];
        mobileno = [MBKUtil decryption:[user_setting objectForKey:@"encryted_banking"]];

	}
	
	NSString *keyStr = [NSString stringWithFormat:@"%@%@ATMLOCATION", mobileno, [CoreData sharedCoreData].UDID];
	
	keyStr = [MBKUtil md5:keyStr];
	
	urlString = [urlString stringByAppendingFormat:@"?act=CME&MobileNo=%@&lang=%@&UUID=%@&ks=%@", mobileno, [CoreData sharedCoreData].lang, [CoreData sharedCoreData].UDID, keyStr];
    NSLog(@"MobileTradingUtil getCheckMobileTradingURL:%@", urlString);
    [mobileno release];
	return urlString; 
}

-(void)checkMobileTradingRegStatus{
    NSLog(@"MobileTradingUtil checkMobileTradingRegStatus");
	//NSData *banking;
	//NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
    //	if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
    //banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
	//	[MBKUtil transform:banking];
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
//    ASIFormDataRequest *request = [HttpRequestUtils getPostRequest4checkMobileTradingRegStatus:self];
    
//    [[CoreData sharedCoreData].queue addOperation:request];
//    [[CoreData sharedCoreData].mask showMask];
	// }

    WebViewController *banking_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
    NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
    BOOL hasMobileNo = (user_setting != nil && [[user_setting objectForKey:@"encryted_banking"] length] > 0);
    NSURLRequest *request = [HttpRequestUtils getPostRequest4MBAIOLogonShow:hasMobileNo];
    [banking_controller setUrlRequest:request]; //To be retested
    [[MyScreenUtil me] adjustViewWithStatusNavbar:banking_controller.view];
    

    NSLog(@"MobileTradingUtil hasMobileNo=%d, requestURL=%@",hasMobileNo,[request URL]);
//    NSLog(@"MobileTradingUtil hasMobileNo=%d",hasMobileNo);
 //   [banking_controller.web_view loadRequest:request];
    
    [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:banking_controller animated:NO];
    
    [banking_controller release];        
//    [CoreData sharedCoreData].bea_view_controller.vc4process = banking_controller;

}

- (void)requestFinished:(ASIHTTPRequest *)request {
	[[CoreData sharedCoreData].mask hiddenMask];
	
	NSLog(@"MobileTradingUtil requestFinished:%@",[request responseString]);
	NSString * regStatus = [NSString stringWithFormat:@"%@", [request responseString]];
    
    //    ///////////////////// for dev testing
    //    regStatus=@"1";
    //    ///////////////////// for dev testing
    
    if (NSOrderedSame == [regStatus compare:@"1"]){
		WebViewController *banking_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
        BOOL hasMobileNo = (user_setting != nil && [[user_setting objectForKey:@"encryted_banking"] length] > 0);
        NSURLRequest *request = [HttpRequestUtils getPostRequest4MBAIOLogonShow:hasMobileNo];
        NSLog(@"MobileTradingUtil hasMobileNo=%d, requestURL=%@",hasMobileNo,[request URL]);
    //    [banking_controller.web_view loadRequest:request];
        [banking_controller setUrlRequest:request]; //To be retested
        [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:banking_controller animated:TRUE];
        [banking_controller release];        
	    return;	
	}else if (NSOrderedSame == [regStatus compare:@"0"]){
		UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Pop Up Notice for Register",nil) message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Continue",nil),nil];
		[alert_view show];
		[alert_view release];
		
	}else {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
        [[CoreData sharedCoreData].mask hiddenMask];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"MobileTradingUtil requestFailed error:%@", [request error]);
	
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSURL *url = [self getURLCYTMBKREG];
	NSLog(@"MobileTradingUtil clickedButtonAtIndex url:%@", url);
	
	[[UIApplication sharedApplication] openURL:url];
}

- (NSURL*) getURLCYTMBKREG{
	NSString * _URLCYBMBKREGen = [NSString stringWithFormat:@"%@?Lang=Eng&MobileNo=%@", [[MigrationSetting me] MBCYTLogonShow], [MBKUtil getMobileNoFromSetting]];
	NSString * _URLCYBMBKREGzh = [NSString stringWithFormat:@"%@?Lang=Big5&MobileNo=%@", [[MigrationSetting me] MBCYTLogonShow], [MBKUtil getMobileNoFromSetting]];
	
	NSURL *url;
	if (![MBKUtil isLangOfChi]) {
		url = [NSURL URLWithString:_URLCYBMBKREGen];
	}else {
		url = [NSURL URLWithString:_URLCYBMBKREGzh];
	}
	
    NSLog(@"MobileTradingUtil getURLCYTMBKREG:%@", url);
	return url;
}

@end
