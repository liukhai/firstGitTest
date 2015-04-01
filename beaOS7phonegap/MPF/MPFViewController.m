#import "MPFViewController.h"
#import "MPFRateUtil.h"

// private method
@interface MPFViewController () 

- (void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;

@end


@implementation MPFViewController

@synthesize tabBar, btnView, backBtn;
@synthesize bt_loginMBK, bt_callMPFhotline;;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[CachedImageView clearAllCache];
    }
    return self;
}

-(void)setTexts{
    NSArray *tab_list = [NSLocalizedString(@"mpf.tabbar.title",nil) componentsSeparatedByString:@","];
	for (int i=0; i<tab_list.count; i++) {
		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
	}
    [self.bt_loginMBK setTitle:NSLocalizedString(@"Logintomobilebanking",nil) forState:UIControlStateNormal];
	[self.bt_callMPFhotline setTitle:NSLocalizedString(@"CallMPFhotline",nil) forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    backBtn.accessibilityLabel = NSLocalizedString(@"Back_accessibility",nil);
    
    if ([[CoreData sharedCoreData].lang hasPrefix:@"e"]) {
        NSLog(@"e");
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            _backgroundView.frame = CGRectMake(0, 44, 320, 475);
            _navigationImage.image = [UIImage imageNamed:@"navigation.png"];
        } else {
            _navigationImage.image = [UIImage imageNamed:@"navigation6.1.png"];
        }
        _backgroundView.clipsToBounds = YES;
        [self.view addSubview:_backgroundView];
    }
    if ([[CoreData sharedCoreData].lang hasPrefix:@"zh_TW"]) {
        NSLog(@"中文");
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            _backgroundView.frame = CGRectMake(0, 44, 320, 475);
            _navigationImage.image = [UIImage imageNamed:@"navigationCN.png"];
        } else {
            _navigationImage.image = [UIImage imageNamed:@"navigationCN6.1.png"];
        }
        _backgroundView.clipsToBounds = YES;
        [self.view addSubview:_backgroundView];
    }
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (screenHeight == 568 && [[UIDevice currentDevice].systemVersion doubleValue] >= 6.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 7.0) {
        _backgroundView.frame = CGRectMake(0, 44, 320, 475);
    }
//    [[MyScreenUtil me] adjustView2Screen:self.view];
//    self.view.center = [[MyScreenUtil me] getmainScreenCenter_20:self];

    btnViewY = 480+[[MyScreenUtil me] getScreenHeightAdjust];

    // add navigation view
    self.navigationController.delegate = self;
//    if (![[MyScreenUtil me] adjustNavBackground:navigationController])
    [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]] autorelease] atIndex:1];
    
    // add content view
//    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
//    [self.view addSubview:self.navigationController.view];
    
    btnView.frame = CGRectMake(0, btnViewY-49, 320, 37);
	[self.view addSubview:btnView];
    
    // add tabbar
    tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-69, 320, 49);
    NSLog(@"L209_Insurance Loan  PropertyLoanViewController.m -- tabber掉下去20");
    tabBar.delegate = self;
    NSArray *tab_list = [NSLocalizedString(@"mpf.tabbar.title",nil) componentsSeparatedByString:@","];
	for (int i=0; i<tab_list.count; i++) {
		((UITabBarItem *)[tabBar.items objectAtIndex:i]).title = [tab_list objectAtIndex:i];
	}
	[self.view addSubview:tabBar];
    tabBar.selectedItem = [tabBar.items objectAtIndex:2];
    [self forwardNextView:NSClassFromString(@"MPFFundPriceViewController")
                 viewName:@"MPFFundPriceViewController_en"];
    [self.bt_loginMBK setTitle:NSLocalizedString(@"Logintomobilebanking",nil) forState:UIControlStateNormal];
    [self.bt_loginMBK addTarget:self action:@selector(call_Logintomobilebanking:) forControlEvents:UIControlEventTouchUpInside];
    self.bt_loginMBK.titleLabel.numberOfLines = 2;
    self.bt_loginMBK.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bt_loginMBK.titleLabel.textAlignment = NSTextAlignmentCenter;
    
	[self.bt_callMPFhotline setTitle:NSLocalizedString(@"CallMPFhotline",nil) forState:UIControlStateNormal];
    [self.bt_callMPFhotline addTarget:self action:@selector(call_CallMPFhotline:) forControlEvents:UIControlEventTouchUpInside];
    self.bt_callMPFhotline.titleLabel.numberOfLines = 2;
    self.bt_callMPFhotline.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bt_callMPFhotline.titleLabel.textAlignment = NSTextAlignmentCenter;
    
 	NSLog(@"MPF viewdidload:%@", self);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguage" object:nil];

	
}

-(void)showBtnView
{
    [btnView setHidden:NO];

    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
    
    btnView.frame = CGRectMake(0, btnViewY-49-38, 320, 38);

	[UIView commitAnimations];

}

-(void)call_Logintomobilebanking:(UIButton *)button
{
    [[MPFUtil me] call_Logintomobilebanking];    
}

-(void)call_CallMPFhotline:(UIButton *)button
{
    [[MPFUtil me] call_CallMPFhotline];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark - UINavigationControllerDelegate

-(void) navigationController:(UINavigationController *)pnavigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"MPFViewController didShowViewController:%@--%@, %d", pnavigationController, viewController,[pnavigationController.viewControllers count]);
	if ([viewController.navigationController.viewControllers count]==1) {
	} else {
        if ([viewController class] == [MPFPromoListViewController class]) {
            tabBar.selectedItem = [tabBar.items objectAtIndex:0];
        }
        if ([viewController class] == [MPFFundPriceViewController class ]) {
            //            [(MPFFundPriceViewController*)viewController loadFundData];
            tabBar.selectedItem = [tabBar.items objectAtIndex:2];
        }
        if ([viewController class] == [MPFNewsViewController class ]) {
        }
        if ([viewController class] == [MPFPromoListViewController class ]) {
            //            [(MPFPromotionViewController*)viewController sendRequest];
        }
    }
    
    if ([viewController class] == [MPFNewsViewController class]
        ||[viewController class] == [MPFPromoListViewController class]) {
        [MBKUtil me].queryButtonWillShow= @"NO";
    }else{
        [MBKUtil me].queryButtonWillShow= @"YES";
    }
}

-(void) navigationController:(UINavigationController *)pnavigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"MPFViewController: willShowViewController(navigationController:%@, viewController:%@)",pnavigationController,viewController);
    
//    if([pnavigationController.viewControllers count] == 1){
//        [self goHome];
//    }
}


#pragma mark - UITabbarDelegate

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    btnView.frame = CGRectMake(0, btnViewY-49, 320, 37);
    [btnView setHidden:YES];
    
    switch (item.tag) {
		case 0: // promotion
//            [[MPFRateUtil me] sendRequestMPFRate:@"MPFPROMO"];
            if ([[self.navigationController.viewControllers lastObject] class] == [MPFPromoListViewController class]) {
                return;
            }
            [self forwardNextView:NSClassFromString(@"MPFPromoListViewController")
                         viewName:@"MPFPromoListViewController"];
            break;
		case 1: // Latest News TabBar
            if ([[self.navigationController.viewControllers lastObject] class] == [MPFNewsViewController class]) {
                return;
            }
//            [[MPFRateUtil me] sendRequestMPFRate:@"MPFNEWS"];
//            if([MBKUtil isLangOfChi]){
//                [self forwardNextView:NSClassFromString(@"MPFNewsViewController")
//                             viewName:@"MPFNewsViewController_zh"];
//            }else{
                [self forwardNextView:NSClassFromString(@"MPFNewsViewController")
                             viewName:@"MPFNewsViewController"];
//            }
			break;
		case 2:  // Fund Price
//            [[MPFRateUtil me] sendRequestMPFRate:@"MPFFUNDPRICE"];
            [self forwardNextView:NSClassFromString(@"MPFFundPriceViewController")
                         viewName:@"MPFFundPriceViewController_en"];
            break;
//		case 3:  // My MPF
//            [[MPFUtil me] alertAndBackToMBKMPF];
//            break; 
		case 4:  // Enquiries TabBar
            if ([[self.navigationController.viewControllers lastObject] class] == [MPFEnquiryViewController class]) {
                return;
            }
//            [[MPFRateUtil me] sendRequestMPFRate:@"MPFENQUIRIES"];
//            if([MBKUtil isLangOfChi]){
//                [self forwardNextView:NSClassFromString(@"MPFEnquiryViewController")
//                             viewName:@"MPFEnquiryViewController_zh"];
//            }else{
                [self forwardNextView:NSClassFromString(@"MPFEnquiryViewController")
                             viewName:@"MPFEnquiryViewController_en"];
//            }
            break;
	}
}

-(void) openNewsViewController:(NSURL*)url
{
    NSLog(@"MPFViewController openNewsViewController:%@",url);
    
    MPFNewsViewController *current_view_controller = [[MPFNewsViewController alloc] initWithNibName:@"MPFNewsViewController" bundle:nil url:url];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        current_view_controller.view.frame = CGRectMake(0, -20, 320, 475);
    }
    [_backgroundView addSubview:current_view_controller.view];
    [self addChildViewController:current_view_controller];
//    [self.navigationController pushViewController:current_view_controller animated:NO];
    [current_view_controller release];
}

-(void) forwardNextView:(Class) viewController viewName:(NSString*)viewName{
    NSLog(@"MPFViewController: forwardNextView:%@",viewController);
    
//    [self.navigationController popToRootViewControllerAnimated:FALSE];
    if ([[self.navigationController.viewControllers lastObject] class] == viewController) {
        return;
    }
    UIViewController *current_view_controller = [[viewController alloc] initWithNibName:viewName bundle:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        current_view_controller.view.frame = CGRectMake(0, -20, 320, 475);
    }
    for (UIView *subView in _backgroundView.subviews) {
        [subView removeFromSuperview];
    }
    for (UIViewController *childView in self.childViewControllers) {
        [childView removeFromParentViewController];
    }
    [_backgroundView addSubview:current_view_controller.view];
    [self addChildViewController:current_view_controller];
    
    NSLog(@"current_view_controller : %@",current_view_controller);
//    [self.navigationController pushViewController:current_view_controller animated:NO];
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
    NSLog(@"MPFViewController goHome");
    
    
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
//	[MPFUtil me].MPF_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
	 [CoreData sharedCoreData].bea_view_controller.vc4process = nil;
    [CoreData setMainViewFrame];//[CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
//	[UIView commitAnimations];
}

-(void) selectTabBarMatchedCurrentView{
    if ([[self.navigationController.viewControllers lastObject] class]==[MPFPromoListViewController class]) {
        tabBar.selectedItem = [tabBar.items objectAtIndex:0];
        return;
    }
    if ([[self.navigationController.viewControllers lastObject] class] == [MPFNewsViewController class]) {
        tabBar.selectedItem = [tabBar.items objectAtIndex:1];
        return;
    }
}

-(void) welcome{
    if (![MBKUtil wifiNetWorkAvailable]) {
        [[MPFUtil me] alertAndBackToMain];
        return ;
    }
    NSLog(@"MPFViewController: welcome()");
    
    [self tabBar:self.tabBar didSelectItem:((UITabBarItem*)[self.tabBar.items objectAtIndex:2])];
    
    //    [[MPFUtil me]._MPFImportantNoticeViewController switchMe];
    
}

- (void)changeLanguage:(NSNotification *)notification {
    [self setTexts];
}

- (IBAction)backBtnClick:(id)sender {
    if ([[self.childViewControllers lastObject] class] == [MPFFundPriceViewController class]) {
        [self.childViewControllers.lastObject removeFromParentViewController];
        [_backgroundView.subviews.lastObject removeFromSuperview];
        [self.navigationController popViewControllerAnimated:NO];
    }
    if ([[self.childViewControllers lastObject] class] == [MPFNewsViewController class]) {
        [self.childViewControllers.lastObject removeFromParentViewController];
        [_backgroundView.subviews.lastObject removeFromSuperview];
        if (_backgroundView.subviews.count < 1) {
            [self.navigationController popViewControllerAnimated:NO];
        }
        //        [self.navigationController popViewControllerAnimated:NO];
        
    }
    if ([[self.childViewControllers lastObject] class] == [MPFPromoListViewController class]) {
        [self.childViewControllers.lastObject removeFromParentViewController];
        [_backgroundView.subviews.lastObject removeFromSuperview];
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    if ([[self.childViewControllers lastObject] class] == [MPFEnquiryViewController class]) {
        [self.childViewControllers.lastObject removeFromParentViewController];
        [_backgroundView.subviews.lastObject removeFromSuperview];
        [self.navigationController popViewControllerAnimated:NO];
    }
    if ([[self.childViewControllers lastObject] class] == [MPFPromoViewController class]) {
        [self.childViewControllers.lastObject removeFromParentViewController];
        [_backgroundView.subviews.lastObject removeFromSuperview];
        //        [self.navigationController popViewControllerAnimated:NO];
    }
    
}
@end
