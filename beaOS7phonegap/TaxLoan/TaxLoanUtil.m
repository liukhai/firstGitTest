//
//  TaxLoanUtil.m
//  BEA
//
//  Created by YAO JASEN on 10/20/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "TaxLoanUtil.h"


@implementation TaxLoanUtil

@synthesize taxLoanViewController;
@synthesize strSend;
@synthesize _ConsumerLoanListViewController;

+ (TaxLoanUtil *)me
{
	static TaxLoanUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[TaxLoanUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"TaxLoanUtil init");
    self = [super init];
    if (self) {
        self.taxLoanViewController = nil;      
        self.strSend = nil;
        
		if (![TaxLoanUtil FileExists]){
			[TaxLoanUtil copyFile];
		}
    }
    
    return self;
}
-(NSString *) findPlistPaths{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path  = [documentsDirectory stringByAppendingPathComponent:@"TaxLoanMenu.plist"];
    
    return path;
}

+ (BOOL) FileExists
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *FilePath = [documentsDirectory stringByAppendingPathComponent:@"TaxLoanMenu.plist"];
	return [[NSFileManager defaultManager] fileExistsAtPath:FilePath] ;
}


+ (void) copyFile {	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *enFilePath = [documentsDirectory stringByAppendingPathComponent:@"TaxLoanMenu.plist"];
	NSString *enOldfilePath = [[NSBundle mainBundle] pathForResource:@"TaxLoanMenu" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:enOldfilePath
											toPath:enFilePath
											 error:NULL];    
}

+(void)showTNC{
	UIViewController *view_controller;
    //	[[CoreData sharedCoreData].taxLoan_view_controller.navigationController popToRootViewControllerAnimated:FALSE];
	view_controller = [[TaxLoanTNCViewController alloc] initWithNibName:@"TaxLoanTNCViewController" bundle:nil];
	[[CoreData sharedCoreData].taxLoan_view_controller.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
}

+(void)showLoanOffers{
	UIViewController *view_controller;
    //	[[CoreData sharedCoreData].taxLoan_view_controller.navigationController popToRootViewControllerAnimated:FALSE];
	view_controller = [[TaxLoanOffersViewController alloc] initWithNibName:@"TaxLoanOffersViewController" bundle:nil];
	[[CoreData sharedCoreData].taxLoan_view_controller.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
}
/*
 +(void)showRepaymentTable{
 UIViewController *view_controller;
 //	[[CoreData sharedCoreData].taxLoan_view_controller.navigationController popToRootViewControllerAnimated:FALSE];
 view_controller = [[TaxLoanRepaymentTableViewController alloc] initWithNibName:@"TaxLoanRepaymentTableViewController" bundle:nil];
 [[CoreData sharedCoreData].taxLoan_view_controller.navigationController pushViewController:view_controller animated:TRUE];
 [view_controller release];
 }
 */
-(void)callToApply{
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TaxLoanCallApply",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==1) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(@"TaxLoanApplyHotline",nil)]];
	}
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
	
	NSLog(@"TaxLoanUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);
	[df release];
	return retValue;
}

-(void) sendRequest:(NSString*) date_stamp
 listViewController:(ConsumerLoanListViewController*)p_ConsumerLoanListViewController
{
    NSLog(@"TaxLoanUtil: sendRequest:%@", date_stamp);
    
    strSend = @"YES";
    self._ConsumerLoanListViewController=p_ConsumerLoanListViewController;
    
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForConsumerLoanPlist:self SN:date_stamp];
    
    [[CoreData sharedCoreData].queue addOperation:request];
    
    [[CoreData sharedCoreData].mask showMask];
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
        NSLog(@"TaxLoanUtil: title_en:%@",[rsp_item objectForKey:@"title_en"]);
    }
    
    NSLog(@"TaxLoanUtil: write plist to disk now.");
    NSString *prompFile = [[TaxLoanUtil me ]findPlistPaths];
    NSLog(@"TaxLoanUtil: Existing plist path:%@",prompFile);
    if (prompFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newFundList writeToFile:prompFile atomically:YES];
}

///////////////////
//ASIHTTPRequest
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	NSLog(@"TaxLoanUtil requestFinished:%@",[[request responseString] substringToIndex:100]);
	[TaxLoanUtil updateFundPriceFile:[request responseData]];
	[[CoreData sharedCoreData].mask hiddenMask];
    [_ConsumerLoanListViewController loadPlistData];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"TaxLoanUtil requestFailed:%@", request.error);
    //	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
    //	[alert_view show];
    //	[alert_view release];
    [_ConsumerLoanListViewController loadPlistData];
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(BOOL)isSend
{
    return ([self.strSend isEqualToString:@"YES"]);
}

@end
