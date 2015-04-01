//
//  SGGViewController.h
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import "SGGUtil.h"
#import "SGGViewController.h"

@implementation SGGViewController

@synthesize navigationController, banner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		[CachedImageView clearAllCache];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    navigationController.delegate = self;
    [navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
    [self.view addSubview:navigationController.view];
	banner.frame = CGRectMake(0, 20, 320, 44);
    [self.view addSubview:banner];

    lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"SGG.header",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:20];
	lbTitle.textAlignment = UITextAlignmentCenter;
	lbTitle.numberOfLines = 1;
	lbTitle.lineBreakMode = UILineBreakModeWordWrap;

 	NSLog(@"SGG viewdidload:%@", self);
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}

-(void) navigationController:(UINavigationController *)pnavigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"SGGViewController didShowViewController:%@--%@, %d", pnavigationController, viewController,[pnavigationController.viewControllers count]);
    
}

-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"SGGViewController: willShowViewController(navigationController:%@, viewController:%@)",pnavigationController,viewController);
    
}

-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName{
    NSLog(@"SGGViewController: forwardNextView(viewController:%@)",viewController);

    [navigationController popToRootViewControllerAnimated:FALSE];
    UIViewController *current_view_controller = [[viewController alloc] initWithNibName:viewName bundle:nil];
    [navigationController pushViewController:current_view_controller animated:TRUE];
    [current_view_controller release];
}

-(void) welcome{
     [[CoreData sharedCoreData].queue cancelAllOperations];
    
    if (![MBKUtil wifiNetWorkAvailable]) {
        [[SGGUtil me] alertAndBackToMain];
        return ;
    }
    NSLog(@"SGGViewController: welcome()");
    
    [self forwardNextView:NSClassFromString(@"SGGIntroViewController") viewName:@"SGGIntroViewController"];    
}

-(void)showIntro:(id)sender
{
    [self forwardNextView:[SGGIntroViewController class] viewName:@"SGGIntroViewController"];
}

-(void)showTNC:(id)sender
{
    UIViewController *current_view_controller = [[SGGTNCViewController alloc] initWithNibName:@"SGGTNCViewController" bundle:nil];
    
    [self.navigationController pushViewController:current_view_controller animated:YES];
    [current_view_controller release];
}

-(void)checkLatestPromo:(id)sender
{
    [[SGGUtil me] goOut];
    
    UIButton* acc_pro_button=[[UIButton alloc] init];
    acc_pro_button.tag=13;
    [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
    [acc_pro_button release];
}
@end
