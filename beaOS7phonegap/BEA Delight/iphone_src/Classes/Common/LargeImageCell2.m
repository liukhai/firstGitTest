//
//  LargeImageCell.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年5月4日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LargeImageCell2.h"


@implementation LargeImageCell2
@synthesize title_label, description_label, cached_image_view, is_new, description, name;

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
//		bg.contentMode = UIViewContentModeScaleToFill;
//		bg.frame = CGRectMake(0, 0, 296, 50);
		self.backgroundView = bg;
        self.backgroundColor = [UIColor clearColor];
//		title_label = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 160, 50)];
//        title_label = [[UILabel alloc] initWithFrame:CGRectMake(100, -5, 180, 60)];
        title_label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 180, 60)];
//		title_label.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
		title_label.textColor = [UIColor blackColor];
//		title_label.font = [UIFont systemFontOfSize:14];
        title_label.font = [UIFont systemFontOfSize:14.5];
		title_label.numberOfLines = 0;
		title_label.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:title_label];
        
//		description_label = [[UILabel alloc] initWithFrame:CGRectMake(125, 33, 160, 21)];
//		description_label.font = [UIFont systemFontOfSize:14];
//		//description_label.textColor = [UIColor colorWithRed:0.482 green:0 blue:0 alpha:1];
//		description_label.textColor = [UIColor blackColor];
//		description_label.numberOfLines = 0;
//		description_label.backgroundColor = [UIColor clearColor];
//		[self.contentView addSubview:description_label];
        
//		cached_image_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_arrow_right.png"]];
//		cached_image_bg.frame = CGRectMake(280, 25, 20, 20);
////		cached_image_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 122, 80)];
//		cached_image_bg.backgroundColor = [UIColor clearColor];
//		[self.contentView addSubview:cached_image_bg];
        
		cached_image_view = [[CachedImageView alloc] initWithFrame:CGRectMake(0, 0, 95, 50)];
		cached_image_view.contentMode = UIViewContentModeScaleAspectFit;
		cached_image_view.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:cached_image_view];
        
//		is_new = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new.png"]];
//		//is_new.frame = CGRectMake(275, 55, 41, 29);
//		is_new.frame = CGRectMake(375, 55, 41, 29);
//		is_new.hidden = TRUE;
//		[self.contentView addSubview:is_new];
	}
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)newName{
    if ([newName isEqualToString:@""]) {
        return;
    }
    title_label.text = newName;
}

- (void)dealloc {
	[title_label removeFromSuperview];
	[title_label release];
//	[cached_image_bg removeFromSuperview];
//	[cached_image_bg release];
	[cached_image_view removeFromSuperview];
	[cached_image_view release];
	[description_label removeFromSuperview];
	[description_label release];
//	[is_new removeFromSuperview];
//	[is_new release];
	[bg release];
    [super dealloc];
}


@end
