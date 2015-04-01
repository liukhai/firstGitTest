//
//  TaxLoanApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on SEP/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "MBKUtil.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#import <CommonCrypto/CommonDigest.h>
#include <sqlite3.h>
#import "CoreData.h"

@implementation MBKUtil


@synthesize md_images;
@synthesize anno_count;
@synthesize mvflag;
//@synthesize mvflag2;


@synthesize realServerURL;

@synthesize ma_atmListItems;

@synthesize atm_item_key;

@synthesize queryButton1;
@synthesize queryButtonWillShow;

+ (MBKUtil *)me
{
	static MBKUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[MBKUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"MBKUtil init");
    self = [super init];
    if (self) {
		self.anno_count = [NSNumber numberWithInt:0];
		self.mvflag = [NSNumber numberWithInt:0];
//		self.mvflag2 = [NSNumber numberWithInt:0];

		self.atm_item_key = [NSArray arrayWithObjects:
							 @"id",
							 @"category",
							 @"district",
							 @"title",
							 @"address",
							 @"remark",
							 @"gps",
							 @"tel",
							 @"fax",
							 @"newtopitem",
							 @"expire",
							 nil];

        
		
		if (![MBKUtil settingFileExists]){
			[MBKUtil copySettingFile];
		}


        
        self.queryButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.queryButton1.tag = NUM_PAD_DONE_BUTTON_TAG;
        if ([UIDevice currentDevice].systemVersion.floatValue < 8.0){
            self.queryButton1.frame = CGRectMake(0, 163, 106, 53);
        }else{
            self.queryButton1.frame = CGRectMake(0, [MyScreenUtil me].getScreenHeight - 53, 106, 53);
        }
        if ([MBKUtil isLangOfChi]){
            [self.queryButton1 setImage:[UIImage imageNamed:@"keyboard_done_zh.png"] forState:UIControlStateNormal];
        }else{
            [self.queryButton1 setImage:[UIImage imageNamed:@"keyboard_done_en.png"] forState:UIControlStateNormal];
        }

        self.queryButtonWillShow=@"NO";
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    return self;
}



- (void)keyboardDidShow:(NSNotification*) note {
    NSLog(@"[MBKUtil] => keyboardDidShow:");
    if (![[MBKUtil me].queryButtonWillShow isEqualToString:@"YES"]) {
        return;
    }
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView *keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        NSLog(@"[MBKUtil] => keyboardDidShow:keyboard %@",keyboard );
        // keyboard view found; add the custom button to it
        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) || ([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES) || ([[keyboard description] hasPrefix:@"<UIInputSetContainerView"] == YES)){
            if ([MBKUtil isLangOfChi]){
                [self.queryButton1 setImage:[UIImage imageNamed:@"keyboard_done_zh.png"] forState:UIControlStateNormal];
            }else{
                [self.queryButton1 setImage:[UIImage imageNamed:@"keyboard_done_en.png"] forState:UIControlStateNormal];
            }
            [keyboard addSubview:[MBKUtil me].queryButton1];
            if (![keyboard viewWithTag:LINE_NUM_PAD_TAG]) {
                
                UILabel * line= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320,1)];
                line.tag = LINE_NUM_PAD_TAG;
                if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
                    line.frame = CGRectMake(0, [MyScreenUtil me].getScreenHeight - 216, 320, 1);
                }
                line.backgroundColor = [UIColor colorWithRed:((float) 203 / 255.0f) green:((float) 205  / 255.0f)blue:((float) 208 / 255.0f) alpha:1.0f];
                [keyboard addSubview:line];
                [line release];
            }
            
            NSLog(@"[MBKUtil] => keyboardDidShow: %@",[MBKUtil me].queryButton1 );
        }
    }
}

- (void)keyboardWillHide:(NSNotification*) note {
    NSArray *windowArr = [[UIApplication sharedApplication] windows];
    if (windowArr != nil && windowArr.count > 1){
        UIWindow *needWindow = [windowArr objectAtIndex:1];
        UIView *keyboard;
        for(int i = 0; i < [needWindow.subviews count]; i++) {
            keyboard = [needWindow.subviews objectAtIndex:i];
            if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) || ([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES) || ([[keyboard description] hasPrefix:@"<UIInputSetContainerView"] == YES)){
                UIView *removeView = [keyboard viewWithTag:NUM_PAD_DONE_BUTTON_TAG];
                if (removeView != nil){
                    [removeView removeFromSuperview];
                }
                removeView = [keyboard viewWithTag:LINE_NUM_PAD_TAG];
                if (removeView != nil){
                    [removeView removeFromSuperview];
                }
            }
        }
    }
}

- (void)increaseMvflag{
	int li_count = [self.mvflag intValue];
	li_count++;
	self.mvflag = [NSNumber numberWithInt:li_count];
}

//- (void)increaseMvflag2
//{
//	int li_count = [self.mvflag2 intValue];
//	li_count++;
//	self.mvflag2 = [NSNumber numberWithInt:li_count];
//}

- (void)detectJailBreak{
    NSString *filePath = @"/Applications/System Preferences.app/Contents/Resources/";
//    NSString *filePath = @"/Applications/Preferences.app/General.plist";
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        // jail broken
        NSLog(@"Jail Broken");
    }
    else{
        // genuine device
        NSLog(@"Genuine device");
    }
}

- (void)increaseAnno_count{
	int li_count = [self.anno_count intValue];
	li_count++;
	self.anno_count = [NSNumber numberWithInt:li_count];
}

- (void)resetAnno_count{
	self.anno_count = [NSNumber numberWithInt:0];
}

- (NSNumber *)getDistanceStringFromA:(CLLocation *)locationA toB:(CLLocation *)locationB
{
//	CGFloat distance = fabs([locationA getDistanceFrom:locationB]);
	CGFloat distance = fabs([locationA distanceFromLocation:locationB]);
	
	return [NSNumber numberWithFloat:distance];
}

+ (BOOL)settingFileExists
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *newFilePath = [documentsDirectory stringByAppendingPathComponent:@"Settings.plist"];
	NSLog(@"settingFileExists:%@---%d", newFilePath, [[NSFileManager defaultManager] fileExistsAtPath:newFilePath]);
    
    
	return [[NSFileManager defaultManager] fileExistsAtPath:newFilePath];
}

//- (BOOL)hotlineFileUpdated{
//    NSString *newHotlineFilePath = [[MBKUtil me] getDocHotlinePath];
//    NSString *oldHotlineFilePath = [[NSBundle mainBundle] pathForResource:@"Hotline" ofType:@"plist"];
//    BOOL same = [[NSFileManager defaultManager] contentsEqualAtPath:newHotlineFilePath andPath:oldHotlineFilePath];    
//    return same;
//}
//            

- (NSString *) getDocPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSLog(@"MBKUtil getDocPath::%@", documentsDirectory);
	return documentsDirectory;
}

+ (void) copySettingFile {	
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *newFilePath = nil;
	NSString *oldfilePath = nil;
    
	newFilePath = [[MBKUtil me] getDocATMplistPath_en];
	oldfilePath = [[NSBundle mainBundle] pathForResource:@"ATMen" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:oldfilePath
											toPath:newFilePath
											 error:NULL];
	if ([[NSFileManager defaultManager] fileExistsAtPath:newFilePath]){
		NSLog(@"copySettingFile created:%@", newFilePath);
	}else {
		NSLog(@"copySettingFile fail:%@", newFilePath);
	}	
	
	newFilePath = [[MBKUtil me] getDocATMplistPath_zh];
	oldfilePath = [[NSBundle mainBundle] pathForResource:@"ATMzh" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:oldfilePath
											toPath:newFilePath
											 error:NULL];
	if ([[NSFileManager defaultManager] fileExistsAtPath:newFilePath]){
		NSLog(@"copySettingFile created:%@", newFilePath);
	}else {
		NSLog(@"copySettingFile fail:%@", newFilePath);
	}	
    
	
}

//- (void) copyHotlineFile {
//	NSString *newFilePath = [[MBKUtil me] getDocHotlinePath];
//	NSString *oldfilePath = [[NSBundle mainBundle] pathForResource:@"Hotline" ofType:@"plist"];
//	[[NSFileManager defaultManager] removeItemAtPath:newFilePath error:NULL];
//
//	[[NSFileManager defaultManager] copyItemAtPath:oldfilePath
//											toPath:newFilePath
//											 error:NULL];
//	if ([[NSFileManager defaultManager] fileExistsAtPath:newFilePath]){
//		NSLog(@"copySettingFile created:%@", newFilePath);
//	}else {
//		NSLog(@"copySettingFile fail:%@", newFilePath);
//	}	
//
//
//
//}            

- (void)setCusBackgroundView:(UIView *)a_view
					   index:(int)a_index
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Backgrounds" ofType:@"plist"];
    NSArray *bgPicA = [NSArray arrayWithContentsOfFile:path];
	
    NSDictionary *bgPic;
	NSNumber *n_index;
	NSString * name;
    for (bgPic in bgPicA)
    {
		n_index = [bgPic objectForKey:@"index"];
		
		int i_index = [n_index intValue];
		
		if (i_index == a_index){
			name = [bgPic objectForKey:@"name"];
		}
		
    }
	
	NSLog(@"MBKUtil setCusBackgroundView:%@", name);
	
	//	UIView *bgview = [[[UIImageView alloc] initWithImage:[[MBKUtil me] getImageByKey:name]] autorelease];
	//	[a_view setBackgroundView:bgview]; 
}

-(void)dealloc
{
	[self.md_images dealloc];
	[super dealloc];
}

-(UIImage *)getImageByKey:(NSString*)key
{
	UIImage *image = nil;
	
	if (nil==self.md_images){
		image = [UIImage imageNamed:key];
		self.md_images = [NSMutableDictionary dictionaryWithCapacity:20];
		[self.md_images setObject:image forKey:key];
	}else {
		image = (UIImage *)[self.md_images objectForKey:key];
		
		if (nil==image) {
			image = [UIImage imageNamed:key];
		}
		
		if (nil!=image) {
			[self.md_images setObject:image forKey:key];
			
		}
		
	}
	
	return image;
}

- (NSString *)getBundleSettingFilePath
{
	return [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
}

- (NSNumber *) getLangCount
{
	NSNumber *langCount=nil;
	
	NSString *filePath = [LangUtil getDocSettingFilePath];
	
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:filePath];
	langCount = [settings objectForKey:@"lang_count"];
	
	NSLog(@"getLangCount:%@", langCount);
	
	return langCount;
}

- (NSString *) getLangName:(int)index
{
	NSString *langname=nil;
	
	NSString *filePath = [LangUtil getDocSettingFilePath];
	
	NSString *key = [NSString stringWithFormat:@"lang_%d",index]; 
	
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:filePath];
	langname = [settings objectForKey:key];
	
	NSLog(@"getLangName:%@ %@", key, langname);
	
	return langname;
}

//+ (NSString *) getLangPref
//{
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
//	NSString * langPref = [NSString stringWithFormat:@"%@", [languages objectAtIndex:0]];
//	//en
//	//zh-Hant
//    NSLog(@"debug MBKUtil getLangPref:%@", langPref);
//	return langPref;	
//}

+ (BOOL) isLangOfChi
{
	return [[[[LangUtil me] getLangPref] lowercaseString] hasPrefix:@"zh"];
}

- (NSNumber *) getLangIndSelected
{
	NSNumber *LangIndSelected=nil;
	
	NSString *filePath = [LangUtil getDocSettingFilePath];
	
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:filePath];
	LangIndSelected = [settings objectForKey:@"lang_ind_selected"];
	
	NSLog(@"getLangIndSelected:%@", LangIndSelected);
	
	return LangIndSelected;
}

- (void) updateSettings:(NSString *)key value:(NSString *)value
{
	NSString *filePath = [LangUtil getDocSettingFilePath];
	
    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
	
	[settings setObject:value forKey:key];
	
	[settings writeToFile:filePath atomically: YES];
	
	NSLog(@"updateSettings:%@-%@", key, value);
	
}

+ (NSString *) loadSettingsByKey:(NSString *)key
{
	NSString *retstr = nil;
	
	NSString *filePath = [LangUtil getDocSettingFilePath];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
		NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:filePath];
		retstr = [settings objectForKey:key];
	}
	
	return retstr;
}


+ (NSString*) getCheckRegStatusURL{
	NSString *urlString = [[MigrationSetting me] CheckRegStatusURL];
	
	NSString *mobileno = [NSString stringWithFormat:@""];
//	NSData *banking;
	NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	
	if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
//		banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
//		[self transform:banking];
//		mobileno =[[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding];
        mobileno = [MBKUtil decryption:[user_setting objectForKey:@"encryted_banking"]];

		
	}
	
	NSString *keyStr = [NSString stringWithFormat:@"%@%@ATMLOCATION", mobileno, [CoreData sharedCoreData].UDID];
	
	keyStr = [MBKUtil md5:keyStr];
	
	urlString = [urlString stringByAppendingFormat:@"?act=CRS&MobileNo=%@&lang=%@&UUID=%@&ks=%@", mobileno, [CoreData sharedCoreData].lang, [CoreData sharedCoreData].UDID, keyStr];
    //	NSLog(@"MBUtil getCheckRegStatusURL:%@", urlString);
	
	return urlString;
}

+ (NSString*) getMobileNoFromSetting{
	NSString *mobileno = [NSString stringWithFormat:@""];
//	NSData *banking;
	NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	
	if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
//		banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
//		[self transform:banking];
//		mobileno =[[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding];
        mobileno = [MBKUtil decryption:[user_setting objectForKey:@"encryted_banking"]];

	}
	
	return mobileno;
}

+ (NSString*) getEASMobileNoFromSetting{
	NSString *mobileno = [NSString stringWithFormat:@""];
//	NSData *banking;
	NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	
	if (user_setting!=nil && [[user_setting objectForKey:@"encryted_trading"] length]>0) {
//		banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_trading"]];
//		[self transform:banking];
//		mobileno =[[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding];
        mobileno = [MBKUtil decryption:[user_setting objectForKey:@"encryted_trading"]];

	}
	
	return mobileno;
}

+ (NSString *) md5:(NSString *)str {
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];	
}

+ (void) transform:(NSData*)input
{
    NSString* key = [[CoreData sharedCoreData].UDID stringByAppendingString:@"UEVBSWQVUURE"];
    unsigned char* pBytesInput = (unsigned char*)[input bytes];
    unsigned char* pBytesKey   = (unsigned char*)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    unsigned int vlen = [input length];
    unsigned int klen = [key length];
    //unsigned int v = 0;
    unsigned int k = vlen % klen;
    unsigned char c;
	
    for (int v=0; v < vlen; v++) {
        c = pBytesInput[v] ^ pBytesKey[k];
        pBytesInput[v] = c;
		
        k = (++k < klen ? k : 0);
    }
}

+ (void) transform2:(NSData*)input
{
    NSString* key = @"UEVBSWQVUURE";
    unsigned char* pBytesInput = (unsigned char*)[input bytes];
    unsigned char* pBytesKey   = (unsigned char*)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    unsigned int vlen = [input length];
    unsigned int klen = [key length];
    //unsigned int v = 0;
    unsigned int k = vlen % klen;
    unsigned char c;
    
    for (int v=0; v < vlen; v++) {
        c = pBytesInput[v] ^ pBytesKey[k];
        pBytesInput[v] = c;
        
        k = (++k < klen ? k : 0);
    }
}

-(bool) isNumeric:(NSString*) hexText
{
    
    NSNumberFormatter* numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    
    NSNumber* number = [numberFormatter numberFromString:hexText];
    
    if (number != nil) {
        NSLog(@"debug isNumeric:%@--is numeric", hexText);
        //do some stuff here
        return true;
    }
    
    NSLog(@"debug isNumeric:%@ is not numeric", hexText);
    //or do some more stuff here
    return false;
}

+ (NSString*) decryption:(NSData*)input
{
    NSData* banking = [NSData dataWithBase64Data:input];
    NSData* banking2 = [NSData dataWithBase64Data:input];
    [self transform:banking];
    [self transform2:banking2];
    NSString* mobileno =[[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding];
    NSString* mobileno2 =[[NSString alloc] initWithData:banking2 encoding:NSUTF8StringEncoding];
    bool right1 = [[MBKUtil me] isNumeric:mobileno];
    bool right2 = [[MBKUtil me] isNumeric:mobileno2];
    NSString* result = @"";
    if (right1) {
        result =  mobileno;
    }else if (right2){
        result =  mobileno2;
    }
    return result;
}

+ (NSData*) encryption:(NSString*)input
{
	NSData *cyberbanking_data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
	[MBKUtil transform2:cyberbanking_data];
    
	NSData *temp_banking = [cyberbanking_data base64Data];
    return temp_banking;
}

+ (NSURL*) getURLCYBMBKREG{
	NSString * _URLCYBMBKREGen = [NSString stringWithFormat:@"%@?Lang=Eng&MobileNo=%@", [[MigrationSetting me] MBCYBLogonShow], [MBKUtil getMobileNoFromSetting]];
	NSString * _URLCYBMBKREGzh = [NSString stringWithFormat:@"%@?Lang=Big5&MobileNo=%@", [[MigrationSetting me] MBCYBLogonShow], [MBKUtil getMobileNoFromSetting]];
	
	NSURL *url;
	if (![MBKUtil isLangOfChi]) {
		url = [NSURL URLWithString:_URLCYBMBKREGen];
	}else {
		url = [NSURL URLWithString:_URLCYBMBKREGzh];
	}
	
    //	NSLog(@"url:%@", url);
	return url;
}

- (NSString *)getDocATMplistPath{
	if (![MBKUtil isLangOfChi]) {
		return [self getDocATMplistPath_en];
	}else {
		return [self getDocATMplistPath_zh];
	}
}

- (NSString *)getDocHotlinePath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Hotline.plist"];
	
	return filePath;
}

- (NSString *)getDocATMplistPath_en
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"ATMen.plist"];
	
	return filePath;
}

- (NSString *)getDocATMplistPath_zh
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"ATMzh.plist"];
	
	return filePath;
}

+ (NSString*) getKeyString4Req{
	NSString *keyStr = [NSString stringWithFormat:@"%@%@ATMLOCATION", [MBKUtil getMobileNoFromSetting], [CoreData sharedCoreData].UDID];
	keyStr = [MBKUtil md5:keyStr];
	keyStr = [NSString stringWithFormat:@"MobileNo=%@&lang=%@&UUID=%@&ks=%@", [MBKUtil getMobileNoFromSetting], [[LangUtil me] getLangPref], [CoreData sharedCoreData].UDID, keyStr];
	return keyStr;
}

+(NSString*) getKS{
    NSString *keyStr = [NSString stringWithFormat:@"%@%@ATMLOCATION", [MBKUtil getMobileNoFromSetting], [CoreData sharedCoreData].UDID];
	keyStr = [MBKUtil md5:keyStr];
    return keyStr;
}

+(NSString*) getEASKS{
    NSString *keyStr = [NSString stringWithFormat:@"%@%@ATMLOCATION", [MBKUtil getEASMobileNoFromSetting], [CoreData sharedCoreData].UDID];
	keyStr = [MBKUtil md5:keyStr];
    return keyStr;
}

- (NSString*) getATMListSNFromLocal{
	NSMutableDictionary *atmplistDict = [NSMutableDictionary dictionaryWithContentsOfFile:[[MBKUtil me] getDocATMplistPath]];
	NSString *localatmplistSN = [atmplistDict objectForKey:@"SN"];
    //	NSLog(@"local SN:%@", localatmplistSN);
	return localatmplistSN;
}

- (NSString*) getHotlineSNFromLocal{
	NSMutableDictionary *atmplistDict = [NSMutableDictionary dictionaryWithContentsOfFile:[[MBKUtil me] getDocHotlinePath]];
	NSString *localhotlineSN = [atmplistDict objectForKey:@"SN"];
	return localhotlineSN;
}

+ (NSString*) getURLOfgetATMListOTA{
    NSString *urlString = [[MigrationSetting me] URLOfgetATMListOTA];
	
	urlString = [urlString stringByAppendingFormat:@"?act=GAL&SN=%@&%@", [[MBKUtil me] getATMListSNFromLocal], [MBKUtil getKeyString4Req]];
	
	return urlString;
}

+ (NSString*) getURLOfgetHotlineOTA{
    NSString *urlString = [[MigrationSetting me] URLOfgetHotlineOTA];
	
	urlString = [urlString stringByAppendingFormat:@"?act=HOT&SN=%@&%@", [[MBKUtil me] getATMListSNFromLocal], [MBKUtil getKeyString4Req]];
	
	return urlString;
}

- (BOOL) saveATMxml:(NSData*)data{
	return [data writeToFile:[[MBKUtil me] getDocATMplistPath] atomically:YES]; 
}

- (BOOL) saveHOTxml:(NSData*)data{
	return [data writeToFile:[[MBKUtil me] getDocHotlinePath] atomically:YES]; 
}


+ (NSString *)getDocTempFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [NSString stringWithFormat:@"%@-%f", [documentsDirectory stringByAppendingPathComponent:@"temp"], [[NSDate date] timeIntervalSince1970]];
	
	return filePath;
}

+ (NSString*) getURLOfTaxLoanApplication{
	NSString *urlString = [[MigrationSetting me] URLOfTaxLoanApplication];
	
	urlString = [urlString stringByAppendingFormat:@"?act=TLA&%@", [MBKUtil getKeyString4Req]];
	return urlString;
}

+ (NSString*) getURLOfCIHApplication{
	NSString *urlString = [[MigrationSetting me] URLOfTaxLoanApplication];
	
	urlString = [urlString stringByAppendingFormat:@"?act=CIH&%@", [MBKUtil getKeyString4Req]];	
	return urlString;
}

+(BOOL) wifiNetWorkAvailable{
#pragma mark by jasen - should be HKBEA, instead of others
    Reachability* reachability = [Reachability reachabilityWithHostName:@"ww2.hkbea-cyberbanking.com"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) { 
        NSLog(@"not reachable");
        return FALSE;
    }else if (remoteHostStatus == ReachableViaWWAN) { 
        NSLog(@"reachable via wwan");
        return TRUE;
    }else if (remoteHostStatus == ReachableViaWiFi) { 
         NSLog(@"reachable via wifi");
        return TRUE;
    }
    return FALSE ;
}

@end
