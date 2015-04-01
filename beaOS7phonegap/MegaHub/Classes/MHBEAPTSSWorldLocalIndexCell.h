//
//  PTWorldLocalIndexCell.h
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ObjFutureInfo;
@class MHFeedXObjQuote;

@interface MHBEAPTSSWorldLocalIndexCell : UITableViewCell {
	UILabel*	m_oLabel_HSIName;
	UILabel*	m_oLabel_Nominal;
	UILabel*	m_oLabel_Change;
	UILabel*	m_oLabel_PChange;
    
	UIImageView	*m_oGraphView;
	
	UIButton	*m_oAccessoryButton;
}

@property (nonatomic, retain) UILabel* m_oLabel_HSIName;
@property (nonatomic, retain) UILabel* m_oLabel_Nominal;
@property (nonatomic, retain) UILabel* m_oLabel_Change;
@property (nonatomic, retain) UILabel* m_oLabel_PChange;

@property (nonatomic, retain) UIImageView *m_oGraphView;
@property (nonatomic, retain) UIButton *m_oAccessoryButton;

+ (CGFloat)getHeight;
+ (CGFloat)getHeightWithGraphic;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)dealloc;

- (void)setAccessoryType:(UITableViewCellAccessoryType)aType;
- (void)updateWithMHFeedXObjQuote:(MHFeedXObjQuote *)aQuote;

@end




