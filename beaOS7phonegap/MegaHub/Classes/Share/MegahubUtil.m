//
//  MegahubUtil.m
//  MagicTraderChief
//
//  Created by ChiYin on 17/08/2010.
//  Copyright 2010 Megahub. All rights reserved.
//

#import "MegahubUtil.h"


@implementation MegahubUtil

+ (NSLocale *) defaultLocale {
	
	static NSLocale *oLocale = nil;
	
	if (oLocale == nil) {
		//const unsigned int zh_hk = 3076;
		
		//oLocale = [[NSLocale localeIdentifierFromWindowsLocaleCode:zh_hk] retain];
		
		oLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	}
	
	return oLocale;
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

+ (NSString *) formatDecimalPercentageString:(NSString *)input {
	
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
		//[formatter setNegativePrefix:@"("];
		//[formatter setNegativeSuffix:@"%)"];
	}
	
	NSDecimalNumber *dDecNum = [NSDecimalNumber decimalNumberWithString:input];
	
	NSString *sFormattedStr = [formatter stringFromNumber:dDecNum];
	//if ([dDecNum compare:[NSDecimalNumber zero]] == NSOrderedAscending) {
	//	return sFormattedStr;
	//} 
	
	return [NSString stringWithFormat:@"%@%%",sFormattedStr];
}


#pragma mark -
#pragma mark String / Numeric Formatting Methods

+ (NSString *) formatDecimalCurrencyNumber:(NSNumber *)input Unit:(NSString *)aCUnit {
	
	if (input == nil) {
		return @"";
	}
	
	if (aCUnit == nil) {
		aCUnit = @"";
	}
	
	static NSNumberFormatter *formatter;
	
	if (formatter == nil) {
		
		formatter = [[NSNumberFormatter alloc] init];
		
		[formatter setLocale:[MegahubUtil defaultLocale]];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:3];
		[formatter setMinimumFractionDigits:3];
		[formatter setMinimumIntegerDigits:1];
		[formatter setNegativePrefix:@"("];
		[formatter setNegativeSuffix:@")"];
	}
	[formatter setCurrencyCode:aCUnit];
	
	return [NSString stringWithFormat:@"%@ %@",[formatter stringFromNumber:input],aCUnit];
	
}


+ (NSString *) formatDecimalCurrencyString:(NSString *)input Unit:(NSString *)aCUnit {
	
	if (input == nil) {
		return @"";
	}
	
	if (aCUnit == nil) {
		aCUnit = @"";
	}
	
	static NSNumberFormatter *formatter;
	
	if (formatter == nil) {
		
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setLocale:[MegahubUtil defaultLocale]];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:3];
		[formatter setMinimumFractionDigits:3];
		[formatter setMinimumIntegerDigits:1];
		[formatter setNegativePrefix:@"("];
		[formatter setNegativeSuffix:@")"];

	}
	
	NSLog(@"Number of min digits: %d",[formatter minimumFractionDigits]);
	NSLog(@"Number of sig digits: %d",[formatter maximumSignificantDigits]);
	
	[formatter setCurrencyCode:aCUnit];
	
	NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:input];
	return [NSString stringWithFormat:@"%@ %@",[formatter stringFromNumber:decNum],aCUnit];
	
}

+ (NSString *) formatDecimalInteger:(NSNumber *)input {
	
	if (input == nil) {
		return @"";
	}
	
	static NSNumberFormatter *formatter = nil;
	
	if (formatter == nil) {
		
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setLocale:[MegahubUtil defaultLocale]];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:0];
	}
	
	return [formatter stringFromNumber:input];
	
}

+ (NSString *) formatDecimalIntegerString:(NSString *)input {
	
	if ([input length] == 0) {
		return @"";
	}
	
	static NSNumberFormatter *formatter = nil;
	
	if (formatter == nil) {
		
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setLocale:[MegahubUtil defaultLocale]];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:0];
	}
		
	NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:[MegahubUtil removeComma:input]];
	return [formatter stringFromNumber:decNum];
	
}

+ (NSString *) formatDecimalString:(NSString *) input {
	
	return [MegahubUtil formatDecimalString:input prettyFormat:YES];
	
}

+ (NSString *) formatDecimalString:(NSString *) input prettyFormat:(BOOL)aPrettyFormat {
	
	if ([input length] == 0) {
		return @"";
	}
	
	NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:[MegahubUtil removeComma:input]];
	return [MegahubUtil formatDecimal:decNum prettyFormat:aPrettyFormat];
	
}

+ (NSString *) formatDecimal:(NSNumber *) input {
	
	if (input == nil) {
		return @"";
	}
	
	static NSNumberFormatter *formatter = nil;
	
	if (formatter == nil) {
		
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setLocale:[MegahubUtil defaultLocale]];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:3];
		[formatter setMinimumFractionDigits:3];
		[formatter setMinimumIntegerDigits:1];
	}
	
	return [formatter stringFromNumber:input];
	
}

+ (NSString *) formatDecimal:(NSDecimalNumber *) input prettyFormat:(BOOL)aPrettyFormat {
	
	if (input == nil) {
		return @"";
	}
	
	static NSNumberFormatter *formatter = nil;
	
	if (formatter == nil) {
		
		NSLocale *oLocale = [MegahubUtil defaultLocale];
		
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setLocale:oLocale];
		[formatter setMaximumFractionDigits:3];
		[formatter setMinimumFractionDigits:3];
		[formatter setMinimumIntegerDigits:1];
	}
	
	if (aPrettyFormat) {
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	} else {
		[formatter setNumberStyle:NSNumberFormatterNoStyle];
	}
	
	return [formatter stringFromNumber:input];
	
}

+ (NSString *) formatDecimal:(NSNumber *) input decPlace:(NSUInteger)aDecPlace {
	
	if (input == nil) {
		return @"";
	}
	
	static NSNumberFormatter *formatter = nil;
	
	if (formatter == nil) {
		
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setLocale:[MegahubUtil defaultLocale]];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:aDecPlace];
		[formatter setMinimumFractionDigits:aDecPlace];
		[formatter setMinimumIntegerDigits:1];
	}
	
	return [formatter stringFromNumber:input];
	
}

+ (NSString *) formatDecimalString:(NSString *)input decPlace:(NSInteger) aDecPlace {
	
	if (input == nil) {
		return @"";
	}
	
	static NSNumberFormatter *formatter;
	
	if (formatter == nil) {
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setLocale:[MegahubUtil defaultLocale]];
	}
	
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:aDecPlace];
	[formatter setMinimumFractionDigits:aDecPlace];
	[formatter setMinimumIntegerDigits:1];
	
	NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:input];
	return [formatter stringFromNumber:decNum];
	
}

+ (NSString *) formatOctODateStringToDate:(NSString *)outFormat input:(NSString *)input {
	
	if (input == nil) {
		return @"";
	}
	
	if (outFormat == nil) {
		outFormat = @"dd-MM-yyyy HH:mm:ss";
	}
	
	static NSDateFormatter *parser = nil;
	static NSDateFormatter *formatter = nil;
	
	if (parser == nil) {
		parser = [[NSDateFormatter alloc] init];
		[parser setDateFormat:@"ddMMyyyyHHmmss"];
		formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:outFormat];
	}
	
	NSDate *parsedDate = [parser dateFromString:input];
	return [formatter stringFromDate:parsedDate];
}

+ (NSString *) timestampStringToDate:(NSString *)outFormat input:(NSString *)input {
	
	NSTimeInterval fTimestamp = [input doubleValue];
	
	if (outFormat == nil) {
		outFormat = @"dd-MM-yyyy HH:mm:ss";
	}
	
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:fTimestamp];
	
	static NSDateFormatter *formatter = nil;
	
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:outFormat];
	
	return [formatter stringFromDate:date];
}

#pragma mark Stock Padding

+ (NSString *) padSymbolToLength:(NSString *)symbol length:(NSUInteger)len {
	
	if ([symbol length] > len) {
		return [symbol substringToIndex:len];
	}
	
	NSMutableString *tmp = [NSMutableString stringWithString:symbol];
	
	while ([tmp length] < len) {
		[tmp insertString:@"0" atIndex:0];
	}
	
	return [NSString stringWithString:tmp];
}

+ (NSString *) formatHKStockCode:(NSString *)input {
	
	NSDecimalNumber *dec = [NSDecimalNumber decimalNumberWithString:input];
	
	if (![dec isEqualToNumber:[NSDecimalNumber notANumber]]) {
		NSUInteger stockInt = [input intValue];
		return [NSString stringWithFormat:@"%d.HK",stockInt];
	} else {
		return nil;
	}
}

#pragma mark -
#pragma mark Misc Functions

+ (void)callPhoneNumber:(NSString *)number {
	
	NSString *callUrlStr = [NSString stringWithFormat:@"tel:%@",number];
	
	NSURL *url = [NSURL URLWithString:callUrlStr];
	[[UIApplication sharedApplication] openURL:url]; 
	
}



NSString* amountToString(double qty) {
	
    static const char units[] = { '\0', 'K', 'M', 'B', 'T', 'P', 'E', 'Z', 'Y' };
    static int maxUnits = sizeof units - 1;
	
    int multiple = 1000;
    int exponent = 0;
	
    while (qty >= multiple && exponent < maxUnits) {
        qty /= multiple;
        exponent++;
    }
    NSNumberFormatter* formatter = [[[NSNumberFormatter alloc] init] autorelease];
    [formatter setMaximumFractionDigits:3];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	
    // Beware of reusing this format string. -[NSString stringWithFormat] ignores \0, *//printf does not.
    return [NSString stringWithFormat:@"%@%c", [formatter stringFromNumber: [NSNumber numberWithDouble: qty]], units[exponent]];
}

NSString* amountToStringWithMinFractionDigits(double qty, int minFractionDigits) {
	
    static const char units[] = { '\0', 'K', 'M', 'B', 'T', 'P', 'E', 'Z', 'Y' };
    static int maxUnits = sizeof units - 1;
	
    int multiple = 1000;
    int exponent = 0;
	
    while (qty >= multiple && exponent < maxUnits) {
        qty /= multiple;
        exponent++;
    }
    NSNumberFormatter* formatter = [[[NSNumberFormatter alloc] init] autorelease];
    [formatter setMaximumFractionDigits:3];
	[formatter setMinimumFractionDigits:minFractionDigits];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	
    // Beware of reusing this format string. -[NSString stringWithFormat] ignores \0, *//printf does not.
    return [NSString stringWithFormat:@"%@%c", [formatter stringFromNumber: [NSNumber numberWithDouble: qty]], units[exponent]];
}

+ (BOOL)stringToBool:(NSString *)string {
	if ([@"YES" isEqualToString:[string uppercaseString]]) {
		return YES;
	} else {
		return NO;
	}
}

#pragma mark NSData to Hex String Encoding / Decoding

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

#pragma mark Base 64 Encoding 

+ (NSString *)Base64Encode:(NSData *)data {
	//Point to start of the data and set buffer sizes
	int inLength = [data length];
	int outLength = ((((inLength * 4)/3)/4)*4) + (((inLength * 4)/3)%4 ? 4 : 0);
	const char *inputBuffer = [data bytes];
	char *outputBuffer = malloc(outLength+1);
	outputBuffer[outLength] = 0;
	
	//64 digit code
	static char Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	
	//start the count
	int cycle = 0;
	int inpos = 0;
	int outpos = 0;
	char temp;
	
	//Pad the last to bytes, the outbuffer must always be a multiple of 4
	outputBuffer[outLength-1] = '=';
	outputBuffer[outLength-2] = '=';
	
	/* http://en.wikipedia.org/wiki/Base64
	 Text content   M           a           n
	 ASCII          77          97          110
	 8 Bit pattern  01001101    01100001    01101110
	 
	 6 Bit pattern  010011  010110  000101  101110
	 Index          19      22      5       46
	 Base64-encoded T       W       F       u
	 */
	
	
	while (inpos < inLength){
		switch (cycle) {
			case 0:
				outputBuffer[outpos++] = Encode[(inputBuffer[inpos]&0xFC)>>2];
				cycle = 1;
				break;
			case 1:
				temp = (inputBuffer[inpos++]&0x03)<<4;
				outputBuffer[outpos] = Encode[temp];
				cycle = 2;
				break;
			case 2:
				outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0)>> 4];
				temp = (inputBuffer[inpos++]&0x0F)<<2;
				outputBuffer[outpos] = Encode[temp];
				cycle = 3;                  
				break;
			case 3:
				outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0)>>6];
				cycle = 4;
				break;
			case 4:
				outputBuffer[outpos++] = Encode[inputBuffer[inpos++]&0x3f];
				cycle = 0;
				break;                          
			default:
				cycle = 0;
				break;
		}
	}
	NSString *pictemp = [NSString stringWithCString:outputBuffer encoding:NSASCIIStringEncoding];
	free(outputBuffer); 
	return pictemp;
}

+ (NSData *)convertBig5DataToUtf8Data:(NSData *)aoData {

	CFStringRef big5Str = CFStringCreateWithBytes(NULL, [aoData bytes], [aoData length], kCFStringEncodingBig5_HKSCS_1999, false);
	
	NSData *utf8Data = nil;
	if (NULL != big5Str) {
		
		NSString *big5String = (NSString *)big5Str;
		utf8Data = [big5String dataUsingEncoding:NSUTF8StringEncoding];
		
		CFRelease(big5Str);
	} 
	return utf8Data;
}

#pragma mark URLEncode / URLDecode

+ (NSString *)urlencode:(NSString *)source {
	
	NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(
														NULL,
														(CFStringRef)source,
														NULL,
														(CFStringRef)@"!*'();:@&=+$,/?%#[]",
														kCFStringEncodingUTF8 );
	return [encodedString autorelease];
}

+ (NSString *)urldecode:(NSString *)source {
	
	NSString *decodedString = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)source, (CFStringRef)@"", kCFStringEncodingUTF8);
	
	return [decodedString autorelease];
}

+ (NSString *) removeComma:(NSString *)aStringWithComma {
	if (aStringWithComma == nil) {
		return @"";
	}
	
	return [aStringWithComma stringByReplacingOccurrencesOfString:@"," withString:@""];
}

/* Strips the suffix from a stock symbol and returns it
 * e.g. 00005.HK will be stripped to 00005, useful if the datasource does not have a suffix. */

+ (NSString *) stripSuffixFromSymbol:(NSString *)asSymbol {
	
	NSScanner *oScanner = [NSScanner scannerWithString:asSymbol];
	NSString *sStrippedSymbol = nil;
	[oScanner scanUpToString:@"." intoString:&sStrippedSymbol];
	
	return sStrippedSymbol;
}

@end
