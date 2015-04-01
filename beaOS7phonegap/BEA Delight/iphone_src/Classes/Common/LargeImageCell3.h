//
//  LargeImageCell3.h
//  BEA
//
//  Created by jerry on 14-3-24.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedImageView.h"
@interface LargeImageCell3 : UITableViewCell {
    IBOutlet UILabel *title_label, *description_label;
	IBOutlet CachedImageView *cached_image_view;
    IBOutlet UIImageView *cached_image_bg, *bg, *is_new;
    NSMutableArray* accessibleElements;
}

@property (nonatomic, assign) UILabel *title_label, *description_label;
@property (nonatomic, assign) CachedImageView *cached_image_view;
@property (nonatomic, assign) UIImageView *is_new;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid;
@end
