//
//  LargeImageCell.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年5月4日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedImageView.h"

@interface LargeImageCell : UITableViewCell{

	IBOutlet UILabel *title_label, *description_label;
	IBOutlet CachedImageView *cached_image_view;
    IBOutlet UIImageView *cached_image_bg, *cached_image_acc_bg, *bg, *is_new;
    NSMutableArray* accessibleElements;
}

@property (nonatomic, strong) NSString *description, *name;
@property (nonatomic, assign) UILabel *title_label, *description_label;
@property (nonatomic, assign) CachedImageView *cached_image_view;
@property (nonatomic, assign) UIImageView *cached_image_bg, * cached_image_acc_bg, *is_new;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid;
@end
