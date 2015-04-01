//
//  Created by NEO on 11/14/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "ConsumerLoanViewController.h"

// private method
@interface ConsumerLoanViewController () 

- (void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;

@end


@implementation ConsumerLoanViewController

@synthesize navigationController, tabBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[CachedImageView clearAllCache];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [[MyScreenUtil me] adjustModuleView:self.view];

    // add navigation view
//    self.navigationController.delegate = self;
    if (![[MyScreenUtil me] adjustNavBackground:self.navigationController])
    [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
    
    // add content view    
    [self.view addSubview:self.navigationController.view];
    

 	NSLog(@"consumerloan viewdidload:%@", self);
	
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
	NSLog(@"ConsumerLoanViewController didShowViewController:%@--%@, %d", pnavigationController, viewController,[pnavigationController.viewControllers count]);
    
    if ([viewController class] == [AccProListViewController class ] || [viewController class] == [ConsumerLoanOffersViewController class ]) {
        tabBar.selectedItem = [tabBar.items objectAtIndex:0];
    }
}

-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"ConsumerLoanViewController: willShowViewController(navigationController:%@, viewController:%@)%d",pnavigationController,viewController,[pnavigationController.viewControllers count]);
    
    if ([viewController class]==[RootViewController class]) {//added by jasen on 20111118
        [[ConsumerLoanUtil me] backToFromPage];
    }
    
    if ([viewController class]==[ConsumerLoanApplicationViewController class]) {
        [MBKUtil me].queryButtonWillShow=@"NO";
    }else {
        [MBKUtil me].queryButtonWillShow=@"YES";
    }
}


#pragma mark - UITabbarDelegate

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    switch (item.tag) {
		case 0: // Offers TabBar
            [self.navigationController popViewControllerAnimated:YES];
            break;
		case 1: // Application TabBar
            [self forwardNextView:NSClassFromString(@"ConsumerLoanApplicationViewController") viewName:@"ConsumerLoanApplicationViewController"];    
			break;
		case 2:  // nearby TabBar
            [[ConsumerLoanUtil me] showNearBy];
            break;
		case 3:  // Enquiries TabBar
            [self forwardNextView:NSClassFromString(@"ConsumerLoanEnquiryViewController") viewName:@"ConsumerLoanEnquiryViewController"];
			break;
	}
}

-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName{
    NSLog(@"ConsumerLoanViewController: forwardNextView(viewController:%@)",viewController);
    if ([[navigationController.viewControllers lastObject] class] == viewController) {
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:FALSE];
    //    UIViewController *current_view_controller = [viewController new];
    UIViewController *current_view_controller = [[viewController alloc] initWithNibName:viewName bundle:nil];       
    
    [self.navigationController pushViewController:current_view_controller animated:NO];
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

-(void) showOffer:(NSString*)url
          hotline:(NSString*)hotline
         btnLabel:(NSString*)btnLabel
              tnc:(NSString*)TNCurl
{
    NSLog(@"ConsumerLoanViewController: welcome");
//        [self forwardNextView:NSClassFromString(@"ConsumerLoanOffersViewController") viewName:@"ConsumerLoanOffersViewController"];    
    
    
    [self.navigationController popToRootViewControllerAnimated:FALSE];
    //    UIViewController *current_view_controller = [viewController new];
    ConsumerLoanOffersViewController *consumerLoanOffersViewController =
    [[ConsumerLoanOffersViewController alloc]
     initWithNibName:@"ConsumerLoanOffersViewController"
     bundle:nil
     url:url
     hotline:hotline
     btnLabel:btnLabel
     tnc:TNCurl];
    [self.navigationController pushViewController:consumerLoanOffersViewController animated:TRUE];
    [consumerLoanOffersViewController release];
}

@end
