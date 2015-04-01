    //
//  MHBEAWatchlistLv0ViewController.m
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAWatchlistLv0ViewStockSearchCell.h"
#import "MHBEAWatchlistLv0ViewController.h"
#import "MHBEAWatchlistLv0ViewStockCell.h"
#import "MHFeedXMsgInGetStockNameSearch.h"
#import "MHFeedXMsgInGetLiteQuote.h"
#import "ViewControllerDirector.h"
#import "MHBEAObjWatchlistStock.h"
#import "MHBEAWatchlistLv0View.h"
#import "MHNumberKeyboardView.h"
#import "MHBEAIndexQuoteView.h"
#import "MHBEAStyleConstant.h"
#import "BEAViewController.h"
#import "MHFeedConnectorX.h"
#import "MHBEADelegate.h"
#import "PTConstant.h"
#import "MHUtility.h"

#define	SECTION_COUNT			1

@implementation MHBEAWatchlistLv0ViewController

- (id)init {
	self = [super init];
	if (self != nil) {
        
        [[MHFeedConnectorX sharedMHFeedConnectorX] addGetLiteQuoteObserver:self action:@selector(onGetLiteQuoteReceived:)];
        [[MHFeedConnectorX sharedMHFeedConnectorX] addGetStockNameSearchObserver:self action:@selector(onGetStockNameSearchReceived:)];
        
		m_oStockArray = [[NSMutableArray alloc] init];
		m_oStockNameSearchArray = [[NSMutableArray alloc] init];
		m_oMHBEAObjWatchlistStockArray = [[NSMutableArray alloc] init];
		
		m_isShowingGainLoss = NO;
		m_iSelectedWatchlistType = LocalWatchlistTypeStock;
		
		for (int i=0; i<MAX_WATCHLISH_COUNT; i++) {
			m_isCellShownInputView[i] = NO;
		}
	}
	return self;
}

- (void)dealloc {
	[m_oStockArray release];
	[m_oStockNameSearchArray release];
	[m_oMHBEAObjWatchlistStockArray release];
    [m_oMHBEAWatchlistLv0View release];
    
    [[MHFeedConnectorX sharedMHFeedConnectorX] removeGetLiteQuoteObserver:self];
	[[MHFeedConnectorX sharedMHFeedConnectorX] removeGetStockNameSearchObserver:self];
    
    [super dealloc];
}

- (void)loadView {
	m_oMHBEAWatchlistLv0View = [[MHBEAWatchlistLv0View alloc] initWithFrame:CGRectMake(0, 0, 320, [MHUtility convertHeightBasedOnCurrentDevice:280]) controller:self];
	self.view = m_oMHBEAWatchlistLv0View;
	
	// set delegate
	[m_oMHBEAWatchlistLv0View.m_oTextField setDelegate:self];
    [m_oMHBEAWatchlistLv0View.m_oSearchButton addTarget:self action:@selector(searchBarSearchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[m_oMHBEAWatchlistLv0View.m_oTableView setDelegate:self];
	[m_oMHBEAWatchlistLv0View.m_oTableView setDataSource:self];
    
    [m_oMHBEAWatchlistLv0View stopLoading];
    
	[self setEditingPrice:NO];
	[self setTableEditing:NO];
	[self setShowGainLoss:NO];
}

- (void)reloadText {
    [MHLanguage setLanguage:LanguageDefault];
    
	[m_oMHBEAWatchlistLv0View.m_oBackButton setTitle:MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewController.m_oBackButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
	[m_oMHBEAWatchlistLv0View.m_oEditButton setTitle:(m_isCellShownInputView[0])?
	 MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewController.m_oEditButton.done", nil, MHLanguage_BEAString):
	 MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewController.m_oEditButton.edit", nil, MHLanguage_BEAString)
				   forState:UIControlStateNormal];

	[m_oMHBEAWatchlistLv0View reloadText];
    [m_oMHBEAWatchlistLv0View updateLastUpdateTime:m_sStockUpdateTime];
    
    [self reloadDataSource];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
	[m_oMHBEAWatchlistLv0View release];
	m_oMHBEAWatchlistLv0View = nil;
	
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(!m_isCellShownInputView[0]){
        [m_oMHBEAWatchlistLv0View setHiddenIndexQuoteView:NO];
    }
    
    [m_oMHBEAWatchlistLv0View.m_oMHBEAIndexQuoteView syncStockCode];
    
    [self switchToWatchlistStock];
    [self reloadText];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hideKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[MHNumberKeyboardView dismiss];
    [[MBKUtil me].queryButton1 setHidden:YES];
	[self setEditingPrice:NO];
	[self setTableEditing:NO];
	
	m_oMHBEAWatchlistLv0View.m_oHideSearchKeyBoardButton.hidden = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == m_oMHBEAWatchlistLv0View.m_oTextField){
        [self searchBarSearchButtonClicked:textField];
    }
    return YES;
}

- (void)searchBarSearchButtonClicked:(UITextField *)textField {
    
    if(textField != m_oMHBEAWatchlistLv0View.m_oTextField){
        textField = m_oMHBEAWatchlistLv0View.m_oTextField;
    }
    
    if([textField.text length] == 0){
        return;
    }
    
	m_oMHBEAWatchlistLv0View.m_oHideSearchKeyBoardButton.hidden = YES;
	[textField resignFirstResponder];
    
	[[MHFeedConnectorX sharedMHFeedConnectorX] getStockNameSearch:[MHLanguage getCurrentLanguage]
														   search:textField.text
															 page:1 
														 freeText:nil
                                                       searchType:String_XML_Stock_Name_Search_All];
	[m_oMHBEAWatchlistLv0View startLoading];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [m_oMHBEAWatchlistLv0View.m_oTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}


#pragma mark -
#pragma mark TableView delegate Functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	int row = 0;
	switch (m_iSelectedWatchlistType) {
        case LocalWatchlistTypeStock: {
            row = [m_oStockArray count];
            break;
        }
        case LocalWatchlistTypeSearch: {
            row = [m_oStockNameSearchArray count];
            if(row==0) {
                row = 1;
            }
            break;
        }default: break;
    }
	return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	int height = 0;
	switch (m_iSelectedWatchlistType) {
        case LocalWatchlistTypeStock: {
            height = [MHBEAWatchlistLv0ViewStockCell getHeight];
            break;
        }
        case LocalWatchlistTypeSearch: {
            height = 44;
            break;
        }default: break;
    }
	return height;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *StockCellIdentifier = @"StockCell";
	static NSString *SearchCellIdentifier = @"SearchCell";

    UITableViewCell *cell = nil;
	
	if (indexPath.section == 0) {

		if(m_iSelectedWatchlistType == LocalWatchlistTypeStock) {
			//-------------------------------------------------------------------------
			// Stock Cell
			MHBEAWatchlistLv0ViewStockCell *stockCell = (MHBEAWatchlistLv0ViewStockCell *)[tableView dequeueReusableCellWithIdentifier:StockCellIdentifier];
			if (stockCell == nil) {
				stockCell = [[[MHBEAWatchlistLv0ViewStockCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StockCellIdentifier] autorelease];
				[stockCell.m_oGainLossButton addTarget:self action:@selector(onCellGainLossButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
				[stockCell setM_idDelegate:self];
			}
			
			MHFeedXObjQuote *quote = ([m_oStockArray count]>indexPath.row)?[m_oStockArray objectAtIndex:indexPath.row]:nil;
			[stockCell updateWithMHFeedXObjQuote:quote];
			
			if (m_isCellShownInputView[indexPath.row]) {
				[stockCell displayInputView];
				
				// set the input price and qty
				NSString *symbol = stockCell.m_oSymbolLabel.text;			
				MHBEAObjWatchlistStock *stock = [self getWatchlistStockWithSymbol:symbol];
				
				if (stock != nil) {
					stockCell.m_oInputPriceTextField.text = stock.m_sInputPrice;
					stockCell.m_oQtyTextField.text = stock.m_sInputQty;
				}
				
			} else {
				[stockCell displayChangeView];
			}
			
			//-------------------------------
			// <!--- update gainLossLabel ---
			[stockCell displayGainLossLabel:m_isShowingGainLoss];
			double gainLoss = 0;
			double pGainLoss = 0;
			double inputPrice = 0;
			double inputQty = 0;
			double lastPrice = 0;
			
			NSString *symbol = stockCell.m_oSymbolLabel.text;			
			MHBEAObjWatchlistStock *stock = [self getWatchlistStockWithSymbol:symbol];
			
			if (stock != nil && 
				stock.m_sInputPrice != nil &&
				[stock.m_sInputPrice length] >0 &&
				[stock.m_sInputPrice doubleValue] != 0 &&
				stock.m_sInputQty != nil &&
				[stock.m_sInputQty length] >0 &&
				[stock.m_sInputQty doubleValue] != 0) {		
				
				inputPrice	= [stock.m_sInputPrice doubleValue];
				inputQty	= [[MHUtility removeComma:stock.m_sInputQty] doubleValue];
				lastPrice	= [[MHUtility removeComma:stockCell.m_oLastLabel.text] doubleValue];
				
				gainLoss = (lastPrice - inputPrice);
				pGainLoss = (((lastPrice * inputQty) - (inputPrice * inputQty))/(inputPrice * inputQty) * 100);
				
				[stockCell setGainLoss:gainLoss pGainLoss:pGainLoss];
				
			} else {
				stockCell.m_oGainLossLabel.text = @"-";
				stockCell.m_oPGainLossLabel.text = @"-.--%";
			}
			// --- UpdateGainLoss ---!>
			//-------------------------
			
			[stockCell reloadText];
			
			return stockCell;
			
        //---------------------------------------------------------------------
		} else if (m_iSelectedWatchlistType == LocalWatchlistTypeSearch) {
			MHBEAWatchlistLv0ViewStockSearchCell *searchCell = nil;
			searchCell = (MHBEAWatchlistLv0ViewStockSearchCell *)[tableView dequeueReusableCellWithIdentifier:SearchCellIdentifier];
			if (searchCell == nil) {
				searchCell = (MHBEAWatchlistLv0ViewStockSearchCell *)[[[MHBEAWatchlistLv0ViewStockSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchCellIdentifier] autorelease];
				[searchCell.m_oAddButton addTarget:self action:@selector(onAccessoryButtonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
			}
			
			if ([m_oStockNameSearchArray count] == 0) {
				[searchCell updateWithSingleString:MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewController.no_search_result", nil, MHLanguage_BEAString)];
			} else {
				MHFeedXObjQuote *quote = [m_oStockNameSearchArray objectAtIndex:indexPath.row];
				[searchCell updateWithMHFeedXObjQuote:quote];			
			}

			return searchCell;
		}
	}
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if([indexPath section]== 0){
		if (m_iSelectedWatchlistType == LocalWatchlistTypeStock) {
			if (editingStyle == UITableViewCellEditingStyleDelete) {
				switch (m_iSelectedWatchlistType) {
					case LocalWatchlistTypeStock: {
						
						// remove the watchlist in app D
						MHFeedXObjQuote *quote = [m_oStockArray objectAtIndex:indexPath.row];
						[MHBEA_DELEGATE removeStockWatchlist:quote.m_sSymbol];
						
						// remove the watchlist in the viewcontroller
						[m_oStockArray removeObjectAtIndex:indexPath.row];
						
						[self removeWatchlistStockWithSymbol:quote.m_sSymbol];
						
						break;
					}default: break;
				}
			}
		}
	}
	[m_oMHBEAWatchlistLv0View.m_oTableView reloadData];
     m_oMHBEAWatchlistLv0View.m_oTableView.editing = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (m_iSelectedWatchlistType == LocalWatchlistTypeStock) {
		MHFeedXObjQuote *quote = [m_oStockArray objectAtIndex:indexPath.row];		
		
		ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
		para.m_sString0 = quote.m_sSymbol;
		para.m_sString1 = MARKET_HONGKONG;
		para.m_iInt0 = [quote.m_sSymbol intValue];
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDQuote para:para];
		[para release];
		
		
	} else if (m_iSelectedWatchlistType == LocalWatchlistTypeSearch) {

		if ([m_oStockNameSearchArray count] == 0) {
			// no search result
			// do nothing
			return;
		}

		MHFeedXObjQuote *quote = ([m_oStockNameSearchArray count] > indexPath.row)?[m_oStockNameSearchArray objectAtIndex:indexPath.row]:nil;
		
		ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
		para.m_sString0 = quote.m_sSymbol;
		para.m_sString1 = MARKET_HONGKONG;
		para.m_iInt0 = [quote.m_sSymbol intValue];
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDQuote para:para];
		[para release];
	}
}

- (void)onAccessoryButtonPressed:(id)sender event:(id)event {
	NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:m_oMHBEAWatchlistLv0View.m_oTableView];
    NSIndexPath *indexPath = [m_oMHBEAWatchlistLv0View.m_oTableView indexPathForRowAtPoint: currentTouchPosition];
	
    if (indexPath != nil) {
        // add the stock to watchlist 
		MHFeedXObjQuote *quote = [m_oStockNameSearchArray objectAtIndex:indexPath.row];
		if([MHBEA_DELEGATE addStockWatchlist:quote.m_sSymbol]) {
			[MHBEA_DELEGATE showAddedStockToWatchlist];
		}
        [m_oMHBEAWatchlistLv0View setHiddenIndexQuoteView:NO];
		[self switchToWatchlistStock];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (m_iSelectedWatchlistType) {
		case LocalWatchlistTypeStock: {
			return UITableViewCellEditingStyleDelete;
			break;		
		}
		case LocalWatchlistTypeMetal:
		case LocalWatchlistTypeForex: 
			return UITableViewCellEditingStyleNone;
			break;
		default: break;	
	}
	return UITableViewCellEditingStyleNone;
}

// Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

// Process the row move. This means updating the data model to correct the item indices.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//	printf("from:%d to:%d\n", fromIndexPath.row, toIndexPath.row);
	
	if (m_iSelectedWatchlistType == LocalWatchlistTypeStock) {
		MHFeedXObjQuote *quote = [[m_oStockArray objectAtIndex:fromIndexPath.row] retain];
		[m_oStockArray removeObjectAtIndex:fromIndexPath.row];
		[m_oStockArray insertObject:quote atIndex:toIndexPath.row];		
		[quote release];
		
		// save the array
		NSMutableArray *newArray = [[NSMutableArray alloc] init];
		for (MHFeedXObjQuote *quote in m_oStockArray) {
			[newArray addObject:quote.m_sSymbol];
		}
		[MHBEA_DELEGATE saveStockWatchlist:newArray];
		[newArray release];
		
	}
	
	[m_oMHBEAWatchlistLv0View.m_oTableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
	
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewController.tableview.delete", nil, MHLanguage_BEAString);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	if (section == 0) {
		switch (m_iSelectedWatchlistType) {
			case LocalWatchlistTypeStock: {
				BOOL isShowInput = NO;
				for (int i=0; i<MAX_WATCHLISH_COUNT && [m_oStockArray count]; i++) {
					isShowInput = m_isCellShownInputView[i];
				}
				if (isShowInput) {
					return [MHBEAWatchlistLv0ViewStockCell getHeaderViewInput];
				} else {
					return [MHBEAWatchlistLv0ViewStockCell getHeaderViewChange:!m_isShowingGainLoss];
				}
			}
			case LocalWatchlistTypeSearch: {
				break;
			}default: break;
		}
	}
	
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 0) {
        switch (m_iSelectedWatchlistType) {
			case LocalWatchlistTypeStock: {
				return [MHBEAWatchlistLv0ViewStockCell getHeightHeader];

			}
			case LocalWatchlistTypeSearch: {
				return 0;
			}default: break;
        }
    }
	return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (m_iSelectedWatchlistType == LocalWatchlistTypeSearch && [m_oStockNameSearchArray count] == 0) {
        cell.backgroundColor = [UIColor whiteColor];
	}else if([indexPath row]%2 == 0){
        cell.backgroundColor = [UIColor colorWithRed:237/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    }else {
        cell.backgroundColor = [UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1];
    }
}

- (void)reloadDataSource {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	switch (m_iSelectedWatchlistType) {
		case LocalWatchlistTypeStock: {
			m_uiMHFeedXMessageID = [MHBEA_DELEGATE getLiteQuoteWatchlistPage];
            
            [m_oMHBEAObjWatchlistStockArray removeAllObjects];
            [m_oMHBEAObjWatchlistStockArray addObjectsFromArray:[MHBEA_DELEGATE loadStockWatchlistGainLoss]];

			break;
		}default: break;
	}
}

- (void)setTableEditing:(BOOL)aBool {
	[m_oMHBEAWatchlistLv0View.m_oTableView setEditing:aBool animated:YES];
}

- (void)setEditingPrice:(BOOL)aBool {
    for (int i=0; i<MAX_WATCHLISH_COUNT; i++) {
        m_isCellShownInputView[i] = aBool;
    }
    [m_oMHBEAWatchlistLv0View.m_oTableView reloadData];

    [m_oMHBEAWatchlistLv0View.m_oEditButton setTitle:aBool ?
     MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewController.m_oEditButton.done", nil, MHLanguage_BEAString):
     MHLocalizedStringFile(@"MHBEAWatchlistLv0ViewController.m_oEditButton.edit", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
    
    // set hidden quote bar view
    if(aBool || m_oMHBEAWatchlistLv0View.m_oEditButton.hidden){
        [m_oMHBEAWatchlistLv0View setHiddenIndexQuoteView:YES];
    }else{
        [m_oMHBEAWatchlistLv0View setHiddenIndexQuoteView:NO];
    }
}

- (void)setShowGainLoss:(BOOL)aBool {
	m_isShowingGainLoss = aBool;
	[m_oMHBEAWatchlistLv0View displayStockTotalValueView:m_isShowingGainLoss];
	[m_oMHBEAWatchlistLv0View.m_oTableView reloadData];
	[self updateStockTotalValueLabel];
}


#pragma mark -
#pragma mark Update Functions
//-----------------------------------------------------------------------------
- (void)hideKeyboard{
    [MHNumberKeyboardView dismiss];
    [m_oMHBEAWatchlistLv0View.m_oTextField resignFirstResponder];
}

- (MHBEAObjWatchlistStock *)getWatchlistStockWithSymbol:(NSString *)aSymbol {
	MHBEAObjWatchlistStock *tmpS, *stock = nil;
	
	for ( int i=0; i<[m_oMHBEAObjWatchlistStockArray count]; i++ ) {
		tmpS = [m_oMHBEAObjWatchlistStockArray objectAtIndex:i];
		if ([tmpS.m_sSymbol intValue] == [aSymbol intValue]) {
			stock = [m_oMHBEAObjWatchlistStockArray objectAtIndex:i];
			break;
		}
	}
	
	if (stock == nil) {
		stock = [[MHBEAObjWatchlistStock alloc] init];
		[m_oMHBEAObjWatchlistStockArray addObject:stock];
		[stock release];
	}
	
	stock.m_sSymbol = aSymbol;
	
	return stock;
}

//-----------------------------------------------------------------------------
- (void)removeWatchlistStockWithSymbol:(NSString *)aSymbol {
	MHBEAObjWatchlistStock *tmpS = nil;
	
	for ( int i=0; i<[m_oMHBEAObjWatchlistStockArray count]; i++ ) {
		tmpS = [m_oMHBEAObjWatchlistStockArray objectAtIndex:i];
		if ([tmpS.m_sSymbol intValue] == [aSymbol intValue]) {
			[m_oMHBEAObjWatchlistStockArray removeObjectAtIndex:i];
			[self updateStockTotalValueLabel];
			[MHBEA_DELEGATE saveStockWatchlistGainLoss:m_oMHBEAObjWatchlistStockArray];
			return;
		}
	}
}

//-----------------------------------------------------------------------------
- (void)updateStockTotalValueLabel {
	// cal the total stock value
	double totalStockValue = 0;
	double currStockValue = 0;
	double inputStockValue = 0;
	
	for (MHBEAObjWatchlistStock *stock in m_oMHBEAObjWatchlistStockArray) {
		inputStockValue += (double)([stock.m_sInputPrice doubleValue] * [stock.m_sInputQty intValue]);
		
		for (MHFeedXObjQuote *quote in m_oStockArray) {
			if ([quote.m_sSymbol intValue] == [stock.m_sSymbol intValue]) {
				currStockValue += (double)([quote.m_sLast doubleValue] * [stock.m_sInputQty intValue]);
			}
		}
	}
	totalStockValue = currStockValue - inputStockValue;
	
	[m_oMHBEAWatchlistLv0View updateStockTotalValueLabel:totalStockValue];
}

//-----------------------------------------------------------------------------
- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)msg {
    
    // Update the last update time by index bar & a stock code
	[msg retain];
    MHFeedXObjStockQuote *stockQuote = nil;
    MHFeedXObjQuote *quote = nil;
    if (msg.m_oStockQuoteArray!= nil && [msg.m_oStockQuoteArray count] > 0) {
        stockQuote = [msg.m_oStockQuoteArray objectAtIndex:0];
        if (stockQuote.m_oQuoteArray != nil && [stockQuote.m_oQuoteArray count] >0) {
            quote = [stockQuote.m_oQuoteArray objectAtIndex:0];
            
            for(int i=0; i<[m_oStockArray count]; i++){
                MHFeedXObjQuote *currentStock = [m_oStockArray objectAtIndex:i];
                if ([currentStock.m_sSymbol isEqualToString:quote.m_sSymbol]) {
                    [m_oStockArray replaceObjectAtIndex:i withObject:quote];
                    break;
                }
            }
            
            // set update time
            @synchronized(m_sStockUpdateTime) {
                if (m_sStockUpdateTime) {
                    [m_sStockUpdateTime release];
                    m_sStockUpdateTime = nil;
                }
                m_sStockUpdateTime = [quote.m_sLastUpdate retain];
            }
            [m_oMHBEAWatchlistLv0View updateLastUpdateTime:m_sStockUpdateTime];
            
            [m_oMHBEAWatchlistLv0View.m_oTableView reloadData];
        }
    }
    [msg release];
}

//-----------------------------------------------------------------------------
- (void)handleGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)aGetLiteQuoteMsg {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
	//NSArray *stockQuoteArray = aGetLiteQuoteMsg.m_oStockQuoteArray;
	NSMutableArray *stockQuoteArray = [[NSMutableArray alloc] initWithArray:aGetLiteQuoteMsg.m_oStockQuoteArray]; 
	MHFeedXObjStockQuote *stockQuote = nil;
	NSArray *quoteArray = nil;
	
	if (stockQuoteArray == nil && [stockQuoteArray count] <= 0) {return;}
	
	NSArray *watchlistSymbolArray = [MHBEA_DELEGATE loadStockWatchlist];
	[m_oStockArray removeAllObjects];
	
	// <!--- reorder the watchlist array according to the user perf. --- 
	int i, j;
	NSString *symbol = nil;
	MHFeedXObjQuote *quote = nil;
	
	
	// as stockQuoteArray stores stockQuote
	// stockQuoteArray stores stockQuote
	for(i=0; i<[watchlistSymbolArray count]; i++) {
		symbol = [NSString stringWithFormat:@"%05d",[[watchlistSymbolArray objectAtIndex:i] intValue]];
		
		for(j=0; j<[stockQuoteArray count]; j++) {
			stockQuote = [stockQuoteArray objectAtIndex:j];
			if (stockQuote.m_oQuoteArray != nil && [stockQuote.m_oQuoteArray count] > 0) { 
				quoteArray = stockQuote.m_oQuoteArray;
				if (quoteArray != nil && [quoteArray count] > 0) {
					quote = [quoteArray objectAtIndex:0];
					if ([quote.m_sSymbol isEqualToString:symbol]) {
						[m_oStockArray addObject:quote];
						[stockQuoteArray removeObjectAtIndex:j];
						break;
					}
				}
			}
		}
	}
	
	// if the watchlist does not have the symbol returned
	for(stockQuote in stockQuoteArray) {
		quoteArray = stockQuote.m_oQuoteArray;
		if (quoteArray != nil && [quoteArray count] > 0) { 
			[m_oStockArray addObjectsFromArray:quoteArray];
		}	
	}
	[stockQuoteArray release];
	// --- reorder the watchlist array according to the user perf. ---!>

	[m_oMHBEAWatchlistLv0View.m_oTableView reloadData];
}

//-----------------------------------------------------------------------------
- (void)handleGetStockNameSearch:(MHFeedXMsgInGetStockNameSearch *)aGetStockNameSearchMsg {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	NSArray *stockQuoteArray = aGetStockNameSearchMsg.m_oStockQuoteArray;
	MHFeedXObjStockQuote *stockQuote = nil;
	NSArray *quoteArray = nil;
	
	if (stockQuoteArray == nil && [stockQuoteArray count] <= 0) {
        return;
    }
	
	[m_oStockNameSearchArray removeAllObjects];
	for (stockQuote in stockQuoteArray) {
		quoteArray = stockQuote.m_oQuoteArray;
		if (quoteArray != nil && [quoteArray count] > 0) { 
			[m_oStockNameSearchArray addObjectsFromArray:quoteArray];
		}
	}
	[self switchToWatchlistSearch];
	[m_oMHBEAWatchlistLv0View stopLoading];
}

//-----------------------------------------------------------------------------
- (void)onGetLiteQuoteReceived:(NSNotification *)n {
	MHFeedXMsgInGetLiteQuote *msg = [n object];
	// not my message, return
	if (msg.m_uiMessageID != m_uiMHFeedXMessageID) {return;}
	
	[self performSelectorOnMainThread:@selector(handleGetLiteQuote:) withObject:msg waitUntilDone:NO];
}

//-----------------------------------------------------------------------------
- (void)onGetStockNameSearchReceived:(NSNotification *)n {
	MHFeedXMsgInGetStockNameSearch *msg = [n object];
	
	[self performSelectorOnMainThread:@selector(handleGetStockNameSearch:) withObject:msg waitUntilDone:NO];
}

- (void)onEditButtonPressed:(id)sender {
	// dimiss keyboard
	[MHNumberKeyboardView dismiss];
	[m_oMHBEAWatchlistLv0View.m_oTextField resignFirstResponder];

	// turn off reorder
	[self setTableEditing:NO];
	[self setEditingPrice:!m_isCellShownInputView[0]];

}

- (void)onReloadButtonPressed:(id)sender {
    [m_oMHBEAWatchlistLv0View.m_oMHBEAIndexQuoteView onQuoteButtonPressed:sender];
	[self reloadDataSource];
}

//-----------------------------------------------------------------------------
- (void)onCellGainLossButtonPressed:(id)sender {
	[self setShowGainLoss:!m_isShowingGainLoss];
}

- (void)onReorderButtonPressed:(id)sender {
	[MHNumberKeyboardView dismiss];
	[m_oMHBEAWatchlistLv0View.m_oTextField resignFirstResponder];

	[self setEditingPrice:NO];
	[self setTableEditing:!m_oMHBEAWatchlistLv0View.m_oTableView.editing];
}

- (void)onAddButtonPressed:(id)sender {
    [self reloadDataSource];
}

- (void)onBackButtonPressed:(id)sender {
    [m_oMHBEAWatchlistLv0View setHiddenIndexQuoteView:NO];
	[self switchToWatchlistStock];
}


#pragma mark -
#pragma mark TextField Delegate Functions
- (void)inputPriceTextFieldShouldBeginEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell {
	NSIndexPath *indexPath = [m_oMHBEAWatchlistLv0View.m_oTableView indexPathForCell:aCell];
    
    if(m_iShowKeyboard == 0){
        [UIView beginAnimations:nil context:nil];
        m_oMHBEAWatchlistLv0View.m_oTableView.frame = CGRectMake(0, m_oMHBEAWatchlistLv0View.m_oTableView.frame.origin.y+70, m_oMHBEAWatchlistLv0View.m_oTableView.frame.size.width, m_oMHBEAWatchlistLv0View.m_oTableView.frame.size.height-70);
        [self.view setFrame:CGRectMake(0, -110, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    
    if(m_oFocusTextField != textField){
        m_iShowKeyboard+=1;
        m_oFocusTextField = textField;
    }
    
    [m_oMHBEAWatchlistLv0View.m_oTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)qtyTextFieldShouldBeginEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell {
	NSIndexPath *indexPath = [m_oMHBEAWatchlistLv0View.m_oTableView indexPathForCell:aCell];
    
    if(m_iShowKeyboard == 0){
        [UIView beginAnimations:nil context:nil];
        m_oMHBEAWatchlistLv0View.m_oTableView.frame = CGRectMake(0, m_oMHBEAWatchlistLv0View.m_oTableView.frame.origin.y+70, m_oMHBEAWatchlistLv0View.m_oTableView.frame.size.width, m_oMHBEAWatchlistLv0View.m_oTableView.frame.size.height-70);
        [self.view setFrame:CGRectMake(0, -110, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    
    if(m_oFocusTextField != textField){
        m_iShowKeyboard+=1;
        m_oFocusTextField = textField;
    }
    
    [m_oMHBEAWatchlistLv0View.m_oTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//-----------------------------------------------------------------------------
- (BOOL)inputPriceTextFieldShouldReturn:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell {
	NSString *symbol = aCell.m_oSymbolLabel.text;
	
	MHBEAObjWatchlistStock *stock = [self getWatchlistStockWithSymbol:symbol];
	stock.m_sInputPrice = textField.text;
	
	[self updateStockTotalValueLabel];
	
	[MHBEA_DELEGATE saveStockWatchlistGainLoss:m_oMHBEAObjWatchlistStockArray];
	
	return YES;
}

//-----------------------------------------------------------------------------
- (void)inputPriceTextFieldDidEndEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell {
	[self inputPriceTextFieldShouldReturn:textField cell:aCell];
    
    if(self.view.frame.origin.y <= -110 && m_iShowKeyboard <= 1){
        [UIView beginAnimations:nil context:nil];
        m_oMHBEAWatchlistLv0View.m_oTableView.frame = CGRectMake(0, m_oMHBEAWatchlistLv0View.m_oTableView.frame.origin.y-70, m_oMHBEAWatchlistLv0View.m_oTableView.frame.size.width, m_oMHBEAWatchlistLv0View.m_oTableView.frame.size.height+70);
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    
    NSIndexPath *indexPath = [m_oMHBEAWatchlistLv0View.m_oTableView indexPathForCell:aCell];
    [m_oMHBEAWatchlistLv0View.m_oTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    if(m_oFocusTextField == textField){
        m_oFocusTextField = nil;
    }
    
    m_iShowKeyboard-=1;
}

//-----------------------------------------------------------------------------
- (BOOL)qtyTextFieldShouldReturn:(UITextField *)aTextField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell {
	NSString *symbol = aCell.m_oSymbolLabel.text;
	
	MHBEAObjWatchlistStock *stock = [self getWatchlistStockWithSymbol:symbol];
	stock.m_sInputQty = aTextField.text;
	
	
	[self updateStockTotalValueLabel];
	
	[MHBEA_DELEGATE saveStockWatchlistGainLoss:m_oMHBEAObjWatchlistStockArray];
	
	
	return YES;
}

//-----------------------------------------------------------------------------
- (void)qtyTextFieldDidEndEditing:(UITextField *)textField cell:(MHBEAWatchlistLv0ViewStockCell *)aCell {
	[self qtyTextFieldShouldReturn:textField cell:aCell];
    
    if(self.view.frame.origin.y <= -110 && m_iShowKeyboard <= 1){
        [UIView beginAnimations:nil context:nil];
        m_oMHBEAWatchlistLv0View.m_oTableView.frame = CGRectMake(0, m_oMHBEAWatchlistLv0View.m_oTableView.frame.origin.y-70, m_oMHBEAWatchlistLv0View.m_oTableView.frame.size.width, m_oMHBEAWatchlistLv0View.m_oTableView.frame.size.height+70);
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    
    NSIndexPath *indexPath = [m_oMHBEAWatchlistLv0View.m_oTableView indexPathForCell:aCell];
    [m_oMHBEAWatchlistLv0View.m_oTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    if(m_oFocusTextField == textField){
        m_oFocusTextField = nil;
    }
    
    m_iShowKeyboard-=1;
}


#pragma mark -
#pragma mark Switch
- (void)switchToWatchlistStock {
    
    m_oMHBEAWatchlistLv0View.frame = CGRectMake(0, 0, 320, [MHUtility convertHeightBasedOnCurrentDevice:280]);
    
    [m_oMHBEAWatchlistLv0View displayBackButton:NO];
    
	m_iSelectedWatchlistType = LocalWatchlistTypeStock;
	
	// reset the search bar text
	m_oMHBEAWatchlistLv0View.m_oTextField.text = @"";
	[m_oMHBEAWatchlistLv0View displayStockTotalValueView:m_isShowingGainLoss];
	
	[m_oMHBEAWatchlistLv0View.m_oTableView reloadData];
	[self reloadDataSource];	
}

- (void)switchToWatchlistSearch {
    
    m_oMHBEAWatchlistLv0View.frame = CGRectMake(0, 0, 320, [MHUtility convertHeightBasedOnCurrentDevice:340]);
    
    [m_oMHBEAWatchlistLv0View displayBackButton:YES];
    
	m_iSelectedWatchlistType = LocalWatchlistTypeSearch;
	[self setTableEditing:NO];
	
	[m_oMHBEAWatchlistLv0View displayStockTotalValueView:NO];	
	
	[m_oMHBEAWatchlistLv0View.m_oTableView reloadData];
}

@end