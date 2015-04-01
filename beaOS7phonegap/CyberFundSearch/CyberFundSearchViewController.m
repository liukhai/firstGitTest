//  Amended by yaojzy on 3/7/12.

#import "CyberFundSearchViewController.h"
#import "CyberFundSearchWebViewController.h"

// private method
@interface CyberFundSearchViewController () 

@end


@implementation CyberFundSearchViewController

@synthesize tabBar, banner, showBack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[CachedImageView clearAllCache];
    }
    return self;
}

-(void)setTexts{
    NSArray *tab_list = [NSLocalizedString(@"cyberfundsearch.tabbar.title",nil) componentsSeparatedByString:@","];
	for (int i=0; i<5; i++) {
		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
	}
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [[MyScreenUtil me] adjustModuleView:self.view];
    // add navigation view
    self.navigationController.delegate = self;
//    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
//    [navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];

    // add content view
//    [[MyScreenUtil me] adjustNavView:navigationController.view];
//    [self.view addSubview:navigationController.view];

//    banner.frame = CGRectMake(0, 20, 320, 44);
//    [self.view addSubview:banner];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bea_logo.png"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.banner.frame = CGRectMake(0.0, 0.0, 320, 44);
    [self.view addSubview:self.banner];
    // add tabbar
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0) {
        tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight_IOS7_20]-49-20, 320, 49);
    }else {
        tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight_IOS7_20]-49, 320, 49);
    }
    
    tabBar.delegate = self;
    NSArray *tab_list = [NSLocalizedString(@"cyberfundsearch.tabbar.title",nil) componentsSeparatedByString:@","];
	for (int i=0; i<5; i++) {
		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
	}
	[self.view addSubview:tabBar];

    self.view.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,[[MyScreenUtil me] getScreenHeight_IOS7_20]);

    [self setTexts];
    [self welcome];
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
	NSLog(@"CyberFundSearchViewController didShowViewController:%@--%@, %d", pnavigationController, viewController,[pnavigationController.viewControllers count]);

    if([self.showBack isEqualToString:@"YES"]){
        [self.banner setHidden:YES];
    }
    [MBKUtil me].queryButtonWillShow= @"NO";
}

//-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//	NSLog(@"CyberFundSearchViewController willShowViewController:%@--%@, %d", pnavigationController, viewController,[pnavigationController.viewControllers count]);
//
//    if([pnavigationController.viewControllers count] <= 2){
//        self.showBack = @"";
//    }
//    if(![self.showBack isEqualToString:@"YES"]){
//        [self.banner setHidden:NO];
//    }
//    if([pnavigationController.viewControllers count] == 1){
//        [self goHome];
//    }
//}


#pragma mark - UITabbarDelegate

-(void) tabBar:(UITabBar *)ptabBar didSelectItem:(UITabBarItem *)item {
    self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:item.tag];
    
    switch (item.tag) {
		case 0:
            [self goHome];
            break; 
		case 1:
            [self openurl:[HttpRequestUtils getUrlStr4ifc:[MigrationSetting me].URLOfCyberFundSearch_FundSearch]];
			break;
		case 2:
            [self openurl:[HttpRequestUtils getUrlStr4ifc:[MigrationSetting me].URLOfCyberFundSearch_MyFunds]];
            break; 
		case 3:
            [self openurl:[HttpRequestUtils getUrlStr4ifc:[MigrationSetting me].URLOfCyberFundSearch_Top10]];
            break; 
		case 4:
            [self openurl:[HttpRequestUtils getUrlStr4ifc:[MigrationSetting me].URLOfCyberFundSearch_News]];
            break; 
	}
}

-(void) openurl:(NSString*)a_url{
//    [self.navigationController popToRootViewControllerAnimated:FALSE];
//    CGRect frame = self.navigationController.view.frame;
// //   frame.origin.y = 20;
//    self.navigationController.view.frame = frame;
//    CGRect newFrame = self.view.frame;
//    newFrame.origin.y = 0;
//    self.view.frame = newFrame;
//    NSLog(@"frame: x:%f y:%f width:%f height:%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);

    [self changeBanner:nil];
    NSLog(@"openurl:%@",a_url);
    for (UIView *subview in self.view.subviews) {
        if (subview.tag == 10000) {
            [subview removeFromSuperview];
        }
    }
    for (UIViewController *viewController in [self childViewControllers]) {
        [viewController removeFromParentViewController];
    }
    
    CyberFundSearchWebViewController *current_view_controller = [[CyberFundSearchWebViewController alloc] initWithNibName:@"CyberFundSearchWebViewController" bundle:nil url:a_url];
//    [self.navigationController pushViewController:current_view_controller animated:FALSE];
    
    current_view_controller.view.tag = 10000;
    [self addChildViewController:current_view_controller];
    [self.view addSubview:current_view_controller.view];
    current_view_controller.view.frame = CGRectMake(0.0, 44, 320, tabBar.frame.origin.y - 44);
    current_view_controller.webView.frame = CGRectMake(0.0, 0.0, 320, tabBar.frame.origin.y - 44);
    [current_view_controller release];
}

#pragma mark
#pragma mark UIAlertViewDelegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==0) {
        [[CoreData sharedCoreData].email createComposerWithSubject:NSLocalizedString(@"Check out",nil) Message:NSLocalizedString(@"Main share app",nil)];		
	}
}

#pragma mark
#pragma mark Core API

-(void)goHome{
    NSLog(@"CyberFundSearchViewController goHome");
    
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
//	[CyberFundSearchUtil me].CyberFundSearch_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
//	[CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//	[UIView commitAnimations];
    
    [[CoreData sharedCoreData].main_view_controller popToRootViewControllerAnimated:NO];
}

-(void) welcome{
    if (![MBKUtil wifiNetWorkAvailable]) {
        [[CyberFundSearchUtil me] alertAndBackToMain];
        return ;
    }
    NSLog(@"CyberFundSearchViewController: welcome()");
    
    [self tabBar:self.tabBar didSelectItem:((UITabBarItem*)[self.tabBar.items objectAtIndex:1])];
    
//    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [customBtn setFrame:CGRectMake(0, 0, 30, 30)];
//    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
//    navigationController.navigationItem.leftBarButtonItem = leftBar;
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bea_logo.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)back:(UIButton *)sender {
    [sender removeFromSuperview];
    for (UIView *subview in self.view.subviews) {
        if (subview.tag == 10001) {
            [subview removeFromSuperview];
        }
    }
    if ([[self.childViewControllers lastObject] class] == [CyberFundSearchWebViewController class]) {
        [self.childViewControllers.lastObject removeFromParentViewController];
    }
    [self changeBanner:nil];
    
}

-(void)changeBanner:(CyberFundSearchWebViewController *)webViewController {
    if (webViewController) {
        self.banner.image = [[LangUtil me] getImage:@"bea_banner_back.png"];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 70, 44);
        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backButton];
        webViewController.view.tag = 10001;
        [self addChildViewController:webViewController];
        [self.view addSubview:webViewController.view];
//        [self.view performSelector:@selector(addSubview:) withObject:webViewController.view afterDelay:0.2];
        webViewController.view.frame = CGRectMake(0.0, 44, 320, tabBar.frame.origin.y - 44);
        webViewController.webView.frame = CGRectMake(0.0, 0.0, 320, tabBar.frame.origin.y - 44);
    }else {
        self.banner.image = [[LangUtil me] getImage:@"bea_logo.png"];
    }
}

@end
