//
//  RotateMenu4ViewController.m
//  BEA
//
//  Created by Algebra on 13/8/14.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import "RotateMenu4ViewController.h"

@interface RotateMenu4ViewController ()

@end

@implementation RotateMenu4ViewController

@synthesize contentView;

@synthesize btnmenu0,
btnmenu1,
btnmenu2,
svmenu,
rmUtil,
btnHome;

@synthesize btnSidemenu;
@synthesize btnMore;
@synthesize btnBack;
@synthesize vc_caller;
@synthesize image_bg;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.rmUtil = [[RotateMenuUtil alloc] init];
        self.rmUtil.rmVC = self;
        CGRect frame3 = self.contentView.frame;
        frame3.origin.x =0;
        frame3.origin.y =0;
        self.view.frame = frame3;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePageTheme:) name:@"ChangePageTheme" object:nil];
    _pageStyle = Orange_Red;
    
}

- (void)setupController
{
    self.svmenu.delegate = self.rmUtil;
    self.svmenu.contentSize = CGSizeMake(self.svmenu.frame.size.width * 1, self.svmenu.frame.size.height);
    
    self.btnmenu0.titleLabel.numberOfLines = 0;
    self.btnmenu0.titleLabel.backgroundColor = [UIColor clearColor];
    self.btnmenu0.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnmenu0.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnmenu0 setTitle:NSLocalizedString(@"iCoupon.menu.fullList", nil) forState:UIControlStateNormal];
    
    
    self.btnmenu1.titleLabel.numberOfLines = 0;
    self.btnmenu1.titleLabel.backgroundColor = [UIColor clearColor];
    self.btnmenu1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnmenu1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnmenu1 setTitle:NSLocalizedString(@"iCoupon.menu.myWallet", nil) forState:UIControlStateNormal];
    
     //not use
    self.btnmenu2.titleLabel.numberOfLines = 0;
    self.btnmenu2.titleLabel.backgroundColor = [UIColor clearColor];
    self.btnmenu2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnmenu2.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray* a_btns = [NSArray arrayWithObjects:self.btnmenu0,self.btnmenu1,self.btnmenu2, nil];
    [self.rmUtil setButtonArray:a_btns];
    [self changePageTheme:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [contentView release];
    [rmUtil release];
    [image_bg release];
    [_view_features release];
    [_lbl_coupon release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setContentView:nil];
    [self setImage_bg:nil];
    [self setView_features:nil];
    [self setLbl_coupon:nil];
    [super viewDidUnload];
}

- (IBAction)doMenuButtonsPressed:(UIButton *)sender {
    [rmUtil doMenuButtonsPressed:sender];
    if (self.vc_caller) {
        [self.vc_caller doMenuButtonsPressed:sender];
    }
    //edit by chu 20150217
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    NSLog(@"%@", pageTheme);
    if (![pageTheme isEqualToString:Orange_Red]) {
        [self setSelectedMenu:sender];
    }
}

//edit by chu 20150217
-(void) refreshMenu{
    [self.btnmenu0 setTitle:NSLocalizedString(@"iCoupon.menu.fullList", nil) forState:UIControlStateNormal];
    [self.btnmenu1 setTitle:NSLocalizedString(@"iCoupon.menu.myWallet", nil) forState:UIControlStateNormal];
}

-(void) setSelectedMenu:(UIButton *)sender {
    //set to white
    [self.btnmenu0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnmenu1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //set target to selected
    [sender setTitleColor:[UIColor colorWithRed:251/255.0 green:221/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)changePageTheme:(NSNotification *)notification {
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    _pageStyle = pageTheme;
    NSLog(@"%@", pageTheme);
    if ([pageTheme isEqualToString:Orange_Red]) {
        UIImage *image;
        if ([_rightOrLeft isEqualToString:@"left"]) {
            image = [UIImage imageNamed:@"my_list_bar.png"];
        } else {
            image = [UIImage imageNamed:@"my_wallet_bar.png"];
        }
        [self.btnmenu0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnmenu1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [image_bg setImage:image];
        UIImage *imageBack = [UIImage imageNamed:@"btn_back.png"];
        [self.btnBack setBackgroundImage:imageBack forState:UIControlStateNormal];
    } else {
        UIImage *image = [UIImage imageNamed:@"my_wallet_bar_new.png"];
        if ([_rightOrLeft isEqualToString:@"left"]) {
            [self.btnmenu0 setTitleColor:[UIColor colorWithRed:251/255.0 green:221/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            [self.btnmenu1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self.btnmenu1 setTitleColor:[UIColor colorWithRed:251/255.0 green:221/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            [self.btnmenu0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [image_bg setImage:image];
        UIImage *imageBack = [UIImage imageNamed:@"btn_back_new.png"];
        [self.btnBack setBackgroundImage:imageBack forState:UIControlStateNormal];
    }
}

@end
