//
//  MHUtility.m
//  AyersGTS
//
//  Created by Megahub on 20/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MHUtility.h"
#include <netdb.h> //socket's friend
#import "PTConstant.h"
#import <CommonCrypto/CommonDigest.h> //md5's friend
#import "MHFeedConnectorX.h"
//#import "PTPDelegate.h"

@implementation MHUtility

+ (BOOL)isValidStockCode:(NSInteger)stockCode {
	BOOL valid = NO;
	
	if (stockCode > 0 && stockCode <= 99999) {
		valid = YES;
	}
	 
	return valid;
}

// return YES if the device iOS version is greater or equal to the aVersion
+ (BOOL)checkVersionGreater:(NSString *)aVersion {
    // A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
    // class is used as fallback when it isn't available.
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    return ([currSysVer compare:aVersion options:NSNumericSearch] != NSOrderedAscending);
}

+(double)getiOSVersion{
    NSString* ver = [[UIDevice currentDevice] systemVersion];
	
	return [ver doubleValue];
}

+ (NSString *)getDeviceName  {return [[UIDevice currentDevice] name];}
+ (NSString *)getSystemName  {return [[UIDevice currentDevice] systemName];}
+ (NSString *)getSystemVersion  {return [[UIDevice currentDevice] systemVersion];}
+ (NSString *)getDeviceModel  {return [[UIDevice currentDevice] model];}
+ (NSString *)getSystemLanguage  {return [[NSLocale currentLocale] localeIdentifier];}

+(void)onDisclaimerButtonIsClicked{
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:MHLocalizedString(@"m_oDisclaimerTextViewTitle", nil) 
													 message:MHLocalizedString(@"m_oDisclaimerTextView", nil) 
													delegate:self 
										   cancelButtonTitle:MHLocalizedString(@"demoAlertViewCancelButtonTitle", nil) 
										   otherButtonTitles:nil] autorelease];
	[alert show];
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == TAG_ALERTVIEW_DEMO_EXPIRED) {    // Demo Expired      
		if (buttonIndex == 0) { // cancel
			[alertView dismissWithClickedButtonIndex:0 animated:YES];
			NSString *urlString = [NSString stringWithFormat:@"tel:%@",@"25843820"];
			NSURL *url = [NSURL URLWithString:urlString];
			[[UIApplication sharedApplication] openURL:url];

			exit(1);
		}
    }
}

#pragma mark -
#pragma mark String formating Functions

+ (NSString *)tradeLogAmountToString:(long long)qty{
    static const char units[] = { '\0', 'K', 'M', 'B', 'T', 'P', 'E', 'Z', 'Y' };
    static int maxUnits = sizeof units - 1;
	
    int multiple = 1000;
    int exponent = 0;

	long long remain = qty;
	
	// more than 10,000 -> 10K
	if(qty >= multiple*10){
		while (qty >= multiple && exponent < maxUnits) {
			qty /= multiple;
			exponent++;
		}
	}
	
	// get the remain, e.g. 19.651M -> 651000
	int digit = pow(multiple, exponent);
	remain %= digit;
	
	// only get first three digits, e.g. 19.651M -> 19.651
	if(exponent>0){
		digit = pow(multiple, exponent-1);
		remain /= digit;
	}
	
	// only show one digit
	if(remain>=100){
		
		// round up, e.g 19.651M -> 19.7M
		if(remain%100>=50){
			remain=remain/100+1;
		}else{
			remain=remain/100;
		}
	
	// e.g 19051000 -> 19.0
	}else{
		remain = 0;
	}
	
	// e.g. 19.95M -> 20M
	if(remain>=10){
		remain = 0;
		qty++;
	}
	
    return [NSString stringWithFormat:@"%lld%@%c",qty, remain>0?[NSString stringWithFormat:@".%lld",remain]:@"", units[exponent]];
}

+ (NSString *)amountToString:(double)qty WithMinFractionDigits:(int)minFractionDigits {
    static const char units[] = { '\0', 'K', 'M', 'B', 'T', 'P', 'E', 'Z', 'Y' };
    static int maxUnits = sizeof units - 1;
	
    int multiple = 1000;
    int exponent = 0;
	
    while (qty >= multiple && exponent < maxUnits) {
        qty /= multiple;
        exponent++;
    }
	
    static NSNumberFormatter *formatter = nil;
	if (!formatter) {
		// Ben: 長用，唔洗release
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setMaximumFractionDigits:3];
		[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	}
	[formatter setMinimumFractionDigits:minFractionDigits];
	
	// Beware of reusing this format string. -[NSString stringWithFormat] ignores \0, *//printf does not.
    return [NSString stringWithFormat:@"%@%c", [formatter stringFromNumber: [NSNumber numberWithDouble: qty]], units[exponent]];
}

+ (NSString *)amountBidAskToString:(double)qty WithMinFractionDigits:(int)minFractionDigits {
    static const char units[] = { '\0', 'K', 'M', 'B', 'T', 'P', 'E', 'Z', 'Y' };
    static int maxUnits = sizeof units - 1;
	
    int multiple = 1000;
    int exponent = 0;
	
    while (qty >= multiple && exponent < maxUnits) {
        qty /= multiple;
        exponent++;
    }
	
    static NSNumberFormatter *formatter = nil;
	if (!formatter) {
		// Ben: 長用，唔洗release
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setMaximumFractionDigits:1];
		[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	}
	[formatter setMinimumFractionDigits:minFractionDigits];
	
	// Beware of reusing this format string. -[NSString stringWithFormat] ignores \0, *//printf does not.
    return [NSString stringWithFormat:@"%@%c", [formatter stringFromNumber: [NSNumber numberWithDouble: qty]], units[exponent]];
}

+ (NSString *) formatDecimalString:(NSString *)input decPlace:(NSInteger) aDecPlace {
	[input retain];
	
	if (input == nil || [input length] == 0) {
		return @"";
	}
	
	static NSNumberFormatter *formatter = nil;
	if (!formatter) {
		formatter = [[NSNumberFormatter alloc] init];
	}
	
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:aDecPlace];
	[formatter setMinimumFractionDigits:aDecPlace];
	[formatter setMinimumIntegerDigits:1];
	
	NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:input];
	
	[input release];
	return [formatter stringFromNumber:decNum];
	
}

+ (NSString *) removeComma:(NSString *)aStringWithComma{
	if (aStringWithComma == nil) {
		return @"";
	}
	
	return [aStringWithComma stringByReplacingOccurrencesOfString:@"," withString:@""];
}

+ (NSString *) formatDecimalPercentage:(NSNumber *)input {
	
	if (input == nil) {
		return @"";
	}
	
	static NSNumberFormatter *formatter;
	
	if (formatter == nil) {
		
		formatter = [[NSNumberFormatter alloc] init];
		
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setMinimumFractionDigits:2];
		[formatter setMinimumIntegerDigits:1];
	}
	
	return [formatter stringFromNumber:input];
	
}

+ (NSData *)hexStringToData:(NSString *) hexString {
	
	NSMutableData *convertedData= [[[NSMutableData alloc] init] autorelease];
	unsigned char whole_byte;
	char byte_chars[3] = {'\0','\0','\0'};
	int i;
	for (i=0; i < [hexString length] / 2; i++) {
		byte_chars[0] = [hexString characterAtIndex:i*2];
		byte_chars[1] = [hexString characterAtIndex:i*2+1];
		whole_byte = strtol(byte_chars, NULL, 16);
		[convertedData appendBytes:&whole_byte length:1]; 
	}
	
	return convertedData;
}

+ (NSString *)dataToHexString:(NSData *) data {
	NSString *hexstr = [data description];
	hexstr = [hexstr stringByReplacingOccurrencesOfString:@" " withString:@""];
	hexstr = [hexstr stringByReplacingOccurrencesOfString:@"<" withString:@""];
	hexstr = [hexstr stringByReplacingOccurrencesOfString:@">" withString:@""];
	
	return hexstr;
}

+(BOOL)equalsIgnoreCase:(NSString *)aString anotherString:(NSString *)bString{
	BOOL isEqual = NO;
	
	if(bString != nil && aString != nil){
		if([aString caseInsensitiveCompare:bString] == NSOrderedSame){
			isEqual = YES;
		}
	}
	
	return isEqual;
}

+(NSString *)doublePriceToString:(double)aPrice market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self formatDecimalString:[NSString stringWithFormat:@"%1.3lf", aPrice] decPlace:3];
	}
	
	return resultString;
}

+(NSString *)longlongPriceToString:(long long)aPrice market:(NSString *)aMarket{
	NSString *resultString = nil;
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self formatDecimalString:[NSString stringWithFormat:@"%lli", aPrice] decPlace:3];
	}
	
	return resultString;
}

+(NSString *)floatPriceToString:(float)aPrice market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self formatDecimalString:[NSString stringWithFormat:@"%f", aPrice] decPlace:3];
	}
	
	return resultString;
}

+(NSString *)floatPricePencentageChangeToString:(float)aPricePencentageChange market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"(%1.2f%%)", aPricePencentageChange];
	}
	
	return resultString;
}

+(NSString *)floatPriceChangeToString:(float)aPriceChange market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"%1.3f", aPriceChange];
	}

	return resultString;
}


#pragma mark -
#pragma mark index

+(NSString *)floatIndexToString:(float)aIndexFloat market:(NSString *)aMarket{
	NSString *resultString  = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"%.2f", aIndexFloat];
	}
	
	return resultString;
}

+(NSString *)floatIndexChangeToString:(float)aIndexFloat market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"%.2f", aIndexFloat];
	}
	
	return resultString;
}

+(NSString *)floatIndexPencentageChangeToString:(float)aIndexFloat market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"%.2f%%", aIndexFloat];
	}
	
	return resultString;
}

+(NSString *)doubleIndexTurnoverToString:(double)aTurnover market:(NSString *)aMarket{ 
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self amountToString:aTurnover WithMinFractionDigits:2];
	}
	
	return resultString;
}


//Stock
+(NSString *)floatOpenToString:(float)aOpenFloat market:(NSString *)aMarket{
	NSString *resultString = @"";
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG] && aOpenFloat > 0) {
		resultString = [NSString stringWithFormat:@"%.3f", aOpenFloat];
	}
	
	return resultString;
}

+(NSString *)floatPrevCloseToString:(float)aPrevCloseFloat market:(NSString *)aMarket{
	NSString *resultString = @"";
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG] && aPrevCloseFloat > 0) {
		resultString = [NSString stringWithFormat:@"%.3f", aPrevCloseFloat];
	}
	
	return resultString;
}

+(NSString *)floatAvgPriceToString:(float)aAvgPriceFloat market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
        if(aAvgPriceFloat >= 0){
            resultString = [NSString stringWithFormat:@"%.3f", aAvgPriceFloat];
        } else {
            resultString = @"";
		}
	}
	
	return resultString;
}

+(NSString *)floatVolumeToString:(float)aVolumeFloat market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self amountToString:aVolumeFloat WithMinFractionDigits:3];
		if(aVolumeFloat < 1000){
			resultString = [self amountToString:aVolumeFloat WithMinFractionDigits:0];
		}
	}
	
	return resultString;
}

+(NSString *)floatTurnoverToString:(float)aTurnoverFloat market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self amountToString:aTurnoverFloat WithMinFractionDigits:3];
		if(aTurnoverFloat < 1000){
			resultString = [self amountToString:aTurnoverFloat WithMinFractionDigits:0];
		}
	}
	
	return resultString;
}

+(NSString *)doubleTurnoverToString:(double)aTurnoverDouble market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self amountToString:aTurnoverDouble WithMinFractionDigits:3];
		if(aTurnoverDouble < 1000){
			resultString = [self amountToString:aTurnoverDouble WithMinFractionDigits:0];
		}
	}
	
	return resultString;
}

//Stock only

+(NSString *)floatPEToString:(float)aPEFloat market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"%.3f", aPEFloat];
	}
	
	return resultString;
}

+(NSString *)floatYieldToString:(float)aYieldFloat market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"%.3f", aYieldFloat];
		if(aYieldFloat == INFINITY){
			resultString = MHLocalizedString(@"MHUtility.Yield.is.inf", nil);
		}
		
	}
	
	return resultString;
}


//Warrant / CBBC

+(NSString *)floatGearingToString:(float)aGearingFloat market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"%.3fx", aGearingFloat];
	}
	
	return resultString;
}

+(NSString *)floatPremiumToString:(float)aPremiumFloat market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"%.3f%%", aPremiumFloat];
	}
	
	return resultString;
}

+(int)convertMHLanguageToChartLang:(Language)aMHLanguage{
	int chartLanguage = 0;
	
	switch (aMHLanguage) {
		case LanguageEnglish:
			chartLanguage = 0;
			break;
		case LanguageTraditionalChinese:
			chartLanguage = 1;
			break;
		case LanguageSimpleChinese:
			chartLanguage = 2;
			break;
		case LanguageJapanese:
			chartLanguage = 3;
			break;
		default:
			chartLanguage = 0;
			break;
	}
	
	return chartLanguage;
}

+ (NSString *)intToTimeString:(int) time {
	NSMutableString *tmp = [NSMutableString stringWithFormat:@"%d",time];
	if([tmp length]<4){
		tmp = [NSMutableString stringWithFormat:@"0%@",tmp];
	}
	[tmp insertString: @":" atIndex:2];
	return tmp;
}

+ (NSString *)expiryDateToDate:(int) date {
	NSMutableString *tmp = [NSMutableString stringWithFormat:@"%d",date];
	if([tmp length]>4){
		[tmp insertString: @"-" atIndex:4];
	}
	if([tmp length]>7){
		[tmp insertString: @"-" atIndex:7];
	}
	return tmp;
}

+(NSString *)stringVolumeToDisplayableString:(NSString *)aString market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self amountToString:[aString doubleValue] WithMinFractionDigits:3];
		if([aString doubleValue] < 1000){
			resultString = [self amountToString:[aString doubleValue] WithMinFractionDigits:0];
		}
	}
	
	return resultString;
}


+(NSString *)stringIEPToDisplayableString:(NSString *)aString market:(NSString *)aMarket{
	
	if([aString floatValue]<=0){
		return @"";
	}
	
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self formatDecimalString:aString decPlace:3];
	}
	
	return resultString;
}

+(NSString *)stringIEVToDisplayableString:(NSString *)aString market:(NSString *)aMarket{
	
	if([aString floatValue]<=0){
		return @"";
	}
	
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self amountToString:[aString doubleValue] WithMinFractionDigits:3];
	}
	
	return resultString;
}

+(NSString *)stringVolatiliityToDisplayableString:(NSString *)aString market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self formatDecimalString:aString decPlace:3];
		resultString = [NSString stringWithFormat:@"%@%%", resultString];
	}
	
	return resultString;
}

+(NSString *)stringAuthSharesToDisplayableString:(NSString *)aString market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self amountToString:[aString doubleValue] WithMinFractionDigits:3];
		if([aString doubleValue] == 0){
			resultString = @"";
		}
	}
	
	return resultString;
}

+(NSString *)stringSharesIssuedToDisplayableString:(NSString *)aString market:(NSString *)aMarket{
    if([aString floatValue]>0){
        NSString *resultString = nil;
        
        if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
            resultString = [self amountToString:[aString doubleValue] WithMinFractionDigits:3];
        }
        
        return resultString;
    }else{
        return @"";
    }
}

+(NSString *)intSymbolToDisplayableString:(int)aSymbol market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [NSString stringWithFormat:@"%05d", aSymbol];
	}
	
	return resultString;
}

+(NSString *)stringMarketCapToDisplayableString:(NSString *)aString market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		resultString = [self amountToString:[aString doubleValue] WithMinFractionDigits:3];
	}
	
	return resultString;
}

// 20110427 added:
// return example: $123,456,789.00
+(NSString *)doubleMoneyValueToDisplayableString:(double)aMoneyValue market:(NSString *)aMarket{
	NSString *resultString = nil;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG]) {
		NSString *s = [NSString stringWithFormat:@"%lf", aMoneyValue];
		resultString = [self formatDecimalString:s decPlace:3];
	}
	
	return [NSString stringWithFormat:@"$%@", resultString];
}

+(void)UIViewsMoveY:(float)aPixal uiView:(UIView *)aUIView,... {
	
	NSMutableArray *aLotOfUIViews = [[NSMutableArray alloc] init];
	
	va_list args;
	va_start(args, aUIView);

	
	for (UIView *argUIView = aUIView; argUIView != nil; argUIView = va_arg(args, UIView*))
	{
		[aLotOfUIViews addObject:argUIView];
	}
	va_end(args);
	
	for (int i = 0; i < [aLotOfUIViews count]; i++) {
		UIView *a = [aLotOfUIViews objectAtIndex:i];
		a.frame = CGRectMake(a.frame.origin.x, a.frame.origin.y+aPixal,
							   a.frame.size.width, a.frame.size.height);
	}
	
	[aLotOfUIViews release];
}

+(BOOL)isSymbolInMarket:(NSString *)emmaXMLLinkSymbol market:(NSString *)aMarket{
	BOOL isThatMarket = NO;
	
	if ([self equalsIgnoreCase:aMarket anotherString:MARKET_HONGKONG] && emmaXMLLinkSymbol!= nil) {
		
		for (int i=0; i<[emmaXMLLinkSymbol length]; i++) {
			isThatMarket = YES;
			if (!isdigit([emmaXMLLinkSymbol characterAtIndex:i])) {
				isThatMarket = NO;
				return isThatMarket;
			}
		}
	}
	
	return isThatMarket;
}


+ (NSString *)applicationDocumentsDirectory {
	NSArray *paths						= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectoryPath	= [paths objectAtIndex:0];
	return documentsDirectoryPath;
}

+ (UIColor *)uicolorWithHexValue:(int)aColorCode {

	float r = ((Byte)(aColorCode>>16))/255.0;
	float g = ((Byte)(aColorCode>>8))/255.0;
	float b = ((Byte)(aColorCode))/255.0;
	return [UIColor colorWithRed:r
						   green:g
							blue:b
						   alpha:1];    
}

+ (UIColor *)uicolorWithHexValueString:(NSString *)aColorString {
	char    *s = (char *)malloc(sizeof(char) * [aColorString length]+1);
	snprintf(s, [aColorString length]+1, "%s",[aColorString UTF8String]);
	int color = strtol(s, NULL, 16);
	free(s);
	return [MHUtility uicolorWithHexValue:color];
}

//+ (NSString *)getCurrentTimeFrom1970{
//	///////////////////////////////////////////////////////////////
//	// 2011-02-11
//	// WARNING!! The below method has known bug 
//	// if the time Zone is set menually
//	///////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
//	
//	//Parse the date
//	NSDateFormatter *oDateParser = [[NSDateFormatter alloc] init];
//	NSString *tmpcurrentTime  = [MHUtility getCurrentTime];
//	NSString *currentTime = [tmpcurrentTime substringToIndex:[tmpcurrentTime length]-4];
//	NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
//	
//	[oDateParser setLocale:locale];
//	[oDateParser setDateFormat:@"dd MMM yyyy HH:mm:ss"];
//	[oDateParser setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"HKT"]];
//
//	//30 MAR 2011 11:10:59 HKT
////	[oDateParser setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:(8*60*60)]];
//	
//	
//	NSDate *oParsedDate = nil;
//	
//	if (currentTime != nil) {
//		oParsedDate = [oDateParser dateFromString:currentTime];
//
//	} else {
//		NSLog(@"Could not parse date");
//		oParsedDate = [NSDate date]; //Invalid date
//	}
//	
//	[oDateParser release];
//	
//	//Multiply by 1000 because Java Timestamps are returned in Milliseconds, while
//	//Objective-C timeIntervalSince1970 returns timestamp as Seconds
//	NSTimeInterval fServerTimestamp = [oParsedDate timeIntervalSince1970] * 1000;
//	NSString *sServerTimestamp = [NSString stringWithFormat:@"%.0f",fServerTimestamp];
//	
//	//NSLog(@"Server Timestamp: %@ Raw timestamp: %@",self.time,sServerTimestamp);
//	//Parse the password
//	
//	///////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//	/////// End //////////////////of\\\\\\\\\\\ WARNING \\\\\\\\\\\
//	///////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//	
//	return sServerTimestamp;
//    
//    return @""; //TODO:XXX
//}


// input 20 Apr 2012 10:13:57
// return 20110122130000
+ (NSString *)getCurrentTimeNum:(NSString *)today {
    
    NSString *alphaMon = [today substringWithRange:NSMakeRange(3, 3)];
    int month = 0;
    if ([alphaMon caseInsensitiveCompare:@"JAN"] == NSOrderedSame) {
        month = 1;
    } else if ([alphaMon caseInsensitiveCompare:@"FEB"] == NSOrderedSame) {
        month = 2;
    } else if ([alphaMon caseInsensitiveCompare:@"MAR"] == NSOrderedSame) {
        month = 3;
    } else if ([alphaMon caseInsensitiveCompare:@"APR"] == NSOrderedSame) {
        month = 4;
    } else if ([alphaMon caseInsensitiveCompare:@"MAY"] == NSOrderedSame) {
        month = 5;
    } else if ([alphaMon caseInsensitiveCompare:@"JUN"] == NSOrderedSame) {
        month = 6;
    } else if ([alphaMon caseInsensitiveCompare:@"JUL"] == NSOrderedSame) {
        month = 7;
    } else if ([alphaMon caseInsensitiveCompare:@"AUG"] == NSOrderedSame) {
        month = 8;
    } else if ([alphaMon caseInsensitiveCompare:@"SEP"] == NSOrderedSame) {
        month = 9;
    } else if ([alphaMon caseInsensitiveCompare:@"OCT"] == NSOrderedSame) {
        month = 10;
    } else if ([alphaMon caseInsensitiveCompare:@"NOV"] == NSOrderedSame) {
        month = 11;
    } else if ([alphaMon caseInsensitiveCompare:@"DEC"] == NSOrderedSame) {        
        month = 12;
    }
    
    // 20 JAN 2012 16:04:31 HKT -> yyyyMMddkkmmss
    NSString *newDate = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                         [today substringWithRange:NSMakeRange(7, 4)],
                         [NSString stringWithFormat:@"%02d", month],
                         [today substringWithRange:NSMakeRange(0, 2)],
                         [today substringWithRange:NSMakeRange(12, 2)],
                         [today substringWithRange:NSMakeRange(15, 2)],
                         [today substringWithRange:NSMakeRange(18, 2)]];
    
    return newDate;
}



+ (NSString *)getOneDayChartEncryptionKey:(NSString *)aCurrentTimeFrom1970String{
	NSString *clearText = [NSString stringWithFormat:@"%@%@%@", @"MEGA",aCurrentTimeFrom1970String , @"HUB"];
	return [MHUtility md5HexDigest:clearText];
}

+ (NSString*)md5HexDigest:(NSString*)input {
		const char *cStr = [input UTF8String];
		unsigned char result[CC_MD5_DIGEST_LENGTH];
		CC_MD5( cStr, strlen(cStr), result );
	
		return [NSString stringWithFormat:
				@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
				result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
				result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
				];
}

+(NSString *)addSpaceInNSString:(NSMutableString *)aTargetString theMaximiumSpaceNumber:(int)aMaximiumSpaceNumber{
	NSMutableString *resultString = [[NSMutableString alloc] initWithString:aTargetString];
	
	if([resultString length]< aMaximiumSpaceNumber){
		NSInteger length = aMaximiumSpaceNumber-[resultString length];
		for(int i=0;i<length;i++){
			[resultString insertString:@" " atIndex:0];
		}
	}
	
	return 	[NSString stringWithString:[resultString autorelease]];	
}

+(NSString *)extractString:(NSString *)aString identifier:(NSString *)aIdentifier
{
    for (NSString *component in [aString componentsSeparatedByString:@"&"])
    {

        NSRange range=[component rangeOfString:aIdentifier];
		
        if (range.location==0) {
            return [component substringFromIndex:range.length];
        }
    }
    return nil;
}

+(NSString *)longlongQtyToDisplayableString:(long long)aQty market:(NSString *)aMarket{
	if([aMarket isEqualToString:MARKET_HONGKONG]){
		return [MHUtility formatDecimalString:[NSString stringWithFormat:@"%lld", aQty] decPlace:0];
	}
	
	return @"";
}

+(BOOL)isValidTGT:(NSString *)aTGTCode{
	BOOL r_isValid  = NO;
	
	if([aTGTCode hasPrefix:@"TGT"] || [aTGTCode hasPrefix:@"-1"]){
		r_isValid = YES;
	}
	
	return r_isValid;
}

+(BOOL)isValidValidation:(NSString *)aValidation{
	[aValidation retain];
	
	BOOL r_isValid  = NO;
	
	if([aValidation hasPrefix:@"ST-"]){
		r_isValid = YES;
	}
	
	[aValidation release];
	return r_isValid;
}

//+ (NSArray *)generatePricePickerForTradeInStreamer:(double)aPrice spreadType:(int)aSpreadType minSpreadPrice:(float)aMinSpreadPrice maxSpreadPrice:(float)aMaxSpreadPrice{
//	
//	NSMutableArray *resultArray = [[[NSMutableArray alloc] init] autorelease];
//	int tmpMinSpreadPrice = aMinSpreadPrice*1000;
//    int tmpMaxSpreadPrice = aMaxSpreadPrice*1000;
//	
//	if(aSpreadType>-1){
//		double targetPrice = aPrice;
//		
//		if(targetPrice*1000<=tmpMaxSpreadPrice){
//			for (int i = 0; i < 50; i++) {
//				if(targetPrice*1000>tmpMinSpreadPrice){
//					double m_dSpreadDn = [PTPDELEGATE getSpread:targetPrice type:aSpreadType];
//					targetPrice-=m_dSpreadDn;
//					[resultArray addObject:[MHUtility formatDecimalString:[NSString stringWithFormat:@"%f",targetPrice] decPlace:3]];
//				}else{
//					break;
//				}
//			}
//		}
//		
//		[resultArray insertObject:[MHUtility formatDecimalString:[NSString stringWithFormat:@"%f",aPrice] decPlace:3] atIndex:0];
//		targetPrice = aPrice;
//		
//		if(targetPrice*1000>=tmpMinSpreadPrice){
//			for (int i = 0; i < 50; i++) {
//				if(targetPrice*1000<tmpMaxSpreadPrice){
//					double m_dSpreadUp = [PTPDELEGATE getSpread:targetPrice+0.001 type:aSpreadType];
//					targetPrice+=m_dSpreadUp;
//					[resultArray insertObject:[MHUtility formatDecimalString:[NSString stringWithFormat:@"%f",targetPrice] decPlace:3] atIndex:0];
//				}else{
//					break;
//				}
//			}
//		}
//	}
//	
//	return [[resultArray reverseObjectEnumerator] allObjects];
//}

+ (NSArray *)generateQuantityForTrade:(long long)aQuantity lotSize:(long long)aLotSize{
	if(aQuantity % aLotSize != 0){
		return nil;
	}
	
	
	NSMutableArray *resultArray = [[[NSMutableArray alloc] init] autorelease];
	
	//lower
	for (int i = 0; i < 50; i++) {
		if(aLotSize > aQuantity - (aLotSize*i)){
			break;
		}
		
		[resultArray addObject:[MHUtility formatDecimalString:[NSString stringWithFormat:@"%lld", aQuantity-(aLotSize*i)]  decPlace:0]];
		
	}
	
	//upper
	for (int i = 1; i < 51; i++) {
		if(aQuantity + (aLotSize*i) > aQuantity + (aLotSize*100)){
			break;
		}
		
		[resultArray insertObject:[MHUtility formatDecimalString:[NSString stringWithFormat:@"%lld", aQuantity+(aLotSize*i)]  decPlace:0] atIndex:0];
		
	}
	
	return [[resultArray reverseObjectEnumerator] allObjects];
}


+ (BOOL)isNumber:(NSString *)s {
	NSUInteger len = [s length];
	NSUInteger i;
	BOOL status = NO;
	
	for(i=0; i < len; i++)
	{
		unichar singlechar = [s characterAtIndex: i];
		if ( (singlechar == ' ') && (!status) )
		{
			continue;
		}
		if ( ( singlechar == '+' ||
              singlechar == '-' ) && (!status) ) { status=YES; continue; }
		if ( ( singlechar >= '0' ) &&
            ( singlechar <= '9' ) )
		{
			status = YES;
		} else {
			return NO;
		}
	}
	return (i == len) && status;
}

+ (CGFloat)getScreenWidth {
    
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)getScreenHeight {
    
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)getAppHeight {
    
    return [[UIScreen mainScreen] applicationFrame].size.height;
}

+ (CGFloat) getOriginY {
    return [MHUtility checkVersionGreater:@"7.0"] ? 20: 0;
}

//Add pixels from baseline based on the screen height of the new device.
//Baseline height = 480px
+ (CGFloat)convertHeightBasedOnCurrentDevice:(CGFloat)origHeight {
    
    CGFloat baselineDiff = [[UIScreen mainScreen] bounds].size.height - 480;
    return origHeight + baselineDiff;
}

@end
