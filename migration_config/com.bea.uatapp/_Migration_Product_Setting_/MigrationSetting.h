//
//  MigrationSetting.h
//  BEA
//
//  Created by yaojzy on 20110323.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MigrationSetting : NSObject {
    
    NSString* CYBDomain;
    NSString* CYBPublicDomain;
    NSString* mTelDomain;
    NSString* ifc_server;
    NSString* CheckRegStatusURL;
    NSString* URLOfgetATMListOTA;
    NSString* URLOfgetHotlineOTA;
    NSString* URLOfTaxLoanApplication;
    NSString* URLOfLoanTaxApplication;
    NSString* CheckMobileTradingURL;
	NSString* MBCYBLogonShow;
	NSString* MBCYTLogonShow;
    NSString *URLOfMBAIOLogonShow;
    //CR1105529-MPF    
    NSString *URLOfFundPrice;
    NSString *URLOfMPFNews;
    NSString *URLOfMPFNewsPre;
    NSString *URLOfFootNote;
    NSString *URLOfLatestPromo;
    NSString *URLOfMPFPromoPlist;
    //CR1201166
    NSString *URLOfMPFRate;
    //CR1105665-AutoPayrollPromotion
    //CR1105982-LatestPromotion
    NSString *URLOfAccProApplication;
    NSString *URLOfAccProDefaultPage_zh;
    NSString *URLOfAccProDefaultPage_en;
    NSString *URLOfBasePromotionPage_zh;
    NSString *URLOfBasePromotionPage_en;
    NSString *URLOfAccProOffersPage_zh;
    NSString *URLOfAccProOffersPage_en;
    NSString *URLOfAccProApplicationTNC_e;
    NSString *URLOfAccProApplicationTNC_c;
    NSString *URLOfAccProApplicationNotes_e;
    NSString *URLOfAccProApplicationNotes_c;
    NSString *URLOfAccProApplicationView;
    NSString *URLOfBannerPlist;
    //CR1105664-RateEnquiries
    NSString *URLOfRateEnquiriesBase;
    //CR1106268-ConsumerLoanGraphicUpdate
    NSString *URLOfLoanBanner_zh;
    NSString *URLOfLoanBanner_en;
    NSString *URLOfLoanOffer_zh;
    NSString *URLOfLoanOffer_en;
    NSString *URLOfLoanTNC_zh;
    NSString *URLOfLoanTNC_en;
    //CR1106053-StockWatch&FastTrade	
	NSString	*m_sURLRegStatusStockTrading;
	NSString	*m_sURLBuyStockTrading;
	NSString	*m_sURLSellStockTrading;
	NSString	*m_sURLRegStatusEAS;
	NSString	*m_sURLBuyEAS;
	NSString	*m_sURLSellEAS;
	NSString	*m_sURLMBCYBLogonShow;
    NSString	*m_sURLMBLogonShow;
    //CR1106304-TaxLoan    
    NSString *URLOfLT_offer_en;
    NSString *URLOfLT_offer_zh;
    NSString *URLOfLT_tc_en;
    NSString *URLOfLT_tc_zh;
    NSString *URLOfLT_repay_en;
    NSString *URLOfLT_repay_zh;
    NSString *URLOfLatestOfferCall_e;
    NSString *URLOfLatestOfferCall_c;
    NSString *URLOfEnquiriesPage_e;
    NSString *URLOfEnquiriesPage_c;
    //CRxxxxxxx-NewBranch
    NSString *URLOfNewBranch;
    //StockGameCentre
    NSString *URLOfStockGameCentre_e;
    NSString *URLOfStockGameCentre_c;
    //ConsumerLoanPromo
    NSString *URLOfConsumerLoanPromo;
    NSString *URLOfConsumerLoanEnquiriesPage_c;
    NSString *URLOfConsumerLoanEnquiriesPage_e;
    NSString *URLOfConsumerLoanOffersCall_c;
    NSString *URLOfConsumerLoanOffersCall_e;
    NSString *URLOfConsumerLoanApplicationView;
    //SupremeGold
    NSString *URLOfSupremeGoldApplicationView;
    //InstalmentLoan
    NSString *URLOfInstalmentLoan_offer_en;
    NSString *URLOfInstalmentLoan_offer_zh;
    NSString *URLOfInstalmentLoan_tc_en;
    NSString *URLOfInstalmentLoan_tc_zh;
    NSString *URLOfInstalmentLoan_repay_en;
    NSString *URLOfInstalmentLoan_repay_zh;
    //Insurance
    NSString *URLOfInsuranceEnquiriesPage_e;
    NSString *URLOfInsuranceEnquiriesPage_c;
    NSString *URLOfInsuranceApplicationView;
    NSString *URLOfInsuranceApplicationLanding;
    NSString *URLOfInsuranceNewsView;
    NSString *URLOfInsurancePlist;
    NSString *URLOfInsuranceDetail_e;
    NSString *URLOfInsuranceDetail_c;

    //MKGeCard
    NSString *URLOfMKGeCard_e;
    NSString *URLOfMKGeCard_c;
    //SGG
    NSString *URLOfSGGANS;
    NSString *URLOfSGG;
    NSString *URLOfSGGTNC_e;
    NSString *URLOfSGGTNC_c;
    //CyberFundSearch
    NSString *URLOfCyberFundSearch_FundSearch;
    NSString *URLOfCyberFundSearch_MyFunds;
    NSString *URLOfCyberFundSearch_Top10;
    NSString *URLOfCyberFundSearch_News;
    //P2P
    NSString *URLOfP2P_main;
    NSString *URLOfP2P_setting;
    NSString *URLOfP2P_Record;
    NSString *URLOfPhoneGap_plugin_unittest;
    NSString *URLOfPhoneGap_plugin_SIT;
    NSString *URLOfFacebook_fun;
    NSString *URLOfFacebook_joy;
    NSString *URLOfAccessibility;
    //iCoupon
    NSString *iCouponServer;
    NSString *iCouponServerURL;
    NSString *iCouponServerLogoutURL;
}
@property(nonatomic, retain) NSString* CYBDomain;
@property(nonatomic, retain) NSString* CYBPublicDomain;
@property(nonatomic, retain) NSString* mTelDomain;
@property(nonatomic, retain) NSString* mTelDomainCard;
@property(nonatomic, retain) NSString* ifc_server;
@property(nonatomic, retain) NSString* CheckRegStatusURL;
@property(nonatomic, retain) NSString* URLOfgetATMListOTA;
@property(nonatomic, retain) NSString* URLOfgetHotlineOTA;
@property(nonatomic, retain) NSString* URLOfTaxLoanApplication;
@property(nonatomic, retain) NSString* URLOfLoanTaxApplication;
@property(nonatomic, retain) NSString* CheckMobileTradingURL;
@property(nonatomic, retain) NSString* MBCYBLogonShow;
@property(nonatomic, retain) NSString* MBCYTLogonShow;
@property(nonatomic, retain) NSString* URLOfMBAIOLogonShow;
@property(nonatomic, retain) NSString *URLOfFundPrice;
@property(nonatomic, retain) NSString *URLOfLatestPromo;
@property(nonatomic, retain) NSString *URLOfFootNote;
@property(nonatomic, retain) NSString *URLOfMPFNews;
@property(nonatomic, retain) NSString *URLOfMPFNewsPre;
@property(nonatomic, retain) NSString *URLOfMPFPromoPlist;
@property(nonatomic, retain) NSString *URLOfMPFRate;
@property(nonatomic, retain) NSString *URLOfAccProApplication;
@property(nonatomic, retain) NSString *URLOfAccProDefaultPage_zh;
@property(nonatomic, retain) NSString *URLOfAccProDefaultPage_en;
@property(nonatomic, retain) NSString *URLOfBasePromotionPage_zh;
@property(nonatomic, retain) NSString *URLOfBasePromotionPage_en;
@property(nonatomic, retain) NSString *URLOfAccProOffersPage_zh;
@property(nonatomic, retain) NSString *URLOfAccProOffersPage_en;
@property(nonatomic, retain) NSString *URLOfAccProApplicationTNC_e;
@property(nonatomic, retain) NSString *URLOfAccProApplicationTNC_c;
@property(nonatomic, retain) NSString *URLOfAccProApplicationNotes_e;
@property(nonatomic, retain) NSString *URLOfAccProApplicationNotes_c;
@property(nonatomic, retain) NSString *URLOfLatestOfferCall_e;
@property(nonatomic, retain) NSString *URLOfLatestOfferCall_c;
@property(nonatomic, retain) NSString *URLOfEnquiriesPage_e;
@property(nonatomic, retain) NSString *URLOfEnquiriesPage_c;
@property(nonatomic, retain) NSString *URLOfAccProApplicationView;
@property(nonatomic, retain) NSString *URLOfBannerPlist;
@property(nonatomic, retain) NSString *URLOfRateEnquiriesBase;

@property(nonatomic, retain) NSString *URLOfLoanBanner_zh;
@property(nonatomic, retain) NSString *URLOfLoanBanner_en;
@property(nonatomic, retain) NSString *URLOfLoanOffer_zh;
@property(nonatomic, retain) NSString *URLOfLoanOffer_en;
@property(nonatomic, retain) NSString *URLOfLoanTNC_zh;
@property(nonatomic, retain) NSString *URLOfLoanTNC_en;

@property(nonatomic, retain) NSString	*m_sURLRegStatusStockTrading;
@property(nonatomic, retain) NSString	*m_sURLBuyStockTrading;
@property(nonatomic, retain) NSString	*m_sURLSellStockTrading;
@property(nonatomic, retain) NSString	*m_sURLRegStatusEAS;
@property(nonatomic, retain) NSString	*m_sURLBuyEAS;
@property(nonatomic, retain) NSString	*m_sURLSellEAS;
@property(nonatomic, retain) NSString	*m_sURLMBCYBLogonShow;
@property(nonatomic, retain) NSString	*m_sURLMBLogonShow;

@property(nonatomic, retain) NSString *URLOfLT_offer_en;
@property(nonatomic, retain) NSString *URLOfLT_offer_zh;
@property(nonatomic, retain) NSString *URLOfLT_tc_en;
@property(nonatomic, retain) NSString *URLOfLT_tc_zh;
@property(nonatomic, retain) NSString *URLOfLT_repay_en;
@property(nonatomic, retain) NSString *URLOfLT_repay_zh;

@property(nonatomic, retain) NSString *URLOfNewBranch;

@property(nonatomic, retain) NSString *URLOfStockGameCentre_e;
@property(nonatomic, retain) NSString *URLOfStockGameCentre_c;

//ConsumerLoanPromo
@property(nonatomic, retain) NSString *URLOfConsumerLoanPromo;
@property(nonatomic, retain) NSString *URLOfConsumerLoanApplicationView;
@property(nonatomic, retain) NSString* URLOfConsumerLoanEnquiriesPage_c;
@property(nonatomic, retain) NSString* URLOfConsumerLoanEnquiriesPage_e;
@property(nonatomic, retain) NSString* URLOfConsumerLoanOffersCall_e;
@property(nonatomic, retain) NSString* URLOfConsumerLoanOffersCall_c;
@property(nonatomic, retain) NSString *URLOfMKGeCard_e;
@property(nonatomic, retain) NSString *URLOfMKGeCard_c;

//SupremeGold
@property(nonatomic, retain) NSString* URLOfSupremeGoldApplicationView;

//InstalmentLoan
@property(nonatomic, retain) NSString *URLOfInstalmentLoan_offer_en;
@property(nonatomic, retain) NSString *URLOfInstalmentLoan_offer_zh;
@property(nonatomic, retain) NSString *URLOfInstalmentLoan_tc_en;
@property(nonatomic, retain) NSString *URLOfInstalmentLoan_tc_zh;
@property(nonatomic, retain) NSString *URLOfInstalmentLoan_repay_en;
@property(nonatomic, retain) NSString *URLOfInstalmentLoan_repay_zh;

@property(nonatomic, retain) NSString *URLOfSGGANS;
@property(nonatomic, retain) NSString *URLOfSGG;
@property(nonatomic, retain) NSString *URLOfSGGTNC_e;
@property(nonatomic, retain) NSString *URLOfSGGTNC_c;

//Insurance
@property(nonatomic, retain) NSString *URLOfInsuranceEnquiriesPage_e;
@property(nonatomic, retain) NSString *URLOfInsuranceEnquiriesPage_c;
@property(nonatomic, retain) NSString *URLOfInsuranceApplicationView;
@property(nonatomic, retain) NSString *URLOfInsuranceApplicationLanding;
@property(nonatomic, retain) NSString *URLOfInsuranceNewsView;
@property(nonatomic, retain) NSString *URLOfInsurancePlist;
@property(nonatomic, retain) NSString *URLOfInsuranceDetail_e;
@property(nonatomic, retain) NSString *URLOfInsuranceDetail_c;

//CyberFundSearch
@property(nonatomic, retain) NSString *URLOfCyberFundSearch_FundSearch;
@property(nonatomic, retain) NSString *URLOfCyberFundSearch_MyFunds;
@property(nonatomic, retain) NSString *URLOfCyberFundSearch_Top10;
@property(nonatomic, retain) NSString *URLOfCyberFundSearch_News;

//P2P
@property(nonatomic, retain) NSString *URLOfP2P_main;
@property(nonatomic, retain) NSString *URLOfP2P_setting;
@property(nonatomic, retain) NSString *URLOfP2P_Record;

@property(nonatomic, retain) NSString *URLOfPhoneGap_plugin_unittest;
@property(nonatomic, retain) NSString *URLOfPhoneGap_plugin_SIT;
@property(nonatomic, retain) NSString *URLOfFacebook_fun;
@property(nonatomic, retain) NSString *URLOfFacebook_joy;
@property(nonatomic, retain) NSString *URLOfAccessibility;
//iCoupon
@property(nonatomic, retain) NSString *iCouponServer;
@property(nonatomic, retain) NSString *iCouponServerURL;
@property(nonatomic, retain) NSString *iCouponServerLogoutURL;
+ (MigrationSetting*) me;
@end
