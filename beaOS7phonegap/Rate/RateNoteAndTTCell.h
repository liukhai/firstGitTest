#import <UIKit/UIKit.h>
#import "CachedImageView.h"

@class CachedImageView;
@interface RateNoteAndTTCell : UITableViewCell {
    IBOutlet UIImageView   *bg ;
    IBOutlet UILabel *lbCurrency, *lbBankBuy , *lbBankSell; 
}

@property (nonatomic, assign) UILabel *lbCurrency, *lbBankBuy , *lbBankSell; 

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
