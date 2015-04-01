//
//  MHTableCell.h
//  MagicTrader
//
//  Created by Megahub on 14/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHUILabel;
@class MHStockQuote;
@class MHStreamerStock;
@class MHFeedXObjQuote;

@interface MHTableCell : UITableViewCell {
	UIView		*m_oFlashView;
	
	MHUILabel	*m_oSymbolLabel;
	MHUILabel	*m_oDescriptionLabel;
	
	MHUILabel	*m_oPriceLabel;
	MHUILabel	*m_oChangeLabel;
	
	MHUILabel	*m_oBidAskLabel;
	MHUILabel	*m_oVolumeLabel;		//成交量
	MHUILabel	*m_oTurnoverLabel;		//成交額
	
	UIButton	*m_oTapButton;
	
	BOOL		m_isDetailMode;
}
@property (nonatomic, assign) BOOL		m_isDetailMode;
@property (nonatomic, retain) MHUILabel *m_oDescriptionLabel;
@property (nonatomic, retain) MHUILabel *m_oSymbolLabel;
@property (nonatomic, retain) UIView	*m_oFlashView;
@property (nonatomic, retain) MHUILabel *m_oPriceLabel;
@property (nonatomic, retain) UIButton	*m_oTapButton;
@property (nonatomic, retain) MHUILabel	*m_oChangeLabel;
@property (nonatomic, retain) MHUILabel	*m_oBidAskLabel;
@property (nonatomic, retain) MHUILabel	*m_oVolumeLabel;
@property (nonatomic, retain) MHUILabel	*m_oTurnoverLabel;

//Default is detail mode
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
+(CGFloat)getHeaderHeight:(BOOL)aIsDetail;
+(CGFloat)getCellHeight:(BOOL)aIsDetail;
-(void)displayHeader:(BOOL)isDetail;
-(void)displayDetailView:(BOOL)isDetail;
-(void)displayStreamerStock;


-(void)displayAnimationWithDuration:(double)second;
-(void)displayMHFeedXObjQuote:(MHFeedXObjQuote *)aMHFeedXObjQuote;
-(void)displaySymbol:(NSString *)aSymbol ;
-(void)setDetailMode:(BOOL)aIsDetailMode;

@end
