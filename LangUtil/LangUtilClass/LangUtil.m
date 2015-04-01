//
//  LangUtil.m
//  BEA
//
//  Created by yaojzy on 4/27/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

// 20140313 7:17pm

#import "LangUtil.h"


@implementation LangUtil

static NSBundle *bundle = nil;
static LangUtil *_me = nil;

+ (LangUtil *)me
{
	@synchronized(self)
	{
		if (!_me)
			[[self alloc] init];
		
		return _me;
	}
	return nil;
}

+(id)alloc
{
	@synchronized([LangUtil class])
	{
		_me = [super alloc];
		return _me;
	}
	return nil;
}

- (id)init
{
    if ((self = [super init])) 
    {
		bundle = [NSBundle mainBundle];
        if (![LangUtil settingFileExists]){
			[LangUtil copySettingFile];
		}

	}
    return self;
}

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment
{
	return [bundle localizedStringForKey:key value:comment table:nil];
}

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment table:(NSString *)tableName
{
	return [bundle localizedStringForKey:key value:comment table:tableName];
}

- (NSString *)localizedStringForImage:(NSString *)key
{
	return [bundle pathForResource:key ofType:@""];
}

- (UIImage *)getImage:(NSString *)name
{
    NSString * path = [[LangUtil me] localizedStringForImage:name];    
    NSData *image_data = [NSData dataWithContentsOfFile:path];
    return[UIImage imageWithData:image_data];    
}

- (void) setLanguage:(NSString*) langname{

	NSString *path = [[ NSBundle mainBundle ] pathForResource:langname ofType:@"lproj" ];
	  
	if (path == nil) {
		[self resetLocalization];
    }else {
        bundle = [[NSBundle bundleWithPath:path] retain];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeLanguage" object:self userInfo:@{@"Lang":NSLocalizedString(@"lang",nil)}];
   
//    [CoreData sharedCoreData].lang = NSLocalizedString(@"lang",nil);
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"notification_onOroff"]) {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
//    }
}

- (NSString*) getLanguage{
    
	NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    
	NSString *preferredLang = [languages objectAtIndex:0];
    
	return preferredLang;
}

- (void) resetLocalization
{
	bundle = [NSBundle mainBundle];
}


- (NSString *) getLangPref
{
    NSMutableDictionary *user_setting = [NSMutableDictionary dictionaryWithContentsOfFile:[LangUtil getDocSettingFilePath]];
    NSString* langname = [user_setting objectForKey:@"lang_ind_selected"];
    NSString *langPref = @"en";
    if (!langname) {
        langname = NSLocalizedString(@"lang",nil);
        if ([langname hasPrefix:@"zh"]) {
            langPref = @"zh";
        }
        langname = langPref;
    }
//    NSLog(@"debug LangUtil getLangPref:%@", langname);
    return langname;
}

- (NSString *) getLangID
{
    NSString* langStr = [[LangUtil me] getLangPref];
	NSString * langPref = @"1";
    if ([langStr hasPrefix:@"zh"]) {
        langPref = @"2";
    }
    NSLog(@"debug LangUtil getLangID:%@", langPref);
	return langPref;
//    NSLog(@"debug LangUtil getLangID:%@", langStr);
//	return langStr;
}

-(void)setLang2plist:(NSString*)langname
{
    NSLog(@"debug setLang2plist:%@", langname);
    NSMutableDictionary *setting = [NSMutableDictionary dictionaryWithContentsOfFile:[LangUtil getDocSettingFilePath]];
    [setting setObject:langname forKey:@"lang_ind_selected"];
    [setting writeToFile:[LangUtil getDocSettingFilePath] atomically:YES];
    [self setTexts];
    
}

-(void)setTexts
{
	NSString* path = [[NSBundle mainBundle] pathForResource:[self getLangPref] ofType:@"lproj" ];
	[bundle release];
	bundle = [[NSBundle bundleWithPath:path] retain];


    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeLanguage" object:self userInfo:@{@"Lang":NSLocalizedString(@"lang",nil)}];
    
//    [CoreData sharedCoreData].lang = NSLocalizedString(@"lang",nil);
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"notification_onOroff"]) {
//      [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
//    }
//    [[CoreData sharedCoreData].bea_view_controller setTexts];
//    [[InsuranceUtil me].Insurance_view_controller setTexts];
//    [[CoreData sharedCoreData]._PropertyLoanViewController setTexts];
//    [[MPFUtil me].MPF_view_controller setTexts];
//    [[MPFUtil me]._MPFImportantNoticeViewController setTexts];
//    [(RootViewController*)[[InsuranceUtil me].Insurance_view_controller.navigationController.viewControllers objectAtIndex:0] setTexts];
//    [(RootViewController*)[[CoreData sharedCoreData]._PropertyLoanViewController.navigationController.viewControllers objectAtIndex:0] setTexts];
//    [(RootViewController*)[[MPFUtil me].MPF_view_controller.navigationController.viewControllers objectAtIndex:0] setTexts];
//    [[CyberFundSearchUtil me]._CyberFundSearchImportantNoticeViewController setTexts];
//     [[CyberFundSearchUtil me].CyberFundSearch_view_controller setTexts];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    exit(0);
}

-(void)getLangFromplist
{
    NSMutableDictionary *user_setting = [NSMutableDictionary dictionaryWithContentsOfFile:[LangUtil getDocSettingFilePath]];
    NSString *langname = [user_setting objectForKey:@"lang_ind_selected"];

    NSLog(@"debug getLangFromplist:%@", langname);
    
    [self setLanguage:langname];
    
//    [CoreData sharedCoreData].lang = NSLocalizedString(@"lang",nil);

//    NSLog(@"debug getLangFromplist 2:%@", [CoreData sharedCoreData].lang);

}


-(void)setLang_en
{
    [[LangUtil me] setLang2plist:@"en"];
}

-(void)setLang_hant
{
    [[LangUtil me] setLang2plist:@"zh-Hant"];
}

-(void)setLang_hans
{
    [[LangUtil me] setLang2plist:@"zh-Hans"];
}

- (NSString *) getDefaultMainpage
{
    NSMutableDictionary *user_setting = [NSMutableDictionary dictionaryWithContentsOfFile:[LangUtil getDocSettingFilePath]];
    NSString* langname = [user_setting objectForKey:@"default_mainpage"];
    if (!langname) {
        langname = @"1";
    }
    return langname;
}

-(void)setDefaultMainpage:(NSString*)defaultname
{
    NSMutableDictionary *setting = [NSMutableDictionary dictionaryWithContentsOfFile:[LangUtil getDocSettingFilePath]];
    [setting setObject:defaultname forKey:@"default_mainpage"];
    [setting writeToFile:[LangUtil getDocSettingFilePath] atomically:YES];
}

- (NSString *) getDefaultAccount
{
    NSMutableDictionary *user_setting = [NSMutableDictionary dictionaryWithContentsOfFile:[LangUtil getDocSettingFilePath]];
    NSString* langname = [user_setting objectForKey:@"default_account"];
    if (!langname) {
        langname = @"1";
    }
    return langname;
}

-(void)setDefaultAccount:(NSString*)defaultname
{
    if (!defaultname) {
        defaultname = @"1";
    }
    NSMutableDictionary *setting = [NSMutableDictionary dictionaryWithContentsOfFile:[LangUtil getDocSettingFilePath]];
    [setting setObject:defaultname forKey:@"default_account"];
    [setting writeToFile:[LangUtil getDocSettingFilePath] atomically:YES];
}

+ (BOOL)settingFileExists
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *newFilePath = [documentsDirectory stringByAppendingPathComponent:@"Settings.plist"];
	NSLog(@"settingFileExists:%@---%d", newFilePath, [[NSFileManager defaultManager] fileExistsAtPath:newFilePath]);
    
	return [[NSFileManager defaultManager] fileExistsAtPath:newFilePath];
}

+ (void)copySettingFile {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *newFilePath = [documentsDirectory stringByAppendingPathComponent:@"Settings.plist"];
	NSString *oldfilePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    
	[[NSFileManager defaultManager] copyItemAtPath:oldfilePath
											toPath:newFilePath
											 error:NULL];
	if ([[NSFileManager defaultManager] fileExistsAtPath:newFilePath]){
		NSLog(@"copySettingFile created:%@", newFilePath);
	}else {
		NSLog(@"copySettingFile fail:%@", newFilePath);
	}
}

+ (NSString *)getDocSettingFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Settings.plist"];
//    NSLog(@"debug getDocSettingFilePath:%@", filePath);
    
	return filePath;
}

@end
