//
//  MHBidAskTableCell.h
//  MagicTrader
//
//  Created by Megahub on 04/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHUILabel.h"

@interface MHBidAskTableCell : UITableViewCell {
	MHUILabel			*m_oBidLabel;
	MHUILabel			*m_oAskLabel;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)setBidStringWithAnimation:(NSString *)aBidString;
-(void)setAskStringWithAnimation:(NSString *)aAskString;

-(void)setBidString:(NSString *)aBidString askString:(NSString *)aAskString;
- (void)dealloc;
@end
