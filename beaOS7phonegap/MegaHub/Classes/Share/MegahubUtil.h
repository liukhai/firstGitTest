//
//  MegahubUtil.h
//  MagicTraderChief
//
//  Created by ChiYin on 17/08/2010.
//  Copyright 2010 Megahub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MegahubUtil : NSObject


+ (NSString *) formatDecimalCurrencyNumber:(NSNumber *)input Unit:(NSString *)aCUnit;
+ (NSString *) formatDecimalCurrencyString:(NSString *)input Unit:(NSString *)aCUnit;

+ (NSString *) formatDecimalPercentage:(NSNumber *)input;
+ (NSString *) formatDecimalPercentageString:(NSString *)input;
+ (NSString *) formatDecimal:(NSNumber *)input;
+ (NSString *) formatDecimal:(NSDecimalNumber *)input prettyFormat:(BOOL)aPrettyFormat;
+ (NSString *) formatDecimal:(NSNumber *)input decPlace:(NSUInteger)aDecPlace;
+ (NSString *) formatDecimalString:(NSString *) input;
+ (NSString *) formatDecimalString:(NSString *) input prettyFormat:(BOOL)aPrettyFormat;
+ (NSString *) formatDecimalString:(NSString *)input decPlace:(NSInteger) aDecPlace;

+ (NSString *) formatDecimalInteger:(NSNumber *)input;
+ (NSString *) formatDecimalIntegerString:(NSString *)input;
+ (NSString *) timestampStringToDate:(NSString *)outFormat input:(NSString *)input;
+ (NSString *) formatOctODateStringToDate:(NSString *)outFormat input:(NSString *)input;

+ (NSString *) padSymbolToLength:(NSString *)symbol length:(NSUInteger)len;
+ (NSString *) formatHKStockCode:(NSString *)input;
+ (BOOL)stringToBool:(NSString *)string;


+ (NSString *)dataToHexString:(NSData *) data;
+ (NSData *)hexStringToData:(NSString *) hexString;
+ (NSString *)Base64Encode:(NSData *)data;
+ (NSString *)urlencode:(NSString *)source;
+ (NSString *)urldecode:(NSString *)source;

+ (NSData *)convertBig5DataToUtf8Data:(NSData *)aoData;
+ (NSString *)removeComma:(NSString *)aStringWithComma;
+ (NSString *)stripSuffixFromSymbol:(NSString *)asSymbol;
+ (NSLocale *)defaultLocale;

@end

NSString* amountToString(double qty);
NSString* amountToStringWithMinFractionDigits(double qty, int minFractionDigits);





