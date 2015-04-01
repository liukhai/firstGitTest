//
//  BEAAppDelegate.m
//  BEA
//
//  Created by Algebra Lo on 10年6月25日.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BEAAppDelegate.h"
#import "BEAViewController.h"
//#import "TVOutManager.h"
#import "MPFViewController.h"
#import "AccProViewController.h"
#import "InstalmentLoanUtil.h"
//#import "UATUtil.h"
#import "ConsumerLoanUtil.h"
#import "InsuranceUtil.h"
#import "SideMenuUtil.h"
#import "MoreMenuUtil.h"
#import "UserDefaultUtil.h"
#import "ICouponCompleteViewController.h"

#define AlertActionSkip    1
#define AlertActionPrivileges   2
#define AlertAciontMainpage     3

@implementation BEAAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize isClick;
@synthesize openSideMenu;
@synthesize openProperty;
@synthesize openImportant;

#pragma mark -
#pragma mark Application lifecycle

- (NSUInteger)application:(UIApplication *)application
    supportedInterfaceOrientationsForWindow:(UIWindow *)window {

    NSUInteger orientations = UIInterfaceOrientationMaskPortrait;
    
    if ([[CoreData sharedCoreData].bea_view_controller.isInStockWatch isEqualToString:@"YES"]) {
        orientations |= UIInterfaceOrientationMaskLandscapeLeft;
        orientations |= UIInterfaceOrientationMaskLandscapeRight;
        if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft ||
            [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight ||
            [UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
            if([CoreData sharedCoreData].bea_view_controller.m_oMHBEAFAQuoteViewController != nil){
                [[CoreData sharedCoreData].bea_view_controller.m_oMHBEAFAQuoteViewController shouldAutorotateToInterfaceOrientation:[UIDevice currentDevice].orientation];
//                NSLog(@"supportedInterfaceOrientationsForWindow:%d", [UIDevice currentDevice].orientation);
                if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                        self.window.frame=CGRectMake(0, 20, 320,[[MyScreenUtil me] getScreenHeight]);
                    }
                }
            }
        }
    }
    
    return orientations;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [application setStatusBarStyle:UIStatusBarStyleLightContent];//黑体白字
    }
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [UserDefaultUtil writeToDocument];
        if ([[[UserDefaultUtil readUserDefault] objectForKey:@"NotInstalledAndFirstOpenApp"] isEqualToString:@"NO"] || [userDefaultes boolForKey:@"notification_onOroff"]) {
            [application registerForRemoteNotifications];
            [userDefaultes setBool:true forKey:@"notification_onOroff"];
        }
    }
    
    [[LangUtil me] getLangFromplist];
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        BOOL notNotInstalledAndFirstOpenApp = [userDefaultes integerForKey:@"NotInstalledAndFirstOpenApp"];
        
        if (!notNotInstalledAndFirstOpenApp) {
            if ([[[LangUtil me] getLanguage] hasPrefix:@"zh"]) {
                [[LangUtil me] setLang_hant];
            }else{
                [[LangUtil me] setLang_en];
            }
        }
//    }
    


    
    // Set App language as ch default.
//    if ([[[LangUtil me] getLangPref] isEqualToString:@"zh-Hant"] ||  [[[LangUtil me] getLangPref] isEqualToString:@"ch"]) {
//        [[LangUtil me] setLang_hant];
//        [[SideMenuUtil me] requestMenuDatas];
//        [[MoreMenuUtil me] setMoreMenuViews];
//    }
    
    // Add the view controller's view to the window and display.
    [window makeKeyAndVisible];

    [CoreData sharedCoreData]._BEAAppDelegate = self;

    [self setupViews:nil];
//    [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(setupViews:) userInfo:nil repeats:TRUE];
    hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, [[MyScreenUtil me] getScreenHeight])];
    hiddenView.backgroundColor = [UIColor clearColor];
    
    BOOL isRegisterRemoteiOS8;
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        isRegisterRemoteiOS8 = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    }
    
    if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] > 0 || isRegisterRemoteiOS8) {
        NSLog(@"launchOptions%@",launchOptions);
        NSDictionary *remoteNotification = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        if (remoteNotification) {
            NSLog(@"远程推送");
            NSLog(@"launchOptions objectForKey:%@",remoteNotification);
            if ([[remoteNotification objectForKey:@"ACT"] isEqualToString:@"2"]) {
                [self goPrivilege];
            }
            if ([[remoteNotification objectForKey:@"ACT"] isEqualToString:@""] || [remoteNotification objectForKey:@"ACT"] == nil ) {
                [self goMainPage];
            }
            if ([[remoteNotification objectForKey:@"ACT"] isEqualToString:@"1"]) {
                return nil;
            }
        }
        
    }
    
    //i-Coupon Timer if running
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    /*
     NSMutableDictionary *dic = [NSMutableDictionary new];
     [dic setObject:self.data_couponDetails forKey:@"data_couponDetails"];
     [dic setObject:self.data_response forKey:@"data_response"];
     [dic setObject:self.codeType forKey:@"codeType"];
     [dic setObject:[NSNumber numberWithInt: self.style] forKey:@"style"];
     [dic setObject:[NSDate date] forKey:@"date"];
     [defaults setObject:dic forKey:@"couponTimer"];
     */
    if([defaults valueForKey:@"couponTimer"]){
        NSDictionary *data_couponDetails = [[defaults valueForKey:@"couponTimer"] valueForKey:@"data_couponDetails"];
        NSDictionary *data_response = [[defaults valueForKey:@"couponTimer"] valueForKey:@"data_response"];
        //        NSString *codeType = [[defaults valueForKey:@"couponTimer"] valueForKey:@"codeType"];
        NSNumber *style = [[defaults valueForKey:@"couponTimer"] valueForKey:@"style"];
        NSDate *couponStartTime =  [[defaults valueForKey:@"couponTimer"] valueForKey:@"date"];
        //Count time
        NSDate *currentTime = [NSDate date];
        NSDate *couponExpireDate = [couponStartTime dateByAddingTimeInterval:[[[data_response valueForKey:@"coupon_use"] valueForKey:@"show_code_time"] integerValue] * 60];
        
        //Coupon no expired.
        if( [currentTime compare:couponExpireDate] == NSOrderedAscending){
            ICouponCompleteViewController * v_comCoupon = [[ICouponCompleteViewController alloc] initWithNibName:@"ICouponCompleteViewController" bundle:nil];
            v_comCoupon.style = [style intValue];
            v_comCoupon.data_couponDetails = data_couponDetails;
            v_comCoupon.data_response = data_response;
            NSTimeInterval distanceBetweenDates = [couponExpireDate timeIntervalSinceDate:currentTime];
            v_comCoupon.remainTime = [NSNumber numberWithInt:(int)distanceBetweenDates];
            
            [[CoreData sharedCoreData].root_view_controller setContent:0];
            
            v_comCoupon.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
            
            
            
            //            [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:NO];
            //            [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:v_comCoupon animated:YES];
            
            [[CoreData sharedCoreData].main_view_controller presentViewController:v_comCoupon animated:YES completion:nil];
            v_comCoupon.v_rmvc.btnBack.hidden = YES;
            v_comCoupon.v_rmvc.btnMore.hidden = YES;
            v_comCoupon.v_rmvc.btnHome.hidden = YES;
            [v_comCoupon release];
        }else{
            [defaults removeObjectForKey:@"couponTimer"];
            [defaults synchronize];
        }
        
    }
    return YES;
}

- (void)setupViews:(NSTimer *)timer
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    if ([userDefaultes integerForKey:@"NotInstalledAndFirstOpenApp"]) {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
//        [CoreData sharedCoreData].bea_view_controller.notification_onOroff = true;
//        [userDefaultes setBool:true forKey:@"notification_onOroff"];
//    }else {
        BOOL notification_onoff = [userDefaultes integerForKey:@"notification_onOroff"];
        if (notification_onoff) {
            [CoreData sharedCoreData].bea_view_controller.notification_onOroff = true;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        }else{
            [CoreData sharedCoreData].bea_view_controller.notification_onOroff = false;
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguage" object:nil];
    //    [timer invalidate];
    //    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //    [[UATUtil me] getUATPreTest];
    // Override point for customization after application launch.
    
	//[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
	got_new_request = FALSE;
    
    [[SideMenuUtil me] initMenuViewPre:menu_view];
    
    [self readToSetup];
    
    //    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    //     UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    //    if (type >=4) {
    //        [CoreData sharedCoreData].bea_view_controller.notification_onOroff = true;
    //    }else{
    //        [CoreData sharedCoreData].bea_view_controller.notification_onOroff = false;
    //    }

    
       //    NSLog(@"UIRemoteNotificationType2 :%d",type);
}

-(void)readToSetup
{
    // Add the view controller's view to the window and display.
//    NSLog(@"debug 20131224: menu_view    %@" ,menu_view);
//    [[MyScreenUtil me] adjustNavView:window];
//    NSLog(@"debug 20140128: window    %@" ,window);
//    [window setBackgroundColor:[UIColor blackColor]];
    [window addSubview:menu_view];
    [[MyScreenUtil me] adjustNavView:navigationController.view];
    NSLog(@"debug 20140128: navigationController.view    %@" ,navigationController.view);
    [window addSubview:navigationController.view];

    [window setRootViewController:navigationController];
	[CoreData sharedCoreData].main_view_controller = navigationController;

//    if ([CoreData sharedCoreData].delight_view_controller) {
//        [[CoreData sharedCoreData].delight_view_controller release];
//        [CoreData sharedCoreData].delight_view_controller = nil;
//    }
//	[CoreData sharedCoreData].delight_view_controller = [[BEADelightViewController alloc] initWithNibName:@"BEADelightView" bundle:nil];
//	[CoreData sharedCoreData].delight_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	[window addSubview:[CoreData sharedCoreData].delight_view_controller.view];

//    if ([CoreData sharedCoreData]._PropertyLoanViewController) {
//        [[CoreData sharedCoreData]._PropertyLoanViewController release];
//        [CoreData sharedCoreData]._PropertyLoanViewController = nil;
//    }
//	[CoreData sharedCoreData]._PropertyLoanViewController = [[PropertyLoanViewController alloc] initWithNibName:@"PropertyLoanViewController" bundle:nil];
//	[CoreData sharedCoreData]._PropertyLoanViewController.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	[window addSubview:[CoreData sharedCoreData]._PropertyLoanViewController.view];

//    if ([CoreData sharedCoreData].taxLoan_view_controller) {
//        [[CoreData sharedCoreData].taxLoan_view_controller release];
//        [CoreData sharedCoreData].taxLoan_view_controller = nil;
//    }
//	[CoreData sharedCoreData].taxLoan_view_controller = [[TaxLoanViewController alloc] initWithNibName:@"TaxLoanView" bundle:nil];
//	[CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	[window addSubview:[CoreData sharedCoreData].taxLoan_view_controller.view];

//    //Tax Loan 2011
//    if ([CoreData sharedCoreData]._LTViewController) {
//        [[CoreData sharedCoreData]._LTViewController release];
//        [CoreData sharedCoreData]._LTViewController = nil;
//    }
//	[CoreData sharedCoreData]._LTViewController = [[LTViewController alloc] initWithNibName:@"LTView" bundle:nil];
//	[CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	[window addSubview:[CoreData sharedCoreData]._LTViewController.view];

    //InstalmentLoan 2011
//    if ([CoreData sharedCoreData]._InstalmentLoanViewController) {
//        [[CoreData sharedCoreData]._InstalmentLoanViewController release];
//        [CoreData sharedCoreData]._InstalmentLoanViewController = nil;
//    }
//	[CoreData sharedCoreData]._InstalmentLoanViewController = [[InstalmentLoanViewController alloc] initWithNibName:@"InstalmentLoanView" bundle:nil];
//	[CoreData sharedCoreData]._InstalmentLoanViewController.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	[window addSubview:[CoreData sharedCoreData]._InstalmentLoanViewController.view];

    // add by yufei
    // init MPFViewController
//    if ([MPFUtil me].MPF_view_controller) {
//        [[MPFUtil me].MPF_view_controller release];
//        [MPFUtil me].MPF_view_controller = nil;
//    }
//    [MPFUtil me].MPF_view_controller = [[MPFViewController alloc] initWithNibName:@"MPFViewController" bundle:nil];
//    [MPFUtil me].MPF_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//    [[MPFUtil me].MPF_view_controller.view setHidden:YES];
//    [window addSubview:[MPFUtil me].MPF_view_controller.view];

//    if ([CoreData sharedCoreData].hotline_view_controller) {
//        [[CoreData sharedCoreData].hotline_view_controller release];
//        [CoreData sharedCoreData].hotline_view_controller = nil;
//    }
//    [CoreData sharedCoreData].hotline_view_controller = [[HotlineViewController alloc] initWithNibName:@"HotlineView" bundle:nil];
//    [CoreData sharedCoreData].hotline_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//    [window addSubview:[CoreData sharedCoreData].hotline_view_controller.view];

//    if ([CyberFundSearchUtil me].CyberFundSearch_view_controller) {
//        [[CyberFundSearchUtil me].CyberFundSearch_view_controller release];
//        [CyberFundSearchUtil me].CyberFundSearch_view_controller = nil;
//    }
//    [CyberFundSearchUtil me].CyberFundSearch_view_controller = [[CyberFundSearchViewController alloc] initWithNibName:@"CyberFundSearchViewController" bundle:nil];
//    [CyberFundSearchUtil me].CyberFundSearch_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//    [window addSubview:[CyberFundSearchUtil me].CyberFundSearch_view_controller.view];
    [window addSubview:[CyberFundSearchUtil me]._CyberFundSearchImportantNoticeViewController.view];

    // add by neo
    // init AccProViewController
//    if ([AccProUtil me].AccPro_view_controller) {
//        [[AccProUtil me].AccPro_view_controller release];
//        [AccProUtil me].AccPro_view_controller = nil;
//    }
//    [AccProUtil me].AccPro_view_controller = [[AccProViewController alloc] initWithNibName:@"AccProViewController" bundle:nil];
//    [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//    [window addSubview:[AccProUtil me].AccPro_view_controller.view];

//    if ([ConsumerLoanUtil me].ConsumerLoan_view_controller) {
//        [[ConsumerLoanUtil me].ConsumerLoan_view_controller release];
//        [ConsumerLoanUtil me].ConsumerLoan_view_controller = nil;
//    }
//    [ConsumerLoanUtil me].ConsumerLoan_view_controller = [[ConsumerLoanViewController alloc] initWithNibName:@"ConsumerLoanViewController" bundle:nil];
//    [ConsumerLoanUtil me].ConsumerLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//    [window addSubview:[ConsumerLoanUtil me].ConsumerLoan_view_controller.view];

//    if ([InsuranceUtil me].Insurance_view_controller) {
//        [[InsuranceUtil me].Insurance_view_controller release];
//        [InsuranceUtil me].Insurance_view_controller = nil;
//    }
//    [InsuranceUtil me].Insurance_view_controller = [[InsuranceViewController alloc] initWithNibName:@"InsuranceViewController" bundle:nil];
//    [InsuranceUtil me].Insurance_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//    [window addSubview:[InsuranceUtil me].Insurance_view_controller.view];

    // add by neo
    // init AccProViewController
//    if ([RateUtil me].Rate_view_controller) {
//        [[RateUtil me].Rate_view_controller release];
//        [RateUtil me].Rate_view_controller = nil;
//    }
//    [RateUtil me].Rate_view_controller = [[RateViewController alloc] initWithNibName:@"RateViewController" bundle:nil];
//    [RateUtil me].Rate_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//    [window addSubview:[RateUtil me].Rate_view_controller.view];

//	// -- started by yelong on 2011.03.02
//	HotlineViewController *hotline_view_controller = [[HotlineViewController alloc] initWithNibName:@"HotlineView" bundle:nil];
//	[window addSubview:hotline_view_controller.view];
//	hotline_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	((BEAViewController *)[navigationController.viewControllers objectAtIndex:0]).hotline_view_controller = hotline_view_controller;
//	[CoreData sharedCoreData].hotline_view_controller = hotline_view_controller;
//	// -- ended by yelong on 2011.03.02

//    [CoreData sharedCoreData]._ImportantNoticeViewController = [[ImportantNoticeViewController alloc] initWithNibName:@"ImportantNoticeViewController" bundle:nil];
//	[window addSubview:[CoreData sharedCoreData]._ImportantNoticeViewController.view];
//	[CoreData sharedCoreData]._ImportantNoticeViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//	((BEAViewController *)[navigationController.viewControllers objectAtIndex:0])._ImportantNoticeViewController = [CoreData sharedCoreData]._ImportantNoticeViewController;

    //SGG
    //    [window addSubview:[SGGUtil me]._SGGViewController.view];
//    if ([CoreData sharedCoreData].atmlocation_view_controller) {
//        [[CoreData sharedCoreData].atmlocation_view_controller release];
//        [CoreData sharedCoreData].atmlocation_view_controller = nil;
//    }
//	[CoreData sharedCoreData].atmlocation_view_controller = [[ATMLocationViewController alloc] initWithNibName:@"ATMLocationView" bundle:nil];
//	[CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	[window addSubview:[CoreData sharedCoreData].atmlocation_view_controller.view];
    
	[window addSubview:[MPFUtil me]._MPFImportantNoticeViewController.view];
    
	[window addSubview:[MoreMenuUtil me]._MoreMenuViewController.view];

    if ([CoreData sharedCoreData].mask) {
        [[CoreData sharedCoreData].mask release];
        [CoreData sharedCoreData].mask = nil;
    }
	[CoreData sharedCoreData].mask = [[MaskViewController alloc] initWithNibName:@"MaskView" bundle:nil];
    [[MyScreenUtil me] adjustView2Screen:[CoreData sharedCoreData].mask.view];
	[CoreData sharedCoreData].mask.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
	[[CoreData sharedCoreData].mask hiddenMask];
	[window addSubview:[CoreData sharedCoreData].mask.view];

//	[window makeKeyAndVisible];

    //    [[TVOutManager sharedInstance] startTVOut];

//    return YES;
//    NSLog(@"20131224: window    %@" ,window);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        window.frame=CGRectMake(0, 20, 320,[[MyScreenUtil me] getScreenHeight]);
    }
    
    return;

}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.window addSubview:hiddenView];
    enterBackground = [[NSDate alloc] init];
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	//if (got_new_request) {
//	exit(0);
	//}
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	NSLog(@"BEAAppDelegate applicationWillEnterForeground");

    enterForeground = [[NSDate alloc] init];
    if ( [enterForeground timeIntervalSinceDate:enterBackground] > 60.0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CleanCache" object:nil];
    }
    
    
    [hiddenView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
    
	if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
		got_new_request = TRUE;
		UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"BEA",nil) message:NSLocalizedString(@"NEW_OFFER_ADD",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert_view show];
		[alert_view release];
		[[CoreData sharedCoreData].home_view_controller reloadNew];
	}
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [navigationController release];
    [window release];
    [super dealloc];
}

///////////////////////
//PushRegister Delegate
///////////////////////
-(void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	NSString *token = [[[[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
	ASIHTTPRequest *reg_token_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@regnotification.api?UDID=%@&token=%@&lang=%@&cs=%@&dt=%@&ver=%@",[CoreData sharedCoreData].realServerURL,[CoreData sharedCoreData].UDID,token,[CoreData sharedCoreData].lang,[CoreData md5:[NSString stringWithFormat:@"%@mtelmtelmmtel%@",[CoreData sharedCoreData].UDID,token]],[[UIDevice currentDevice].model stringByReplacingOccurrencesOfString:@" " withString:@"%20"],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]];
	NSLog(@"BEAAppDelegate didRegisterForRemoteNotificationsWithDeviceToken:%@",reg_token_request.url);
	reg_token_request.delegate = self;
	[[CoreData sharedCoreData].queue addOperation:reg_token_request];
}

-(void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [CoreData sharedCoreData].bea_view_controller.notification_onOroff = false;
	NSLog(@"BEAAppDelegate didFailToRegisterForRemoteNotificationsWithError:%@",error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	NSLog(@"BEAAppDelegate didReceiveRemoteNotification:%@", userInfo);
	NSLog(@"badge:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"badge"]);
	//[UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue];
	got_new_request = TRUE;
    NSLog(@"application.applicationState--------%d",application.applicationState);
    
    BOOL isRegisterRemoteiOS8;
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        isRegisterRemoteiOS8 = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    }
    
    if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] > 0 || isRegisterRemoteiOS8) {
    
        if (application.applicationState == UIApplicationStateActive) {
            UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"BEA",nil) message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            
            if ([[userInfo objectForKey:@"ACT"] isEqualToString:@""] || [userInfo objectForKey:@"ACT"] == nil) {
                alert_view.delegate = self;
                alert_action = AlertAciontMainpage;
            }
            if ([[userInfo objectForKey:@"ACT"] isEqualToString:@"1"]) {
                alert_action = nil;
            }
            if ([[userInfo objectForKey:@"ACT"] isEqualToString:@"2"]) {
                alert_view.delegate = self;
                alert_action = AlertActionPrivileges;
            }
            
            [alert_view show];
            [alert_view release];
            [[CoreData sharedCoreData].home_view_controller reloadNew];
        }
        

    }
    
}

-(void) alertView:(UIAlertView *)alert_View clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alert_action == AlertActionPrivileges) {
        NSLog(@"点击OK，L290");
        [self goPrivilege];
        
    }
    if (alert_action == AlertAciontMainpage) {
        [self goMainPage];
    }
    
}

- (void)goPrivilege {
    NSLog(@"点击OKgoPrivilege，L290");
    plistvc1 = [[AccProListViewController alloc] initWithNibName:@"AccProListViewController" bundle:nil];
    [plistvc1 viewDidLoad];
    [plistvc1 loadPlistDataDetail];
    //        NSLog(@"plistvc.items_data-----------%@",plistvc1.items_data);
    ConsumerLoanOffersViewController* current_view_controller =
    [[ConsumerLoanOffersViewController alloc] initWithNibName:@"ConsumerLoanOffersViewController"
                                                       bundle:nil
                                                     merchant:[plistvc1.items_data firstObject]];
    current_view_controller.fromType = @"Pri";
    [self.navigationController pushViewController:current_view_controller animated:NO];
}

- (void)goMainPage {
    NSLog(@"点击OKgoMainPage，L290");
    NSLog(@"[CoreData sharedCoreData].bea_view_controller L290%@",[CoreData sharedCoreData].bea_view_controller);
    [self.navigationController popToRootViewControllerAnimated:NO];
    if ([CoreData sharedCoreData].bea_view_controller) {
        [[CoreData sharedCoreData].bea_view_controller.v_rmvc.rmUtil showMenu:1];
    }else {
        [CoreData sharedCoreData].goBanking = YES;
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request {
	NSLog(@"BEAAppDelegate requestFinished:%@",[request responseString]);
	[request release];
}

-(void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"BEAAppDelegate requestFailed:%@", [request error]);
	[request release];
}

- (void)changeLanguage:(NSNotification *)notification {
    [CoreData sharedCoreData].lang = [[notification userInfo] objectForKey:@"Lang"];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"notification_onOroff"]) {
        if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        }else {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    }
}

- (void)registerFirstNotification {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    if (![userDefaultes integerForKey:@"NotInstalledAndFirstOpenApp"] && [UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        [CoreData sharedCoreData].bea_view_controller.notification_onOroff = true;
        [userDefaultes setBool:true forKey:@"notification_onOroff"];
        [[CoreData sharedCoreData].bea_view_controller saveNotInstalledAndFirstOpenApp];
    } else if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [UserDefaultUtil updateNotInstalledAndFirstOpenApp];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {

    NSLog(@"Setting notification - - - - %@", notificationSettings);
}

@end
