//
//  YearRoundOffersDistrictViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YearRoundOffersListViewController.h"

@interface YearRoundOffersDistrictViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	IBOutlet UIPickerView *picker;
	IBOutlet UIButton *search;
	NSArray *location_list, *location_id_list;
}

-(IBAction)searchButtonPressed:(UIButton *)button;
@end
