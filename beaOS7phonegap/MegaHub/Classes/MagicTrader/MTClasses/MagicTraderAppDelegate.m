//  Testing
//  MagicTraderAppDelegate.m
//  MagicTrader
//
//  Created by Megahub on 25/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MagicTraderAppDelegate.h"
#import "PTConstant.h"
#import "MHUtility.h"
#import "StyleConstant.h"

@implementation MagicTraderAppDelegate

static MagicTraderAppDelegate *sharedMagicTraderAppDelegate = nil;

+ (MagicTraderAppDelegate *)sharedMagicTraderAppDelegate {
	@synchronized(self) {
		if (sharedMagicTraderAppDelegate == nil) {
			sharedMagicTraderAppDelegate	= [[self alloc] init];
		}
	}
	
	return sharedMagicTraderAppDelegate;
}

- (oneway void)release {
}

- (id)autorelease { 
	return self;
}

- (NSUInteger)retainCount {
	return NSUIntegerMax;
}
- (id)retain {
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

//=============================================================================
+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedMagicTraderAppDelegate == nil) {
			sharedMagicTraderAppDelegate = [super allocWithZone:zone];
			return sharedMagicTraderAppDelegate;
		}
	}
	
	return nil;
}

//=============================================================================

-(id)init{
	if(self = [super init]){
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}

- (NSString *)loadChartDisclaimerFileName {
    NSString *fileName		= nil;
    switch ([MHLanguage getCurrentLanguage]) {
        case LanguageEnglish:
            fileName = @"mh_general_en";
            break;
        case LanguageTraditionalChinese:
            fileName = @"mh_general_tc";
            break;
        case LanguageSimpleChinese:
            fileName = @"mh_general_sc";
            break;
        case LanguageJapanese:
            fileName = @"mh_general_jp";
            break;
        default:
            fileName = @"mh_general_en";
            break;
    }
    
    return fileName;
}

-(NSString *)loadChartDisclaimer{
	NSString *returnString = nil;
	NSString *disclosurePath = nil;
	NSString *fileName		= nil;
	
	switch ([MHLanguage getCurrentLanguage]) {
		case LanguageEnglish:
			fileName = @"mh_chart_en";
			break;
		case LanguageTraditionalChinese:
			fileName = @"mh_chart_tc";
			break;
		case LanguageSimpleChinese:
			fileName = @"mh_chart_sc";
			break;	
		case LanguageJapanese:
			fileName = @"mh_chart_jp";
			break;	
		default:
			fileName = @"mh_chart_en";
			break;
	}
	disclosurePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
	returnString = [NSString stringWithContentsOfFile:disclosurePath encoding:NSUTF8StringEncoding error:nil];
	
	return returnString;
}

-(NSString *)loadGeneralDisclaimer{
	NSString *returnString = nil;
	NSString *disclosurePath = nil;
	NSString *fileName		= nil;
	
	switch ([MHLanguage getCurrentLanguage]) {
		case LanguageEnglish:
			fileName = @"mh_general_en";
			break;
		case LanguageTraditionalChinese:
			fileName = @"mh_general_tc";
			break;
		case LanguageSimpleChinese:
			fileName = @"mh_general_sc";
			break;	
		case LanguageJapanese:
			fileName = @"mh_general_jp";
			break;	
		default:
			fileName = @"mh_general_en";
			break;
	}
	
	disclosurePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
	returnString = [NSString stringWithContentsOfFile:disclosurePath encoding:NSUTF8StringEncoding error:nil];
	
	return returnString;
}

-(NSString *)loadDetailStyleString{
	NSString *styleString = nil;
	
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	@synchronized(preferences) {
		styleString = [preferences objectForKey:SAVEKEY_DEFAULT_STYLE];
	}
	
	if(styleString == nil){
		styleString = STYLE_DEFAULT;
	}
	
	if(![MHUtility equalsIgnoreCase:styleString anotherString:STYLE_DEFAULT] &&
	   ![MHUtility equalsIgnoreCase:styleString anotherString:STYLE_ChinaStyle]){
		styleString = STYLE_DEFAULT;
		
		// 20110726 set the style to STYLE_DEFAULT when the saved style string is unknown
		[self countineDetailStyleString:STYLE_DEFAULT];
	}

	return styleString;
}

-(void)countineDetailStyleString:(NSString *)aStyleString{
	if(aStyleString == nil){
		return;
	}
	
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	[preferences setObject:aStyleString forKey:SAVEKEY_DEFAULT_STYLE];
	[preferences synchronize];
}

- (BOOL)loadIsDetailViewInSectorView {
	BOOL isDetail = NO;
	
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	@synchronized(preferences) {
		isDetail = [preferences boolForKey:SAVEKEY_IS_DETAILIVIEW_IN_SectorView];
	}
	
	return isDetail;
}

- (BOOL)loadIsDetailViewInTopRankView {
	BOOL isDetail = NO;
	
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	@synchronized(preferences) {
		isDetail = [preferences boolForKey:SAVEKEY_IS_DETAILIVIEW_IN_TopRankView];
	}
	
	return isDetail;
}

-(NSString *)loadFlashColor{
	return Default_label_flash_color;
}


#pragma mark -
#pragma mark Submenu Reorder
-(NSDictionary *)loadSubmenuReorderSetting{
	NSString *appDocfilePath = [[MHUtility applicationDocumentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", PLIST_PT_SUBMENUORDER]];
	NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:appDocfilePath]; //[[NSDictionary alloc] initWithContentsOfFile:appDocfilePath];
	if (plistDictionary == nil || [[plistDictionary objectForKey:KEY_VERSION_NUMBER] floatValue]<[VERSION_NUMBER floatValue]) { //load default if not exisit
		NSString *filePath = [[NSBundle mainBundle] pathForResource:PLIST_PT_SUBMENUORDER ofType:@"plist"];
		plistDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
		[plistDictionary writeToFile:appDocfilePath atomically:YES];
	}
	
	return plistDictionary;
}

@end