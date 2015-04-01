//
//  AccProUtil.m
//  BEA
//
//  Created by YAO JASEN on 10/20/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "AccProUtil.h"


@implementation AccProUtil

@synthesize _BasePromotion;
@synthesize AccPro_view_controller;
@synthesize _AccProListViewController;
@synthesize strSend,requestSign;
@synthesize animate;
@synthesize inStockWatch;

+ (AccProUtil *)me
{
	static AccProUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[AccProUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"AccProUtil init");
    self = [super init];
    if (self) {
        self.AccPro_view_controller = nil;
        
        self._BasePromotion = nil;
        self.strSend = nil;
        self.animate = @"YES";
        self.inStockWatch = @"";
        
		if (![AccProUtil FileExists]){
			[AccProUtil copyFile];
		}
    }
    
    return self;
}

-(void)callToApply{
	UIAlertView *alert_view = [[UIAlertView alloc]
                               initWithTitle:NSLocalizedString(@"LTAlert_ApplicationHotline",nil)
                               message:nil
                               delegate:self
                               cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                               otherButtonTitles:NSLocalizedString(@"LTAlert_SupremeGold",nil),
                               NSLocalizedString(@"LTAlert_AutoPayroll",nil),
                               NSLocalizedString(@"LTAlert_TaxLoan",nil),
                               nil
                               ];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex:%d", buttonIndex);
    NSString* telString=nil;
	if (buttonIndex==1) {
        telString = [NSString stringWithFormat:
                     @"tel:%@",[NSLocalizedString(@"LTAlert_SupremeGold.call",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                     ];
	}else if (buttonIndex==2) {
        telString = [NSString stringWithFormat:
                     @"tel:%@",[NSLocalizedString(@"LTAlert_AutoPayroll.call",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                     ];
	}else if (buttonIndex==3) {
        telString = [NSString stringWithFormat:
                     @"tel:%@",[NSLocalizedString(@"LTAlert_TaxLoan.call",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                     ];
	}else {
        return;
    }
    NSLog(@"call:%@", telString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
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
	
	NSLog(@"AccProUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);
	
	return retValue;
}

-(NSString *) findPlistPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path ;
    path = [documentsDirectory stringByAppendingPathComponent:@"BasePromotion.plist"];
    NSLog(@"findPlist:%@",path);
    return path;
}


+ (BOOL) FileExists
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *FilePath = [documentsDirectory stringByAppendingPathComponent:@"BasePromotion.plist"];
    NSString *LatestPromotionFilePath = [documentsDirectory stringByAppendingPathComponent:@"LatestPromotion.plist"];
	return [[NSFileManager defaultManager] fileExistsAtPath:FilePath] && [[NSFileManager defaultManager] fileExistsAtPath:LatestPromotionFilePath]  ;
}


+ (void) copyFile {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *enFilePath = [documentsDirectory stringByAppendingPathComponent:@"BasePromotion.plist"];
	NSString *enOldfilePath = [[NSBundle mainBundle] pathForResource:@"BasePromotion" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:enOldfilePath
											toPath:enFilePath
											 error:NULL];
    
    NSString *LatestPromotionFilePath = [documentsDirectory stringByAppendingPathComponent:@"LatestPromotion.plist"];
	NSString *LatestPromotionOldFilePath = [[NSBundle mainBundle] pathForResource:@"LatestPromotion" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:LatestPromotionOldFilePath
											toPath:LatestPromotionFilePath
											 error:NULL];
    
}

+(void)showTNC {
	UIViewController *view_controller;
	view_controller = [[AccProTNCViewController alloc] initWithNibName:@"AccProTNCViewController" bundle:nil ];
	[[AccProUtil me].AccPro_view_controller.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
}

-(void)showPopupPromotion
{
    if([self needShow])
    {
        [AccProUtil me]._BasePromotion = [[BasePromotion alloc] initWithNibName:@"BasePromotion" bundle:nil];
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:[AccProUtil me]._BasePromotion.view];
        [[AccProUtil me]._BasePromotion switchMe];
    }
}


-(void)updateBasePromotionPlist//added by jasen on 20111122
{
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[self findPlistPath]];
    NSMutableDictionary *md_temp_bundle = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BasePromotion" ofType:@"plist"]];
    
    NSString *sn_temp = [md_temp objectForKey:@"SN"];
    NSString *sn_temp_bundle = [md_temp_bundle objectForKey:@"SN"];
    
    NSLog(@"updateBasePromotionPlist:%@-%@", md_temp, md_temp_bundle);
    NSLog(@"updateBasePromotionPlist:%@-%@", sn_temp, sn_temp_bundle);
    
    if (![sn_temp isEqualToString:sn_temp_bundle]){
        [md_temp_bundle writeToFile:[self findPlistPath] atomically:YES];
    }else{
        NSLog(@"updateBasePromotionPlist updated");
    }
    
}

-(BOOL)needShow//added by jasen on 20111122
{
    [self updateBasePromotionPlist];
    
    int count;
    
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[AccProUtil me ]findPlistPath]];
    
    NSLog(@"AccProUtil needShow:%@",md_temp);
    NSString *date_stamp = [md_temp objectForKey:@"ClickCount"];
    
    count = [date_stamp intValue];
    
    if(count<3)
        return YES;
    else
        return NO;
    
}


-(NSString *) findPlistPaths{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path  = [documentsDirectory stringByAppendingPathComponent:@"LatestPromotion.plist"];
    
    return path;
}

-(NSString *) findBannerPlistPaths{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path  = [documentsDirectory stringByAppendingPathComponent:@"banner_ts.plist"];
    
    return path;
}

+ (void) updateFundPriceFile:(NSData*)datas{
    NSString *tempFile = [MBKUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newFundList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];
    
    NSMutableArray *promolist = [newFundList objectForKey:@"promotionList"];
    NSDictionary *rsp_item;
    for (int i=0; i<[promolist count]; i++) {
        rsp_item = [promolist objectAtIndex:i];
        NSLog(@"AccProUtil: title_en:%@",[rsp_item objectForKey:@"title_en"]);
    }
    
    NSLog(@"AccProUtil: write plist to disk now.");
    NSString *prompFile = [[AccProUtil me ]findPlistPaths];
    NSLog(@"AccProUtil: Existing plist path:%@",prompFile);
    if (prompFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newFundList writeToFile:prompFile atomically:YES];
}
-(void)sendRequestToGetBannerPlist{
    NSLog(@"AccProUtil: sendRequestToGetBannerPlist");
    self.requestSign = @"banner";
    
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForBannerPlist:self];
    
    [[CoreData sharedCoreData].queue addOperation:request];
}

-(void) sendRequest:(NSString*) date_stamp
 listViewController:(AccProListViewController*)p_AccProListViewController
{
    NSLog(@"AccProUtil: sendRequest:listViewController:%@", date_stamp);
    self.requestSign = @"accprolist";
    strSend = @"YES";
    self._AccProListViewController=p_AccProListViewController;
    
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForLatestPromoPlist:self SN:date_stamp];
    
    [[CoreData sharedCoreData].queue addOperation:request];
    
    [[CoreData sharedCoreData].mask showMask];
}

///////////////////
//ASIHTTPRequest delegate
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
//	NSLog(@"AccProUtil requestFinished:%@",[request responseString]);
    if([self.requestSign isEqualToString:@"accprolist"]){
        [AccProUtil updateFundPriceFile:[request responseData]];
        [[CoreData sharedCoreData].mask hiddenMask];
        [_AccProListViewController loadPlistData];
    }else if([self.requestSign isEqualToString:@"banner"]){
        [self updateBannerPlistAndResetCount:[request responseData]];
        [self showPopupPromotion];
        [[CoreData sharedCoreData].mask hiddenMask];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"AccProUtil requestFailed:%@",[request responseString]);
    //	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
    //	[alert_view show];
    //	[alert_view release];
    if([self.requestSign isEqualToString:@"accprolist"]){
        NSLog(@"AccProUtil requestFailed accprolist");
//        [_AccProListViewController loadPlistData];
        [[CoreData sharedCoreData].mask hiddenMask];
    }else if([self.requestSign isEqualToString:@"banner"]){
        [[CoreData sharedCoreData]._BEAAppDelegate registerFirstNotification];
        NSLog(@"AccProUtil requestFailed banner");
//        [self showPopupPromotion];
        [[CoreData sharedCoreData].mask hiddenMask];
    }
}

-(void)updateBannerPlistAndResetCount:(NSData*)datas{
    NSLog(@"AccProUtil updateBannerPlistAndResetCount");
    NSString *tempFile = [MBKUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newFundList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];
    NSString *newSN =  [newFundList objectForKey:@"SN"];
    
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[AccProUtil me ]findBannerPlistPaths]];
    NSString *localSN = [md_temp objectForKey:@"SN"];
    
    NSLog(@"newSN:%@",newSN);
    NSLog(@"localSN:%@",localSN);
    if(![newSN isEqualToString:localSN]){
        NSLog(@"AccProUtil banner : write plist to disk now.");
        NSString *prompFile = [[AccProUtil me ]findBannerPlistPaths];
        NSLog(@"AccProUtil banner : Existing plist path:%@",prompFile);
        if (prompFile == nil) {
            [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
        }
        [[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
        [newFundList writeToFile:prompFile atomically:YES];
        
        
        //reset clickCount
        NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[AccProUtil me ]findPlistPath]];
        NSString *counts = [NSString stringWithFormat:@"%d",0];
        [md_temp setValue:counts forKey:@"ClickCount"];
        [md_temp writeToFile:[[AccProUtil me ]findPlistPath] atomically:YES];
    }
}

-(BOOL)isSend
{
    return ([self.strSend isEqualToString:@"YES"]);
}

//-(void)setLatestPromoInStockWatch:(UIView*)stockWatchView frame:(CGRect)frame
//{
//    NSLog(@"debug ACCProUtil setLatestPromoInStockWatch");
//    
//    [[AccProUtil me].AccPro_view_controller welcome];
//    [[AccProUtil me].AccPro_view_controller._AccProListViewController.table_view removeFromSuperview];
//    [AccProUtil me].AccPro_view_controller._AccProListViewController.table_view.frame = frame;
//    [stockWatchView addSubview:[AccProUtil me].AccPro_view_controller._AccProListViewController.table_view];
//
//    UIButton* gotoLatestPromo = [[UIButton alloc] initWithFrame:frame];
//    gotoLatestPromo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    gotoLatestPromo.titleLabel.font = [UIFont systemFontOfSize:14];
//    gotoLatestPromo.backgroundColor = [UIColor clearColor];
//    [gotoLatestPromo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [gotoLatestPromo addTarget:self action:@selector(gotoLatestPromo:) forControlEvents:UIControlEventTouchUpInside];
//    [stockWatchView addSubview:gotoLatestPromo];
//
//}
//
//-(void)gotoLatestPromo:(UIButton *)button{
//    self.inStockWatch = @"YES";
//
//    [[AccProUtil me].AccPro_view_controller._AccProListViewController.table_view removeFromSuperview];
//    [[AccProUtil me].AccPro_view_controller goHome2];
//    [[CoreData sharedCoreData].bea_view_controller.navigationController popToRootViewControllerAnimated:NO];
//    [[CoreData sharedCoreData].mask showMask];
//    
//}


@end
