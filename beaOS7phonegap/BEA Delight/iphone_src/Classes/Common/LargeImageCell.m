//
//  LargeImageCell.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年5月4日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LargeImageCell.h"


@implementation LargeImageCell
@synthesize title_label, description_label, cached_image_view, is_new, cached_image_bg, cached_image_acc_bg, description, name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        accessibleElements = nil;
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryNone;
        if (sid==1) {
            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
        } else {
//            bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
            
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
        
		description_label = [[UILabel alloc] initWithFrame:CGRectMake(105, 33, 150, 21)];
		description_label.font = [UIFont systemFontOfSize:15];
		//description_label.textColor = [UIColor colorWithRed:0.482 green:0 blue:0 alpha:1];
		description_label.textColor = [UIColor blackColor];
		description_label.numberOfLines = 0;
        description_label.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:description_label];
        
		cached_image_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_arrow_right.png"]];
		cached_image_bg.frame = CGRectMake(260, 25, 20, 20);
//		cached_image_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 122, 80)];
        cached_image_bg.backgroundColor = [UIColor clearColor];
        //cached_image_bg.isAccessibilityElement = YES;
        //cached_image_bg.accessibilityLabel = NSLocalizedString(@"Details_accessibility", nil);
        //cached_image_bg.accessibilityTraits = UIAccessibilityTraitNone;
        [self.contentView addSubview:cached_image_bg];
        
        //edit by chu for accessibility touch area
        cached_image_acc_bg = [[UIImageView alloc] initWithImage:nil];
        cached_image_acc_bg.frame = CGRectMake(255, 0, 30, 80);
        cached_image_acc_bg.backgroundColor = [UIColor clearColor];
        cached_image_acc_bg.isAccessibilityElement = YES;
        cached_image_acc_bg.accessibilityLabel = NSLocalizedString(@"Details_accessibility", nil);
        cached_image_acc_bg.accessibilityTraits = UIAccessibilityTraitNone;
        [self.contentView addSubview:cached_image_acc_bg];
        
		cached_image_view = [[CachedImageView alloc] initWithFrame:CGRectMake(10, 11, 82, 60)];
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

- (void)setName:(NSString *)newName{
    if ([newName isEqualToString:@""]) {
        return;
    }
    title_label.text = [newName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int footer = 10;
    
    CGRect frame;
    
    frame = title_label.frame;
    frame.origin.y = footer;
    title_label.frame = frame;
    
    footer = [self fitHeight:title_label] + 10;
    
//    frame = description_label.frame;
//    frame.origin.y = footer;
//    description_label.frame = frame;
//    
//    footer = [self fitHeight:description_label] + 5;
    if (footer > 81) {
//        frame = self.frame;
//        frame.size.height = footer;
//        self.frame = frame;
    } else {
        frame = title_label.frame;
        frame.size.height = 61;
        title_label.frame = frame;
    }
    
//    frame = self.frame;
//    frame.size.height = footer;
//    self.frame = frame;
    
    CGPoint center = cached_image_view.center;
    center.y = title_label.center.y;
    cached_image_view.center = center;
    
    center = cached_image_bg.center;
    center.y = title_label.center.y;
    cached_image_bg.center = center;
    
    //edit by chu 20150224
    center = cached_image_acc_bg.center;
    center.y = title_label.center.y;
    cached_image_acc_bg.center = center;
}

- (void)setDescription:(NSString *)newDescription {
    if ([newDescription isEqualToString:@""]) {
        return;
    }
//    description_label.text = newDescription;
    
    int footer = 10;
    
    CGRect frame;
    
    NSString *str = [NSString stringWithFormat:@"%@\n\n%@",title_label.text,newDescription];
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    title_label.text = str;
    
    frame = title_label.frame;
    frame.origin.y = footer;
    title_label.frame = frame;
    
    
    footer = [self fitHeight:title_label] + 10;
    
//    frame = description_label.frame;
//    frame.origin.y = footer;
//    description_label.frame = frame;
    
//    footer = [self fitHeight:description_label] + 5;
    
    if (footer > 81) {
//        frame = self.frame;
//        frame.size.height = footer;
//        self.frame = frame;
    } else {
        frame = title_label.frame;
        frame.size.height = 61;
        title_label.frame = frame;
    }
    
    
    CGPoint center = cached_image_view.center;
    center.y = title_label.center.y;
    cached_image_view.center = center;
    
    center = cached_image_bg.center;
    center.y = title_label.center.y;
    cached_image_bg.center = center;
    
    //edit by chu 20150224
    center = cached_image_acc_bg.center;
    center.y = title_label.center.y;
    cached_image_acc_bg.center = center;
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
    //edit by chu 20150223
    [cached_image_acc_bg removeFromSuperview];
    [cached_image_acc_bg release];
    [super dealloc];
}

- (int) fitHeight:(UILabel*)sender
{
    //    NSLog(@"debug ATMCustomCellCMS fitHeight:%@", sender.text);
    
    CGSize maxSize = CGSizeMake(sender.frame.size.width, MAXFLOAT);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height);
    int height = sender.frame.origin.y + sender.frame.size.height;
    return height;
}

#pragma mark - 
/* The container itself is not accessible, so MultiFacetedView should return NO in isAccessiblityElement. */
- (BOOL)isAccessibilityElement
{
    return NO;
}
@end
