//
//  MHLanguage.h
//  AyersGTS
//
//  Created by Hong on 07/11/2010.
//  Copyright 2010 MegaHub. All rights reserved.
//

/*
 Version: 2011_05_05
	- Added: [MHLanguage getText:(key) defaultText:(comment) file:(file)]
 
 Version: 2011_03_24
	- Added: + (Language)getDeviceLanguage;
	- Added: Japnese support
 
 Version: 2010_01_03
	- Fixed: get wrong language when using default language
	- Added: get LocalizaliedImage
 
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
	LanguageUnknown					= -1,
	LanguageDefault					= 0,	
	LanguageEnglish					= 1,
	LanguageTraditionalChinese		= 2,
	LanguageSimpleChinese			= 3,
	LanguageJapanese				= 4
}Language;

#define LANGUAGE_ENGLISH				@"en"
#define LANGUAGE_TRADITIONAL_CHINESE	@"zh-Hant"
#define LANGUAGE_SIMPLE_CHINESE			@"zh-Hans"
#define LANGUAGE_JAPANESE				@"jp"

#define SAVEKEY_LANGUAGE							@"Language"
#define SAVEKEY_USE_TIME							@"useTime"

#define MHLocalizedString(key, comment) \
[MHLanguage getText:(key) defaultText:(comment)]

#define MHLocalizedStringFile(key, comment, aFile) \
[MHLanguage getText:(key) defaultText:(comment) file:(aFile)]


// 2010_12_08
// for images
#define MHGetLocalizedImageNamed(key) \
[MHLanguage getImage:(key)]

@interface MHLanguage : NSObject {

}

// 2010_12_08 Hong
+ (UIImage *)getImage:(NSString *)name;

//-------------------------------------------------------------------------------
//1. loadSettingLangauge (Display Langauage) default English
//2. getCurrentLangauge (Display Langauge)
//3. setLangauage (New Display Language)
+ (void)setLanguage:(Language)languageType;
+ (Language)getDeviceLanguage;
+ (Language)getCurrentLanguage;
+ (NSString*)getText:(NSString *)key defaultText:(NSString *)defaultText;
+ (NSString *)getText:(NSString *)key defaultText:(NSString *)defaultText file:(NSString *)fileName;
+ (Language)loadSettingLanguage;
+ (void)saveSettingLanguage ;

@end
