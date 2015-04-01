//
//  ATMCustomCellCMS.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedImageView.h"

@class CachedImageView;
@interface ATMCustomCellCMS : UITableViewCell {

	IBOutlet UILabel *title_label, *description_label, *date_label, *distance_label, *address_label;
	IBOutlet CachedImageView *cached_image_view;
	IBOutlet UIImageView *platinum, *cached_image_bg, *bg, *is_new;
	//IBOutlet 
    int default_title_font_size, default_description_font_size, default_date_font_size, default_distance_font_size;

	UIImageView *handset, *imgHome, *imgHour, *imgFax, *cached_image_bgAccessibility;
	UIButton *tel;

}

@property (nonatomic, assign) UILabel *title_label, *description_label, *date_label, *distance_label, *address_label, *fax_label;
@property (nonatomic, assign) CachedImageView *cached_image_view;
@property (nonatomic, assign) UIImageView *platinum, *is_new, *imgHome, *bg, *cached_image_bg, *handset, *imgHour, *imgFax, *cached_image_bgAccessibility;

@property (nonatomic, assign) UIButton *tel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid;

//- (void)showTel;
-(void) set2ATM;
-(void) setPlace;

@end
