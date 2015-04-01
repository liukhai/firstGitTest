#import <UIKit/UIKit.h>
#import "CachedImageView.h"

@class CachedImageView;
@interface NewBranchCell : UITableViewCell {

	IBOutlet UILabel *title_label, *description_label, *date_label, *distance_label, *address_label;
	IBOutlet CachedImageView *cached_image_view;
	IBOutlet UIImageView *platinum, *cached_image_bg, *bg, *is_new;
	//IBOutlet 
    int default_title_font_size, default_description_font_size, default_date_font_size, default_distance_font_size;

	UIImageView *handset;
	UIButton *tel;
	UIButton *tel2;
	UIButton *tel3;

}

@property (nonatomic, assign) UILabel *title_label, *description_label, *date_label, *distance_label, *address_label;
@property (nonatomic, assign) CachedImageView *cached_image_view;
@property (nonatomic, assign) UIImageView *platinum, *is_new;

@property (nonatomic, assign) UIButton *tel;
@property (nonatomic, assign) UIButton *tel2;
@property (nonatomic, assign) UIButton *tel3;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mystyle:(int)sid;

- (void)showTel;

@end
