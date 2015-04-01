//
//  RootViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月12日.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "HomeViewController.h"
#import "YearRoundOffersViewController.h"
#import "QuarterlySurpriseListViewController.h"
#import "NearBySearchListViewController.h"
#import "AdvanceSearchViewController.h"
#import "AdvanceSearchListViewController.h"
#import "FavouriteListViewController.h"
#import "TaxLoanHomeViewController.h"
#import "LTHomeViewController.h"
#import "InstalmentLoanViewController.h"


@interface RootViewController : UIViewController <UITabBarDelegate> {
	UIViewController *home;
	UIViewController *current_view_controller;
	IBOutlet UIView *content_view;
	//IBOutlet UITabBar *tab_bar;
	NSString* menuType;
}
@property(nonatomic, retain) NSString* menuType;
@property(nonatomic, assign) UIView *content_view;
@property(nonatomic, retain) UIViewController *current_view_controller;
-(void)setContent:(int)index;
-(void)goHome;
- (void)setTexts;
- (void)menuButtonPressed:(UIButton *)button;
@end
