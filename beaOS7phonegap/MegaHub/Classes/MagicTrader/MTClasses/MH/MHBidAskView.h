//
//  MHBidAskView.h
//  MagicTrader
//
//  Created by Megahub on 03/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHUILabel;
@class BidAskGraphicView;
@class PTPMsgInSBidQueue;
@class PTPMsgInSAskQueue;
@class PTPMsgInLBidQueue;
@class PTPMsgInLAskQueue;

@interface MHBidAskView : UIView <UITableViewDataSource, UITableViewDelegate>{
	MHUILabel			*m_oBidTitleLabel;
	MHUILabel			*m_oAskTitleLabel;
	MHUILabel			*m_oBidValueLabel;
	MHUILabel			*m_oAskValueLabel;
	BidAskGraphicView	*m_oBidAskGraphicView;
	UIImageView			*m_oBidView;
	UIImageView			*m_oAskView;
	UIImageView			*m_oCompanyLogoImageView;
	UIImageView			*m_oBidQueueView;
	UIImageView			*m_oAskQueueView;
	UIButton			*m_oCopyBidButton;
	UIButton			*m_oCopyAskButton;
	UITableView			*m_oBidAskTableView;
	NSMutableArray		*m_oBidStringArray;
	NSMutableArray		*m_oAskStringArray;
	float				m_fCellHeight;
}

@property(nonatomic,retain) MHUILabel			*m_oBidTitleLabel;
@property(nonatomic,retain) MHUILabel			*m_oAskTitleLabel;
@property(nonatomic,retain) MHUILabel			*m_oBidValueLabel;
@property(nonatomic,retain) MHUILabel			*m_oAskValueLabel;
@property(nonatomic,retain) UIImageView			*m_oBidView;
@property(nonatomic,retain) UIImageView			*m_oAskView;
@property(nonatomic,retain) BidAskGraphicView	*m_oBidAskGraphicView;
@property(nonatomic,retain) UITableView			*m_oBidAskTableView;
@property(nonatomic,retain) NSMutableArray		*m_oBidStringArray;
@property(nonatomic,retain) NSMutableArray		*m_oAskStringArray;
@property(nonatomic,retain) UIImageView			*m_oBidQueueView;
@property(nonatomic,retain) UIImageView			*m_oAskQueueView;
@property(nonatomic,assign) float				m_fCellHeight;
@property(nonatomic,retain) UIImageView			*m_oCompanyLogoImageView;
@property(nonatomic, assign) id					m_idCopyPriceDelegate;
@property(nonatomic, assign) UIButton			*m_oCopyBidButton;
@property(nonatomic, assign) UIButton			*m_oCopyAskButton;


- (id)initWithFrame:(CGRect)frame;
- (void)reloadText;
- (void)clean;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)dealloc;

@end
