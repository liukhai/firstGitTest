//
//  ICouponMenuViewController.m
//  BEA
//
//  Created by Keith Wong on 6/10/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import "ICouponMenuViewController.h"

@interface ICouponMenuViewController (){
        RotateMenu3ViewController* v_rmvc;
}

@end

@implementation ICouponMenuViewController
@synthesize lb_pagetitle, but_fullList, but_mywallet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
//    self.navigationController.delegate = self;
    [self setMenuBar4];
}

//edit by chu 20150216
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    self.navigationController.delegate = self;
    //    [super viewWillAppear:animated];
    [self setLang];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setLang{
    //for add icoupon title by chu - 20150216
    self.lb_pagetitle.text = NSLocalizedString(@"iCoupon.title",nil);
    self.lb_pagetitle.accessibilityLabel = NSLocalizedString(@"iCoupon.title",nil);
    
    [self.lbl_fullList setText:NSLocalizedString(@"iCoupon.menu.fullList", nil)];
    [self.lbl_myWallet setText:NSLocalizedString(@"iCoupon.menu.myWallet", nil)];
    
    //edit by chu 20150224
    self.but_fullList.accessibilityLabel = NSLocalizedString(@"iCoupon.menu.fullList",nil);
    self.but_mywallet.accessibilityLabel = NSLocalizedString(@"iCoupon.menu.myWallet",nil);
    self.lbl_fullList.isAccessibilityElement = NO;
    self.lbl_myWallet.isAccessibilityElement = NO;
    
}

-(void)setMenuBar4
{
    v_rmvc = [[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] ;
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
//    v_rmvc.vc_caller = self;
//    [v_rmvc.view_features setHidden:YES];
//    [v_rmvc.btnSidemenu setHidden:YES];
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
    
}



-(IBAction)buttonPressed:(UIButton *)button {
    NSLog(@"debug ICouponMenuViewController buttonPressed button:%d", button.tag);
    
    
    
    
	ICouponListViewController *view_controller = [[ICouponListViewController alloc] initWithNibName:@"ICouponListViewController" bundle:nil];

    [self.navigationController pushViewController:view_controller animated:NO];
    
    
    switch (button.tag) {
        case 1:
			view_controller.toListTag = ICouponListStatusCouponList;
            
			break;
            
        case 2:
			view_controller.toListTag = ICouponListStatusMyCouponList;
			break;
    }
    
//    [view_controller release];
}

//- (void)dealloc {
//    [_lbl_fullList release];
//    [_lbl_myWallet release];
//    [super dealloc];
//}
- (void)viewDidUnload {
    [self setLbl_fullList:nil];
    [self setLbl_myWallet:nil];
    [super viewDidUnload];
}
@end
