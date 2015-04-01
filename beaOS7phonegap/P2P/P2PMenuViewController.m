//
//  P2PMenuViewController.m
//  BEA
//
//  Created by yaojzy on 24/12/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//
#import "LangUtil.h"
#import "P2PMenuViewController.h"
#import "MyPlugin.h"
#import <Cordova/CDV.h>
#import "MyScreenUtil.h"
#import "MigrationSetting.h"

//#define P2P_URL_SETTING @"index.html"
//#define P2P_URL_MAIN @"https://210.176.64.24/jsp/P2PActive.html"
//#define P2P_URL_RECORD @"http://www.baidu.com"


@interface P2PMenuViewController ()

@end

@implementation P2PMenuViewController

@synthesize
mv_content,
mv_rmvc,
m_nvc;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_nvc = a_nvc;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    UIView *mmenuv0;
    UIView *mmenuv1;
    UIView *mmenuv2;
    
//    mmenuv0 = [[UIView alloc] init];
//    mmenuv1 = [[UIView alloc] init];
//    mmenuv2 = [[UIView alloc] init];
    mmenuv0 = mmenuv1 = mmenuv2 = [[UIView alloc] init];
    
    RotateMenuViewController* v_rmvc = [[RotateMenuViewController alloc] initWithNibName:@"RotateMenuViewController" bundle:nil];
    v_rmvc.rmUtil.caller = self;
    
    [self.view addSubview:v_rmvc.contentView];
    
    NSArray* a_texts = [NSArray arrayWithObjects:NSLocalizedString(@"tag_p2p_setting", nil),
                        NSLocalizedString(@"tag_p2p_main", nil),
                        NSLocalizedString(@"tag_p2p_records", nil),
                        nil];
    [v_rmvc.rmUtil setTextArray:a_texts];
    
    NSArray* a_views = [NSArray arrayWithObjects:mmenuv0,mmenuv0,mmenuv0, nil];
    [v_rmvc.rmUtil setViewArray:a_views];
    
    [v_rmvc.rmUtil setNav:self.m_nvc];
    [v_rmvc.rmUtil setShowIndex:1];
    [v_rmvc.rmUtil showMenu];
    
    mv_rmvc=v_rmvc;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showMenu:(int)show
{
    NSLog(@"debug P2PMenuViewController showMenu in:%@", self);
    if (show>=0 && show<=2) {
        if (mvc0) {
            [mvc0 release];
        }
        
        mvc0 = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];

        NSString * url;
        switch (show) {
            case 0:
                url =  [MigrationSetting me].URLOfP2P_setting;
                break;
            case 1:
                url = [MigrationSetting me].URLOfP2P_main;
//                url = [MigrationSetting me].URLOfPhoneGap_plugin_unittest;
//                url = [MigrationSetting me].URLOfPhoneGap_plugin_SIT;
                break;
            case 2:
                url = [MigrationSetting me].URLOfP2P_Record;
                break;
                
            default:
                break;
        }
//        NSData *banking;
		NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
        NSString *mobileno = @"";
		if (user_setting!=nil && [[user_setting objectForKey:@"encryted_banking"] length]>0) {
//			banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
//            [MBKUtil transform:banking];
//            mobileno = [[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding];
            mobileno = [MBKUtil decryption:[user_setting objectForKey:@"encryted_banking"]];

        }
        url=[NSString stringWithFormat:@"%@?Lang=%@&MobileNo=%@",url,[CoreData sharedCoreData].lang,mobileno];
        NSLog(@"P2PMenuViewController  : %@" , url);
        if (isOtherViewToSettingView) {
            mvc0.startPage = ToSettingView_Url;
            isOtherViewToSettingView = false;
        }else{
            mvc0.startPage = url;
        }
        CGRect frame = self.mv_content.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        //        frame.size.height += +[[MyScreenUtil me] getScreenHeightAdjust];
        
        [self.mv_content addSubview:mvc0.view];
        
        mvc0.view.frame = frame;
        
        mvc0.webView.dataDetectorTypes = UIDataDetectorTypeNone;

    }
}
-(void)setSettingURL:(NSString *) _url
{
    isOtherViewToSettingView = true;
    NSString * url =  [MigrationSetting me].URLOfP2P_setting;
    url=[NSString stringWithFormat:@"%@?Lang=%@&%@",url,[CoreData sharedCoreData].lang,_url];
    ToSettingView_Url = url;
}
-(void)openBrowserURL:(NSString *) url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
- (void) viewDidUnload {
    NSLog(@"debug P2PMenuViewController viewDidUnload:%@", self);
    [mvc0 release];
    [mvc1 release];
    [mvc2 release];
    if (mv_rmvc) {
        [mv_rmvc release];
    }
}

@end
