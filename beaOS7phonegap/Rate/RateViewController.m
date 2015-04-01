#import "RateViewController.h"
//
//  Created by NEO on 06/16/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//
// private method
@interface RateViewController () 

- (void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;

@end


@implementation RateViewController

@synthesize tabBar;

@synthesize
menuVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[CachedImageView clearAllCache];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[MyScreenUtil me] adjustView2Screen:self.view];

    // add navigation view
    self.navigationController.delegate = self;
//    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
//    [navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
//    
//    // add content view
//    [[MyScreenUtil me] adjustNavView:navigationController.view];
//    [self.view addSubview:navigationController.view];
    
//    // add tabbar
//    tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-49, 320, 49);
//    tabBar.delegate = self;
//    NSArray *tab_list = [NSLocalizedString(@"Rate.common.tabName",nil) componentsSeparatedByString:@","];
//    for (int i=0; i<4; i++) {
//		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
//	}
//	[self.view addSubview:tabBar];

// 	NSLog(@"Rate viewdidload:%@", self);
	
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

#pragma mark - UINavigationControllerDelegate

-(void) navigationController:(UINavigationController *)pnavigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"RateViewController didShowViewController:%@--%@, %d", pnavigationController, viewController,[pnavigationController.viewControllers count]);
    
}

-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"RateViewController: willShowViewController(navigationController:%@, viewController:%@)",pnavigationController,viewController);
    
    if([pnavigationController.viewControllers count] == 1 && [[CoreData sharedCoreData].main_view_controller.viewControllers.lastObject class] == [RateViewController class]){
        [self goMain];
    }
}


#pragma mark - UITabbarDelegate

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    switch (item.tag) {
		case 0: // Note TabBar
			[self forwardNextView:NSClassFromString(@"RateNoteViewController") viewName:@"RateNoteViewController"];
			break;
		case 1: // TT TabBar
            [self forwardNextView:NSClassFromString(@"RateTTViewController") viewName:@"RateTTViewController"];    
			break;
		case 2:  // Prime rate TabBar
            [self forwardNextView:NSClassFromString(@"RatePrimeViewController") viewName:@"RatePrimeViewController"];    
			break;
		case 3:  // nearby TabBar
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [[CoreData sharedCoreData].root_view_controller setContent:0];
//            [CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            [CoreData sharedCoreData].hotline_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
            [RateUtil me].Rate_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
//            [[CoreData sharedCoreData].atmlocation_view_controller welcome];
            [[CoreData sharedCoreData].hotline_view_controller welcome];
            [UIView commitAnimations];
			break;
	}
}

-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName{
    NSLog(@"RateViewController: forwardNextView(viewController:%@)",viewController);

    [self.navigationController popToRootViewControllerAnimated:FALSE];
    //    UIViewController *current_view_controller = [viewController new];
    UIViewController *current_view_controller = [[viewController alloc] initWithNibName:viewName bundle:nil];
    
    [self.navigationController pushViewController:current_view_controller animated:TRUE];
    [current_view_controller release];
}

#pragma mark
#pragma mark Core API

-(void)goMainFaster
{
    NSLog(@"debug goMainFaster:%@", self);
    //	[RateUtil me].Rate_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
//    [CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
}

-(void)goMain
{
    NSLog(@"RateViewController goMain");
	
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
    [self goMainFaster];
//	[UIView commitAnimations];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
}

-(void) selectTabBarMatchedCurrentView{
    if ([[self.navigationController.viewControllers lastObject] class] == [RateNoteViewController class] ) {
        tabBar.selectedItem = [tabBar.items objectAtIndex:0];
    }else if([[self.navigationController.viewControllers lastObject] class]== [RateTTViewController class]){
        tabBar.selectedItem = [tabBar.items objectAtIndex:1];
    }else if([[self.navigationController.viewControllers lastObject] class]== [RatePrimeViewController class]){
        tabBar.selectedItem = [tabBar.items objectAtIndex:2];
    }
    
    
}

-(void) welcome{
    if (![MBKUtil wifiNetWorkAvailable]) {
        [[RateUtil me] alertAndBackToMain];
        return ;
    }
    NSLog(@"debug RateViewController: welcome");
    
//    [self forwardNextView:NSClassFromString(@"RateNoteViewController") viewName:@"RateNoteViewController"];
    menuVC = [[RateMenuViewController alloc] initWithNibName:@"RateMenuViewController" bundle:nil nav:self.navigationController];
    [self.navigationController popViewControllerAnimated:FALSE];
    [self.navigationController pushViewController:menuVC animated:NO];

    [menuVC welcome];

}

-(void) welcome:(int)tag
{
    if (![MBKUtil wifiNetWorkAvailable]) {
        [[RateUtil me] alertAndBackToMain];
        return ;
    }
    NSLog(@"debug Rate RateViewController: welcome:%d",tag);
    
    menuVC = [[RateMenuViewController alloc] initWithNibName:@"RateMenuViewController" bundle:nil nav:self.navigationController];
    [self.navigationController popViewControllerAnimated:FALSE];
    menuVC.menuTag = tag;
    
    NSLog(@"debug Rate RateViewController: push before:%@",menuVC);

    [[CoreData sharedCoreData].main_view_controller pushViewController:menuVC animated:NO];
    
    NSLog(@"debug Rate RateViewController: push after:%@",menuVC);

//    [menuVC welcome:tag];

    NSLog(@"debug Rate RateViewController: welcome after:%@",menuVC);

//    switch (tag) {
//        case 0:
//            [self forwardNextView:NSClassFromString(@"RateNoteViewController") viewName:@"RateNoteViewController"];
//            break;
//
//        case 1:
//            [self forwardNextView:NSClassFromString(@"RateTTViewController") viewName:@"RateTTViewController"];
//            break;
//
//        case 2:
//            [self forwardNextView:NSClassFromString(@"RatePrimeViewController") viewName:@"RatePrimeViewController"];
//            break;
//
//        default:
//            [self forwardNextView:NSClassFromString(@"RateNoteViewController") viewName:@"RateNoteViewController"];
//            break;
//    }
}

@end
