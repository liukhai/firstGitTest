//
//  Created by NEO on 06/16/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "AccProViewController.h"
#import "AccProMenuViewController.h"

// private method
@interface AccProViewController () 

- (void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;

@end


@implementation AccProViewController

@synthesize tabBar;
@synthesize _AccProListViewController;
@synthesize menuVC;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[CachedImageView clearAllCache];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[MyScreenUtil me] adjustView2Screen:self.view];

    // add navigation view
    self.navigationController.delegate = self;
//    if (![[MyScreenUtil me] adjustNavBackground:self.navigationController])
    [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];

    // add content view    
//    [self.view addSubview:self.navigationController.view];
    
    // add tabbar
//    tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-49, 320, 49);
//    tabBar.delegate = self;
//    NSArray *tab_list = [NSLocalizedString(@"accpro.common.tabName",nil) componentsSeparatedByString:@","];
//    for (int i=0; i<4; i++) {
//		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
//	}
//	[self.view addSubview:tabBar];
 	NSLog(@"AccPro viewdidload:%@", self);
	
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
	NSLog(@"AccProViewController didShowViewController:%@--%@, %d", pnavigationController, viewController,[pnavigationController.viewControllers count]);
    
    if ([viewController class] == [AccProListViewController class ] || [viewController class] == [ConsumerLoanOffersViewController class]) {
        //            [(MPFFundPriceViewController*)viewController loadFundData];
        tabBar.selectedItem = [tabBar.items objectAtIndex:0];
    }
}

-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"AccProViewController: willShowViewController(navigationController:%@, viewController:%@)%d",pnavigationController,viewController,[pnavigationController.viewControllers count]);
    
//    if([pnavigationController.viewControllers count] == 1){
//        [self goHome];
//    }
    if ([viewController class] == [AccProViewController class]) {
        [[CoreData sharedCoreData].main_view_controller popViewControllerAnimated:NO];
    }
    if ([viewController class]==[AccProApplicationViewController class]) {
        [MBKUtil me].queryButtonWillShow=@"NO";
    }else {
        [MBKUtil me].queryButtonWillShow=@"YES";
    }
}


#pragma mark - UITabbarDelegate

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    switch (item.tag) {
		case 0: // Offers TabBar
            //			if ([AccProUtil isLangOfChi]) {
            //                [self forwardNextView:NSClassFromString(@"AccProDefaultPageViewController") viewName:@"AccProDefaultPageViewController_zh"];    
            //            }else{
            //                [self forwardNextView:NSClassFromString(@"AccProDefaultPageViewController") viewName:@"AccProDefaultPageViewController_en"];
            //            }
            [self forwardNextView:NSClassFromString(@"AccProListViewController") viewName:@"AccProListViewController"];    
			break;
		case 1: // Application TabBar
            [self forwardNextView:NSClassFromString(@"AccProApplicationViewController") viewName:@"AccProApplicationViewController"];    
			break;
		case 2:  // nearby TabBar
            [UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.5];
			[[CoreData sharedCoreData].root_view_controller setContent:0];
			[CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
			[AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
			[[CoreData sharedCoreData].atmlocation_view_controller welcome];
            
			[UIView commitAnimations];
            
            break;
		case 3:  // Enquiries TabBar
            [self forwardNextView:NSClassFromString(@"AccProEnquiryViewController") viewName:@"AccProEnquiryViewController"];
			break;
	}
}

-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName{
    NSLog(@"AccProViewController: forwardNextView(viewController:%@)",viewController);
    if ([[self.navigationController.viewControllers lastObject] class] == viewController) {
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:FALSE];
    //    UIViewController *current_view_controller = [viewController new];
    UIViewController *current_view_controller = [[viewController alloc] initWithNibName:viewName bundle:nil];
    
    [self.navigationController pushViewController:current_view_controller animated:TRUE];
    [current_view_controller release];
}

#pragma mark
#pragma mark UIAlertViewDelegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==0) {
        [[CoreData sharedCoreData].email createComposerWithSubject:NSLocalizedString(@"Check out",nil) Message:NSLocalizedString(@"Main share app",nil)];
		[self.view addSubview:[CoreData sharedCoreData].email.view];
	}
}


#pragma mark
#pragma mark Core API

-(void)goHome{
    NSLog(@"AccProViewController goHome");
    
    if ([[AccProUtil me].animate isEqualToString:@"YES"]) {
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.5];
    }
//	[AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[AccProUtil me].AccPro_view_controller.navigationController popViewControllerAnimated:NO];
	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    if ([[AccProUtil me].animate isEqualToString:@"YES"]) {
//        [UIView commitAnimations];
    }
//    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;

//    if([SGGUtil isInModule]){
//        [[SGGUtil me] goIn];
//    }
}

-(void)goHome2{
    [[AccProUtil me].AccPro_view_controller.navigationController popToRootViewControllerAnimated:NO];
}

-(void) selectTabBarMatchedCurrentView{
}

-(void) showWelcomeOffer{
    NSLog(@"AccProViewController: showWelcomeOffer");
    if ([AccProUtil isLangOfChi]) {
        [self forwardNextView:NSClassFromString(@"AccProDefaultPageViewController") viewName:@"AccProDefaultPageViewController_zh"];    
    }else{
        [self forwardNextView:NSClassFromString(@"AccProDefaultPageViewController") viewName:@"AccProDefaultPageViewController_en"];
    }
}

-(void) welcome{
//    [self forwardNextView:NSClassFromString(@"AccProListViewController") viewName:@"AccProListViewController"];
    
//    [self.navigationController popToRootViewControllerAnimated:FALSE];
//    AccProListViewController *current_view_controller = [[AccProListViewController alloc] initWithNibName:@"AccProListViewController" bundle:nil];
//    [self.navigationController pushViewController:current_view_controller animated:TRUE];
//    self._AccProListViewController = current_view_controller;
//    [current_view_controller release];

    menuVC = [[AccProMenuViewController alloc] initWithNibName:@"AccProMenuViewController" bundle:nil nav:self.navigationController];
//    [self.navigationController popToRootViewControllerAnimated:FALSE];
    
//    if ([CoreData sharedCoreData].bea_view_controller->jump1) {
//        [navigationController pushViewController:menuVC animated:NO];
//    } else {
        [self.navigationController pushViewController:menuVC animated:NO];
//    }
    
//    [menuVC welcome];

}
-(void) welcome2 :(int)index{
    
    menuVC = [[AccProMenuViewController alloc] initWithNibName:@"AccProMenuViewController" bundle:nil nav:self.navigationController];
    [menuVC setShowIndex:index];
//    [self.navigationController popToRootViewControllerAnimated:FALSE];
    [self.navigationController pushViewController:menuVC animated:NO];
    
}
-(void)goMainFaster
{
    NSLog(@"debug goMainFaster:%@", self);
//	[AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
    [[AccProUtil me].AccPro_view_controller.navigationController popToRootViewControllerAnimated:NO];
//	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
}

@end
