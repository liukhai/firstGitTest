//
//  OutletListCell.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OutletListCell.h"


@implementation OutletListCell
@synthesize address, tel, opening, distance;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSString *status = [[PageUtil pageUtil] getPageTheme];
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
        
		bg.contentMode = UIViewContentModeScaleToFill;
		bg.frame = CGRectMake(0, 0, 320, 81);
		//jeff
		//bg.frame = CGRectMake(0, 0, 320, 101);
		//
		self.backgroundView = bg;
		
        house.frame = CGRectMake(0.0, 0.0, 18, 18);
		//house.center = CGPointMake(20, 27);
		//jeff
		house.center = CGPointMake(20, 20);
		//
		[self.contentView addSubview:house];
		
        
        if ([status isEqualToString:@"1"]) {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_cell_bg.png"]];
            house = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_address.png"]];
            handset = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_telephone.png"]];
        } else {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_cell_bg_new.png"]];
            house = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_address_new.png"]];
            handset = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_telephone_new.png"]];
        }
        
		//handset.center = CGPointMake(20, 64);
		//jeff
        handset.frame = CGRectMake(0.0, 0.0, 18, 18);
		handset.center = CGPointMake(20, 64);
		//
		[self.contentView addSubview:handset];
		//address = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 245, 50)];
		//jeff
		address = [[UILabel alloc] initWithFrame:CGRectMake(35, 12, 225, 40)];
		//
		//address.editable = FALSE;
		address.userInteractionEnabled = FALSE;
		//address.scrollEnabled = FALSE;
		address.backgroundColor = [UIColor clearColor];
		address.textColor = [UIColor blackColor];
		//address.numberOfLines = 3;
		//jeff
		address.numberOfLines = 4;
		//
		
		//address.font = [UIFont systemFontOfSize:14];
		//jeff
		address.font = [UIFont systemFontOfSize:13];
		//
		[self.contentView addSubview:address];
		//tel = [[UIButton alloc] initWithFrame:CGRectMake(35, 50, 100, 25)];
		//jeff
		tel = [[UIButton alloc] initWithFrame:CGRectMake(35, 53, 100, 20)];
		//
		tel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		//tel.titleLabel.font = [UIFont systemFontOfSize:14];
		tel.titleLabel.font = [UIFont systemFontOfSize:13];
		tel.backgroundColor = [UIColor clearColor];
		[tel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
		[tel addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:tel];
		
		//opening = [[UILabel alloc] initWithFrame:CGRectMake(105, 50, 200, 25)];
		//jeff
		opening = [[UILabel alloc] initWithFrame:CGRectMake(105, 64, 200, 20)];
		//
		opening.font = [UIFont systemFontOfSize:14];
		opening.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:opening];
		
		distance = [[UILabel alloc] initWithFrame:CGRectMake(280, 20, 40, 33)];
		//jeff
		//distance = [[UILabel alloc] initWithFrame:CGRectMake(280, 40, 40, 33)];
		//
		distance.font = [UIFont boldSystemFontOfSize:17];
		distance.backgroundColor = [UIColor clearColor];
		distance.textColor = [UIColor colorWithRed:232/255.0 green:48/255.0 blue:100/255.0 alpha:1];
		[self.contentView addSubview:distance];
	}
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
	[house removeFromSuperview];
	[house release];
	[handset removeFromSuperview];
	[handset release];
	[bg release];
	[address removeFromSuperview];
	[address release];
	[tel removeFromSuperview];
	[tel release];
	[opening removeFromSuperview];
	[opening release];
	[distance removeFromSuperview];
	[distance release];
    [super dealloc];
}

-(void)call:(UIButton *)button{
	NSLog(@"phone call pressed");
	//UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@ %@?",NSLocalizedString(@"Dial to ",nil),[button titleForState:UIControlStateNormal]] delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",[button titleForState:UIControlStateNormal]] message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==1) {
		NSLog(@"Call %@",[tel titleForState:UIControlStateNormal]);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[tel titleForState:UIControlStateNormal] stringByReplacingOccurrencesOfString:@" " withString:@""]]]];
	}
}

@end
