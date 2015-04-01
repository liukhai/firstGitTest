//
//  RateUtil.m
//  BEA
//
//  Created by neo on 10/20/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "RateUtil.h"


@implementation RateUtil

@synthesize Rate_view_controller,serverFlag;

+ (RateUtil *)me
{
	static RateUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[RateUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"RateUtil init");
    self = [super init];
    if (self) {
        self.Rate_view_controller = nil;
        
		if (![RateUtil FileExists]){
			[RateUtil copyFile];
		}
    }
    
    return self;
}

-(void)callToApply{
    self.serverFlag = @"phone";
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Rate.application.call",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([serverFlag isEqualToString:@"phone"]){
        if (buttonIndex==1) {
            NSString* telString = [NSString stringWithFormat:
                                   @"tel:%@",[NSLocalizedString(@"Rate.application.call",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                                   ];
            NSLog(@"call:%@", telString);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
        }
    }else if([serverFlag isEqualToString:@"backtomain"]){
        [self goHome];
    }
}

+ (BOOL) isLangOfChi
{
	return [[[[LangUtil me] getLangPref] lowercaseString] hasPrefix:@"zh"];
}

+ (BOOL) isValidUtil
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
	NSDate *now_date = [NSDate date];
	
	NSDate *start_date = [df dateFromString:@"20110101"];
	NSDate *end_date = [df dateFromString:@"20110901"];
	
	BOOL retValue=NO;
	if ([now_date isEqualToDate:start_date] 
		|| [now_date isEqualToDate:end_date] 
		|| ( (NSOrderedDescending == [now_date compare:start_date]) && (NSOrderedAscending == [now_date compare:end_date]) )
		)
	{
		retValue=YES;
	}
	
	NSLog(@"RateUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);
	
	return retValue;
}


-(NSString *) findRatePlistPath :(NSString*) rateType{//note,tt,prime
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path ;
    NSString *plistName = [NSString stringWithFormat:@"rate_%@.plist",rateType];
    path = [documentsDirectory stringByAppendingPathComponent:plistName];

    return path;
}



+ (BOOL) FileExists
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *noteFilePath = [documentsDirectory stringByAppendingPathComponent:@"rate_note.plist"];
    NSString *ttFilePath = [documentsDirectory stringByAppendingPathComponent:@"rate_tt.plist"];
    NSString *primeFilePath = [documentsDirectory stringByAppendingPathComponent:@"rate_prime.plist"];
    return [[NSFileManager defaultManager] fileExistsAtPath:noteFilePath] && [[NSFileManager defaultManager] fileExistsAtPath:ttFilePath] && [[NSFileManager defaultManager] fileExistsAtPath:primeFilePath] ;
}


+ (void) copyFile {	
    NSLog(@"copyFile ");
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *noteFilePath = [documentsDirectory stringByAppendingPathComponent:@"rate_note.plist"];
	NSString *noteOldfilePath = [[NSBundle mainBundle] pathForResource:@"rate_note" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:noteOldfilePath
											toPath:noteFilePath
											 error:NULL];
    NSString *TTFilePath = [documentsDirectory stringByAppendingPathComponent:@"rate_tt.plist"];
	NSString *TTOldfilePath = [[NSBundle mainBundle] pathForResource:@"rate_tt" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:TTOldfilePath
											toPath:TTFilePath
											 error:NULL];
    NSString *primeFilePath = [documentsDirectory stringByAppendingPathComponent:@"rate_prime.plist"];
	NSString *primeOldfilePath = [[NSBundle mainBundle] pathForResource:@"rate_prime" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:primeOldfilePath
											toPath:primeFilePath
											 error:NULL];
}

-(void)alertAndBackToMain{
	self.serverFlag = @"backtomain";
    
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
}

-(void)alertAndBackToMain:(UIViewController*)outViewController{
    [self alertAndBackToMain];
    if(!outViewController) [outViewController release];
}

- (void)goHome{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[RateUtil me].Rate_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
	[UIView commitAnimations];
}

- (BOOL) checkRateSNExpired:(NSString *) ratePlistPath
{
    BOOL dateExpired = NO;
    
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:ratePlistPath];
    NSString* date_stamp = [md_temp objectForKey:@"SN"];
    
    if (date_stamp == nil) {
        dateExpired=YES;
    }
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSDate *now = [NSDate date];
    
    NSDate *updateDate = [formatter dateFromString:date_stamp];
    updateDate = [updateDate dateByAddingTimeInterval:300];

    dateExpired = ((NSOrderedDescending == [now  compare:updateDate]));
    
    NSLog(@"current date:%@, update_date:%@",[formatter stringFromDate:now],date_stamp);
    NSLog(@"dateExpired:%d",dateExpired);
    
    return dateExpired;
    
}

+ (BOOL)checkResponseData:(NSData*)datas rateType:(NSString*) rate{
    BOOL isValid = TRUE;
    NSString *tempFile = [RateUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    NSLog(@"rateType:%@",rate);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newNoteList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];
    NSString * SN = [newNoteList objectForKey:@"SN"];
    NSArray *newArray = [newNoteList objectForKey:rate];
    NSLog(@"RateUtil: SN:%@",SN);
    NSLog(@"RateUtil: newArray count:%d",[newArray count]);
    if (SN==nil || [SN isEqualToString:@""] || [newArray count] < 1){
        isValid =  FALSE;
    }    
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    return isValid;
}
+ (void)updateRateFile:(NSData*)datas rateType:(NSString*) rate{
    NSString *tempFile = [RateUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    NSLog(@"rateType:%@",rate);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newNoteList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];
 
    NSString *fundFile = [[RateUtil me] findRatePlistPath:rate];
    if (fundFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newNoteList writeToFile:fundFile atomically:YES];
}

+ (NSString *)getDocTempFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [NSString stringWithFormat:@"%@-%f", [documentsDirectory stringByAppendingPathComponent:@"temp"], [[NSDate date] timeIntervalSince1970]];
	
	return filePath;
}

@end
