#import "MPFFundCell.h"

#define MPFFundCell_MARGIN_COL_1    13
#define MPFFundCell_MARGIN_COL_2    247
#define MPFFundCell_MARGIN_TOP      3
#define MPFFundCell_WIDTH_COL_1     220
#define MPFFundCell_WIDTH_COL_2     60
#define MPFFundCell_HEIGHT_ROW      73
#define MPFFundCell_FONT_SIZE       14

@implementation MPFFundCell

@synthesize scheme_label, price_label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
		bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_cell_bg.png"]];
		bg.contentMode = UIViewContentModeScaleToFill;
		bg.frame = CGRectMake(0, 0, 320, 111);
		self.backgroundView = bg;
        
        scheme_label = [[UILabel alloc] initWithFrame:
                        CGRectMake(MPFFundCell_MARGIN_COL_1,
                                   MPFFundCell_MARGIN_TOP,
                                   MPFFundCell_WIDTH_COL_1,
                                   MPFFundCell_HEIGHT_ROW)];
        scheme_label.font=[UIFont fontWithName:@"Arial" size:MPFFundCell_FONT_SIZE];
        scheme_label.textColor=[UIColor blackColor];
        scheme_label.numberOfLines=0;
        scheme_label.backgroundColor = [UIColor clearColor];
        scheme_label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:scheme_label];
        
        price_label = [[UILabel alloc] initWithFrame:
                       CGRectMake(MPFFundCell_MARGIN_COL_2,
                                  MPFFundCell_MARGIN_TOP,
                                  MPFFundCell_WIDTH_COL_2,
                                  MPFFundCell_HEIGHT_ROW)];
        price_label.font=[UIFont fontWithName:@"Arial" size:MPFFundCell_FONT_SIZE];
        price_label.textColor=[UIColor blackColor];
        price_label.numberOfLines=1;
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
