//
//  NewBranchBannerUtil.m
//  BEA
//
//  Created by yaojzy on 10/24/11.
//  Copyright (c) 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "NewBranchBannerUtil.h"

@implementation NewBranchBannerUtil

@synthesize _NewBranchBannerViewController, showing, exit, mask;

+ (NewBranchBannerUtil *)me
{
	static NewBranchBannerUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[NewBranchBannerUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"NewBranchBannerUtil init");
    self = [super init];
    if (self) {
        
        self._NewBranchBannerViewController = nil;
        self.showing = @"";
        self.exit = @"";
        self.mask = [[MaskViewController alloc] initWithNibName:@"MaskView" bundle:nil];
        mask.view.center = CGPointMake(160, mask.view.frame.size.height/2 + 20);
        [CoreData sharedCoreData].mask = mask;
        [mask hiddenMask];
        
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self.mask.view];
        
		if (![NewBranchBannerUtil FileExists]){
			[NewBranchBannerUtil copyFile];
		}
    }
    
    return self;
}

-(NSString *) findPlistPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path ;
    path = [documentsDirectory stringByAppendingPathComponent:@"NewBranchBanner.plist"];
    NSLog(@"findPlist:%@",path);
    return path;
}

+ (BOOL) FileExists
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *FilePath = [documentsDirectory stringByAppendingPathComponent:@"NewBranchBanner.plist"];
	return [[NSFileManager defaultManager] fileExistsAtPath:FilePath];
}

+ (void) copyFile
{	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *oldFilePath = [[NSBundle mainBundle] pathForResource:@"NewBranchBanner" ofType:@"plist"];
	NSString *newFilePath = [documentsDirectory stringByAppendingPathComponent:@"NewBranchBanner.plist"];
	[[NSFileManager defaultManager] copyItemAtPath:oldFilePath
											toPath:newFilePath
											 error:NULL];
    
}

-(void)showPopupPromotion:(NSMutableArray *)shown_data
{
    NSLog(@"showPopupPromotion:%@",shown_data);
    
    if ([shown_data count]>0){
        [NewBranchBannerUtil me]._NewBranchBannerViewController = [[[NewBranchBannerViewController alloc] initWithNibName:@"NewBranchBannerViewController" bundle:nil shownData:shown_data] autorelease];
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:[NewBranchBannerUtil me]._NewBranchBannerViewController.view];
        [[NewBranchBannerUtil me]._NewBranchBannerViewController showMe];
    }
}

- (NSString *)getDocATMplistPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"NewBranch.plist"];
	
	return filePath;
}

-(void)setExit
{
    self.exit = @"YES";
}

-(BOOL)isExit
{
    return [self.exit isEqualToString:@"YES"];
}

-(NewBranchCell* )getTableViewCell:(id) obj
{
    NSString *identifier = @"NewBranchCell";
    
    NewBranchCell *cell = [[NewBranchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:2];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([MBKUtil isLangOfChi]) {
        cell.title_label.text = [obj objectForKey:@"Title_zh"];
        cell.address_label.text = [obj objectForKey:@"Address_zh"];
    }else{
        cell.title_label.text = [obj objectForKey:@"Title_en"];
        cell.address_label.text = [obj objectForKey:@"Address_en"];
    }
    
    NSArray *listItems = [[obj objectForKey:@"Tel"] componentsSeparatedByString:@","];
    [cell.tel setTitle:[listItems objectAtIndex:0] forState:UIControlStateNormal];
    [cell.tel2 setTitle:[listItems objectAtIndex:1] forState:UIControlStateNormal];
    [cell.tel3 setTitle:[listItems objectAtIndex:2] forState:UIControlStateNormal];
    
    [cell showTel];
    
    return cell;
}   

-(NSMutableArray*)selectItemsForShow:(NSMutableArray*)items_data//added by jasen on 20111122
{
    NSLog(@"selectItemsForShow begin:%@",items_data);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
    
	NSDate *now_date= [NSDate new];
    
	NSDate *start_date = [now_date dateByAddingTimeInterval:-5184000];
	NSDate *end_date = [now_date dateByAddingTimeInterval:5184000];
    
	NSString *str_start_date = [df stringFromDate:start_date];
	NSString *str_end_date = [df stringFromDate:end_date];
    
	BOOL willShow=NO;
    
    NSMutableArray* top_items_data = [NSMutableArray new];
    NSString *opening;
    
    for (int i=0; i<[items_data count]; i++) {
        opening=[[items_data objectAtIndex:i] objectForKey:@"opening"];
        if ([opening compare:str_start_date]==NSOrderedSame 
            || [opening compare:str_end_date]==NSOrderedSame 
            || ( (NSOrderedDescending == [opening compare:str_start_date]) 
                && (NSOrderedAscending == [opening compare:str_end_date]) )
            )
        {
            willShow=YES;
        }else{
            willShow=NO;
        }
        NSLog(@"selectItemsForShow:%@-%@-%@",opening,str_start_date,str_end_date);
        if (willShow){
            [top_items_data addObject:[items_data objectAtIndex:i]];
        }
    }
    
    [df release];
	[now_date release];
    
    NSLog(@"selectItemsForShow end:%@",top_items_data);
    
    return [top_items_data autorelease];
    
}

-(NSMutableArray*)selectItemsForPopup:(NSMutableArray*)items_data//added by jasen on 20111122
{
    NSLog(@"selectItemsForPopup begin:%@",items_data);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
    
	NSDate *now_date= [NSDate new];
    
	NSDate *start_date = [now_date dateByAddingTimeInterval:-432000];
	NSDate *end_date = [now_date dateByAddingTimeInterval:432000];
    
	NSString *str_start_date = [df stringFromDate:start_date];
	NSString *str_end_date = [df stringFromDate:end_date];
    
	BOOL willShow=NO;
    
    NSMutableArray* top_items_data = [NSMutableArray new];
    NSString *opening;
    
    for (int i=0; i<[items_data count]; i++) {
        opening=[[items_data objectAtIndex:i] objectForKey:@"opening"];
        if ([opening compare:str_start_date]==NSOrderedSame 
            || [opening compare:str_end_date]==NSOrderedSame 
            || ( (NSOrderedDescending == [opening compare:str_start_date]) 
                && (NSOrderedAscending == [opening compare:str_end_date]) )
            )
        {
            willShow=YES;
        }else{
            willShow=NO;
        }
        NSLog(@"selectItemsForPopup:%@-%@-%@",opening,str_start_date,str_end_date);
        if (willShow){
            [top_items_data addObject:[items_data objectAtIndex:i]];
        }
    }
    
    [df release];
	[now_date release];
    
    NSLog(@"selectItemsForPopup end:%@",top_items_data);
    return [top_items_data autorelease];
    
}

+(void)tranferAnnotations:(NSArray *)annotationsDetail
{
	for (int i=0; i<[annotationsDetail count]; i++) {
		NSMutableDictionary *temp_record = [annotationsDetail objectAtIndex:i];
        if (![MBKUtil isLangOfChi]) {
            [temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"Title_en"] forKey:@"title"];
            [temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"Address_en"] forKey:@"address"];
            [temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"Remark_en"] forKey:@"remark"];
        }else{
            [temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"Title_zh"] forKey:@"title"];
            [temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"Address_zh"] forKey:@"address"];
            [temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"Remark_zh"] forKey:@"remark"];
        }
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"Tel"] forKey:@"tel"];
		[temp_record setValue:@"" forKey:@"id"];
		[temp_record setValue:@"" forKey:@"newtopitem"];
	}
}

-(void)sendRequest{
    NSLog(@"sendRequest");
    
    ASIFormDataRequest *request = [HttpRequestUtils getPostRequest4NewBranch:self];
    
    [[CoreData sharedCoreData].queue addOperation:request];
    
    [[NewBranchBannerUtil me].mask showMask];
}

-(BOOL)needShow
{
    NSLog(@"needShow");
    
    int count;
    
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[NewBranchBannerUtil me ]findPlistPath]];
    
    NSLog(@"NSMutableDictionary:%@",md_temp);
    NSString *date_stamp = [md_temp objectForKey:@"ClickCount"];
    NSLog(@"NewBranchBanner ClickCount:%@",date_stamp);
    
    count = [date_stamp intValue];
    
    NSLog(@"[NewBranchBannerUtil needShow]:%d", count);
    
    return (count<3);
    
}

-(void)requestPlist
{
    NSLog(@"NewBranchBannerUtil requestPlist");
    
    if ([[NewBranchBannerUtil me] isExit]){
        return;
    }
    
    [[NewBranchBannerUtil me] setExit];
    
    [self sendRequest];    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request 
{
	// Use when fetching text data
	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
	NSLog(@"NewBranchBannerUtil.requestFinished rsp:%d", [reponsedString length]);
    NSLog(@"NewBranchBannerUtil.requestFinished rsp:%@", reponsedString);
    
    NSMutableDictionary *md_tempOld = nil;
    
    NSMutableDictionary *md_tempNew = nil;
    
    md_tempOld = [NSMutableDictionary dictionaryWithContentsOfFile:[[NewBranchBannerUtil me] getDocATMplistPath]];
    NSLog(@"md_tempOld %@",md_tempOld);
    if ([NewBranchBannerUtil newBranchFileExists]){
        [[NSFileManager defaultManager] removeItemAtPath:[[NewBranchBannerUtil me] getDocATMplistPath] error:nil];
    }
    
    [[request responseData] writeToFile:[[NewBranchBannerUtil me] getDocATMplistPath] atomically:YES];
    
    
    md_tempNew = [NSMutableDictionary dictionaryWithContentsOfFile:[[NewBranchBannerUtil me] getDocATMplistPath]];
    NSLog(@"md_tempNew %@",md_tempNew);
    
    if(![md_tempNew isEqualToDictionary:md_tempOld]){
        [self clearCount];
    }
    NSMutableArray *popup_data = [[NewBranchBannerUtil me] selectItemsForPopup:[md_tempNew objectForKey:@"atmlist"]];
    
    if([self needShow] && [popup_data count]>0){
        NSMutableArray *shown_data = [[NewBranchBannerUtil me] selectItemsForShow:[md_tempNew objectForKey:@"atmlist"]];
        
        [self showPopupPromotion:shown_data];
    }
    
    [[NewBranchBannerUtil me].mask hiddenMask];
}

- (void)clearCount{
    
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[NewBranchBannerUtil me ]findPlistPath]];
    NSString *date_stamp = [md_temp objectForKey:@"ClickCount"];
    int count = [date_stamp intValue]; 
    NSLog(@"clearCount beforecount:%d",count);
    
    [md_temp setValue:@"0" forKey:@"ClickCount"];
    [md_temp writeToFile:[[NewBranchBannerUtil me] findPlistPath] atomically:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request 
{
	NSLog(@"NewBranchBannerUtil.requestFailed:%@", [request error]);
    
	[[NewBranchBannerUtil me].mask hiddenMask];
}

+ (BOOL) newBranchFileExists
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *FilePath = [documentsDirectory stringByAppendingPathComponent:@"NewBranch.plist"];
    
    BOOL retCode = [[NSFileManager defaultManager] fileExistsAtPath:FilePath];
    NSLog(@"newBranchFileExists:%d", retCode);
    
    if(retCode){
        NSMutableDictionary *md_temp = nil;
        
        md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[NewBranchBannerUtil me] getDocATMplistPath]];
        
        retCode = [[md_temp objectForKey:@"atmlist"] count]>0;
        NSLog(@"atmlist count:%d", [[md_temp objectForKey:@"atmlist"] count]);
    }
    
    return retCode;
}

@end
