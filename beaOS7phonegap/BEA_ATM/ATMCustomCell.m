//
//  ATMCustomCell.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMCustomCell.h"


@implementation ATMCustomCell
@synthesize title_label, description_label, date_label, distance_label, cached_image_view, platinum, is_new, address_label;

@synthesize tel, cached_image_bg, bg, handset;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid{
	
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
		bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_cell_bg.png"]];
		bg.contentMode = UIViewContentModeScaleToFill;
		bg.frame = CGRectMake(0, 0, 320, 81);
		self.backgroundView = bg;
		
		default_title_font_size = 17;
		default_description_font_size = 14;
		default_date_font_size = 12;
		default_distance_font_size = 12;
		
		title_label = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 192, 18)];
		if (sid==2) {
			title_label = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 310, 18)];
		}else {
			title_label = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 192, 18)];
		}
		title_label.font = [UIFont boldSystemFontOfSize:default_title_font_size];
		title_label.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
		title_label.numberOfLines = 1;
		title_label.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:title_label];
		
		address_label = [[UILabel alloc] initWithFrame:CGRectMake(5, 11, 250, 60)];
		address_label.font = [UIFont systemFontOfSize:default_description_font_size];
		//address_label.textColor = [UIColor colorWithRed:0.482 green:0 blue:0 alpha:1];
		address_label.textColor = [UIColor blackColor];
		address_label.numberOfLines = 2;
		address_label.backgroundColor = [UIColor clearColor];
		address_label.lineBreakMode = NSLineBreakByWordWrapping;
		[self.contentView addSubview:address_label];
		
		distance_label = [[UILabel alloc] initWithFrame:CGRectMake(250, 1, 60, 20)];
		distance_label.font = [UIFont boldSystemFontOfSize:15];
		distance_label.textAlignment = NSTextAlignmentRight;
		distance_label.backgroundColor = [UIColor clearColor];
		distance_label.textColor = [UIColor colorWithRed:232/255.0 green:48/255.0 blue:100/255.0 alpha:1];
		[self.contentView addSubview:distance_label];

		handset = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handset.png"]];
		handset.center = CGPointMake(12, 66);
		[self.contentView addSubview:handset];
		
		tel = [[UIButton alloc] initWithFrame:CGRectMake(25, 53, 100, 25)];
		tel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		tel.titleLabel.font = [UIFont systemFontOfSize:14];
		tel.backgroundColor = [UIColor clearColor];
		[tel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
		[tel addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:tel];
		
    }
    return self;
}

- (void)showTel{
	NSString* ctitle = tel.currentTitle;
	ctitle = [ctitle stringByReplacingOccurrencesOfString:@"NULL" withString:@""];

	if ([ctitle length]<1) {
		handset.hidden = YES;
		tel.hidden = YES;
	}
	
}
/*
 - (void)setSelected:(BOOL)selected animated:(BOOL)animated {
 
 [super setSelected:selected animated:animated];
 
 // Configure the view for the selected state
 }
 */

- (void)dealloc {
	NSLog(@"ATMCustomCell dealloc");
	
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

-(void)call:(UIButton *)button{
	NSLog(@"ATMCustomCell phone call pressed");
	//UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@ %@?",NSLocalizedString(@"Dial to ",nil),[button titleForState:UIControlStateNormal]] delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",[button titleForState:UIControlStateNormal]] message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==1) {
		NSLog(@"ATMCustomCell Call %@",[tel titleForState:UIControlStateNormal]);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[tel titleForState:UIControlStateNormal] stringByReplacingOccurrencesOfString:@" " withString:@""]]]];
	}
}

@end
