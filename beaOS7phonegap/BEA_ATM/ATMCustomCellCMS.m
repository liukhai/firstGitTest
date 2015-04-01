//
//  ATMCustomCellCMS.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMCustomCellCMS.h"


@implementation ATMCustomCellCMS
@synthesize title_label, description_label, date_label, distance_label, cached_image_view, platinum, is_new, address_label,fax_label;

@synthesize tel,imgHome, bg, handset, cached_image_bg, imgHour,imgFax;

#define margin_top 10
#define margin_bottom 10
#define margin_left 10
#define margin_right 10
#define position_y_line234 30
#define width_line1 180
#define width_line23 220

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid{
	
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryNone;
        if (sid==1) {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
        } else {
//            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
        }
		bg.contentMode = UIViewContentModeScaleToFill;
//		bg.frame = CGRectMake(0, 0, 320, 81);
		self.backgroundView = bg;
		
		default_title_font_size = 13;
		default_description_font_size = 13;
		default_date_font_size = 12;
		default_distance_font_size = 12;
		
        title_label = [[UILabel alloc] initWithFrame:CGRectMake(margin_left, margin_top, width_line23+18, 18)];
		title_label.font = [UIFont boldSystemFontOfSize:default_title_font_size];
		title_label.textColor = [UIColor blackColor];
		title_label.numberOfLines = 0;
        title_label.lineBreakMode = NSLineBreakByWordWrapping;
		title_label.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:title_label];
        
        imgHome = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_address.png"]];
		imgHome.frame = CGRectMake(margin_left, 25, 15, 15);
		[self.contentView addSubview:imgHome];

		address_label = [[UILabel alloc] initWithFrame:CGRectMake(position_y_line234, 25, width_line23, 20)];
		address_label.font = [UIFont systemFontOfSize:default_description_font_size];
		address_label.textColor = [UIColor blackColor];
		address_label.numberOfLines = 0;
		address_label.backgroundColor = [UIColor clearColor];
		address_label.lineBreakMode = NSLineBreakByWordWrapping;
		[self.contentView addSubview:address_label];

		distance_label = [[UILabel alloc] initWithFrame:CGRectMake(230, margin_top, 60, 20)];
		distance_label.font = [UIFont boldSystemFontOfSize:default_title_font_size];
		distance_label.textAlignment = NSTextAlignmentRight;
		distance_label.backgroundColor = [UIColor clearColor];
		distance_label.textColor = [UIColor blackColor];
		[self.contentView addSubview:distance_label];

        handset = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_telephone.png"]];
		handset.frame = CGRectMake(margin_left, 63, 15, 15);
		[self.contentView addSubview:handset];

		tel = [[UIButton alloc] initWithFrame:CGRectMake(position_y_line234, 58, 100, 20)];
		tel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		tel.titleLabel.font = [UIFont systemFontOfSize:14];
		tel.backgroundColor = [UIColor clearColor];
		[tel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
		[tel addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:tel];

		imgHour = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_openinghours.png"]];
		imgHour.frame = CGRectMake(margin_left, 83, 15, 15);
		[self.contentView addSubview:imgHour];
        
		description_label = [[UILabel alloc] initWithFrame:CGRectMake(position_y_line234, 68, width_line23, 25)];
		description_label.font = [UIFont systemFontOfSize:default_description_font_size];
		description_label.textColor = [UIColor blackColor];
		description_label.numberOfLines = 0;
		description_label.backgroundColor = [UIColor clearColor];
		description_label.lineBreakMode = NSLineBreakByWordWrapping;
		[self.contentView addSubview:description_label];
        
//        imgFax = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_telephone_15.png"]];
//        imgFax.frame = CGRectMake(margin_left, 103, 15, 15);
//        [self.contentView addSubview:imgFax];
//        
//        fax_label = [[UILabel alloc] initWithFrame:CGRectMake(position_y_line234, 103, 100, 20)];
//        fax_label.font = [UIFont systemFontOfSize:14];
//        fax_label.textColor = [UIColor blackColor];
//        fax_label.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:fax_label];
        
        cached_image_bgAccessibility = [[UIImageView alloc] initWithFrame:CGRectMake(250, 20, 40, 40)];
        cached_image_bgAccessibility.isAccessibilityElement = YES;
        cached_image_bgAccessibility.accessibilityLabel = NSLocalizedString(@"ATM_Map", nil);
        cached_image_bgAccessibility.accessibilityTraits = UIAccessibilityTraitButton;
        [self.contentView addSubview:cached_image_bgAccessibility];
		cached_image_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_arrow_right.png"]];
		cached_image_bg.frame = CGRectMake(260, 30, 20, 20);
//        cached_image_bg.isAccessibilityElement = YES;
//        cached_image_bg.accessibilityTraits = UIAccessibilityTraitButton;
//        cached_image_bg.accessibilityLabel = NSLocalizedString(@"ATM_Map", nil);
		cached_image_bg.backgroundColor = [UIColor clearColor];
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
	NSLog(@"ATMCustomCellCMS dealloc");
	
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

-(void)call:(UIButton *)button{
	NSLog(@"ATMCustomCellCMS phone call pressed");
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",[button titleForState:UIControlStateNormal]] message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==1) {
		NSLog(@"ATMCustomCellCMS Call %@",[tel titleForState:UIControlStateNormal]);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[tel titleForState:UIControlStateNormal] stringByReplacingOccurrencesOfString:@" " withString:@""]]]];
	}
}

-(void) setPlace {
    int footer;
    CGRect frame;
    footer = [self fitHeight:title_label]+5;
    
    frame = address_label.frame;
    frame.origin.y = footer;
    address_label.frame = frame;
    
    frame = imgHome.frame;
    frame.origin.y = footer;
    imgHome.frame = frame;
    
    footer = [self fitHeight:address_label]+5;
    
    if (tel.titleLabel.text && ![@"" isEqualToString:tel.titleLabel.text]) {
        frame = tel.frame;
        frame.origin.y = footer;
        tel.frame = frame;
        
        frame = handset.frame;
        frame.origin.y = footer + 2;
        handset.frame = frame;
        
        footer = tel.frame.origin.y + tel.frame.size.height+5;
    }else {
        tel.hidden = YES;
        handset.hidden = YES;
    }

//    if (fax_label.text && ![@"" isEqualToString:fax_label.text]) {
//        frame = fax_label.frame;
//        frame.origin.y = footer - 1;
//        fax_label.frame = frame;
//        
//        frame = imgFax.frame;
//        frame.origin.y = footer;
//        imgFax.frame = frame;
//        
//        footer = fax_label.frame.origin.y + fax_label.frame.size.height+5;
//    }else {
//        fax_label.hidden = YES;
//        imgFax.hidden = YES;
//    }
    
    frame = imgHour.frame;
    frame.origin.y = footer;
    imgHour.frame = frame;

    frame = description_label.frame;
    frame.origin.y = footer;
    description_label.frame = frame;
    footer = [self fitHeight:description_label];
    
    footer += margin_bottom;
    
    frame = cached_image_bg.frame;
    frame.origin.y = footer/2-frame.size.height/2;
    cached_image_bg.frame = frame;
    
    cached_image_bgAccessibility.frame = CGRectMake(frame.origin.x - 10, frame.origin.y - 10, frame.size.width + 20, frame.size.height + 20);
    
    frame = self.frame;
    frame.size.height = footer;
    self.frame = frame;
}

-(void) setPlace4ATM {
    int footer = 0;
    CGRect frame = self.frame;
    footer = [self fitHeight:title_label] + 5;
    
//    NSLog(@"debug ATMCustomCellCMS setPlace4ATM 1:%f--%f--%d", frame.size.width, frame.size.height, footer);

    frame = address_label.frame;
    frame.origin.y = footer;
    address_label.frame = frame;
    
    frame = imgHome.frame;
    frame.origin.y = footer;
    imgHome.frame = frame;

    footer = [self fitHeight:address_label] + 5;
    
//    NSLog(@"debug ATMCustomCellCMS setPlace4ATM 2:%f--%f--%d", frame.size.width, frame.size.height, footer);

    frame = imgHour.frame;
    frame.origin.y = footer;
    imgHour.frame = frame;
    
    frame = description_label.frame;
    frame.origin.y = footer;
    description_label.frame = frame;
    footer = [self fitHeight:description_label];
    
//    NSLog(@"debug ATMCustomCellCMS setPlace4ATM 3:%f--%f--%d", frame.size.width, frame.size.height, footer);

    footer += margin_bottom;

    frame = cached_image_bg.frame;
    frame.origin.y = footer/2-frame.size.height/2;
    cached_image_bg.frame = frame;

    frame = self.frame;
    frame.size.height = footer;
    self.frame = frame;
    
//    NSLog(@"debug ATMCustomCellCMS setPlace4ATM 4:%f--%f--%d", frame.size.width, frame.size.height, footer);
}

-(void) set2ATM {
    [handset setHidden:YES];
    [tel setHidden:YES];
    
    [self setPlace4ATM];
}

- (int) fitHeight:(UILabel*)sender
{
//    NSLog(@"debug ATMCustomCellCMS fitHeight:%@", sender.text);

    CGSize maxSize = CGSizeMake(sender.frame.size.width, 200);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height);
    int height = sender.frame.origin.y + sender.frame.size.height;
    return height;
}

@end
