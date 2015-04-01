//
//  RateMenuViewController.m
//  BEA
//
//  Created by yaojzy on 15/5/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//

#import "RateMenuViewController.h"

@interface RateMenuViewController ()

@end

@implementation RateMenuViewController

@synthesize
v_rmvc,
m_nvc;

@synthesize menuTag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_nvc = a_nvc;
        NSLog(@"debug RateMenuViewController initWithNibName:%@--%@", self, v_rmvc);
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
//    UIViewController *mvc0, *mvc1, *mvc2;

//    mvc0 = [[RateNoteViewController alloc] initWithNibName:@"RateNoteViewController" bundle:nil];
//    mvc1 = [[RateTTViewController alloc] initWithNibName:@"RateTTViewController" bundle:nil];
//    mvc2 = [[RatePrimeViewController alloc] initWithNibName:@"RatePrimeViewController" bundle:nil];

//    mmenuv0 = mvc0.view;
//    mmenuv1 = mvc1.view;
//    mmenuv2 = mvc2.view;

//    //amended by jasen on 201303
//    [self.view addSubview:mmenuv0];
//    CGRect frame = self.view.frame;
//    mmenuv0.frame = frame;
//    [self.view addSubview:mmenuv1];
//    mmenuv1.frame = frame;
//    [self.view addSubview:mmenuv2];
//    mmenuv2.frame = frame;

    
    mmenuv0 = mmenuv1 = mmenuv2 = [[UIView alloc] init];
    
    v_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
    v_rmvc.rmUtil.caller = self;

//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//        v_rmvc.contentView.frame = CGRectMake(0, -20, 320, 95);
//    }
    [self.view addSubview:v_rmvc.contentView];

    NSArray* a_texts = [NSArray arrayWithObjects:
                        NSLocalizedString(@"Rate.Note.menu",nil),
                        NSLocalizedString(@"Rate.TT.menu",nil),
                        NSLocalizedString(@"Rate.Prime.menu",nil),
                        nil];
    
    NSArray* a_views = [NSArray arrayWithObjects:mmenuv0, mmenuv1, mmenuv2, nil];
    
    [v_rmvc.rmUtil setTextArray:a_texts];
    [v_rmvc.rmUtil setViewArray:a_views];
    [v_rmvc.rmUtil setNav:self.m_nvc];
    
    [v_rmvc.rmUtil setShowIndex:menuTag];
    [v_rmvc.rmUtil showMenu];
    
    NSLog(@"debug RateMenuViewController viewDidLoad:%@--%@", self, v_rmvc);

}

-(void)showMenu:(int)show
{
    NSLog(@"debug RateMenuViewController showMenu in:%@--%d", self, show);
    if (show>=0 && show<=2) {
        if (mvc0) {
            [mvc0 removeFromParentViewController];
            [mvc0 release];
        }
        
        switch (show) {
            case 0:
                mvc0 = [[RateNoteViewController alloc] initWithNibName:@"RateNoteViewController" bundle:nil];
                break;
            case 1:
                mvc0 = [[RateTTViewController alloc] initWithNibName:@"RateTTViewController" bundle:nil];
                break;
            case 2:
                mvc0 = [[RatePrimeViewController alloc] initWithNibName:@"RatePrimeViewController" bundle:nil];
                break;
                
            default:
                break;
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
            CGRect frame = self.mv_content.frame;
            frame.origin.x = 0;
            frame.origin.y = -20;
            //        frame.size.height += +[[MyScreenUtil me] getScreenHeightAdjust];
            
            [self.mv_content addSubview:mvc0.view];
            mvc0.view.frame = frame;
        }else {
            CGRect frame = self.mv_content.frame;
            frame.origin.x = 0;
            frame.origin.y = 0;
            //        frame.size.height += +[[MyScreenUtil me] getScreenHeightAdjust];
            
            [self.mv_content addSubview:mvc0.view];
            mvc0.view.frame = frame;
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) welcome
{
    NSLog(@"debug RateMenuViewController welcome:%@", self);
   [v_rmvc.rmUtil setShowIndex:0];
    [v_rmvc.rmUtil showMenu];

}

-(void) welcome:(int)tag
{
    NSLog(@"debug RateMenuViewController welcome:%d--%@--%@", tag, self, v_rmvc);
    if (tag<0 || tag>2) {
        tag = 0;
    }
    [v_rmvc.rmUtil setShowIndex:tag];
    [v_rmvc.rmUtil showMenu];

}

@end
