//
//  LargeImageCell3.m
//  BEA
//
//  Created by jerry on 14-3-24.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import "LargeImageCell3.h"

@implementation LargeImageCell3
@synthesize title_label, description_label, cached_image_view, is_new;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        accessibleElements = nil;
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryNone;
        if (sid==1) {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
        } else {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
        }
//		bg.contentMode = UIViewContentModeScaleToFill;
        //		bg.frame = CGRectMake(0, 0, 290, 81);
		self.backgroundView = bg;
        self.backgroundColor = [UIColor clearColor];
		title_label = [[UILabel alloc] initWithFrame:CGRectMake(105, 10, 150, 60)];
        //		title_label.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
		title_label.textColor = [UIColor blackColor];
		title_label.font = [UIFont systemFontOfSize:15];
		title_label.numberOfLines = 0;
		title_label.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:title_label];
        
        
        UIImageView *imageAccessibility = [[UIImageView alloc] initWithFrame:CGRectMake(258, 20, 42, 42)];
        imageAccessibility.isAccessibilityElement = YES;
        imageAccessibility.accessibilityLabel = NSLocalizedString(@"Details_accessibility", nil);
        imageAccessibility.accessibilityTraits = UIAccessibilityTraitNone;
        [self.contentView addSubview:imageAccessibility];

		cached_image_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_arrow_right.png"]];
		cached_image_bg.frame = CGRectMake(268, 30, 22, 22);
        //		cached_image_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 122, 80)];
		cached_image_bg.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:cached_image_bg];
//        cached_image_bg.isAccessibilityElement = YES;
//        cached_image_bg.accessibilityLabel = NSLocalizedString(@"Details_accessibility", nil);
//        cached_image_bg.accessibilityTraits = UIAccessibilityTraitNone;
        
        
		cached_image_view = [[CachedImageView alloc] initWithFrame:CGRectMake(10, 13, 82, 60)];
		cached_image_view.contentMode = UIViewContentModeScaleAspectFit;
		cached_image_view.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:cached_image_view];
        
        //		is_new = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new.png"]];
		//is_new.frame = CGRectMake(275, 55, 41, 29);
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

- (void)dealloc {
	[title_label removeFromSuperview];
	[title_label release];
	[cached_image_bg removeFromSuperview];
	[cached_image_bg release];
	[cached_image_view removeFromSuperview];
	[cached_image_view release];
	[description_label removeFromSuperview];
	[description_label release];
	[is_new removeFromSuperview];
	[is_new release];
	[bg release];
    [super dealloc];
}

#pragma mark -
/* The container itself is not accessible, so MultiFacetedView should return NO in isAccessiblityElement. */
- (BOOL)isAccessibilityElement
{
    return NO;
}

@end
