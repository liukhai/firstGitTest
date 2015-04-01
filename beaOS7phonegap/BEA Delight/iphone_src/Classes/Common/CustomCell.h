//
//  CustomCell.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedImageView.h"

@class CachedImageView;
@interface CustomCell : UITableViewCell {

	IBOutlet UILabel *title_label, *description_label, *date_label, *distance_label;
	IBOutlet CachedImageView *cached_image_view;
	IBOutlet UIImageView *platinum, *cached_image_bg, *bg, *is_new;
	//IBOutlet int default_title_font_size, default_description_font_size, default_date_font_size, default_distance_font_size;
	int default_title_font_size, default_description_font_size, default_date_font_size, default_distance_font_size;
}

@property (nonatomic, assign) UILabel *title_label, *description_label, *date_label, *distance_label;
@property (nonatomic, assign) CachedImageView *cached_image_view;
@property (nonatomic, assign) UIImageView *platinum, *is_new, *cached_image_bg, *cached_image_bg1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid;

@end
