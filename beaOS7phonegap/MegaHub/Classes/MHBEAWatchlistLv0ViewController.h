//
//  MHBEAWatchlistLv0ViewController.h
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHBEAWatchlistLv0ViewStockCell.h"
#import "MHBEAConstant.h"

@class BEAViewController;
@class MHBEAWatchlistLv0View;
@class MHBEAObjWatchlistStock;
@class MHFeedXMsgInGetLiteQuote;
@class MHFeedXMsgInGetStockNameSearch;

@interface MHBEAWatchlistLv0ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, MHBEAWatchlistLv0ViewStockCellDelegate> {
	
	MHBEAWatchlistLv0View			*m_oMHBEAWatchlistLv0View;
    
    LocalWatchlistType				m_iSelectedWatchlistType;
	
	unsigned int					m_uiMHFeedXMessageID;
	BOOL							m_isShowingGainLoss;		// YES -> showing gain and loss, NO-> showing change and % change

	// Storing MHFeedXObjQuote
	NSMutableArray					*m_oStockArray;
	
	// State if the cell is showing input currently
	BOOL							m_isCellShownInputView[MAX_WATCHLISH_COUNT];
    
	// Storing MHBEAObjWatchlistStock for calulating gain and loss
	NSMutableArray					*m_oMHBEAObjWatchlistStockArray;
	
	// Storing  MHFeedXObjQuote
	NSMutableArray					*m_oStockNameSearchArray;
    
    // For resizing table view
    UITextField                     *m_oFocusTextField;
    int                             m_iShowKeyboard;
    
    NSString						*m_sStockUpdateTime;
}

- (id)init;
- (void)dealloc;
- (void)loadView;
- (void)reloadText;
- (void)viewDidLoad;
- (void)viewDidUnload;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)searchBarSearchButtonClicked:(UITextField *)textField;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)onAccessoryButtonPressed:(id)sender event:(id)even;
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (void)reloadDataSource;
- (void)setTableEditing:(BOOL)aBool;
- (void)setEditingPrice:(BOOL)aBool;
- (void)setShowGainLoss:(BOOL)aBool;
- (void)hideKeyboard;
- (MHBEAObjWatchlistStock *)getWatchlistStockWithSymbol:(NSString *)aSymbol;
- (void)removeWatchlistStockWithSymbol:(NSString *)aSymbol;
- (void)updateStockTotalValueLabel;
- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)msg;
- (void)handleGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)aGetLiteQuoteMsg;
- (void)handleGetStockNameSearch:(MHFeedXMsgInGetStockNameSearch *)aGetStockNameSearchMsg;
- (void)onGetLiteQuoteReceived:(NSNotification *)n;
- (void)onGetStockNameSearchReceived:(NSNotification *)n;
- (void)onEditButtonPressed:(id)sender;
- (void)onReloadButtonPressed:(id)sender;
- (void)onCellGainLossButtonPressed:(id)sender;
- (void)onReorderButtonPressed:(id)sender;
- (void)onAddButtonPressed:(id)sender;
- (void)onBackButtonPressed:(id)sender;
- (void)inputPriceTextFieldShouldBeginEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
- (void)qtyTextFieldShouldBeginEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
- (BOOL)inputPriceTextFieldShouldReturn:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
- (void)inputPriceTextFieldDidEndEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
- (BOOL)qtyTextFieldShouldReturn:(UITextField *)aTextField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
- (void)qtyTextFieldDidEndEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell;
- (void)switchToWatchlistStock;
- (void)switchToWatchlistSearch;

@end