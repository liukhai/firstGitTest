//
//  AccProMenuViewController.m
//  BEA
//
//  Created by yaojzy on 2/7/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//

#import "AccProMenuViewController.h"

#import "AccProListViewController.h"
#import "AccProApplicationViewController.h"
#import "AccProEnquiryViewController.h"

#import "ConsumerLoanEnquiryViewController.h"

@interface AccProMenuViewController () {
    RotateMenu2ViewController* v_rmvc;
    BOOL isFirstInit;
}

@end

#define FUNC_TAG_PRIVILEGES 13

@implementation AccProMenuViewController

@synthesize
mv_content,
mv_rmvc,
mvc0,
m_nvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_nvc = a_nvc;
        isFirstInit = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //edit by chu 20150217
    isFirstInit = YES;
    
    // Do any additional setup after loading the view from its nib.
    
    UIView *mmenuv0;
    UIView *mmenuv1;
    UIView *mmenuv2;
    UIView *mmenuv3;
    

//    [AccProUtil me].AccPro_view_controller._AccProListViewController = [[AccProListViewController alloc] initWithNibName:@"AccProListViewController" bundle:nil];
    mvc0 = [[AccProListViewController alloc] initWithNibName:@"AccProListViewController" bundle:nil];
    mvc1 = [[AccProApplicationViewController alloc] initWithNibName:@"AccProApplicationViewController" bundle:nil];
    mvc2 = [[AccProEnquiryViewController alloc] initWithNibName:@"AccProEnquiryViewController" bundle:nil];
    
    mmenuv0 = mvc0.view;
    mmenuv1 = mvc1.view;
    mmenuv2 = mvc2.view;
    mmenuv3 = [[UIView alloc] init];

//    NSLog(@"debug AccProMenuViewController viewDidLoad  :%@", self.view);
//    NSLog(@"debug AccProMenuViewController mv_content:%@", self.mv_content);
//    NSLog(@"debug AccProMenuViewController mmenuv0:%@", ((AccProListViewController*)mvc0).view);
//    NSLog(@"debug AccProMenuViewController mmenuv0:%@", ((AccProListViewController*)mvc0).table_view);
//    NSLog(@"debug AccProMenuViewController mmenuv1:%@", mmenuv1);
//    NSLog(@"debug AccProMenuViewController mmenuv2:%@", mmenuv2);

    CGRect frame = self.mv_content.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height += +[[MyScreenUtil me] getScreenHeightAdjust];
    
    [self.mv_content addSubview:mmenuv0];
    [self.mv_content addSubview:mmenuv1];
    [self.mv_content addSubview:mmenuv2];
    
    mmenuv0.frame = frame;
    
    frame = self.mv_content.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;

    mmenuv1.frame = frame;
    mmenuv2.frame = frame;

//    NSLog(@"debug AccProMenuViewController mmenuv0:%@", ((AccProListViewController*)mvc0).view);
//    NSLog(@"debug AccProMenuViewController mmenuv0:%@", ((AccProListViewController*)mvc0).table_view);
//    NSLog(@"debug AccProMenuViewController mmenuv1:%@", mmenuv1);
//    NSLog(@"debug AccProMenuViewController mmenuv2:%@", mmenuv2);

    v_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
    v_rmvc.rmUtil.caller = self;
    v_rmvc.vc_caller = mvc1;
    v_rmvc.rmUtil.noPop = YES;
    
    [self.view addSubview:v_rmvc.contentView];

    NSArray* a_texts = [NSArray arrayWithObjects:NSLocalizedString(@"tag_offers", nil),
                        NSLocalizedString(@"tag_applications", nil),
                        NSLocalizedString(@"Nearby", nil),
                        NSLocalizedString(@"tag_enquiries", nil),
                        nil];
    [v_rmvc.rmUtil setTextArray:a_texts];

    NSArray* a_views = [NSArray arrayWithObjects:mmenuv0,mmenuv1,mmenuv3,mmenuv2, nil];
    [v_rmvc.rmUtil setViewArray:a_views];

    [v_rmvc.rmUtil setNav:self.m_nvc];
    [v_rmvc.rmUtil setShowIndex: self.mShowInt];
    [v_rmvc.rmUtil showMenu];

    mv_rmvc=v_rmvc;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //edit by chu 20150217
    NSArray* a_texts = [NSArray arrayWithObjects:NSLocalizedString(@"tag_offers", nil),
                        NSLocalizedString(@"tag_applications", nil),
                        NSLocalizedString(@"Nearby", nil),
                        NSLocalizedString(@"tag_enquiries", nil),
                        nil];
    [v_rmvc.rmUtil setTextArray:a_texts];
    //set up menu
    [v_rmvc.rmUtil setShowIndex:self.mShowInt];
    [v_rmvc.rmUtil showMenu];
    
    if(!isFirstInit){
        //edit by chu - 20150217
        [(AccProListViewController*)mvc0 refreshViewContent];
        [(AccProApplicationViewController*)mvc1 refreshViewContent];
        [(AccProEnquiryViewController*)mvc2 refreshViewContent];
    }else{
        isFirstInit = NO;
    }
}

-(void)setShowIndex:(int)index{
    self.mShowInt = index;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showMenu:(int)show
{
    NSLog(@"debug AccProMenuViewController showMenu in:%@--%d", self, show);

    ((AccProApplicationViewController *)mvc1).isShow = NO;
    
    if (show == 1) {
        ((AccProApplicationViewController *)mvc1).isShow = YES;
    }
    if (show == 2) {
//        [CoreData sharedCoreData].lastScreen = @"AccProViewController";
        [[CoreData sharedCoreData].root_view_controller setContent:0];
//        [CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
        ATMLocationViewController *atm_location = [[ATMLocationViewController alloc] initWithNibName:@"ATMLocationView" bundle:nil];
        atm_location.menuIndex = 3;
         [self.navigationController pushViewController:atm_location animated:NO];
//        [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
        NSLog(@"Navigation Revamp - AccPro Menu - AccProMenuViewController.m");
//        [[CoreData sharedCoreData].atmlocation_view_controller welcomeToindex:3];
       
//         [CoreData sharedCoreData].bea_view_controller.vc4process  =  [CoreData sharedCoreData].atmlocation_view_controller;
    }else {
        self.mShowInt = show;
    }
}

//-(void) welcome
//{
//    [mv_rmvc.rmUtil setShowIndex:0];
//    [mv_rmvc.rmUtil showMenu];
//
//}

-(void) welcome:(int)tag
{
    if (tag<0 || tag>2) {
        tag = 0;
    }
    [mv_rmvc.rmUtil setShowIndex:tag];
    [mv_rmvc.rmUtil showMenu];

}

- (void)dealloc {
    [mv_content release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setMv_content:nil];
    [super viewDidUnload];
}

@end
