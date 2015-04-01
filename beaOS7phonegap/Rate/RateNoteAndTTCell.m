#import "RateNoteAndTTCell.h"

@implementation RateNoteAndTTCell

@synthesize lbCurrency, lbBankBuy ,lbBankSell ;

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

        lbCurrency = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 150, 43)];
        lbCurrency.font=[UIFont fontWithName:@"Arial" size:13];
        lbCurrency.textColor=[UIColor blackColor];
        lbCurrency.numberOfLines=0;        
        lbCurrency.backgroundColor = [UIColor clearColor];
        lbCurrency.lineBreakMode = NSLineBreakByClipping;
        lbCurrency.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:lbCurrency];
        
        lbBankBuy = [[UILabel alloc] initWithFrame:CGRectMake(157, 3, 60, 43)];
        lbBankBuy.font=[UIFont fontWithName:@"Arial" size:13];
        lbBankBuy.textColor=[UIColor blackColor];
        lbBankBuy.numberOfLines=0;
        lbBankBuy.backgroundColor = [UIColor clearColor];
        lbBankBuy.lineBreakMode = NSLineBreakByClipping;
        lbBankBuy.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:lbBankBuy];
        
        lbBankSell = [[UILabel alloc] initWithFrame:CGRectMake(233, 3, 60, 43)];
        lbBankSell.font=[UIFont fontWithName:@"Arial" size:13];
        lbBankSell.textColor=[UIColor blackColor];
        lbBankSell.numberOfLines=0;
        lbBankSell.backgroundColor = [UIColor clearColor];
        lbBankSell.lineBreakMode = NSLineBreakByClipping;
        lbBankSell.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:lbBankSell];
    }
    return self;
}

  
- (void)dealloc {
	NSLog(@"MPFFundCell dealloc");
    [lbCurrency release];
    [lbBankBuy release];
    [lbBankSell release];
	[bg release];
    [super dealloc];
}
@end
