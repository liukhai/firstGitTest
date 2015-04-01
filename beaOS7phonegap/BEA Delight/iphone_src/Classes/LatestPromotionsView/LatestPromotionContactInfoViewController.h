//
//  LatestPromotionContactInfoViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月30日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutletListViewController.h"
#import "OutletListCell.h"

@interface LatestPromotionContactInfoViewController : UIViewController {
	IBOutlet UILabel *title_label;
	NSDictionary *merchant_info;
	OutletListViewController *outlet_list_controller;
	//jeff
	IBOutlet UIButton *prev, *next;
}

@property (nonatomic, assign) NSDictionary *merchant_info;
//jeff
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;
@end
