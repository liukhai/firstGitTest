//
//  InsuranceMenuViewController.m
//  BEA
//
//  Created by jasen on 17/5/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//

#import "InsuranceMenuViewController.h"

#import "InsuranceUtil.h"
#import "InsuranceApplicationViewController.h"

@interface InsuranceMenuViewController ()

@end

@implementation InsuranceMenuViewController

@synthesize
v_rmvc,
mv_content,
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *mmenuv0;
    UIView *mmenuv1;
    UIView *mmenuv2;
    UIView *mmenuv3;
    UIViewController *mvc0, *mvc1, *mvc2, *mvc3;
    
    mvc0 = [[InsuranceListViewController alloc] initWithNibName:@"InsuranceListViewController" bundle:nil];
    mvc1 = [[InsuranceNewsViewController alloc] initWithNibName:@"InsuranceNewsViewController" bundle:nil];
    mvc2 = [[InsuranceEnquiryViewController alloc] initWithNibName:@"InsuranceEnquiryViewController" bundle:nil];
    mvc3 = [[InsuranceApplicationViewController alloc] initWithNibName:@"InsuranceApplicationViewController" bundle:nil];
    
    mmenuv0 = mvc0.view;
    mmenuv1 = mvc1.view;
    mmenuv2 = mvc2.view;
    mmenuv3 = mvc3.view;
    
    [self.mv_content addSubview:mmenuv0];
    CGRect frame = self.view.frame;
    mmenuv0.frame = frame;
    [self.mv_content addSubview:mmenuv1];
    mmenuv1.frame = frame;
    [self.mv_content addSubview:mmenuv2];
    mmenuv2.frame = frame;
    [self.mv_content addSubview:mmenuv3];
    mmenuv3.frame = frame;
    
    v_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
    v_rmvc.rmUtil.caller = self;

    [self.view addSubview:v_rmvc.contentView];
    
    NSArray* a_texts = [NSArray arrayWithObjects:NSLocalizedString(@"tag_insurance_products", nil),
                        NSLocalizedString(@"tag_insurance_news", nil),
                        NSLocalizedString(@"tag_insurance_enquiries", nil),
                        NSLocalizedString(@"tag_insurance_applications", nil),
                        nil];
    
    NSArray* a_views = [NSArray arrayWithObjects:mmenuv0, mmenuv1, mmenuv2, mmenuv3, nil];
    
    [v_rmvc.rmUtil setTextArray:a_texts];
    [v_rmvc.rmUtil setViewArray:a_views];
    [v_rmvc.rmUtil setNav:self.m_nvc];
    [v_rmvc.rmUtil showMenu];
    
}

-(void)showMenu:(int)show
{
    NSLog(@"showMenu in:%@", self);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void) welcome
//{
//    
//    if ([[InsuranceUtil me].nextTab isEqualToString:@"news"]){
//        [InsuranceUtil me].nextTab = @"";
//        [v_rmvc.rmUtil setShowIndex:1];
//    }else if ([[InsuranceUtil me].nextTab isEqualToString:@"application"]){
//        [InsuranceUtil me].nextTab = @"";
//        [v_rmvc.rmUtil setShowIndex:2];
//    }else{
//        [v_rmvc.rmUtil setShowIndex:0];
//    }
//    
//    [v_rmvc.rmUtil showMenu];
//    
//}
-(void) welcome
{
    [v_rmvc.rmUtil setShowIndex:1];
    [v_rmvc.rmUtil showMenu];
    
}

-(void) welcome:(int)tag
{
//    if (tag<0 || tag>2) {
//        tag = 0;
//    }
    [v_rmvc.rmUtil setShowIndex:tag];
    [v_rmvc.rmUtil showMenu];
    
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
