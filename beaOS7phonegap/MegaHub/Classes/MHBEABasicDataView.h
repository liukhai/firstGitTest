//
//  MHBasicDataView.h
//  MagicTrader
//
//  Created by Megahub on 07/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHUILabel.h"

@class MHRelatedStockDataView;
@class SegmentedButton;
@class MHSolutionProviderView;
@class MHBEAFundamentalTableCell;
@class PTPMsgInSBasicQuote;
@class PTPMsgInSStaticNumeDetail;
@class PTPMsgInSStaticNumeBasic;
@class PTPMsgInSStaticNumeSpreadInfo;
@class PTPMsgInSTechInfo;
@class PTPMsgInLBasicQuote;
@class PTPMsgInLTechInfo;
@class PTPMsgInSBidQueue;
@class PTPMsgInSAskQueue;
@class PTPMsgInLBidQueue;
@class PTPMsgInLAskQueue;
@class MHFeedXObjQuote;

@interface MHBEABasicDataView : UIView <UITableViewDataSource, UITableViewDelegate>{
    SegmentedButton			*m_oStockDataSegmentedButton;
	UITableView				*m_oStockDataTableView;
	
	//Stock load this:
	NSArray					*m_oStockFundamentalTitleDataArray;
	NSArray					*m_oStockTechnicalTitleDataArray;
	
	//CBBC or Warrant load this:
	NSArray					*m_oCBBCTitleDataArray;
	NSArray					*m_oCBBCTechnicalTitleDataArray;
	
	NSArray					*m_oWarrantTitleDataArray;
	NSArray					*m_oWarrantTechnicalTitleDataArray;
	
	float					m_fBestBid;
	float					m_fBestAsk;
	
	int						m_iSpreadType;	// assigned value by PTQuoteViewController
	
	MHRelatedStockDataView	*m_oRelateStockDataView;
	
	UIImageView				*m_oLastUpdateBackgroundImageView;
	
	MHSolutionProviderView	*m_oMHSolutionProviderView;
	
	MHUILabel				*m_oLastUpdateLabel;
	NSString				*m_oLastUpdateString;
	
	NSMutableDictionary		*m_oBasicDataDictionary;
	NSMutableDictionary		*m_oTechDataDictionary;
	
}

@property(nonatomic, retain) MHRelatedStockDataView *m_oRelateStockDataView;
@property(nonatomic, retain) NSArray *m_oStockFundamentalTitleDataArray;
@property(nonatomic, retain) NSArray *m_oStockTechnicalTitleDataArray;
@property(nonatomic, retain) NSArray *m_oCBBCTitleDataArray;
@property(nonatomic, retain) NSArray *m_oCBBCTechnicalTitleDataArray;
@property(nonatomic, retain) NSArray *m_oWarrantTitleDataArray;
@property(nonatomic, retain) NSArray *m_oWarrantTechnicalTitleDataArray;
@property(nonatomic, retain) SegmentedButton *m_oStockDataSegmentedButton;
@property(nonatomic, retain) NSString *m_oLastUpdateString;
@property(nonatomic, retain) NSDictionary *m_oBasicDataDictionary;
@property(nonatomic, retain) NSDictionary *m_oTechDataDictionary;
@property(nonatomic, assign) int m_iSpreadType;
@property(nonatomic, retain) MHUILabel *m_oLastUpdateLabel;

- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;
//You can customized this
-(void)setSelectSelectStockData:(int)aStockData;
-(int)getSelectStockDataPageIndex;
-(void)loadTitleStringArray;
-(void)performReloadTable;
-(void)reloadText;
-(void)clean;

// Button callback functions
- (void)onStockDataSegmentedButtonIsPressed:(id)sender;
// tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void) setSpread:(MHBEAFundamentalTableCell*)aCell;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (void)updatePriceToCall:(float)aPriceToCall;
- (void)updateLastUpdate:(NSString *)aText ;
- (void)updateSRData:(MHFeedXObjQuote*)quoteData;

@end