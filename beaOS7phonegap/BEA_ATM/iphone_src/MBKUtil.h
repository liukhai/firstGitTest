//
//  TaxLoanApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on SEP/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ASIFormDataRequest.h"
#import "Reachability.h"
#import "LangUtil.h"
#import "MigrationSetting.h"

#define NUM_PAD_DONE_BUTTON_TAG 1000
#define LINE_NUM_PAD_TAG 1001
@interface MBKUtil: NSObject {
	NSMutableDictionary *md_images;
	NSNumber* anno_count;
	NSNumber* mvflag;
//	NSNumber* mvflag2;

	NSMutableArray *ma_atmListItems;

	NSMutableArray *ma_atm_Items;
	
	NSArray *atm_item_key;

    UIButton *queryButton1;
    NSString *queryButtonWillShow;
}

@property(nonatomic, retain) NSMutableDictionary *md_images;
@property(nonatomic, retain) NSNumber* anno_count;
@property(nonatomic, retain) NSNumber* mvflag;
//@property(nonatomic, retain) NSNumber* mvflag2;

@property(nonatomic, retain) NSString *realServerURL;

@property(nonatomic, retain) NSMutableArray *ma_atmListItems;

@property(nonatomic, retain) NSArray *atm_item_key;

@property(nonatomic, retain) UIButton *queryButton1;
@property(nonatomic, retain) NSString *queryButtonWillShow;

+ (MBKUtil*) me;

+ (NSString*) getCheckRegStatusURL;

- (NSNumber*) getDistanceStringFromA:(CLLocation *)locationA toB:(CLLocation *)locationB;
- (void) setCusBackgroundView:(UIView *)a_view index:(int)a_index;

- (UIImage*) getImageByKey:(NSString*)key;
- (NSString*) getBundleSettingFilePath;

+ (BOOL) settingFileExists;
+ (void) copySettingFile;
//- (BOOL) hotlineFileUpdated;
//- (void) copyHotlineFile;
- (NSNumber*) getLangCount;
- (NSString*) getLangName:(int)index;
+ (NSString*) loadSettingsByKey:(NSString *)key;
- (void) increaseAnno_count;
- (void) resetAnno_count;
- (void) increaseMvflag;
//- (void) increaseMvflag2;
- (void) updateSettings:(NSString *)key value:(NSString *)value;
- (void)detectJailBreak;
//+ (NSString*) getLangPref;

- (NSString*) getDocPath;

+ (NSString *) md5:(NSString *)str;

+ (NSString*) decryption:(NSData*)input;
+ (NSData*) encryption:(NSString*)input;

+ (NSString*) getMobileNoFromSetting;
+ (NSString*) getEASMobileNoFromSetting;
+ (NSURL*) getURLCYBMBKREG;

- (NSString *)getDocATMplistPath;
- (NSString *)getDocATMplistPath_en;
- (NSString *)getDocATMplistPath_zh;
- (NSString *)getDocHotlinePath;

+ (NSString*) getKeyString4Req;
+(NSString*) getKS;
+(NSString*) getEASKS;
- (NSString*) getATMListSNFromLocal;
+ (NSString*) getURLOfgetATMListOTA;
- (NSString*) getHotlineSNFromLocal;
+ (NSString*) getURLOfgetHotlineOTA;
- (BOOL) saveATMxml:(NSData*)data;
- (BOOL) saveHOTxml:(NSData*)data;

+ (NSString *)getDocTempFilePath;
+ (NSString*) getURLOfTaxLoanApplication;
+ (NSString*) getURLOfCIHApplication;

+ (BOOL) isLangOfChi;
+ (BOOL) wifiNetWorkAvailable;

@end
