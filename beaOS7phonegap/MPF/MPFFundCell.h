#import <UIKit/UIKit.h>
#import "CachedImageView.h"

@class CachedImageView;
@interface MPFFundCell : UITableViewCell {
    IBOutlet UIImageView   *bg ;
    IBOutlet UILabel *scheme_label, *price_label; 
}

@property (nonatomic, assign) UILabel *scheme_label, *price_label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
