//
//  ATMDistCellCMS.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMDistCellCMS.h"


@implementation ATMDistCellCMS
@synthesize title_label, description_label, date_label, distance_label, cached_image_view, platinum, is_new, address_label;

@synthesize tel,imgHome;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid{
	
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryNone;

        if (sid==1) {                                                   
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
        } else if(sid==2){
             bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"widget_banking_icon_mobilebanking_list_middle_selected.png"]];
        } else if(sid==3){
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
        }else {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
        }
		bg.contentMode = UIViewContentModeScaleToFill;
//		bg.frame = CGRectMake(0, 0, 320, 81);
		self.backgroundView = bg;
		
		default_title_font_size = 14;
		default_description_font_size = 13;
		default_date_font_size = 12;
		default_distance_font_size = 12;
		
		title_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, 260, 18)];
		title_label.font = [UIFont systemFontOfSize:default_title_font_size];
		title_label.textColor = [UIColor blackColor];
		title_label.numberOfLines = 1;
		title_label.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:title_label];
		
//		address_label = [[UILabel alloc] initWithFrame:CGRectMake(25, 11, 280, 60)];
//		address_label.font = [UIFont systemFontOfSize:default_description_font_size];
//		//address_label.textColor = [UIColor colorWithRed:0.482 green:0 blue:0 alpha:1];
//		address_label.textColor = [UIColor blackColor];
//		address_label.numberOfLines = 2;
//		address_label.backgroundColor = [UIColor clearColor];
//		address_label.lineBreakMode = UILineBreakModeWordWrap;
//		[self.contentView addSubview:address_label];
//		
//		distance_label = [[UILabel alloc] initWithFrame:CGRectMake(250, 1, 60, 20)];
//		distance_label.font = [UIFont boldSystemFontOfSize:default_title_font_size];
//		distance_label.textAlignment = NSTextAlignmentRight;
//		distance_label.backgroundColor = [UIColor clearColor];
//		distance_label.textColor = [UIColor blackColor];
//		[self.contentView addSubview:distance_label];
//
//		handset = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgCMShours.png"]];
//		handset.frame = CGRectMake(5, 43, 15, 15);
//		[self.contentView addSubview:handset];
//
//        imgHome = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgCMShome.png"]];
//		imgHome.frame = CGRectMake(5, 25, 15, 15);
//		[self.contentView addSubview:imgHome];
//
//		tel = [[UILabel alloc] initWithFrame:CGRectMake(25, 33, 280, 60)];
//		tel.font = [UIFont systemFontOfSize:default_description_font_size];
//		tel.textColor = [UIColor blackColor];
//		tel.numberOfLines = 2;
//		tel.backgroundColor = [UIColor clearColor];
//		tel.lineBreakMode = UILineBreakModeWordWrap;
//		[self.contentView addSubview:tel];
        
        UIImageView *imageAccessibility = [[UIImageView alloc] initWithFrame:CGRectMake(250, 20, 40, 40)];
        imageAccessibility.isAccessibilityElement = YES;
        imageAccessibility.accessibilityLabel = NSLocalizedString(@"ATM_Map", nil);
        imageAccessibility.accessibilityTraits = UIAccessibilityTraitButton;
        [self.contentView addSubview:imageAccessibility];
		cached_image_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_orange_right.png"]];
		cached_image_bg.frame = CGRectMake(260, 15, 15, 15);
        //		cached_image_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 122, 80)];
		cached_image_bg.backgroundColor = [UIColor clearColor];
        cached_image_bg.isAccessibilityElement = YES;
        cached_image_bg.accessibilityTraits = UIAccessibilityTraitButton;
        cached_image_bg.accessibilityLabel = NSLocalizedString(@"SelectBranchATM", nil);
		[self.contentView addSubview:cached_image_bg];
		
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
	NSLog(@"ATMDistCellCMS dealloc");
	
	[title_label removeFromSuperview];
	[title_label release];
	[cached_image_bg removeFromSuperview];
	[cached_image_bg release];
	[cached_image_view removeFromSuperview];
	[cached_image_view release];
	[description_label removeFromSuperview];
	[description_label release];
	[address_label removeFromSuperview];
	[address_label release];
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
