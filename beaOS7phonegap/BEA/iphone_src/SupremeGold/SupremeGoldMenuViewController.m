//
//  SupremeGoldMenuViewController.m
//  BEA
//
//  Created by Ledp944 on 14-9-3.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//
#import "RotateMenuUtil.h"
#import "SupremeGoldMenuViewController.h"
#import "SupremeGoldEnquiryViewController.h"
#import "SupremeGoldListViewController.h"
#import "SupremeGoldApplicationViewController.h"



@interface SupremeGoldMenuViewController ()

@end

@implementation SupremeGoldMenuViewController

@synthesize
mv_content,
mv_rmvc,
m_nvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_nvc = a_nvc;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setMenus];
    
    [mv_rmvc.rmUtil setShowIndex:showIndex];
    [mv_rmvc.rmUtil showMenu];
    
}

- (void)setMenus
{
    UIView *mmenuv0;
    UIView *mmenuv1;
    UIView *mmenuv2;
    UIView *mmenuv3;
    
    mvc0 = [[SupremeGoldEnquiryViewController alloc] initWithNibName:@"SupremeGoldEnquiryViewController" bundle:nil];
    mvc1 = [[SupremeGoldListViewController alloc] initWithNibName:@"SupremeGoldListViewController" bundle:nil];
    mvc2 = [[SupremeGoldApplicationViewController alloc] initWithNibName:@"SupremeGoldApplicationViewController" bundle:nil];
    
    mv_rmvc.vc_caller = mvc2;
    mv_rmvc.rmUtil.noPop = YES;
    
    mmenuv0 = mvc0.view;
    mmenuv1 = mvc1.view;
    mmenuv2 = mvc2.view;
    mmenuv3 = [[UIView alloc] init];
    
    NSLog(@"debug SupremeGoldMenuViewController viewDidLoad 0:%@", mvc0);
    NSLog(@"debug SupremeGoldMenuViewController viewDidLoad 1:%@", mvc1);
    NSLog(@"debug SupremeGoldMenuViewController viewDidLoad 2:%@", mvc2);
    
    CGRect frame = self.mv_content.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
//    frame.size.height += +[[MyScreenUtil me] getScreenHeightAdjust];
    for (UIView *view in self.mv_content.subviews) {
        [view removeFromSuperview];
    }
    [self.mv_content addSubview:mmenuv0];
    mmenuv0.frame = frame;
    [self.mv_content addSubview:mmenuv1];
    mmenuv1.frame = frame;
    [self.mv_content addSubview:mmenuv2];
//    mmenuv2.frame = frame;

    NSLog(@"debug ConsumerLoanMenuViewController viewDidLoad mmenuv0:%f--%f", mmenuv0.frame.size.width, mmenuv0.frame.size.height);
    NSLog(@"debug ConsumerLoanMenuViewController viewDidLoad mmenuv1:%f--%f", mmenuv1.frame.size.width, mmenuv1.frame.size.height);
    NSLog(@"debug ConsumerLoanMenuViewController viewDidLoad mmenuv2:%f--%f", mmenuv2.frame.size.width, mmenuv2.frame.size.height);
    NSArray* a_texts = [NSArray arrayWithObjects:
                        NSLocalizedString(@"tag_enquiries", nil),
                        NSLocalizedString(@"tag_offers", nil),
                        NSLocalizedString(@"tag_applications", nil),
                        NSLocalizedString(@"Nearby", nil),
                        nil];
    [mv_rmvc.rmUtil setTextArray:a_texts];
    
    NSArray* a_views = [NSArray arrayWithObjects:mmenuv0,mmenuv1,mmenuv2, mmenuv3, nil];
    [mv_rmvc.rmUtil setViewArray:a_views];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    
    mv_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
    mv_rmvc.rmUtil.caller = self;
    
    [self.view addSubview:mv_rmvc.contentView];
    
    [mv_rmvc.rmUtil setNav:self.m_nvc];
    showIndex = 1;
    
    
    NSLog(@"debug 20140128 ConsumerLoanMeuViewController viewDidLoad:%@", self.view);
    
}

-(void)showMenu:(int)show
{
    NSLog(@"showMenu in:%@", self);
    
    ((SupremeGoldApplicationViewController *)mvc2).isShow = NO;
    
    if (show == 2) {
        ((SupremeGoldApplicationViewController *)mvc2).isShow = YES;
    }
    
    if (show == 3) {
        [[CoreData sharedCoreData].root_view_controller setContent:0];
//        [CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//        [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
        
        //        [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].taxLoan_view_controller animated:NO];
        //        [CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
        
        NSLog(@"Navigation Revamp - Consumer Loan - ConsumerLoanMenuViewController.m");
//        [[CoreData sharedCoreData].atmlocation_view_controller welcomeToindex:1];
//        
//        [CoreData sharedCoreData].bea_view_controller.vc4process  =  [CoreData sharedCoreData].atmlocation_view_controller;
        ATMLocationViewController *atm_location = [[ATMLocationViewController alloc] initWithNibName:@"ATMLocationView" bundle:nil];
        atm_location.menuIndex = 1;
        [self.navigationController pushViewController:atm_location animated:NO];
    }else {
        showIndex = show;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) welcome
{
    [mv_rmvc.rmUtil setShowIndex:1];
    [mv_rmvc.rmUtil showMenu];
    
}

-(void) welcome:(int)tag
{
    if (tag<0 || tag>2) {
        tag = 0;
    }
    [mv_rmvc.rmUtil setShowIndex:tag];
    [mv_rmvc.rmUtil showMenu];
    
}

- (void)dealloc {
    [mv_rmvc release];
    [mv_content release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setMv_content:nil];
    [super viewDidUnload];
}
@end

