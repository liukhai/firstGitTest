//
//  CustomCell2.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomCell2.h"


@implementation CustomCell2
@synthesize title_label, description_label, date_label, distance_label, cached_image_view, platinum, is_new;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryNone;
        if (sid==1) {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
        } else {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
        }
		bg.contentMode = UIViewContentModeScaleToFill;
//		bg.frame = CGRectMake(0, 0, 320, 81);
		self.backgroundView = bg;
		default_title_font_size = 15;
		default_description_font_size = 14;
		default_date_font_size = 12;
		default_distance_font_size = 12;
        
		title_label = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 180, 60)];
//		title_label.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
		title_label.textColor = [UIColor blackColor];
		title_label.font = [UIFont systemFontOfSize:default_title_font_size];
		title_label.numberOfLines = 0;
		title_label.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:title_label];
        
//		description_label = [[UILabel alloc] initWithFrame:CGRectMake(78, 33, 160, 21)];
//		description_label.font = [UIFont systemFontOfSize:default_description_font_size];
////		description_label.textColor = [UIColor colorWithRed:0.482 green:0 blue:0 alpha:1];
//		description_label.textColor = [UIColor blackColor];
//		description_label.numberOfLines = 1;
//		description_label.backgroundColor = [UIColor clearColor];
//		[self.contentView addSubview:description_label];
        
        cached_image_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_arrow_right.png"]];
		cached_image_bg.frame = CGRectMake(260, 25, 20, 20);
		[self.contentView addSubview:cached_image_bg];

		cached_image_view = [[CachedImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
		cached_image_view.contentMode = UIViewContentModeScaleAspectFit;
		cached_image_view.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:cached_image_view];
        
		platinum = [[UIImageView alloc] initWithImage:[[LangUtil me] getImage:@"platinum.png"]];
   //     platinum = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"platinum.png", nil)]];
		platinum.contentMode = UIViewContentModeLeft;
		platinum.center = CGPointMake(78 + platinum.frame.size.width/2, 62);
//		platinum.hidden = TRUE;
		[self.contentView addSubview:platinum];

//		is_new = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new.png"]];
//		is_new.frame = CGRectMake(275, 55, 41, 29);
////		is_new.hidden = TRUE;
//		[self.contentView addSubview:is_new];

		distance_label = [[UILabel alloc] initWithFrame:CGRectMake(220, 1, 60, 20)];
		distance_label.font = [UIFont systemFontOfSize:13];
		distance_label.textAlignment = NSTextAlignmentRight;
		distance_label.backgroundColor = [UIColor clearColor];
//		distance_label.textColor = [UIColor colorWithRed:232/255.0 green:48/255.0 blue:100/255.0 alpha:1];
        distance_label.textColor = [UIColor blackColor];
		[self.contentView addSubview:distance_label];
		
    }
    return self;
}

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/

- (void)dealloc {
	[title_label removeFromSuperview];
	[title_label release];
	[cached_image_bg removeFromSuperview];
	[cached_image_bg release];
	[cached_image_view removeFromSuperview];
	[cached_image_view release];
	[description_label removeFromSuperview];
	[description_label release];
	[platinum removeFromSuperview];
	[platinum release];
	[is_new removeFromSuperview];
	[is_new release];
	[distance_label removeFromSuperview];
	[distance_label release];
	[bg release];
    [super dealloc];
}


@end