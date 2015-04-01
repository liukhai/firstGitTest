#import "RatePrimeCell.h"

@implementation RatePrimeCell

@synthesize scheme_label, price_label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryNone;
//		bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_cell_bg.png"]];
//		bg.contentMode = UIViewContentModeScaleToFill;
//		bg.frame = CGRectMake(0, 0, 320, 81);
//		self.backgroundView = bg;

        scheme_label = [[UILabel alloc] initWithFrame:CGRectMake(03, 3, 180, 43)];
        scheme_label.font=[UIFont fontWithName:@"Arial" size:13];
        scheme_label.textColor=[UIColor blackColor];
        scheme_label.numberOfLines=0;
        scheme_label.backgroundColor = [UIColor clearColor];
        scheme_label.lineBreakMode = NSLineBreakByClipping;
        scheme_label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:scheme_label];
        
        price_label = [[UILabel alloc] initWithFrame:CGRectMake(236, 3, 60, 43)];
        price_label.font=[UIFont fontWithName:@"Arial" size:13];
        price_label.textColor=[UIColor blackColor];
        price_label.numberOfLines=0;
        price_label.backgroundColor = [UIColor clearColor];
        price_label.lineBreakMode = NSLineBreakByClipping;
        price_label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:price_label];
    }
    return self;
}

  
- (void)dealloc {
	NSLog(@"MPFFundCell dealloc");
    [scheme_label release];
    [price_label release];
	[bg release];
    [super dealloc];
}
@end
