//
//  LangUtil.h
//  BEA
//
//  Created by yaojzy on 4/27/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSLocalizedString(key, comment) \
[[LangUtil me] localizedStringForKey:(key) value:(comment)]

@interface LangUtil : NSObject
{
	NSString *language;
}
/**
 *  return a LangUtil singleton
 *
 *  @return LangUtil singleton
 */
+ (LangUtil *)me;
/**
 *  Method for retrieving localized strings.read Localizable.strings through key to find value,adapt to differetn language.
 *  Using NSLocalizedString(key, comment) to call this method
 *
 *  @param key     key to find string
 *  @param comment nil
 *
 *  @return string in Localizable.strings for key
 */
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment;

//- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment table:(NSString *)tableName;


//- (void) setLanguage:(NSString*) language;

/**
 *  get the language of device
 *
 *  @return the language of device
 */
- (NSString*) getLanguage;

//- (void) resetLocalization;

//-(void)setLang2plist:(NSString*)langname;

//-(void)setTexts;

/**
 *  return prefix of language
 *
 *  @return "en" is English,"zh" is Chinese
 */
- (NSString *) getLangPref;

/**
 *  set app language from plist
 */
-(void)getLangFromplist;

/**
 *  Set English as the language of the app
 */
-(void)setLang_en;
/**
 *  Set Chinese traditional as the language of the app
 */
-(void)setLang_hant;
/**
 *  Set Chinese simple as the language of the app
 */
-(void)setLang_hans;


//- (NSString *)localizedStringForImage:(NSString *)key;

/**
 *  get different image of different language
 *
 *  @return the image of current language
 */
- (UIImage *)getImage:(NSString *)name;
/**
 *  get the mainPage from plist,default value is 1
 *
 *  @return the number of default mainpage
 */
- (NSString *) getDefaultMainpage;
/**
 *  set the default mainPage
 *
 *  @param defaultname the number of default mainPage
 */
-(void)setDefaultMainpage:(NSString*)defaultname;
/**
 *  Use Cyberbanking account or Use EAS account
 *
 *  @return "2" is EAS account "1" is Cyberbanking account
 */
- (NSString *) getDefaultAccount;
/**
 *  set using Cyberbanking account or Use EAS account
 *
 *  @param defaultname "2" is EAS account "1" is Cyberbanking account
 */
-(void)setDefaultAccount:(NSString*)defaultname;
/**
 *  the Id of language
 *
 *  @return "1" is English ,"2" is Chinese
 */
- (NSString *) getLangID;
/**
 *  get the path of Settings.plist
 *
 *  @return path of Settings.plist
 */
+ (NSString *)getDocSettingFilePath;

@end
