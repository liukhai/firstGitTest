//
//  RootViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月12日.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController
@synthesize content_view, current_view_controller;
@synthesize menuType;

- (void)viewDidLoad {
	[CoreData sharedCoreData].root_view_controller = self;
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
//    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);

	//	[self setContent:-1];
	//This is important
    [self setTexts];
//	self.navigationItem.backBarButtonItem =
//	[[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back",nil)
//                                      style: UIBarButtonItemStyleBordered
//                                     target:nil
//                                     action:nil] autorelease];
	//	self.navigationItem.title = @"Back";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	/*	session = [[FBSession sessionForApplication:@"eb92c6be289ec4348b6fe1bfc0e043c6" secret:@"2be6b0295ad3f06247ad9905f9e27253" delegate:self] retain];
	 FBLoginButton *login = [[[FBLoginButton alloc] init] autorelease];
	 login.session = session;
	 [self.view addSubview:login];*/
    NSLog(@"debug RootViewController:%@", self);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguage" object:nil];
}
- (void)setTexts{
    self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back",nil)
                                      style: UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];
}
/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	//	[session.delegates removeObject:self];
    [super dealloc];
}

-(void)setContent:(int)index {
	/*if (index<6) {
	 tab_bar.selectedItem = nil;
	 }*/
	if (current_view_controller!=nil) {
		[current_view_controller.view removeFromSuperview];
		[current_view_controller release];
		current_view_controller = nil;
	}
	if (index==-1) {
		self.navigationItem.rightBarButtonItem = nil;
	} else {
		/*UIButton *home_button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
		 home_button.titleLabel.font = [UIFont systemFontOfSize:10];
		 [home_button setTitle:NSLocalizedString(@"Home",nil) forState:UIControlStateNormal];
		 [home_button addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
		 self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:home_button] autorelease];*/
		//self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Home",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(goHome)] autorelease];
	}
	
	NSLog(@"debug RootViewController setContent:%d",index);
	NSLog(@"debug RootViewController content_view:%@",content_view);
	switch (index) {
		case -2:
        {
         //   NSArray *nav1 = self.navigationController.viewControllers;
         //   NSArray *nav2 = [MoreMenuUtil me].creditCardNav.viewControllers;
			[self.navigationController popToRootViewControllerAnimated:NO];
//            if (current_view_controller == nil) {
//                current_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
//                [content_view addSubview:current_view_controller.view];
//            }
            if (![[CoreData sharedCoreData].main_view_controller.viewControllers containsObject:[CoreData sharedCoreData].home_view_controller]) {
                if ([CoreData sharedCoreData].home_view_controller) {
                    [[CoreData sharedCoreData].home_view_controller release];
                    [CoreData sharedCoreData].home_view_controller = nil;
                }
                [CoreData sharedCoreData].home_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
                current_view_controller = [CoreData sharedCoreData].home_view_controller;
                [content_view addSubview:current_view_controller.view];
            }
            
            
            //			NSLog(@"current_view_controller:%@",current_view_controller);
//            [self.navigationController pushViewController:current_view_controller animated:NO];
//            NSLog(@"debug RootViewController current_view_controller:%@",current_view_controller);
//            NSLog(@"debug RootViewController current_view_controller.view:%@",current_view_controller.view);
			break;
        }
		case -1:
        {
        //    NSArray *navArrs = self.navigationController.viewControllers;
         //   NSArray *navArrs2 = [CoreData sharedCoreData].bea_view_controller.navigationController.viewControllers;
		//	[self.navigationController popToRootViewControllerAnimated:TRUE];
            
            if (![[CoreData sharedCoreData].main_view_controller.viewControllers containsObject:[CoreData sharedCoreData].home_view_controller]) {
                if ([CoreData sharedCoreData].home_view_controller) {
                    [[CoreData sharedCoreData].home_view_controller release];
                    [CoreData sharedCoreData].home_view_controller = nil;
                }
                [CoreData sharedCoreData].home_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
                current_view_controller = [CoreData sharedCoreData].home_view_controller;
                [self.navigationController pushViewController:[CoreData sharedCoreData].home_view_controller animated:NO];
            }
            
//            if (current_view_controller == nil) {
//                current_view_controller = [[HomeViewController alloc] initWithNibName:@"HomeView" bundle:nil];
//                [self.navigationController pushViewController:current_view_controller animated:NO];
//            }
//            NSLog(@"current_view_controller:%@",current_view_controller);
		//jerry	[content_view addSubview:current_view_controller.view];
        //    [CoreData sharedCoreData].bea_view_controller.navigationController.viewControllers = self.navigationController.viewControllers;
//            [self.navigationController pushViewController:current_view_controller animated:NO];
      //      [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:current_view_controller animated:NO];
            [MoreMenuUtil me].creditCardNav = self.navigationController;
			break;
        }
		case 1:
			[self.navigationController popToRootViewControllerAnimated:TRUE];
			current_view_controller = [[TaxLoanOffersViewController alloc] initWithNibName:@"TaxLoanOffersViewController" bundle:nil];
			NSLog(@"current_view_controller:%@",current_view_controller);
			[self.navigationController pushViewController:current_view_controller animated:NO];
			break;
            
            
		case 2:
			[self.navigationController popToRootViewControllerAnimated:TRUE];
			current_view_controller = [[LTOffersViewController alloc] initWithNibName:@"LTOffersViewController" bundle:nil];
			NSLog(@"current_view_controller:%@",current_view_controller);
			[self.navigationController pushViewController:current_view_controller animated:NO];
			break;
		case 3:
			[self.navigationController popToRootViewControllerAnimated:TRUE];
			current_view_controller = [[InstalmentLoanOffersViewController alloc] initWithNibName:@"InstalmentLoanOffersViewController" bundle:nil];
			NSLog(@"current_view_controller:%@",current_view_controller);
			[self.navigationController pushViewController:current_view_controller animated:NO];
			break;
            
			/*		case 0:
			 current_view_controller = [[YearRoundOffersViewController alloc] initWithNibName:@"YearRoundOffersView" bundle:nil];
			 [content_view addSubview:current_view_controller.view];
			 break;
			 case 1:
			 current_view_controller = [[QuarterlySurpriseListViewController alloc] initWithNibName:@"QuarterlySurpriseListView" bundle:nil];
			 //			[(QuarterlySurpriseListViewController *)current_view_controller getItemsListType:@"all" Category:@"quarterly"];
			 [content_view addSubview:current_view_controller.view];
			 break;
			 case 2:
			 current_view_controller = [[TacticalDiningListViewController alloc] initWithNibName:@"TacticalDiningListView" bundle:nil];
			 [(TacticalDiningListViewController *)current_view_controller getItemsListType:@"all" Category:@"tactical"];
			 [content_view addSubview:current_view_controller.view];
			 break;
			 case 6:
			 current_view_controller = [[NearBySearchListViewController alloc] initWithNibName:@"NearBySearchListView" bundle:nil];
			 [content_view addSubview:current_view_controller.view];
			 break;
			 case 7:
			 current_view_controller = [[AdvanceSearchViewController alloc] initWithNibName:@"AdvanceSearchView" bundle:nil];
			 [content_view addSubview:current_view_controller.view];
			 break;
			 case 8: //Show search result
			 current_view_controller = [[AdvanceSearchListViewController alloc] initWithNibName:@"AdvanceSearchListView" bundle:nil];
			 [content_view addSubview:current_view_controller.view];
			 NSDictionary *search_critiria = [PlistOperator openPlistFile:@"search_critiria" Datatype:@"NSDictionary"];
			 [(AdvanceSearchListViewController *)current_view_controller getItemsListCuisine:[search_critiria objectForKey:@"cuisine"] Location:[search_critiria objectForKey:@"location"] Keywords:[search_critiria objectForKey:@"keywords"]];
			 break;
			 case 9:
			 current_view_controller = [[FavouriteListViewController alloc] initWithNibName:@"FavouriteListView" bundle:nil];
			 [self.navigationController pushViewController:current_view_controller animated:NO];
			 //			[content_view addSubview:current_view_controller.view];
			 break;
			 case 10:
			 current_view_controller = [[ShareViewController alloc] initWithNibName:@"ShareView" bundle:nil];
			 [self.navigationController pushViewController:current_view_controller animated:NO];
			 //			[content_view addSubview:current_view_controller.view];
			 break;
			 
			 */
	}
}

-(void)goHome {
	[self.navigationController popToRootViewControllerAnimated:TRUE];
	[self setContent:-1];
}

////////////////////
//UITabBarDelegate
////////////////////
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	[self setContent:item.tag+6];
}

- (void)menuButtonPressed:(UIButton *)button {
    switch (button.tag) {
        case 2024:
        {
//            NSArray *navArr1 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
//            NSArray *navArr2 = [CoreData sharedCoreData].bea_view_controller.navigationController.viewControllers;
//            NSArray *navArr = [MoreMenuUtil me].creditCardNav.viewControllers;
			FavouriteListViewController* vc = [[FavouriteListViewController alloc] initWithNibName:@"FavouriteListView" bundle:nil];
            vc.isCreditCardBookmark = YES;
            NSLog(@"debug :self.navigationController.view 1:%@ ",self.navigationController.view);
            [self.navigationController pushViewController:vc animated:NO];
         //   [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:vc animated:NO];
//            NSArray *navArr3 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
//            NSArray *navArr4 = [CoreData sharedCoreData].bea_view_controller.navigationController.viewControllers;
            if (button.tag == 2024) {
                [[MoreMenuUtil me] setMoreMenuViews4CreditCard];
            }
			[vc release];
            break;
        }
        default:
            break;
    }
}

- (void)changeLanguage:(NSNotification *)notification {
    [self setTexts];
}
@end

