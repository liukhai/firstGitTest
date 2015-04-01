//
//  AdvanceSearchViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月24日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "CoreData.h"
#import "AdvanceSearchListViewController.h"
#import "MBKUtil.h"

@interface AdvanceSearchViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate> {

    IBOutlet UIImageView *img1;
    IBOutlet UIImageView *img0;
    IBOutlet UIImageView *img3;
    IBOutlet UIImageView *img2;
    IBOutlet UIImageView *tableBackImage;
    IBOutlet UIImageView *underLineImage;
	IBOutlet UILabel *title_label;
	IBOutlet UIButton *dining_offers, *shopping_offers, *cuisine, *location, *search;
	IBOutlet UILabel *location_label, *cuisine_label;
	IBOutlet UITextField *keywords;
	IBOutlet UITableView *table_view;
	IBOutlet UITableViewCell *keywords_cell, *district_cell, *cuisine_cell;
	UIPickerView *pickerView;
	NSArray *location_list, *location_index_list, *cuisine_list, *cuisine_index_list, *category_list, *category_index_list;
	int current_cuisine, current_category, current_location;
}

-(IBAction)diningButtonPressed:(UIButton *)button;
-(IBAction)shoppingButtonPressed:(UIButton *)button;
-(IBAction)cuisineButtonPressed:(UIButton *)button;
-(IBAction)searchButtonPressed:(UIButton *)button;

@end
