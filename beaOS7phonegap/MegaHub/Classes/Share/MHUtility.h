//
//  MHUtility.h
//  AyersGTS
//
//  Created by Megahub on 20/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHLanguage.h"

#define TAG_ALERTVIEW_DEMO_EXPIRED	11111

@interface MHUtility : NSObject <UIAlertViewDelegate>{

}
+ (BOOL)isValidStockCode:(NSInteger)stockCode;

+ (BOOL)checkVersionGreater:(NSString *)aVersion;
+ (double)getiOSVersion;

+ (NSString *)getDeviceName;
+ (NSString *)getSystemName;
+ (NSString *)getSystemVersion;
+ (NSString *)getDeviceModel;
+ (NSString *)getSystemLanguage;

+ (void)onDisclaimerButtonIsClicked;


// formating functions
// change 10000 ~> 10K
+ (NSString *)tradeLogAmountToString:(long long)qty;
// change 1000 ~> 1K
+ (NSString *)amountToString:(double)qty WithMinFractionDigits:(int)minFractionDigits;
+ (NSString *)amountBidAskToString:(double)qty WithMinFractionDigits:(int)minFractionDigits;

// change 123456789.1234... ~> 123,456,789.123
// where |aDecPlace| determine the number of digits after decimel
+ (NSString *)formatDecimalString:(NSString *)input decPlace:(NSInteger) aDecPlace;
+ (NSString *)removeComma:(NSString *)aStringWithComma;



+ (NSData *)hexStringToData:(NSString *) hexString;

+(BOOL)equalsIgnoreCase:(NSString *)aString anotherString:(NSString *)bString;

+(NSString *)doublePriceToString:(double)aPrice market:(NSString *)aMarket;
+(NSString *)longlongPriceToString:(long long)aPrice market:(NSString *)aMarket;

+(NSString *)floatPriceToString:(float)aPrice market:(NSString *)aMarket;
+(NSString *)floatPriceChangeToString:(float)aPriceChange market:(NSString *)aMarket;
+(NSString *)floatPricePencentageChangeToString:(float)aPricePencentageChange market:(NSString *)aMarket;

//Index
+(NSString *)floatIndexToString:(float)aIndexFloat market:(NSString *)aMarket;
+(NSString *)floatIndexChangeToString:(float)aIndexFloat market:(NSString *)aMarket;
+(NSString *)floatIndexPencentageChangeToString:(float)aIndexFloat market:(NSString *)aMarket;
+(NSString *)doubleIndexTurnoverToString:(double)aTurnover market:(NSString *)aMarket;

//Stock
+(NSString *)floatOpenToString:(float)aOpenFloat market:(NSString *)aMarket;
+(NSString *)floatPrevCloseToString:(float)aPrevCloseFloat market:(NSString *)aMarket;
+(NSString *)floatAvgPriceToString:(float)aAvgPriceFloat market:(NSString *)aMarket;
+(NSString *)floatVolumeToString:(float)aVolumeFloat market:(NSString *)aMarket;
+(NSString *)floatTurnoverToString:(float)aTurnoverFloat market:(NSString *)aMarket;

+(NSString *)doubleTurnoverToString:(double)aTurnoverDouble market:(NSString *)aMarket;


//For stock
+(NSString *)floatPEToString:(float)aPEFloat market:(NSString *)aMarket;
+(NSString *)floatYieldToString:(float)aYieldFloat market:(NSString *)aMarket;


//Warrant / CBBC
+(NSString *)floatGearingToString:(float)aGearingFloat market:(NSString *)aMarket;
+(NSString *)floatPremiumToString:(float)aPremiumFloat market:(NSString *)aMarket;


//Chart
+(int)convertMHLanguageToChartLang:(Language)aMHLanguage;

//Stock Data
+ (NSString *)intToTimeString:(int) time;
+(NSString *)expiryDateToDate:(int) date;
+(NSString *)stringVolumeToDisplayableString:(NSString *)aString market:(NSString *)aMarket;
+(NSString *)stringIEPToDisplayableString:(NSString *)aString market:(NSString *)aMarket;
+(NSString *)stringIEVToDisplayableString:(NSString *)aString market:(NSString *)aMarket;
+(NSString *)stringVolatiliityToDisplayableString:(NSString *)aString market:(NSString *)aMarket;
+(NSString *)stringAuthSharesToDisplayableString:(NSString *)aString market:(NSString *)aMarket;
+(NSString *)stringSharesIssuedToDisplayableString:(NSString *)aString market:(NSString *)aMarket;
+(NSString *)stringMarketCapToDisplayableString:(NSString *)aString market:(NSString *)aMarket;

//Watchlist
+(NSString *)intSymbolToDisplayableString:(int)aSymbol market:(NSString *)aMarket;
+(NSString *)doubleMoneyValueToDisplayableString:(double)aMoneyValue market:(NSString *)aMarket;

+(void)UIViewsMoveY:(float)aPixal uiView:(UIView *)aUIView,... NS_REQUIRES_NIL_TERMINATION;

+(BOOL)isSymbolInMarket:(NSString *)emmaXMLLinkSymbol market:(NSString *)aMarket;

+ (NSString *)applicationDocumentsDirectory;
+ (UIColor *)uicolorWithHexValue:(int)aColorCode;
+ (UIColor *)uicolorWithHexValueString:(NSString *)aColorString;

+ (NSString *)getCurrentTimeNum:(NSString *)today ;

+ (NSString *)getOneDayChartEncryptionKey:(NSString *)aCurrentTimeFrom1970String;
+ (NSString*)md5HexDigest:(NSString*)input;

+(NSString *)addSpaceInNSString:(NSMutableString *)aTargetString theMaximiumSpaceNumber:(int)aMaximiumSpaceNumber;
+(NSString *)extractString:(NSString *)aString identifier:(NSString *)aIdentifier;

+(NSString *)longlongQtyToDisplayableString:(long long)aQty market:(NSString *)aMarket;

+(BOOL)isValidTGT:(NSString *)aTGTCode;
+(BOOL)isValidValidation:(NSString *)aValidation;

+ (NSArray *)generatePricePickerForTradeInSnapShot:(double)aPrice spreadType:(int)aSpreadType minSpreadPrice:(float)aMinSpreadPrice maxSpreadPrice:(float)aMaxSpreadPrice;
+ (NSArray *)generateQuantityForTrade:(long long)aQuantity lotSize:(long long)aLotSize;

// Check the input string is a number or not
+ (BOOL)isNumber:(NSString *)s ;

+ (CGFloat)getScreenWidth;
+ (CGFloat)getScreenHeight;
+ (CGFloat)getAppHeight;
+ (CGFloat) getOriginY;
+ (CGFloat)convertHeightBasedOnCurrentDevice:(CGFloat)origHeight;
@end
