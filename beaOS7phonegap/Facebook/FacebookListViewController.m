//
//  FacebookListViewController.m
//  BEA
//
//  Created by Helen on 14-8-22.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import "FacebookListViewController.h"
#import "LangUtil.h"
#import "MyPlugin.h"
#import "MyScreenUtil.h"
#import "MigrationSetting.h"
#import "FacebookViewController.h"
#import "FacebookViewController2.h"
#import "LangUtil.h"

@interface FacebookListViewController ()

@end

@implementation FacebookListViewController

@synthesize v_rmvc;
@synthesize v_nav;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    NSLog(@"debug FacebookListViewController initWithNibName:%@", self);
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    funLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 170, 90)];
    funLabel.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"Funlabel_text",nil)];
    funLabel.backgroundColor = [UIColor clearColor];
    funLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13.0];
    funLabel.numberOfLines = 0;
    [fun_view addSubview:funLabel];
    funLabel.accessibilityLabel = NSLocalizedString(@"Funlabel_text", nil);
    fun_button.accessibilityLabel = NSLocalizedString(@"Details_accessibility", nil);
    

    joyLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 170, 90)];
    joyLabel.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"Joylabel_text",nil)];
    joyLabel.numberOfLines = 0;
    joyLabel.backgroundColor = [UIColor clearColor];
    joyLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13.0];
    [joy_view addSubview:joyLabel];
    joyLabel.accessibilityLabel = NSLocalizedString(@"Joylabel_text", nil);
    joy_button.accessibilityLabel = NSLocalizedString(@"Details_accessibility", nil);

    self.v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    [self.view addSubview:self.v_rmvc.contentView];
    if (!v_nav) {
        [self.v_rmvc.rmUtil setNav:[CoreData sharedCoreData].bea_view_controller.navigationController];
    } else {
        [self.v_rmvc.rmUtil setNav:v_nav];
    }

}

-(void)setTexts {
    self.navigationItem.backBarButtonItem.title = NSLocalizedString(@"Back",nil);
}

-(void)setNav:(UINavigationController*)a_nav
{
    v_nav = [a_nav retain];
}

-(void)setMenuBar1
{
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [fun_label release];
    [joy_label release];
    [fun_image release];
    [fun_view release];
    [fun_button release];
    [joy_image release];
    [joy_view release];
    [joy_button release];
    [funBtn release];
    [joyBtn release];
    [funLabel release];
    [joyLabel release];
    [super dealloc];
}


- (IBAction)funBtnClick:(id)sender {
    NSLog(@"BEA FUN");
    FacebookViewController *facebookVC = [[FacebookViewController alloc] initWithNibName:@"FacebookViewController" bundle:nil];
    [self.navigationController pushViewController:facebookVC animated:NO];
    [facebookVC release];
}

- (IBAction)joyBtnClick:(id)sender {
    NSLog(@"BEA JOY");
    FacebookViewController2 *facebookVC = [[FacebookViewController2 alloc] initWithNibName:@"FacebookViewController2" bundle:nil];
    [self.navigationController pushViewController:facebookVC animated:NO];
    [facebookVC release];
}
@end
