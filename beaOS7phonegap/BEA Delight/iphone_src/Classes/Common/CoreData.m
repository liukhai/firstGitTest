//
//  CoreData.m
//  PIPTrade
//
//  Created by MTel on 19/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoreData.h"
#import "MigrationSetting.h"
#import <CommonCrypto/CommonDigest.h>
#import "OpenUDID.h"


@implementation CoreData

@synthesize _BEAAppDelegate;

@synthesize realServerURL,realServerURLCard, sessionID, loginID, root_view_controller, mask, ecoupon, lang, UDID, OS, queue, iCouponServerURL, iCouponServerLogoutURL, iCouponServer;
@synthesize main_view_controller, bea_view_controller, delight_view_controller, home_view_controller;
@synthesize email;

@synthesize atmlocation_view_controller;
@synthesize taxLoan_view_controller;
@synthesize sg_view_controller;
@synthesize _InsuranceViewController;
@synthesize _LTViewController;
@synthesize _InstalmentLoanViewController;
@synthesize hotline_view_controller; //hotline_view_controller added by yelong on 2011.02.28
@synthesize _PropertyLoanViewController;
@synthesize sP2PMenuViewController;
@synthesize facebookListViewController;
//@synthesize _ImportantNoticeViewController;
@synthesize lastScreen;

@synthesize m_sLastQuoteSymbol;
@synthesize m_iLastVisitPage, m_iAccountType;

static CoreData *sharedCoreData = nil;

+(CoreData *)sharedCoreData {
	if (sharedCoreData==nil) {
		sharedCoreData = [[CoreData alloc] init];
        //		sharedCoreData.realServerURL = @"http://hkbea.mtel.ws/java/bea/dev/";
        //		sharedCoreData.realServerURL = @"http://hkbea.mtel.ws/java/bea/";
		sharedCoreData.realServerURL = [[MigrationSetting me] mTelDomain];
        sharedCoreData.realServerURLCard = [[MigrationSetting me] mTelDomainCard];
        //UAT
        sharedCoreData.iCouponServer = [[MigrationSetting me] iCouponServer];
        sharedCoreData.iCouponServerURL = [[MigrationSetting me] iCouponServerURL];
        sharedCoreData.iCouponServerLogoutURL = [[MigrationSetting me] iCouponServerLogoutURL];
        
		sharedCoreData.main_view_controller = nil;
		sharedCoreData.bea_view_controller = nil;
		sharedCoreData.home_view_controller = nil;
		sharedCoreData.delight_view_controller = nil;
		sharedCoreData.root_view_controller = nil;
		sharedCoreData.mask = nil;
		sharedCoreData.email = nil;
		sharedCoreData.lang = NSLocalizedString(@"lang",nil);
        NSLog(@"debug CoreData lang:%@", sharedCoreData.lang);
		sharedCoreData.queue = [[NSOperationQueue alloc] init];
		[sharedCoreData.queue setMaxConcurrentOperationCount:4];
        //		sharedCoreData.UDID = [UIDevice currentDevice].uniqueIdentifier;
		sharedCoreData.UDID = [OpenUDID value];
		sharedCoreData.OS = [[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0];
		
		sharedCoreData.atmlocation_view_controller = nil;
		sharedCoreData.taxLoan_view_controller = nil;
        sharedCoreData.sg_view_controller = nil;
		sharedCoreData._LTViewController = nil;
		sharedCoreData._InstalmentLoanViewController = nil;
		sharedCoreData.hotline_view_controller = nil; // --added by yelong on 2011.03.01
		sharedCoreData._PropertyLoanViewController = nil;
        //        sharedCoreData._ImportantNoticeViewController = nil;
        sharedCoreData.sP2PMenuViewController=nil;
        sharedCoreData.facebookListViewController=nil;
		sharedCoreData.lastScreen = @"";
		
		//MeaguhubAdded
		sharedCoreData.m_iAccountType = AccountTypeStockTrading;
		sharedCoreData.m_sLastQuoteSymbol = @"23";
        
        sharedCoreData._BEAAppDelegate = nil;
        
        sharedCoreData.goBanking = NO;
	}
	return sharedCoreData;
}

+(NSString *)md5:(NSString *)str {
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

+(void)setMainViewFrame {
    CGRect frame = [CoreData sharedCoreData].main_view_controller.view.frame;
    frame.origin = CGPointMake(0.0, 0.0);
    [CoreData sharedCoreData].main_view_controller.view.frame = frame;
}
-(NSString *)couponLang{
    if([lang isEqualToString:@"e"]){
        return @"Eng";
    }else{
        return @"Big5";
    }
}
@end
