//amended by jasen on 20120817

#import "MPFUtil.h"

@implementation MPFUtil

@synthesize _MPFImportantNoticeViewController;
@synthesize MPF_view_controller,serviceFlag;
@synthesize caller;
@synthesize MPFserverFlag;
@synthesize fund_request,mt_request,ind_request;
@synthesize callMBKMPF;
@synthesize callMBKMPFBalance;
@synthesize strSend;
@synthesize strSendImportantNotice;
@synthesize strSendEnquiry;

+ (MPFUtil *)me
{
	static MPFUtil *me;

	@synchronized(self)
	{
		if (!me)
			me = [[MPFUtil alloc] init];

		return me;
	}
}

- (id)init
{
	NSLog(@"MPFUtil init");
    self = [super init];
    if (self) {

        self._MPFImportantNoticeViewController = [[MPFImportantNoticeViewController alloc] initWithNibName:@"MPFImportantNoticeViewController" bundle:nil];

        self.strSend = nil;
        self.MPF_view_controller = nil;
        isFundPlistValid = FALSE;
        isNotemtPlistValid = FALSE;
        isNoteindPlistValid = FALSE;
        isEnquiryPlistValid = FALSE;
        isImportantNoticePlistValid = FALSE;

    }

    return self;
}

+ (NSString *)getDocTempFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [NSString stringWithFormat:@"%@-%f", [documentsDirectory stringByAppendingPathComponent:@"temp"], [[NSDate date] timeIntervalSince1970]];

	return filePath;
}

-(NSString *) findImportantNoticePlistPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MPFImportantNotice.plist"];

    return path;
}

-(NSString *) findEnquiryPlistPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MPFEnquiry.plist"];

    return path;
}

+ (BOOL) FileExists
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *FilePath = [documentsDirectory stringByAppendingPathComponent:@"MPFImportantNotice.plist"];
    NSString *LatestPromotionFilePath = [documentsDirectory stringByAppendingPathComponent:@"MPFImportantNotice.plist"];
	return [[NSFileManager defaultManager] fileExistsAtPath:FilePath] && [[NSFileManager defaultManager] fileExistsAtPath:LatestPromotionFilePath]  ;
}

-(void) checkImportantNoticePlist
{
    if (![MPFUtil FileExists]){
        [[MPFUtil me] sendRequestMPFImportantNoticePlist:nil];
        return;
    }
    NSMutableDictionary *md_temp = [NSMutableDictionary  dictionaryWithContentsOfFile:[[MPFUtil me ] findImportantNoticePlistPath]];
    NSString *date_stamp = [md_temp objectForKey:@"SN"];
    [[MPFUtil me] sendRequestMPFImportantNoticePlist:date_stamp];

}

+ (BOOL) FileExists2
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *FilePath = [documentsDirectory stringByAppendingPathComponent:@"MPFEnquiry.plist"];
    NSString *LatestPromotionFilePath = [documentsDirectory stringByAppendingPathComponent:@"MPFEnquiry.plist"];
	return [[NSFileManager defaultManager] fileExistsAtPath:FilePath] && [[NSFileManager defaultManager] fileExistsAtPath:LatestPromotionFilePath]  ;
}

-(void) checkEnquiryPlist
{
    if (![MPFUtil FileExists2]){
        [[MPFUtil me] sendRequestMPFEnquiryPlist:nil];
        return;
    }
    NSMutableDictionary *md_temp = [NSMutableDictionary  dictionaryWithContentsOfFile:[[MPFUtil me ] findEnquiryPlistPath]];
    NSString *date_stamp = [md_temp objectForKey:@"SN"];
    [[MPFUtil me] sendRequestMPFEnquiryPlist:date_stamp];

}

+ (void) updateImportantNoticeFile:(NSData*)datas
{
    NSString *tempFile = [MPFUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newNoteList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];

    NSString *fundFile = [[MPFUtil me] findImportantNoticePlistPath];
    if (fundFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newNoteList writeToFile:fundFile atomically:YES];
    NSLog(@"writed file:%@",fundFile);
}

+ (void) updateEnquiryFile:(NSData*)datas
{
    NSString *tempFile = [MPFUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newNoteList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];

    NSString *fundFile = [[MPFUtil me] findEnquiryPlistPath];
    if (fundFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newNoteList writeToFile:fundFile atomically:YES];
    NSLog(@"writed file:%@",fundFile);

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"MPFUtil webViewDidFinishLoad");

}

+(void)showLoanOffers{
	UIViewController *view_controller;

	view_controller = [[MPFPromoViewController alloc] initWithNibName:@"MPFPromoViewController" bundle:nil];
	[[MPFUtil me].MPF_view_controller.navigationController pushViewController:view_controller animated:TRUE];
	[view_controller release];
}

-(void)callToApply{
    self.serviceFlag = @"phone";
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"MPFCallApply",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) openMBK
{
    self.callMBKMPF=@"Y";

    UIButton* acc_pro_button=[[UIButton alloc] init];
    acc_pro_button.tag=1;
    [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
    [self._MPFImportantNoticeViewController hiddenMe];
    [acc_pro_button release];

}

-(BOOL) is_callMBKMPF
{
    return [self.callMBKMPF isEqualToString:@"Y"];
}

-(void)do_callMBKMPFBalance
{
    self.callMBKMPFBalance=@"Y";
    [self alertAndBackToMBKMPF];
}

-(BOOL) is_callMBKMPFBalance
{
    return [self.callMBKMPFBalance isEqualToString:@"Y"];
}

-(NSString*) getReqParam
{
    NSString *ret=nil;
    NSString *part1 = nil;
    NSString *part2 = nil;

    if ([self is_callMBKMPF]){
        part1 = @"&MPF=Y";
    }else{
        part1 = @"&MPF=N";
    }

    if ([self is_callMBKMPFBalance]){
        part2 = @"&MPFBal=Y";
    }else{
        part2 = @"&MPFBal=N";
    }

    ret = [part1 stringByAppendingString:part2];

    self.callMBKMPF=@"N";
    self.callMBKMPFBalance=@"N";

    return ret;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([serviceFlag isEqualToString:@"phone"]){
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(@"MPFApplyHotline",nil)]];
        }
    }else if ([serviceFlag isEqualToString:@"backtomain"]){
        [self goHome];
    }else if ([serviceFlag isEqualToString:@"callHotline"]){
        if (buttonIndex==1) {

            NSString *telString = [NSString stringWithFormat:
                                   @"tel:%@",[NSLocalizedString(@"mpf.enquiries.phone",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                                   ];
            NSLog(@"%@", telString);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
        }

    }
}

-(void)call_Logintomobilebanking
{
    [[MPFUtil me].MPF_view_controller goHome];
    [[MPFUtil me] openMBK];
}

-(void)call_CallMPFhotline
{
    serviceFlag = @"callHotline";

    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"mpf.enquiries.phone",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
    [alert_view show];
    [alert_view release];
}

+ (BOOL) isValidUtil
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
	NSDate *now_date = [NSDate date];

	NSDate *start_date = [df dateFromString:@"20110101"];
	NSDate *end_date = [df dateFromString:@"20121231"];

	BOOL retValue=NO;
	if ([now_date isEqualToDate:start_date]
		|| [now_date isEqualToDate:end_date]
		|| ( (NSOrderedDescending == [now_date compare:start_date]) && (NSOrderedAscending == [now_date compare:end_date]) )
		)
	{
		retValue=YES;
	}

	NSLog(@"MPFUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);

	return retValue;
}

-(NSString *) findMPFPromoPlistPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path ;
    path = [documentsDirectory stringByAppendingPathComponent:@"mpfpromo.plist"];
    return path;
}

-(NSString *) findFundPricePlistPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path ;
    path = [documentsDirectory stringByAppendingPathComponent:@"MPF_Fund_Price.plist"];
    return path;
}

+ (void) updateMPFPromoPlist:(NSData*)datas{
    NSString *tempFile = [MBKUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newFundList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];
    NSLog(@"MPFUtil: write mpf promo list to disk now.");
    NSString *fundFile = [[MPFUtil me ]findMPFPromoPlistPath];
    if (fundFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newFundList writeToFile:fundFile atomically:YES];
}

+ (void) updateFundPriceFile:(NSData*)datas{
    NSString *tempFile = [MBKUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newFundList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];
    NSLog(@"MPFUtil: write fund price list to disk now.");
    NSString *fundFile = [[MPFUtil me ]findFundPricePlistPath];
    if (fundFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newFundList writeToFile:fundFile atomically:YES];
}

+ (void) updateFootNotePriceFile:(NSData*)datas{
    NSString *tempFile = [MBKUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newFundList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];
    NSLog(@"MPFUtil: write fund price list to disk now.");

    NSString *fundFile = [[MPFUtil me ]findFundPriceNotePlistPath];
    if (fundFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newFundList writeToFile:fundFile atomically:YES];
}


+ (BOOL)checkPlistValid:(NSData*)datas plistFlag:(NSString*)flag{

    BOOL isValid = TRUE;

    NSString *tempFile = [MBKUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    [datas writeToFile:tempFile atomically:YES];

    NSMutableDictionary *newFundList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];

    if([flag isEqualToString:@"ImportantNotice"]){

        NSString * newDateStamp = [newFundList objectForKey:@"SN"];
        NSLog(@"MPFUtil: newDateStamp:%@",newDateStamp);
        if (newDateStamp==nil){
            isValid = FALSE;
        }

    }else if([flag isEqualToString:@"fundprice"]){

        NSString * newDateStamp = [newFundList objectForKey:@"DateStamp"];
        NSArray *newSchemeArray = [newFundList objectForKey:@"SchemeList"];
        NSArray *newPriceArray = [newFundList objectForKey:@"FundPriceList"];
        NSLog(@"MPFUtil: newDateStamp:%@",newDateStamp);
        NSLog(@"MPFUtil: newSchemeArray count:%d",[newSchemeArray count]);
        NSLog(@"MPFUtil: newPriceArray count:%d",[newPriceArray count]);
        if (newDateStamp==nil || [newDateStamp isEqualToString:@""] || [newSchemeArray count] < 1 || [newPriceArray count] < 1){
            isValid = FALSE;
        }

    }else if([flag isEqualToString:@"footnote"]){

        NSArray *newnote = [newFundList objectForKey:@"note"];
        NSLog(@"MPFUtil: newnote count:%d",[newnote count]);
        if ([newnote count] < 1){
            isValid = FALSE;
        }
    }

    [[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];

    return isValid;
}

-(NSString *) findFundPriceNotePlistPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"mpfNotes.plist"];

    NSLog(@"findFundPriceNotePlistPath, %@", path);

    return path;
}


-(void)alertAndBackToMain{
    self.serviceFlag = @"backtomain";

    [self releaseResource];

    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
}

-(void)alertAndBackToMain:(UIViewController*)outViewController{
	[self alertAndBackToMain];
    if(!outViewController) [outViewController dealloc];
}

-(void)alertAndBackToMBKMPF{
    self.serviceFlag = @"BackToMBKMPF";
    NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
    if (user_setting==nil || [[user_setting objectForKey:@"encryted_banking"] length]<=0) {
        [self.MPF_view_controller showBtnView];
    }else{

        self.callMBKMPF=@"Y";

        [MobileTradingUtil me].requestServer=@"MOBILEBANKING";//added by jasen
        NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
        if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
            [[CoreData sharedCoreData].bea_view_controller checkMBKRegStatus];
        } else {
            SettingViewController* setting_controller = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
            [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:setting_controller animated:TRUE];
            [setting_controller release];
        }

//        [MPFUtil me].MPF_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
        [[CoreData sharedCoreData].main_view_controller pushViewController:[MPFUtil me].MPF_view_controller animated:NO];
        [CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];

    }
}

- (void)goHome{
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
    [[CoreData sharedCoreData].main_view_controller pushViewController:[MPFUtil me].MPF_view_controller animated:NO];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
//	[MPFUtil me].MPF_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//	[UIView commitAnimations];
}

- (void) loadImportantNotice:(UIViewController *) pcaller
{
    self.caller = pcaller;
    [self checkImportantNoticePlist];
}


- (void) loadEnquiry:(UIViewController *) pcaller
{
    self.caller = pcaller;
    [self checkEnquiryPlist];
}

#pragma mark - checking app server of MPF
- (void) checkingMPFServerReady:(UIViewController *) pcaller{
    self.caller = pcaller;
    [self sendRequest];
}

-(void) sendRequest{
    NSLog(@"MPFFundPrice: sendRequest .");
    self.MPFserverFlag = @"fundprice";
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForFundPricePlist:self];

    [[CoreData sharedCoreData].queue addOperation:request];

    [[CoreData sharedCoreData].mask showMask];
}

-(void) sendRequestfootmt{
    NSLog(@"MPFFundPrice: sendRequestfootmt.");
    self.MPFserverFlag = @"footnote";
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForFootNotePlist:self plistFlag:self.MPFserverFlag];

    [[CoreData sharedCoreData].queue addOperation:request];
}

-(void) sendRequestMPFPromoPlist:(NSString*) date_stamp
              listViewController:(MPFPromoListViewController*)p_AccProListViewController
{
    NSLog(@"MPFUtil: sendRequestMPFPromoPlist .");
    self.caller = p_AccProListViewController;
    self.MPFserverFlag = @"promo";
    strSend = @"YES";
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForMPFPromoPlist:self SN:date_stamp];

    [[CoreData sharedCoreData].queue addOperation:request];

    [[CoreData sharedCoreData].mask showMask];
}

-(void) sendRequestMPFImportantNoticePlist:(NSString*) date_stamp
{
    NSLog(@"MPFUtil: sendRequestMPFImportantNoticePlist .");
    self.MPFserverFlag = @"ImportantNotice";
    self.strSendImportantNotice = @"YES";
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForMPFImportantNoticePlist:self SN:date_stamp];

    [[CoreData sharedCoreData].queue addOperation:request];

    [[CoreData sharedCoreData].mask showMask];
}

-(void) sendRequestMPFEnquiryPlist:(NSString*) date_stamp
{
    NSLog(@"MPFUtil: sendRequestMPFEnquiryPlist .");
    self.MPFserverFlag = @"Enquiry";
    self.strSendEnquiry = @"YES";
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForMPFEnquiryPlist:self SN:date_stamp];

    [[CoreData sharedCoreData].queue addOperation:request];

    [[CoreData sharedCoreData].mask showMask];
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
//    NSLog(@"MPFFundPrice: request finish:%@", reponsedString);

    if (!reponsedString || [reponsedString isEqualToString:@""]) {
        [[MPFUtil me] alertAndBackToMain];
        return;
    }
    [self updateData:request];
}

- (void)updateData:(ASIHTTPRequest *)request {
    NSLog(@"updateData for %@ ",self.MPFserverFlag);

    if([self.MPFserverFlag isEqualToString:@"Enquiry"]){

        if(![MPFUtil checkPlistValid:[request responseData] plistFlag:self.MPFserverFlag]){
            [[MPFUtil me] alertAndBackToMain];
            return;
        }

        isEnquiryPlistValid = TRUE;
        [MPFUtil updateEnquiryFile:[request responseData]];
        [(MPFEnquiryViewController*)caller showContents];
        [[CoreData sharedCoreData].mask hiddenMask];
        return;

    }else if([self.MPFserverFlag isEqualToString:@"ImportantNotice"]){

        if(![MPFUtil checkPlistValid:[request responseData] plistFlag:self.MPFserverFlag]){
            if ([MPFUtil FileExists]){
                isImportantNoticePlistValid = TRUE;
                [(MPFImportantNoticeViewController*)caller showMe];
                [[CoreData sharedCoreData].mask hiddenMask];
                return;
            }
            [[MPFUtil me] alertAndBackToMain];
            return;
        }

        isImportantNoticePlistValid = TRUE;
        [MPFUtil updateImportantNoticeFile:[request responseData]];
        [(MPFImportantNoticeViewController*)caller showMe];
        [[CoreData sharedCoreData].mask hiddenMask];
        return;

    }else if([self.MPFserverFlag isEqualToString:@"fundprice"]){

        if(![MPFUtil checkPlistValid:[request responseData] plistFlag:self.MPFserverFlag]){
            [[MPFUtil me] alertAndBackToMain];
            return;
        }

        isFundPlistValid = TRUE;
        fund_request = request;
        [self sendRequestfootmt];

    }else if([self.MPFserverFlag isEqualToString:@"footnote"]){
        if(![MPFUtil checkPlistValid:[request responseData] plistFlag:self.MPFserverFlag]){

            [[MPFUtil me] alertAndBackToMain];
            return;
        }
        isNotemtPlistValid = TRUE;
        mt_request = request;

    }else if([self.MPFserverFlag isEqualToString:@"promo"]){
        [MPFUtil updateMPFPromoPlist:[request responseData]];
        [[CoreData sharedCoreData].mask hiddenMask];
        [(MPFPromoListViewController*)caller loadPlistData];
        return;
    }

    if(isNotemtPlistValid && isFundPlistValid){

        [MPFUtil updateFundPriceFile:[fund_request responseData]];
        [MPFUtil updateFootNotePriceFile:[mt_request responseData]];

        [self releaseResource];

        if([caller class]==[MPFFundPriceViewController class]){

            [(MPFFundPriceViewController*)caller showContents];

        }else if([caller class]==[MPFImportantNoticeViewController class]){

            [(MPFImportantNoticeViewController*)caller showMe];
        }

    }

}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"MPFFundPrice: request failed.:%@", request.error);
    
    isFundPlistValid = FALSE;
    isNotemtPlistValid = FALSE;
    isNoteindPlistValid = FALSE;
    [[CoreData sharedCoreData].mask hiddenMask];
    [[MPFUtil me] alertAndBackToMain];
}


-(void) releaseResource
{
    isFundPlistValid = FALSE;
    isNotemtPlistValid = FALSE;
    isNoteindPlistValid = FALSE;
    
    //    if (fund_request!=nil) [fund_request release];
    //    if (mt_request!=nil) [mt_request release];
    //    if (ind_request!=nil) [ind_request release];
    
    [[CoreData sharedCoreData].mask hiddenMask];
    
}

-(BOOL)isSend
{
    return ([self.strSend isEqualToString:@"YES"]);
}

@end
