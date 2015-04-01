//
//  InsuranceUtil.m
//  BEA
//
//  Created by NEO on 03/01/12.
//
// Amended by Jasen on 20120330

#import "InsuranceUtil.h"
#import "LangUtil.h"

@implementation InsuranceUtil

@synthesize Insurance_view_controller;
@synthesize strSend;
@synthesize strSendPromo;
@synthesize frompage;
@synthesize reqfor;
@synthesize revolvingLoanUrl;
@synthesize _InsuranceListViewController;
@synthesize quoteAndApply;
@synthesize nextTab;
@synthesize animate;
@synthesize isInIns;
+ (InsuranceUtil *)me
{
	static InsuranceUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[InsuranceUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"InsuranceUtil init");
    self = [super init];
    if (self) {
        self.Insurance_view_controller = nil;
        
        self.strSend = nil;
        self.strSendPromo = nil;
        self.frompage = nil;
        self.reqfor = nil;
        self.revolvingLoanUrl = nil;
        self.quoteAndApply = @"";
        self.nextTab = @"";
        self.animate = @"YES";

        if (![InsuranceUtil FileExists]){
			[InsuranceUtil copyFile];
		}

        if (![InsuranceUtil FileExistsPromo]){
			[InsuranceUtil copyFilePromo];
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

-(BOOL)isSend
{
    return ([self.strSend isEqualToString:@"YES"]);
}

-(BOOL)isSendPromo
{
    return ([self.strSendPromo isEqualToString:@"YES"]);
}

-(void)showNearBy
{
    [CoreData sharedCoreData].lastScreen = @"InsuranceRevamp";
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[CoreData sharedCoreData].root_view_controller setContent:0];
//    [CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    [[CoreData sharedCoreData].main_view_controller pushViewController:[InsuranceUtil me].Insurance_view_controller animated:NO];
    NSLog(@"L209 - Insurance 20140702 InsuranceUtil.m");
    [InsuranceUtil me].Insurance_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
    [[CoreData sharedCoreData].atmlocation_view_controller welcome];
    
    [UIView commitAnimations];

}

-(void)backToFromPage
{
    NSLog(@"InsuranceUtil backToFromPage to:%@", self.frompage);
    if ([self.frompage isEqualToString:@"accpro"]){
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.5];
//        [InsuranceUtil me].Insurance_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
        [[CoreData sharedCoreData].main_view_controller pushViewController:[InsuranceUtil me].Insurance_view_controller animated:NO];
         NSLog(@"L209 - Insurance 20140702 InsuranceUtil.m");
        [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [UIView commitAnimations];
        self.frompage=@"";
       
    }else{
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.5];
//        [InsuranceUtil me].Insurance_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight_20:self];
        [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
        NSLog(@"L209 - Insurance 20140702 InsuranceUtil.m");
//         NSLog(@"InsuranceUtil backToFromPage to:[InsuranceUtil me].Insurance_view_controller.view.center: %f--%f", [InsuranceUtil me].Insurance_view_controller.view.center.x,[InsuranceUtil me].Insurance_view_controller.view.center.y);
        [CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        NSLog(@"InsuranceUtil backToFromPage to:[CoreData sharedCoreData].main_view_controller.view.center: %f--%f", [CoreData sharedCoreData].main_view_controller.view.center.x,[CoreData sharedCoreData].main_view_controller.view.center.y);
//        [[MyScreenUtil me] adjustView2Top0:[CoreData sharedCoreData].main_view_controller.view];
//        [UIView commitAnimations];
    }
    self.frompage=@"";
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
}

-(NSString *) findPlistPaths{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path  = [documentsDirectory stringByAppendingPathComponent:@"Insurance.plist"];
    
    return path;
}

-(NSString *) findPlistPathsPromo{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path  = [documentsDirectory stringByAppendingPathComponent:@"InsurancePromo.plist"];
    
    return path;
}

+ (BOOL) FileExists
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *FilePath = [documentsDirectory stringByAppendingPathComponent:@"Insurance.plist"];
	return [[NSFileManager defaultManager] fileExistsAtPath:FilePath] ;
}

+ (void) copyFile {	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *enFilePath = [documentsDirectory stringByAppendingPathComponent:@"Insurance.plist"];
	NSString *enOldfilePath = [[NSBundle mainBundle] pathForResource:@"Insurance" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:enOldfilePath
											toPath:enFilePath
											 error:NULL];    
}

+ (BOOL) FileExistsPromo
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *FilePath = [documentsDirectory stringByAppendingPathComponent:@"InsurancePromo.plist"];
	return [[NSFileManager defaultManager] fileExistsAtPath:FilePath] ;
}

+ (void) copyFilePromo {	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *enFilePath = [documentsDirectory stringByAppendingPathComponent:@"InsurancePromo.plist"];
	NSString *enOldfilePath = [[NSBundle mainBundle] pathForResource:@"InsurancePromo" ofType:@"plist"];
	[[NSFileManager defaultManager] copyItemAtPath:enOldfilePath
											toPath:enFilePath
											 error:NULL];    
}

-(void) sendRequest:(NSString*) date_stamp
 listViewController:(id)p_InsuranceListViewController
{
    NSLog(@"InsuranceUtil: sendRequest:%@", date_stamp);
    
    strSend = @"YES";
    reqfor = @"product";
    
    self._InsuranceListViewController = p_InsuranceListViewController;
    
//    ASIFormDataRequest *request = [HttpRequestUtils getRequestForConsumerLoanPlist:self SN:date_stamp];
    
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForInsurancePlist:self SN:date_stamp];
    
    [[CoreData sharedCoreData].queue addOperation:request];
    
    [[CoreData sharedCoreData].mask showMask];
}

-(void) sendRequestPromo:(NSString*) date_stamp
 listViewController:(id)p_InsuranceNewsViewController
{
    NSLog(@"InsuranceUtil: sendRequest:%@", date_stamp);
    
    strSendPromo = @"YES";
    reqfor = @"promo";
    
    self._InsuranceListViewController = p_InsuranceNewsViewController;
    
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForInsurancePlistPromo:self SN:date_stamp];
    
    [[CoreData sharedCoreData].queue addOperation:request];
    
    [[CoreData sharedCoreData].mask showMask];
}


///////////////////
//ASIHTTPRequest
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	NSLog(@"InsuranceUtil requestFinished:%@",[request responseString]);
	[InsuranceUtil updateFundPriceFile:[request responseData]];
	[[CoreData sharedCoreData].mask hiddenMask];
    [_InsuranceListViewController loadPlistData];
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
        NSLog(@"InsuranceUtil: title_en:%@",[rsp_item objectForKey:@"title_en"]);
    }
    
    NSLog(@"InsuranceUtil: write plist to disk now.");
    NSString *prompFile =nil;
    
    if ([[InsuranceUtil me].reqfor isEqualToString:@"product"]) {
        prompFile= [[InsuranceUtil me ]findPlistPaths];
    }else if ([[InsuranceUtil me].reqfor isEqualToString:@"promo"]) {
        prompFile= [[InsuranceUtil me ]findPlistPathsPromo];
    }
    
    NSLog(@"InsuranceUtil: Existing plist path:%@",prompFile);
    if (prompFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newFundList writeToFile:prompFile atomically:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"InsuranceUtil requestFailed:%@", request.error);
    [_InsuranceListViewController loadPlistData];
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void)showInsuranceViewController:(NSString*) lastScreenName url:(NSString*)url hotline:(NSString*)hotline btnLanel:(NSString*) btnLabel//added by jasen on 20111118
{
    self.frompage = lastScreenName;
    self.revolvingLoanUrl = url;
    
    NSLog(@"InsuranceUtil showInsuranceViewController from:%@", self.frompage);
    
    if ([self.frompage isEqualToString:@"accpro"]){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[CoreData sharedCoreData].root_view_controller setContent:0];
        [self showInsuranceOffersViewController:url hotline:hotline btnLanel:(NSString*) btnLabel];
//        [InsuranceUtil me].Insurance_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
         [[CoreData sharedCoreData].main_view_controller pushViewController:[InsuranceUtil me].Insurance_view_controller animated:NO];
        NSLog(@"L209 - Insurance 20140702 InsuranceUtil.m");
        [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//        [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
        [UIView commitAnimations];
    }
}

-(void)showInsuranceOffersViewController:(NSString*)url hotline:(NSString*)hotline btnLanel:(NSString*) btnLabel//added by jasen on 20111118
{    RootViewController* _RootViewController = (RootViewController*)[[InsuranceUtil me].Insurance_view_controller.navigationController.viewControllers objectAtIndex:0];
    [_RootViewController.navigationController popToRootViewControllerAnimated:TRUE];
    InsuranceOffersViewController* current_view_controller = [[InsuranceOffersViewController alloc] initWithNibName:@"InsuranceOffersViewController" bundle:nil url:url hotline:hotline caption:btnLabel];
    NSLog(@"InsuranceUtil current_view_controller:%@--%@",current_view_controller,url);
    [_RootViewController.navigationController pushViewController:current_view_controller animated:TRUE];
}

-(void)showInsuranceViewController:(NSString*)targeturl hotline:(NSString*)hotline caption: (NSString*)caption type:(int)type{
    InsuranceOffersViewController *insuranceOffersViewController =nil;
    
    insuranceOffersViewController = [[InsuranceOffersViewController alloc] initWithNibName:@"InsuranceOffersViewController" bundle:nil url:targeturl hotline:hotline caption:caption];
    insuranceOffersViewController.show = type;
    [[InsuranceUtil me].Insurance_view_controller.navigationController pushViewController:insuranceOffersViewController animated:NO];
}

@end
