//
//  MHBEABuySellStockViewController.m
//  BEA
//
//  Created by MegaHub on 07/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEABuySellStockViewController.h"
#import "MHBEABuySellStockView.h"
#import "MHBEAIndexQuoteView.h"
#import "MHBEAStyleConstant.h"
#import "MobileTradingUtil.h"
#import "MHFeedXObjQuote.h"
#import "MHBEADelegate.h"
#import "LoadingView.h"
#import "MHLanguage.h"
#import "MHNumberKeyboardView.h"
#import "MHUtility.h"
#import "MHDisclaimerBarView.h"
#import "MHBEAObjWatchlistStock.h"
#import "MHFeedXMsgInGetLiteQuote.h"
#import "MHFeedXObjStockQuote.h"
#import "MHBEAWatchlistLv0ViewStockSearchCell.h"
#import "MHFeedConnectorX.h"
#import "ViewControllerDirector.h"

#define SECTION_COUNT			1

@implementation MHBEABuySellStockViewController

- (id)init {
	self = [super init];
	if (self != nil) {
        
        [[MHFeedConnectorX sharedMHFeedConnectorX] addGetLiteQuoteObserver:self action:@selector(onGetLiteQuoteReceived:)];
        
		m_oStockArray = [[NSMutableArray alloc] init];
		m_oMHBEAObjWatchlistStockArray = [[NSMutableArray alloc] init];
		
		m_isShowingGainLoss = NO;
        m_isWebTrade = NO;
	}
	return self;
}

- (void)dealloc {
    if(m_sSelectedSymbol){
        [m_sSelectedSymbol release];
        m_sSelectedSymbol = nil;
    }
    [v_rmvc release];

	[super dealloc];
}

- (void)loadView {
	[super loadView];
	
    // Watchlist
    m_oMHBEABuySellStockView = [[MHBEABuySellStockView alloc] initWithFrame:CGRectMake(0, 63, 320, [MHUtility getAppHeight]) controller:self];
	self.view = m_oMHBEABuySellStockView;
    [m_oMHBEABuySellStockView release];
	
	// set delegate
	[m_oMHBEABuySellStockView.m_oTableView setDelegate:self];
	[m_oMHBEABuySellStockView.m_oTableView setDataSource:self];
    
    [m_oMHBEABuySellStockView stopLoading];
    
	[self setTableEditing:NO];
	[self setShowGainLoss:NO];
	
	// web view for trade
	m_oWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 126, 320, [MHUtility getAppHeight]-63-m_oMHBEABuySellStockView.m_oMHBEAIndexQuoteView.frame.size.height-31-15)];
	[m_oWebView setDelegate:self];
	[m_oWebView setHidden:YES];
	[self.view addSubview:m_oWebView];
    [m_oWebView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    v_rmvc = [[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil];
//    [v_rmvc.rmUtil setNav:self.navigationController];
    [self.view addSubview:v_rmvc.contentView];
//    [v_rmvc release];
}

- (void)reloadText {
    [m_oMHBEABuySellStockView reloadText];
    [m_oMHBEABuySellStockView updateLastUpdateTime:m_sStockUpdateTime];
    [self reloadDataSource];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [v_rmvc.rmUtil setNav:self.navigationController];

    if(!m_isWebTrade){
        @synchronized(m_sSelectedSymbol) {
            if (m_sSelectedSymbol) {
                [m_sSelectedSymbol release];
                m_sSelectedSymbol = nil;
            }
            m_sSelectedSymbol = [[CoreData sharedCoreData].m_sLastQuoteSymbol retain];
        }

        [m_oMHBEABuySellStockView.m_oMHBEAIndexQuoteView syncStockCode];
    }
    
    [[MBKUtil me].queryButton1 setHidden:YES];
	[self hideWebView];
	[self reloadText];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark TableView delegate Functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [m_oStockArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [MHBEAWatchlistLv0ViewStockCell getHeight];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *StockCellIdentifier = @"StockCell";
	
    // Stock Cell
    MHBEAWatchlistLv0ViewStockCell *stockCell = (MHBEAWatchlistLv0ViewStockCell *)[tableView dequeueReusableCellWithIdentifier:StockCellIdentifier];
    if (stockCell == nil) {
        stockCell = [[[MHBEAWatchlistLv0ViewStockCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StockCellIdentifier] autorelease];
        [stockCell.m_oGainLossButton addTarget:self action:@selector(onCellGainLossButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    MHFeedXObjQuote *quote = ([m_oStockArray count]>indexPath.row)?[m_oStockArray objectAtIndex:indexPath.row]:nil;
    [stockCell updateWithMHFeedXObjQuote:quote];
    
    [stockCell displayChangeView];
    
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
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // remove the watchlist in app D
        MHFeedXObjQuote *quote = [m_oStockArray objectAtIndex:indexPath.row];
        [MHBEA_DELEGATE removeStockWatchlist:quote.m_sSymbol];
        
        // remove the watchlist in the viewcontroller
        [m_oStockArray removeObjectAtIndex:indexPath.row];
        
        [self removeWatchlistStockWithSymbol:quote.m_sSymbol];
    }
	[m_oMHBEABuySellStockView.m_oTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [MHNumberKeyboardView dismiss];
    
    MHFeedXObjQuote *quote = [m_oStockArray objectAtIndex:indexPath.row];
    // save the symbol for later use
    @synchronized(m_sSelectedSymbol) {
        if (m_sSelectedSymbol) {
            [m_sSelectedSymbol release];
            m_sSelectedSymbol = nil;
        }
        m_sSelectedSymbol = [quote.m_sSymbol retain];
    }
	
	[self requestCheckMobileRegisterStatus];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
	return UITableViewCellEditingStyleDelete;
}

// Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

// Process the row move. This means updating the data model to correct the item indices.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
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
	
	[m_oMHBEABuySellStockView.m_oTableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
	
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BOOL isShowInput = NO;
    if (isShowInput) {
        return [MHBEAWatchlistLv0ViewStockCell getHeaderViewInput];
    } else {
        return [MHBEAWatchlistLv0ViewStockCell getHeaderViewChange:!m_isShowingGainLoss];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return [MHBEAWatchlistLv0ViewStockCell getHeightHeader];
	}
	return 0;
}


#pragma mark -
- (void)reloadDataSource {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    m_uiMHFeedXMessageID = [MHBEA_DELEGATE getLiteQuoteWatchlistPage];
    @synchronized(m_oMHBEAObjWatchlistStockArray) {
        if (m_oMHBEAObjWatchlistStockArray) {
            [m_oMHBEAObjWatchlistStockArray release];
            m_oMHBEAObjWatchlistStockArray = nil;
        }
        m_oMHBEAObjWatchlistStockArray = [[NSMutableArray alloc] initWithArray:[MHBEA_DELEGATE loadStockWatchlistGainLoss]];
    }
}

- (void)setTableEditing:(BOOL)aBool {
	[m_oMHBEABuySellStockView.m_oTableView setEditing:aBool animated:YES];
}

- (void)setShowGainLoss:(BOOL)aBool {
	m_isShowingGainLoss = aBool;
	[m_oMHBEABuySellStockView displayStockTotalValueView:m_isShowingGainLoss];
	[m_oMHBEABuySellStockView.m_oTableView reloadData];
	[self updateStockTotalValueLabel];
}

- (void)setBuySellType:(BuySellType)aType {
    m_iBuySellType = aType;
    
    if(aType == BuySellTypeBuy){
        [m_oMHBEABuySellStockView.m_oMHBEABottomView setSelectedIndex:0];
    }else{
        [m_oMHBEABuySellStockView.m_oMHBEABottomView setSelectedIndex:4];
    }
}

- (void)switchToWebTrade:(NSString*)stockCode{
    
    m_isWebTrade = YES;
    
    @synchronized(m_sSelectedSymbol) {
		if (m_sSelectedSymbol) {
			[m_sSelectedSymbol release];
			m_sSelectedSymbol = nil;
		}
        m_sSelectedSymbol = [stockCode retain];
	}
    
    m_oMHBEABuySellStockView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text = [NSString stringWithFormat:@"%05d",[m_sSelectedSymbol intValue]];
    
    [self requestCheckMobileRegisterStatus];
}

- (void)hideWebView {
	m_oWebView.hidden = YES;
}


#pragma mark WebView
- (void)webViewLoadString:(NSString *)aURLString {
	[m_oWebView setHidden:NO];
	NSString *link = [aURLString stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	[m_oWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:link]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[CoreData sharedCoreData].mask showMask];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[CoreData sharedCoreData].mask hiddenMask];	
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	if([error code] == NSURLErrorCancelled){
		return;
	}
	
	[[CoreData sharedCoreData].mask hiddenMask];
	[self hideWebView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //	NSString *urlString = [[request URL] absoluteString];
	
	if ([[[request URL] scheme] isEqualToString:MHBEA_URL_BACK] == YES) {
		
//		NSLog(@"Receive from webview: %@",MHBEA_URL_BACK);
		
		[self hideWebView];
	} 
	
	return YES;
}


#pragma mark -
#pragma mark Button callback Functions
- (void)onAddButtonPressed:(id)sender {
	[self reloadDataSource];
}

- (void)onCellGainLossButtonPressed:(id)sender {
	[self setShowGainLoss:!m_isShowingGainLoss];
}

- (void)onBuySellButtonPressed:(id)sender {
    
    [MHNumberKeyboardView dismiss];
    
	@synchronized(m_sSelectedSymbol) {
		if (m_sSelectedSymbol) {
			[m_sSelectedSymbol release];
			m_sSelectedSymbol = nil;
		}
	}
	[self requestCheckMobileRegisterStatus];
}


#pragma mark -
- (void)handleNoReg {
	[[CoreData sharedCoreData].mask hiddenMask];

    // Stock trading
    [[MHBEADelegate sharedMHBEADelegate] showNoMobileNoStockTrading];
}

- (void)handleHaveReg:(NSString *)aToken {
	[[CoreData sharedCoreData].mask hiddenMask];
	MHBEA_DELEGATE.m_sToken = aToken;
    
	NSString *buySellURLString = nil;
	NSString *udid = [CoreData sharedCoreData].UDID;
	NSString *ks = nil;
	NSString *token = MHBEA_DELEGATE.m_sToken;
	NSString *symbol = m_sSelectedSymbol?m_sSelectedSymbol:@"";
	NSString *lan = [[[LangUtil me] getLangPref] isEqualToString:@"en"]?@"Eng":@"Big5";
	
    // Use EAS account
	if ([[[LangUtil me] getDefaultAccount] isEqualToString:@"2"]) {
		buySellURLString = (m_iBuySellType == BuySellTypeBuy)?MHBEA_URL_BUY_EAS:MHBEA_URL_SELL_EAS;
		ks = [MBKUtil getEASKS];
        
    // Use Cyberbanking account
	} else if ([[[LangUtil me] getDefaultAccount] isEqualToString:@"1"]) {
		buySellURLString = (m_iBuySellType == BuySellTypeBuy)?MHBEA_URL_BUY_StockTrading:MHBEA_URL_SELL_StockTrading;
		ks = [MBKUtil getKS];
	}
	
	NSString *urlString = [NSString stringWithFormat:@"%@UUID=%@&ks=%@&token=%@&StockNo=%@&lang=%@",
						   buySellURLString,
						   udid,
						   ks,
						   token,
						   symbol,
						   lan];
    
//	BuySellTypeBuy?NSLog(@"Go to buy trading page: %@",urlString):NSLog(@"Go to sell trading page: %@",urlString);
	
//	[self webViewLoadString:urlString];
    
    ViewControllerDirectorParameter *para = [[ViewControllerDirectorParameter alloc] init];
    if(m_sSelectedSymbol){
        para.m_sString0 = m_sSelectedSymbol;
    }else{
        para.m_sString0 = m_oMHBEABuySellStockView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text;
    }
    para.m_sString1 = urlString;
    [[ViewControllerDirector sharedViewControllerDirector] switchTo:(m_iBuySellType == BuySellTypeBuy)?ViewControllerDirectorIDWebTradeBuy:ViewControllerDirectorIDWebTradeSell para:para];
    [para release];
}

- (void)requestCheckMobileRegisterStatus {
    [[CoreData sharedCoreData].mask showMask];
    [self performSelectorInBackground:@selector(requestCheckMobileRegisterStatusInBackground) withObject:nil];
}

- (void)requestCheckMobileRegisterStatusInBackground{

	NSString *udid = [CoreData sharedCoreData].UDID;
	NSString *ks = nil;
	NSString *mobileNo = nil;
	NSString *lan = [[[LangUtil me] getLangPref] isEqualToString:@"en"]?@"Eng":@"Big5";
	NSString *basicLink = nil;
	
    // Use EAS account
	if ([[[LangUtil me] getDefaultAccount] isEqualToString:@"2"]) {
		basicLink = [MigrationSetting me].m_sURLRegStatusEAS;
		mobileNo = [MBKUtil getEASMobileNoFromSetting];
		ks = [MBKUtil getEASKS];
        
    // Use Cyberbanking account
	} else if ([[[LangUtil me] getDefaultAccount] isEqualToString:@"1"]) {
		basicLink = [MigrationSetting me].m_sURLRegStatusStockTrading;
		mobileNo = [MBKUtil getMobileNoFromSetting];
		ks = [MBKUtil getKS];
	}
	
	if (mobileNo == nil || [mobileNo length] <= 0) {
		[self performSelectorOnMainThread:@selector(handleNoReg) withObject:nil waitUntilDone:NO];
		return;
	}
	
	NSString *url = [NSString stringWithFormat:@"%@UUID=%@&ks=%@&MobileNo=%@&lang=%@",
					 basicLink,
					 udid,
					 ks,
					 mobileNo,
					 lan];
	
	NSLog(@"Check mobile register status: %@",url);
    
	ASIFormDataRequest *request = [HttpRequestUtils getRequest:self url:[NSURL URLWithString:url] isHttps:YES];		
	[[CoreData sharedCoreData].queue addOperation:request];
}

- (void)requestStarted:(ASIHTTPRequest *)request {
	[[CoreData sharedCoreData].mask showMask];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	[[CoreData sharedCoreData].mask hiddenMask];

	NSString *result = request.responseString;
	if (result == nil || 
		[result isEqualToString:@"N"] ||
		[result isEqualToString:@"0"] ||
		[result length] <= 0) {
		
		NSLog(@"Receive from URL with an error: %@",result);
		[self performSelectorOnMainThread:@selector(handleNoReg) withObject:nil waitUntilDone:NO];
        
	} else {
		NSLog(@"Receive from URL without error: %@",result);
		[self performSelectorOnMainThread:@selector(handleHaveReg:) withObject:result waitUntilDone:NO];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[[CoreData sharedCoreData].mask hiddenMask];
	[self performSelectorOnMainThread:@selector(handleNoReg) withObject:nil waitUntilDone:NO];
}


#pragma mark -
#pragma mark Update Functions
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
	
	[m_oMHBEABuySellStockView updateStockTotalValueLabel:totalStockValue];
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
            [m_oMHBEABuySellStockView updateLastUpdateTime:m_sStockUpdateTime];
            
            [m_oMHBEABuySellStockView.m_oTableView reloadData];
        }
    }
    [msg release];
}

//-----------------------------------------------------------------------------
- (void)handleGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)aGetLiteQuoteMsg {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	if (m_oMHBEABuySellStockView.m_oTableView.editing == YES) {return;}
    
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
		symbol = [watchlistSymbolArray objectAtIndex:i];
		
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
    
	[m_oMHBEABuySellStockView.m_oTableView reloadData];
}

//-----------------------------------------------------------------------------
- (void)onGetLiteQuoteReceived:(NSNotification *)n {
	MHFeedXMsgInGetLiteQuote *msg = [n object];
	// not my message, return
	if (msg.m_uiMessageID != m_uiMHFeedXMessageID) {return;}
	
	[self performSelectorOnMainThread:@selector(handleGetLiteQuote:) withObject:msg waitUntilDone:NO];
}

@end