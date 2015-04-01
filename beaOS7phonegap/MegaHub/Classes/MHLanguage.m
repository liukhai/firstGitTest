//
//  MHLanguage.m
//  AyersGTS
//
//  Created by Hong on 07/11/2010.
//  Copyright 2010 MegaHub. All rights reserved.
//

/*
 Version: 2010_01_03
	- Fixed: get wrong language when using default language
	- Added: get LocalizaliedImage
 
 
 */


#import "MHLanguage.h"
#import "LangUtil.h"

#define IMAGE_LANGUAGE_PROFIX_ENGLISH					@"_en"
#define IMAGE_LANGUAGE_PROFIX_TRADITIONAL_CHINESE		@"_tw"
#define IMAGE_LANGUAGE_PROFIX_SIMPLE_CHINESE			@"_cn"
#define IMAGE_LANGUAGE_PROFIX_JAPANESE					@"_jp"

#define MHLANGUAGE_HAVE_JAPANESE						0

static NSBundle *bundle = nil;
static int currentLanguage = LanguageDefault;

@implementation MHLanguage

// the image name should be in the following 
// name_en.png
// en for English
// cn for Simple Chinese
// tw for Tradition chinese
// jp for Japanese
+ (UIImage *)getImage:(NSString *)name {
	
	NSArray *nameArray		= [name componentsSeparatedByString:@"."];
	if ([nameArray count] < 2) {
		return nil;
	}
	NSString *imageName		= [nameArray objectAtIndex:0];
	NSString *imageExt		= [nameArray objectAtIndex:1];
	NSString *langProfix	= nil;
	
	switch (currentLanguage) {
		case LanguageEnglish:				langProfix = IMAGE_LANGUAGE_PROFIX_ENGLISH;					break;
		case LanguageSimpleChinese:			langProfix = IMAGE_LANGUAGE_PROFIX_SIMPLE_CHINESE;			break;
		case LanguageTraditionalChinese:	langProfix = IMAGE_LANGUAGE_PROFIX_TRADITIONAL_CHINESE;		break;
#if MHLANGUAGE_HAVE_JAPANESE
		case LanguageJapanese:				langProfix = IMAGE_LANGUAGE_PROFIX_JAPANESE;				break;
#endif
			
		default: 
			// if unknown, set auto
			NSLog(@"Set language, Unknown language: %d", currentLanguage);
		case LanguageDefault: {
			
			NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
			NSArray *array = [preferences objectForKey:@"AppleLanguages"];
			if (array != nil && [array count] >= 1) {
				NSString *languageString = [array objectAtIndex:0];
				if ([languageString caseInsensitiveCompare:@"en"] == NSOrderedSame ||		// English
					[languageString caseInsensitiveCompare:@"en-GB"] == NSOrderedSame ||
					[languageString caseInsensitiveCompare:@"english"] == NSOrderedSame) {	// British English
					langProfix = IMAGE_LANGUAGE_PROFIX_ENGLISH;
					
				} else if ( [languageString caseInsensitiveCompare:@"zh-Hant"] == NSOrderedSame ||
						   [languageString caseInsensitiveCompare:@"zh_TW"] == NSOrderedSame) {
					langProfix = IMAGE_LANGUAGE_PROFIX_TRADITIONAL_CHINESE;
					
				} else if( [languageString caseInsensitiveCompare:@"zh-Hans"] == NSOrderedSame ||
						  [languageString caseInsensitiveCompare:@"zh_CN"] == NSOrderedSame) {
					langProfix = IMAGE_LANGUAGE_PROFIX_SIMPLE_CHINESE;
#if MHLANGUAGE_HAVE_JAPANESE
				} else if ( [languageString caseInsensitiveCompare:@"ja"] == NSOrderedSame ) {
					langProfix = IMAGE_LANGUAGE_PROFIX_JAPANESE;
#endif
				} else {
					langProfix = IMAGE_LANGUAGE_PROFIX_TRADITIONAL_CHINESE;
				}
			}
		}
	}
	
	UIImage *returnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.%@", imageName, langProfix, imageExt]];
	if (returnImage == nil) {
		return [UIImage imageNamed:name];
	} else {
		return returnImage;
	}
}

//-------------------------------------------------------------------------------
+ (void)setLanguage:(Language)newLanguage {
	currentLanguage = newLanguage;
	
	NSString *path = nil, *languageText = nil;
	switch (currentLanguage) {
		case LanguageEnglish:	
			languageText = LANGUAGE_ENGLISH;	
			break;
			
		case LanguageSimpleChinese:	
			languageText = LANGUAGE_SIMPLE_CHINESE;	
			break;
			
		case LanguageTraditionalChinese:
			languageText = LANGUAGE_TRADITIONAL_CHINESE;	
			break;
			
		case LanguageJapanese:
			languageText = LANGUAGE_JAPANESE;
			break;
			
		default: // if unknown, set auto
		case LanguageDefault: {
            NSString *langStr = [[LangUtil me] getLangPref];
            if([langStr isEqualToString:@"en"]){
                languageText = LANGUAGE_ENGLISH;
            }else{
                languageText = LANGUAGE_TRADITIONAL_CHINESE;
            }
		}
	}
    
	path = [[NSBundle mainBundle] pathForResource:languageText ofType:@"lproj" ];
	[bundle release];
	bundle = [[NSBundle bundleWithPath:path] retain];
}

//-------------------------------------------------------------------------------
+ (Language)getDeviceLanguage {
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	NSArray *array = [preferences objectForKey:@"AppleLanguages"];
	if (array != nil && [array count] >= 1) {
		NSString *languageString = [array objectAtIndex:0];
		if ([languageString caseInsensitiveCompare:@"en"] == NSOrderedSame ||		// English
			[languageString caseInsensitiveCompare:@"en-GB"] == NSOrderedSame ||
			[languageString caseInsensitiveCompare:@"english"] == NSOrderedSame) {	// British English
			return LanguageEnglish;
			
		} else if ( [languageString caseInsensitiveCompare:@"zh-Hant"] == NSOrderedSame ||
				   [languageString caseInsensitiveCompare:@"zh_TW"] == NSOrderedSame) {
			return LanguageTraditionalChinese;
						
		} else if( [languageString caseInsensitiveCompare:@"zh-Hans"] == NSOrderedSame ||
				  [languageString caseInsensitiveCompare:@"zh_CN"] == NSOrderedSame) {
			return LanguageSimpleChinese;
#if MHLANGUAGE_HAVE_JAPANESE		
		} else if ( [languageString caseInsensitiveCompare:@"ja"] == NSOrderedSame ) {
				return LanguageJapanese;
#endif				
		} else {					
			return LanguageUnknown;
		}
	}
	return LanguageUnknown;
}

//-------------------------------------------------------------------------------
+ (Language)getCurrentLanguage {
    NSString *langStr = [[LangUtil me] getLangPref];
    if([langStr isEqualToString:@"en"]){
        currentLanguage = LanguageEnglish;
    }else{
        currentLanguage = LanguageTraditionalChinese;
    }
	return currentLanguage;
}

//-------------------------------------------------------------------------------
+ (NSString *)getText:(NSString *)key defaultText:(NSString *)defaultText {
	NSString *text;
	NSString *company_key = [NSString stringWithFormat:@"company.%@",key];
	if (bundle == nil) { // Auto
		
		text = [[NSBundle mainBundle] localizedStringForKey:company_key value:defaultText table:nil];
		if ([text caseInsensitiveCompare:company_key] == NSOrderedSame) {
			// cannot find, load default
			text = [[NSBundle mainBundle] localizedStringForKey:key value:defaultText table:nil];
		}
	} else {
		
		text = [bundle localizedStringForKey:company_key value:defaultText table:nil];
		if ([text caseInsensitiveCompare:company_key] == NSOrderedSame) {
			// cannot find, load default
			text = [bundle localizedStringForKey:key value:defaultText table:nil];
		}

	}
	
	if (text == nil) { // defaultText is nil or key not exist
		text = [NSString stringWithFormat:@"[%@]", key];
	}
	return text;
}

//-------------------------------------------------------------------------------
// the file shoule be without .strings
+ (NSString *)getText:(NSString *)key defaultText:(NSString *)defaultText file:(NSString *)fileName {
	
	NSString *text;
	NSString *company_key = [NSString stringWithFormat:@"company.%@",key];
	if (bundle == nil) { // Auto
		
		text = [[NSBundle mainBundle] localizedStringForKey:company_key value:defaultText table:fileName];
		if ([text caseInsensitiveCompare:company_key] == NSOrderedSame) {
			// cannot find, load default
			text = [[NSBundle mainBundle] localizedStringForKey:key value:defaultText table:fileName];
		}
	} else {
		
		text = [bundle localizedStringForKey:company_key value:defaultText table:fileName];
		if ([text caseInsensitiveCompare:company_key] == NSOrderedSame) {
			// cannot find, load default
			text = [bundle localizedStringForKey:key value:defaultText table:fileName];
		}
		
	}
	
	if (text == nil) { // defaultText is nil or key not exist
		text = [NSString stringWithFormat:@"[%@]", key];
	}
	return text;
}

//-------------------------------------------------------------------------------
+ (Language)loadSettingLanguage {
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	if (preferences == nil) {return LanguageDefault;}
	
	NSString *key = SAVEKEY_LANGUAGE;
	NSInteger languageIndex = [preferences integerForKey:key];
	
	[self setLanguage:languageIndex];
	
	return languageIndex;
}

+ (void)saveSettingLanguage {
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	if (preferences) {
        [preferences setInteger:currentLanguage forKey:SAVEKEY_LANGUAGE];
        [preferences synchronize];
    }
}

@end
