//
//  MigrationSetting.m
//  BEA
//
//  Created by yaojzy on 20110323.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MigrationSetting.h"
#import "MHBEAConstant.h"

@implementation MigrationSetting

@synthesize CheckRegStatusURL,
URLOfgetATMListOTA,
URLOfgetHotlineOTA,
URLOfTaxLoanApplication,
URLOfLoanTaxApplication,
CheckMobileTradingURL,
MBCYBLogonShow,
MBCYTLogonShow,
URLOfMBAIOLogonShow,
URLOfFundPrice,
URLOfMPFRate,
URLOfFootNote,
URLOfLatestPromo,
URLOfMPFNews,
URLOfMPFNewsPre,
URLOfMPFPromoPlist,
URLOfAccProApplication,
URLOfLT_offer_en,
URLOfLT_offer_zh,
URLOfLT_tc_en,
URLOfLT_tc_zh,
URLOfLatestOfferCall_e,
URLOfLatestOfferCall_c,
URLOfEnquiriesPage_e,
URLOfEnquiriesPage_c,
URLOfStockGameCentre_e,
URLOfStockGameCentre_c,
URLOfMKGeCard_e,
URLOfMKGeCard_c,
URLOfLT_repay_en,
URLOfLT_repay_zh,
URLOfInstalmentLoan_offer_en,
URLOfInstalmentLoan_offer_zh,
URLOfInstalmentLoan_tc_en,
URLOfInstalmentLoan_tc_zh,
URLOfInstalmentLoan_repay_en,
URLOfBannerPlist,
URLOfInstalmentLoan_repay_zh,
CYBDomain,
CYBPublicDomain,
mTelDomain,
mTelDomainCard,
ifc_server;

@synthesize URLOfAccProDefaultPage_zh;
@synthesize URLOfAccProDefaultPage_en;
@synthesize URLOfBasePromotionPage_zh;
@synthesize URLOfBasePromotionPage_en;
@synthesize URLOfAccProOffersPage_zh;
@synthesize URLOfAccProOffersPage_en;
@synthesize URLOfAccProApplicationTNC_e;
@synthesize URLOfAccProApplicationTNC_c;
@synthesize URLOfAccProApplicationNotes_e;
@synthesize URLOfAccProApplicationNotes_c;
@synthesize URLOfAccProApplicationView;
@synthesize URLOfRateEnquiriesBase;

@synthesize URLOfLoanBanner_zh;
@synthesize URLOfLoanBanner_en;
@synthesize URLOfLoanOffer_zh;
@synthesize URLOfLoanOffer_en;
@synthesize URLOfLoanTNC_zh;
@synthesize URLOfLoanTNC_en;

@synthesize m_sURLRegStatusStockTrading;
@synthesize m_sURLBuyStockTrading;
@synthesize m_sURLSellStockTrading;
@synthesize m_sURLRegStatusEAS;
@synthesize m_sURLBuyEAS;
@synthesize m_sURLSellEAS;
@synthesize m_sURLMBCYBLogonShow;

@synthesize URLOfNewBranch;

@synthesize URLOfConsumerLoanApplicationView,
URLOfConsumerLoanPromo,
URLOfConsumerLoanOffersCall_c,
URLOfConsumerLoanOffersCall_e,
URLOfConsumerLoanEnquiriesPage_e,
URLOfConsumerLoanEnquiriesPage_c;

@synthesize URLOfSupremeGoldApplicationView;

@synthesize URLOfSGGANS, URLOfSGG, URLOfSGGTNC_e, URLOfSGGTNC_c;

@synthesize URLOfInsuranceEnquiriesPage_e,
URLOfInsuranceEnquiriesPage_c,
URLOfInsuranceApplicationView,
URLOfInsuranceApplicationLanding,
URLOfInsuranceNewsView,
URLOfInsurancePlist,
URLOfInsuranceDetail_e,
URLOfInsuranceDetail_c;

//CyberFundSearch
@synthesize URLOfCyberFundSearch_FundSearch,
URLOfCyberFundSearch_MyFunds,
URLOfCyberFundSearch_Top10,
URLOfCyberFundSearch_News;

//CyberFundSearch
@synthesize URLOfP2P_main,
URLOfP2P_setting,
URLOfP2P_Record;

//facebook
@synthesize URLOfFacebook_joy,
URLOfFacebook_fun;
@synthesize URLOfAccessibility;
//iCoupon
@synthesize iCouponServer;
@synthesize iCouponServerURL;
@synthesize iCouponServerLogoutURL;

+ (MigrationSetting *)me
{
	static MigrationSetting *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[MigrationSetting alloc] init];
		
		return me;
	}
}

- (id)init
{
    self = [super init];
    if (self) {

        //product setting ======================================================
        //      id: com.bea.app
        //ipa name: BEAPROD.ipa
        //app name: BEA
        self.CYBDomain=[NSString stringWithFormat:@"https://mobile.hkbea-cyberbanking.com"];
        self.CYBPublicDomain=[NSString stringWithFormat:@"https://ww2.hkbea-cyberbanking.com"];
        self.ifc_server = @"http://ifc02.etwealth.com/bea-ebank2/";
        self.mTelDomain = @"http://hkbea.mtel.ws/java/bea/";
        self.mTelDomainCard = @"http://hkbea.mtel.ws/java/bea/";
        self.iCouponServer = @"https://mobile.hkbea-cyberbanking.com";
        self.iCouponServerURL = @"https://mobile.hkbea-cyberbanking.com/servlet/ICouponBeaAppShow";
        self.iCouponServerLogoutURL = @"https://mobile.hkbea-cyberbanking.com/servlet/MBICPLogoutShow";
        //product setting ======================================================

/*
        //product setting ======================================================
        //      id: com.hkbea.app
        //ipa name: BEAPROD.ipa
        //app name: BEA(PP)
        self.CYBDomain=[NSString stringWithFormat:@"https://mobile.hkbea-cyberbanking.com"];
        self.CYBPublicDomain=[NSString stringWithFormat:@"https://ww2.hkbea-cyberbanking.com"];
        self.ifc_server = @"http://ifc02.etwealth.com/bea-ebank2/";
        self.mTelDomain = @"https://hkbea.mtel.ws/java/bea/";
        self.mTelDomainCard = @"https://hkbea.mtel.ws/java/bea/";
        self.iCouponServer = @"https://mobile.hkbea-cyberbanking.com";
        self.iCouponServerURL = @"https://mobile.hkbea-cyberbanking.com/servlet/ICouponBeaAppShow";
        self.iCouponServerLogoutURL = @"https://mobile.hkbea-cyberbanking.com/servlet/MBICPLogoutShow";
        //product setting ======================================================
*/
/*
        //uat24 setting ========================================================
        //      ID: com.bea.uatapp
        //IPA NAME: BEA.ipa
        //app name: BEA(U24)
        self.CYBDomain=[NSString stringWithFormat:@"https://210.176.64.24"];
        self.CYBPublicDomain=[NSString stringWithFormat:@"https://210.176.64.17"];
        self.ifc_server = @"http://202.62.220.215/bea-ebank-110v4b/";
        self.mTelDomain = @"https://testsvr3.mtel.ws/java/BeaAPI/";
        self.mTelDomainCard = @"http://hkbea.mtel.ws/java/bea/dev/";
        self.iCouponServer = @"https://210.176.64.24";
        self.iCouponServerURL = @"https://210.176.64.24/servlet/ICouponBeaAppShow";
        self.iCouponServerLogoutURL = @"https://210.176.64.24/servlet/MBICPLogoutShow";
        //uat24 setting ========================================================
*/
/*
        //uat23 setting ========================================================
        //      id: com.hkbea.uat23
        //ipa name: BEA23.ipa
        //app name: BEA(U23)
        self.CYBDomain=[NSString stringWithFormat:@"https://220.241.201.85"];
        self.CYBPublicDomain=[NSString stringWithFormat:@"https://220.241.201.84"];
        self.ifc_server = @"http://202.62.220.215/bea-ebank-110v4b/";
        self.mTelDomain = @"http://testsvr3.mtel.ws/java/BeaAPI/";
        self.mTelDomainCard = @"http://hkbea.mtel.ws/java/bea/";
        self.iCouponServer = @"https://210.176.64.24";
        self.iCouponServerURL = @"https://210.176.64.24/servlet/ICouponBeaAppShow";
        self.iCouponServerLogoutURL = @"https://210.176.64.24/servlet/MBICPLogoutShow";
        //uat23 setting ========================================================
*/
        
        //some old product setting
//        self.mTelDomain = @"http://hkbea.mtel.ws/java/bea/dev/";
//        self.mTelDomainCard = @"http://hkbea.mtel.ws/java/bea/dev/";
        
        //some old uat setting
//        self.ifc_server = @"http://202.62.220.215/bea-ebank-110v4b/";
//        self.mTelDomainCard = @"http://hkbea.mtel.ws/java/bea/dev/";
        
        
        // Mobile Banking
        self.CheckRegStatusURL = [NSString stringWithFormat:@"%@/servlet/appsrv",CYBDomain,nil];
        self.MBCYBLogonShow = [NSString stringWithFormat:@"%@/servlet/MBCYBLogonShow",CYBDomain,nil];

        // ATM and branch search              
        self.URLOfgetATMListOTA = [NSString stringWithFormat:@"%@/servlet/appsrvpub",CYBPublicDomain,nil];
        self.URLOfNewBranch = [NSString stringWithFormat:@"%@/servlet/appsrvpub",CYBPublicDomain,nil];
        
        // Hotline         
        self.URLOfgetHotlineOTA = [NSString stringWithFormat:@"%@/servlet/appsrvpub",CYBPublicDomain,nil];

        // Mobile trading         
        self.CheckMobileTradingURL = [NSString stringWithFormat:@"%@/servlet/appsrv",CYBDomain,nil];
        self.MBCYTLogonShow = [NSString stringWithFormat:@"%@/servlet/MBCYTLogonShow",CYBDomain,nil];
        self.URLOfMBAIOLogonShow = [NSString stringWithFormat:@"%@/servlet/MBAIOLogonShow",CYBDomain,nil];        
        // Stock Watch & Fast Trade        
		self.m_sURLRegStatusStockTrading		= [NSString stringWithFormat:@"%@/servlet/appsrv?act=CMT&",CYBDomain,nil];
		self.m_sURLBuyStockTrading				= [NSString stringWithFormat:@"%@/servlet/MBSWBuyInput?",CYBDomain,nil];
		self.m_sURLSellStockTrading				= [NSString stringWithFormat:@"%@/servlet/MBSWSellInput?",CYBDomain,nil];
		self.m_sURLRegStatusEAS					= [NSString stringWithFormat:@"%@/servlet/appsrv?act=EMT&",CYBDomain,nil];
		self.m_sURLBuyEAS						= [NSString stringWithFormat:@"%@/servlet/MESWBuyInput?",CYBDomain,nil];
		self.m_sURLSellEAS						= [NSString stringWithFormat:@"%@/servlet/MESWSellInput?",CYBDomain,nil];
		self.m_sURLMBCYBLogonShow				= [NSString stringWithFormat:@"%@/servlet/MBCYBLogonShow?",CYBDomain,nil];
        self.m_sURLMBLogonShow				= [NSString stringWithFormat:@"%@/servlet/MBLogonShow?",CYBDomain,nil];
        
        // MPF module
        self.URLOfMPFRate = [NSString stringWithFormat:@"%@/servlet/MPFRatePub",CYBPublicDomain,nil];
        self.URLOfFundPrice = [NSString stringWithFormat:@"%@/servlet/AppPlistPub",CYBPublicDomain,nil];
        self.URLOfMPFNewsPre = [NSString stringWithFormat:@"%@/servlet/AppPlistPub",CYBPublicDomain,nil];
        self.URLOfMPFNews = [NSString stringWithFormat:@"%@/servlet/AppPlistPub",CYBPublicDomain,nil];
        self.URLOfMPFPromoPlist = [NSString stringWithFormat:@"%@/servlet/AppPlistPub",CYBPublicDomain,nil];

        // Account promotion module
        self.URLOfLatestPromo = [NSString stringWithFormat:@"%@/servlet/AppPlistPub",CYBPublicDomain,nil];
        self.URLOfAccProApplicationView =  [NSString stringWithFormat:@"%@/servlet/LatestPromoInputShow",CYBPublicDomain,nil];
        self.URLOfAccProDefaultPage_zh =    [NSString stringWithFormat:@"%@/acc_pro/payroll_top_c.html",CYBPublicDomain,nil];
        self.URLOfAccProDefaultPage_en =    [NSString stringWithFormat:@"%@/acc_pro/payroll_top_e.html",CYBPublicDomain,nil];
        self.URLOfAccProOffersPage_zh =     [NSString stringWithFormat:@"%@/acc_pro/payroll_bottom_c.html",CYBPublicDomain,nil];
        self.URLOfAccProOffersPage_en =     [NSString stringWithFormat:@"%@/acc_pro/payroll_bottom_e.html",CYBPublicDomain,nil];
        self.URLOfLatestOfferCall_e = [NSString stringWithFormat:@"%@/acc_pro/LatestOfferCall_e.html",CYBPublicDomain,nil]; 
        self.URLOfLatestOfferCall_c = [NSString stringWithFormat:@"%@/acc_pro/LatestOfferCall_c.html",CYBPublicDomain,nil]; 
        self.URLOfEnquiriesPage_e = [NSString stringWithFormat:@"%@/acc_pro/LatestPromoEnquiry_e.html",CYBPublicDomain,nil]; 
        self.URLOfEnquiriesPage_c = [NSString stringWithFormat:@"%@/acc_pro/LatestPromoEnquiry_c.html",CYBPublicDomain,nil]; 
        self.URLOfBannerPlist = [NSString stringWithFormat:@"%@/servlet/AppPlistPub",CYBPublicDomain,nil]; 
        self.URLOfAccProApplication =      [NSString stringWithFormat:@"%@/servlet/appsrv",CYBDomain,nil];
        self.URLOfBasePromotionPage_zh =   [NSString stringWithFormat:@"%@/acc_pro/crazyad_zh.html",CYBPublicDomain,nil];
        self.URLOfBasePromotionPage_en =   [NSString stringWithFormat:@"%@/acc_pro/crazyad_en.html",CYBPublicDomain,nil];
        self.URLOfAccProApplicationTNC_e = [NSString stringWithFormat:@"%@/acc_pro/TNC_e.html",CYBPublicDomain,nil]; 
        self.URLOfAccProApplicationTNC_c = [NSString stringWithFormat:@"%@/acc_pro/TNC_c.html",CYBPublicDomain,nil]; 
        self.URLOfAccProApplicationNotes_e =  [NSString stringWithFormat:@"%@/acc_pro/important_notes_e.html",CYBPublicDomain,nil]; 
        self.URLOfAccProApplicationNotes_c =  [NSString stringWithFormat:@"%@/acc_pro/important_notes_c.html",CYBPublicDomain,nil]; 

        // Rate enquiries         
        self.URLOfRateEnquiriesBase = [NSString stringWithFormat:@"%@/servlet/appsrvpub",CYBPublicDomain,nil];

        // Consumer loan
        self.URLOfLoanBanner_zh =    [NSString stringWithFormat:@"%@/CLbanner_zh.html",CYBPublicDomain,nil];
        self.URLOfLoanBanner_en =    [NSString stringWithFormat:@"%@/CLbanner_en.html",CYBPublicDomain,nil];
        self.URLOfLoanOffer_zh =    [NSString stringWithFormat:@"%@/CLOffer_zh.html",CYBPublicDomain,nil];
        self.URLOfLoanOffer_en =    [NSString stringWithFormat:@"%@/CLOffer_en.html",CYBPublicDomain,nil];
        self.URLOfLoanTNC_zh =    [NSString stringWithFormat:@"%@/CLTNC_zh.html",CYBPublicDomain,nil];
        self.URLOfLoanTNC_en =    [NSString stringWithFormat:@"%@/CLTNC_en.html",CYBPublicDomain,nil];
        self.URLOfTaxLoanApplication = [NSString stringWithFormat:@"%@/servlet/appsrv",CYBPublicDomain,nil];

        // Tax Loan (2011)
        self.URLOfLT_offer_en =    [NSString stringWithFormat:@"%@/taxloan_offer_en.html",CYBPublicDomain,nil];
        self.URLOfLT_offer_zh =    [NSString stringWithFormat:@"%@/taxloan_offer_zh.html",CYBPublicDomain,nil];
        self.URLOfLT_repay_en =    [NSString stringWithFormat:@"%@/taxloan_repay_en.html",CYBPublicDomain,nil];
        self.URLOfLT_repay_zh =    [NSString stringWithFormat:@"%@/taxloan_repay_zh.html",CYBPublicDomain,nil];
        self.URLOfLT_tc_en =    [NSString stringWithFormat:@"%@/taxloan_tc_en.html",CYBPublicDomain,nil];
        self.URLOfLT_tc_zh =    [NSString stringWithFormat:@"%@/taxloan_tc_zh.html",CYBPublicDomain,nil];
        self.URLOfLoanTaxApplication = [NSString stringWithFormat:@"%@/servlet/appsrvpub",CYBPublicDomain,nil];

        //ConsumerLoanPromotion
        self.URLOfConsumerLoanPromo = [NSString stringWithFormat:@"%@/servlet/AppPlistPub",CYBPublicDomain,nil];
        self.URLOfConsumerLoanOffersCall_e = [NSString stringWithFormat:@"%@/acc_pro/ConsumerLoanCall_e.html",CYBPublicDomain,nil];
        self.URLOfConsumerLoanOffersCall_c = [NSString stringWithFormat:@"%@/acc_pro/ConsumerLoanCall_c.html",CYBPublicDomain,nil];
        self.URLOfConsumerLoanEnquiriesPage_e = [NSString stringWithFormat:@"%@/acc_pro/ConsumerLoanEnquiry_e.html",CYBPublicDomain,nil]; 
        self.URLOfConsumerLoanEnquiriesPage_c = [NSString stringWithFormat:@"%@/acc_pro/ConsumerLoanEnquiry_c.html",CYBPublicDomain,nil]; 
        self.URLOfConsumerLoanApplicationView =  [NSString stringWithFormat:@"%@/servlet/ConsumerLoanPromoInputShow",CYBPublicDomain,nil];
        
        //SupremeGold
        self.URLOfSupremeGoldApplicationView =  [NSString stringWithFormat:@"%@/servlet/SGPromoInputShow",CYBPublicDomain,nil];
        
        //InstalmentLoan
        self.URLOfInstalmentLoan_offer_en =    [NSString stringWithFormat:@"%@/insloan_offer_en.html",CYBPublicDomain,nil];
        self.URLOfInstalmentLoan_offer_zh =    [NSString stringWithFormat:@"%@/insloan_offer_zh.html",CYBPublicDomain,nil];
        self.URLOfInstalmentLoan_repay_en =    [NSString stringWithFormat:@"%@/insloan_repay_en.html",CYBPublicDomain,nil];
        self.URLOfInstalmentLoan_repay_zh =    [NSString stringWithFormat:@"%@/insloan_repay_zh.html",CYBPublicDomain,nil];
        self.URLOfInstalmentLoan_tc_en =    [NSString stringWithFormat:@"%@/insloan_tc_en.html",CYBPublicDomain,nil];
        self.URLOfInstalmentLoan_tc_zh =    [NSString stringWithFormat:@"%@/insloan_tc_zh.html",CYBPublicDomain,nil];        

        //Insurance
        self.URLOfInsuranceEnquiriesPage_e = [NSString stringWithFormat:@"%@/acc_pro/InsuranceEnquiry_e.html",CYBPublicDomain,nil];
        self.URLOfInsuranceEnquiriesPage_c = [NSString stringWithFormat:@"%@/acc_pro/InsuranceEnquiry_c.html",CYBPublicDomain,nil];
        self.URLOfInsuranceApplicationView = [NSString stringWithFormat:@"%@/servlet/MBPubInsIn",CYBPublicDomain,nil];
        self.URLOfInsuranceApplicationLanding = [NSString stringWithFormat:@"%@/servlet/MBPubInsWel",CYBPublicDomain,nil];
//        self.URLOfInsuranceApplicationView = [NSString stringWithFormat:@"https://test.bluecross.com.hk/PaymentProcessorMobile.jsp?site=BEAMOBILE&tran_no=BXT130&return_url=https://210.176.64.17/servlet/MBInsPubQo&amount=100&currency=344&language=zh_tr"];
        self.URLOfInsuranceNewsView =  [NSString stringWithFormat:@"%@/jsp/InsNewsList.jsp",CYBPublicDomain,nil];
        self.URLOfInsurancePlist = [NSString stringWithFormat:@"%@/servlet/AppPlistPub",CYBPublicDomain,nil];
        self.URLOfInsuranceDetail_e = [NSString stringWithFormat:@"%@/acc_pro/insT_body_e.html?#goToDetails",CYBPublicDomain,nil];
        self.URLOfInsuranceDetail_c = [NSString stringWithFormat:@"%@/acc_pro/insT_body_c.html?#goToDetails",CYBPublicDomain,nil];

        //StockGameCentre
//        self.URLOfStockGameCentre_e =    [NSString stringWithFormat:@"http://hkbea.111128jw.facebookcampaign2012.wdemo.pacim.com/drink_fun/mobile/form_en.php"];
//        self.URLOfStockGameCentre_e =    [NSString stringWithFormat:@"http://beafb.pacim.com/quiz_fun/index.php"];
//        self.URLOfStockGameCentre_c =    [NSString stringWithFormat:@"http://hkbea.111128jw.facebookcampaign2012.wdemo.pacim.com/drink_fun/mobile/form.php"];
        self.URLOfStockGameCentre_e =    [NSString stringWithFormat:@"http://beafb.pacim.com/drink_fun/mobile/en/form.php"];
        self.URLOfStockGameCentre_c =    [NSString stringWithFormat:@"http://beafb.pacim.com/drink_fun/mobile/tc/form.php"];
        
        //MKGeCard
        self.URLOfMKGeCard_e =    [NSString stringWithFormat:@"http://emarketing.hkbea.com/intimate/ecard/public.jsp?Lang=eng&From=13"];
        self.URLOfMKGeCard_c =    [NSString stringWithFormat:@"http://emarketing.hkbea.com/intimate/ecard/public.jsp?Lang=big5&From=13"];
          
        //SGG      
        self.URLOfSGGANS = [NSString stringWithFormat:@"%@/servlet/AppPlistPub",CYBPublicDomain,nil];
        self.URLOfSGG = [NSString stringWithFormat:@"%@/servlet/SGGInput",CYBPublicDomain,nil];
        self.URLOfSGGTNC_e = [NSString stringWithFormat:@"http://www.hkbea.com/FileManager/EN/Content_3280/game_tcs_eng.pdf"]; 
        self.URLOfSGGTNC_c = [NSString stringWithFormat:@"http://www.hkbea.com/FileManager/TC/Content_3280/game_tcs_chi.pdf"]; 

        //CyberFundSearch
        self.URLOfCyberFundSearch_FundSearch = [NSString stringWithFormat:@"%@iphone.jsp?sc=fdsearch",ifc_server,nil];
        self.URLOfCyberFundSearch_MyFunds = [NSString stringWithFormat:@"%@iphone.jsp?sc=myfund",ifc_server,nil];
        self.URLOfCyberFundSearch_Top10 = [NSString stringWithFormat:@"%@iphone.jsp?sc=topfund",ifc_server,nil];
        self.URLOfCyberFundSearch_News = [NSString stringWithFormat:@"%@iphone.jsp?sc=news",ifc_server,nil];
        
//        self.URLOfCyberFundSearch_FundSearch = [NSString stringWithFormat:@"%@iphone?sc=fdsearch",ifc_server,nil];
//        self.URLOfCyberFundSearch_MyFunds = [NSString stringWithFormat:@"%@iphone?sc=myfund",ifc_server,nil];
//        self.URLOfCyberFundSearch_Top10 = [NSString stringWithFormat:@"%@iphone?sc=topfund",ifc_server,nil];
//        self.URLOfCyberFundSearch_News = [NSString stringWithFormat:@"%@iphone?sc=news",ifc_server,nil];
        //P2P
        self.URLOfP2P_main = [NSString stringWithFormat:@"%@/servlet/MBP2PPaymentShow",CYBDomain,nil];
        self.URLOfP2P_setting = [NSString stringWithFormat:@"%@/servlet/MBP2PSettingShow",CYBDomain,nil];
        self.URLOfP2P_Record = [NSString stringWithFormat:@"%@/servlet/MBP2PRecordShow",CYBDomain,nil];
        
        //PhoneGap plugin
        self.URLOfPhoneGap_plugin_unittest = @"index.html";
        self.URLOfPhoneGap_plugin_SIT = [NSString stringWithFormat:@"%@/phonegap_plugin/www/index.html",CYBDomain,nil];

        //facebook
        self.URLOfFacebook_fun = @"https://www.facebook.com/hkbeafun";
//        self.URLOfFacebook_fun = @"http://www.baidu.com";
        self.URLOfFacebook_joy = @"https://www.facebook.com/hkbeajoy";
//        self.URLOfFacebook_joy = @"http://weibo.com";
        self.URLOfAccessibility = @"http://testsvr3.mtel.ws/java/BeaAPI/upload/menuicon/image/2012-11-20/20121120103532_menu_icon_importantnotice_securitytips.png";
    }
    return self;
}

@end
