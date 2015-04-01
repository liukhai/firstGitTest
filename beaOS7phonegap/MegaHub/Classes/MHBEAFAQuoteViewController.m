    //
//  MHBEAFAQuoteViewController.m
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//
#import "MHBEAFAQuoteViewController.h"
#import "MHFeedXMsgInGetLiteQuote.h"
#import "MagicTraderAppDelegate.h"
#import "MHBEAObjWatchlistStock.h"
#import "ViewControllerDirector.h"
#import "MHNumberKeyboardView.h"
#import "MHBEAStyleConstant.h"
#import "BEAViewController.h"
#import "MHBEAFAQuoteView.h"
#import "MHFeedConnectorX.h"
#import "MHStaticDataView.h"
#import "MHBEAConstant.h"
#import "MHBEADelegate.h"
#import "PTConstant.h"
#import "CoreData.h"
#import "MHUtility.h"
#import "StyleConstant.h"
#import "MHBEADelegate.h"
#import "LangUtil.h"
#import "CoreData.h"

@implementation MHBEAFAQuoteViewController

- (id)init {
	self = [super init];
	if (self != nil) {
        isGoToBuyView = YES;
        [[ViewControllerDirector sharedViewControllerDirector] addObserver:self action:@selector(onReceiveViewControllerDirector:)];
	}
	return self;
}

- (void)dealloc {
	[[MHFeedConnectorX sharedMHFeedConnectorX] removeGetLiteQuoteObserver:self];

    [m_oMHBEAFAQuoteView  release];
	m_oMHBEAFAQuoteView = nil;
    
    [m_oMHTAChartView release];
    m_oMHTAChartView = nil;
    
    [v_rmvc release];
    v_rmvc = nil;
    
    [super dealloc];
}

- (void)loadView {
	m_oMHBEAFAQuoteView = [[MHBEAFAQuoteView alloc] initWithFrame:CGRectMake(0, 0, 320, [MHUtility getAppHeight]) controller:self];
	self.view = m_oMHBEAFAQuoteView;
    
    [m_oMHBEAFAQuoteView.m_oMHBEABottomView.m_oBuyButton addTarget:self action:@selector(onBuyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [m_oMHBEAFAQuoteView.m_oMHBEABottomView.m_oSellButton addTarget:self action:@selector(onSellButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    m_oMHBEAFAQuoteView.m_oScrollView.delegate = self;
    [m_oMHBEAFAQuoteView.m_oMHStaticDataView.m_oRelatedStockButton addTarget:self action:@selector(onRelatedStockButtonIsClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    v_rmvc = [[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil];
//    [v_rmvc.rmUtil setNav:self.navigationController];
    [self.view addSubview:v_rmvc.contentView];
}

- (void)viewDidUnload {
	[super viewDidUnload];

	[m_oMHBEAFAQuoteView  release];
	m_oMHBEAFAQuoteView = nil;
    
    [m_oMHTAChartView release];
    m_oMHTAChartView = nil;
    
    [v_rmvc release];
    v_rmvc = nil;
}	

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadText {
    [self initChart];
    [m_oMHBEAFAQuoteView reloadText];
}

- (void)clean {
	[m_oMHBEAFAQuoteView clean];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [v_rmvc.rmUtil setNav:self.navigationController];
    [m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView syncStockCode];
    [self reloadText];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)msg {
	[msg retain];
    
    //Stock
    MHFeedXObjStockQuote *stockQuote = nil;
    MHFeedXObjQuote *quote = nil;
    if (msg.m_oStockQuoteArray!= nil && [msg.m_oStockQuoteArray count] > 0) {
        stockQuote = [msg.m_oStockQuoteArray objectAtIndex:0];
        if (stockQuote.m_oQuoteArray != nil && [stockQuote.m_oQuoteArray count] >0) {
            quote = [stockQuote.m_oQuoteArray objectAtIndex:0];
            
            [m_oMHBEAFAQuoteView switchToPage:0];
            
            m_oMHBEAFAQuoteView.m_oScrollView.hidden = NO;
            
            // display the quote
            [m_oMHBEAFAQuoteView updateStockInfo:msg];
            [m_oMHBEAFAQuoteView.m_oMHBEABasicDataView updateSRData:quote];
            [self getRelatedStock:quote];
            
            // if the watchlist have the symbol, update GainLoss
            if ([MHBEA_DELEGATE stockWathlistHaveStock:quote.m_sSymbol]) {
                
                NSArray *stockArray = [MHBEA_DELEGATE loadStockWatchlistGainLoss];
                BOOL hasStock = NO;
                
                for (MHBEAObjWatchlistStock *s in stockArray) {
                    if ([s.m_sSymbol intValue] == [quote.m_sSymbol intValue]) {
                        hasStock = YES;
                        [m_oMHBEAFAQuoteView.m_oMHBEAQuoteGainLossView updateWithBuyPrice:s.m_sInputPrice
                                                                                      qyt:s.m_sInputQty
                                                                                     last:quote.m_sLast];
                        break;
                    }
                }
                
                if(!hasStock){
                    [m_oMHBEAFAQuoteView.m_oMHBEAQuoteGainLossView updateWithBuyPrice:0 qyt:0 last:quote.m_sLast];
                }
                
            } else {
                [m_oMHBEAFAQuoteView.m_oMHBEAQuoteGainLossView clean];
            }
            
            @synchronized(m_sLastQuoteSymbol){
                if(m_sLastQuoteSymbol){
                    [m_sLastQuoteSymbol release];
                    m_sLastQuoteSymbol = nil;
                }
                m_sLastQuoteSymbol = [m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text retain];
            }
            [CoreData sharedCoreData].m_sLastQuoteSymbol = m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text;
            
        }else{
            // invalid stock
            m_oMHBEAFAQuoteView.m_oScrollView.hidden = YES;
            m_oMHBEAFAQuoteView.m_oBottomLeftButton.hidden = YES;
            m_oMHBEAFAQuoteView.m_oBottomRightButton.hidden = YES;
        }
        
    }else{
        // invalid stock
        m_oMHBEAFAQuoteView.m_oScrollView.hidden = YES;
        m_oMHBEAFAQuoteView.m_oBottomLeftButton.hidden = YES;
        m_oMHBEAFAQuoteView.m_oBottomRightButton.hidden = YES;
    }
}

- (void)getRelatedStock:(MHFeedXObjQuote *)aQuote{
	[aQuote retain];
	
	if([aQuote.m_sSymbol length] > 0){
		if([aQuote.m_sStockType isEqualToString:STOCK_TYPE_SR_STOCK]){
			[m_oMHBEAFAQuoteView.m_oMHBEABasicDataView.m_oRelateStockDataView loadStock:aQuote.m_sSymbol rate:-1 action:@"-1" realtime:NO];
			
		}else if([aQuote.m_sStockType isEqualToString:STOCK_TYPE_SR_CBBC] || [aQuote.m_sStockType isEqualToString:STOCK_TYPE_SR_WARRANT]){
			[m_oMHBEAFAQuoteView.m_oMHBEABasicDataView.m_oRelateStockDataView loadWarrant:aQuote.m_sSymbol rate:-1 action:@"-1" realtime:NO];
		}
	}
	
	[aQuote release];
}

//- (void)setStockCode:(NSString*)stockCode{
//    if(stockCode != nil && [stockCode length] > 0){
//        m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text = [NSString stringWithFormat:@"%05d",[stockCode intValue]];
//    }
//}


#pragma mark - Scroll view
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint pointX = scrollView.contentOffset;
    int page = (int)pointX.x/320;
    if(page == 0){
        m_oMHBEAFAQuoteView.m_oBottomLeftButton.hidden = YES;
        m_oMHBEAFAQuoteView.m_oBottomRightButton.hidden = NO;
    }else{
        m_oMHBEAFAQuoteView.m_oBottomLeftButton.hidden = NO;
        m_oMHBEAFAQuoteView.m_oBottomRightButton.hidden = YES;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}


#pragma mark - Chart
- (void)initChart{
    @synchronized(m_oMHTAChartView) {
        if (m_oMHTAChartView) {
            [m_oMHTAChartView removeFromSuperview];
            [m_oMHTAChartView release];
            m_oMHTAChartView = nil;
        }
        
        CGFloat width = [MHUtility getScreenHeight];
        CGFloat height = [MHUtility getScreenWidth];
        
        m_oMHTAChartView = [[MHTAChartView alloc] initWithDefaultSettings:CGRectMake(0, 0, width, height) isRealTime:NO];
    }
    m_oMHTAChartView.hidden = YES;
    m_oMHTAChartView.isRealTime = NO;
    m_oMHTAChartView.delegate = self;
    m_oMHTAChartView.iFontSize = 11;
    m_oMHTAChartView.iTstyle = 6;
    m_oMHTAChartView.iLang = [MHUtility convertMHLanguageToChartLang:[MHLanguage getCurrentLanguage]];
    if([MHUtility checkVersionGreater:@"7"]){
        [m_oMHTAChartView setToolBarTint:[UIColor lightGrayColor]];
        [m_oMHTAChartView setToolBarAlpha:0.9];
        [m_oMHTAChartView setMenuBarTint:[UIColor orangeColor]];
        [m_oMHTAChartView setMenuBarTextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12]];
        [m_oMHTAChartView setMenuBarNormalBackgroundImage:[UIImage imageNamed:@"background_button.png"]];
        [m_oMHTAChartView setMenuBarSelectedBackgroundImage:[UIImage imageNamed:@"background_button_selected.png"]];
        
        [m_oMHTAChartView setConfigViewButtonBorderWithWithColor:[UIColor clearColor]
                                                 withBorderWidth:0
                                                withCornerRadius:5.0];
        
        [m_oMHTAChartView setSegmentedButtonsBackgroundImage:[UIImage imageNamed:@"background_button_leftmost.png"] selectedLeftImage:[UIImage imageNamed:@"background_button_leftmost_selected.png"]
                                                 middleImage:[UIImage imageNamed:@"background_button_middle.png"] selectedMiddleImage:[UIImage imageNamed:@"background_button_middle_selected.png"]
                                                  rightImage:[UIImage imageNamed:@"background_button_rightmost.png"] selectedRightImage:[UIImage imageNamed:@"background_button_rightmost_selected.png"]];
        
        [m_oMHTAChartView setButtonsBackgroundImage:[UIImage imageNamed:@"background_button.png"] selectedImage:[UIImage imageNamed:@"background_button_selected.png"]];
        
        
    }else{
        [m_oMHTAChartView setMenuBarTint:[UIColor orangeColor]];
        [m_oMHTAChartView setToolBarTint:[UIColor blackColor]];
        [m_oMHTAChartView setToolBarAlpha:0.85];
    }
    [m_oMHTAChartView setIColorScheme:MHChartColorMegahubLight];
    [m_oMHTAChartView setODisclaimerLogo:Default_chart_disclaimer_image_view];
    [m_oMHTAChartView setDisclaimerText:[MT_DELEGATE loadChartDisclaimerFileName]];

    [self.view addSubview:m_oMHTAChartView];
}

- (void)clientDidRequestNewQuote:(NSString *)aNewSymbol{
	[m_oMHTAChartView setISymbol:[aNewSymbol intValue]];
	m_oMHTAChartView.hidden = NO;
	[m_oMHTAChartView loadCharts];
    
    [CoreData sharedCoreData].m_sLastQuoteSymbol = aNewSymbol;
    [m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView syncStockCode];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if(m_sLastQuoteSymbol && [m_sLastQuoteSymbol length] > 0){
        m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text = m_sLastQuoteSymbol;
    }
    [MHNumberKeyboardView dismiss];
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self showHorizontalChart:toInterfaceOrientation];
	} else {
        [self hideHorizontalChart];
	}
	return YES;
}

- (void)showHorizontalChart:(UIInterfaceOrientation)orientation{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(setStatusBarHidden:withAnimation:)] == YES) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if(m_oMHTAChartView.hidden){
        m_oMHTAChartView.iSymbol = [m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text intValue];
        m_oMHTAChartView.hidden = NO;
        [m_oMHTAChartView loadCharts];
    }
    
    v_rmvc.contentView.hidden = YES;
}

- (void)hideHorizontalChart{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(setStatusBarHidden:withAnimation:)] == YES) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    if(m_oMHTAChartView.iSymbol != [m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text intValue] && m_oMHTAChartView.iSymbol != 0){
        m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text = [NSString stringWithFormat:@"%05d",m_oMHTAChartView.iSymbol];
        [m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView onQuoteButtonPressed:nil];
    }
    
    [m_oMHTAChartView findAndResignFirstResponder];
    m_oMHTAChartView.hidden = YES;
    m_oMHTAChartView.iSymbol = 0;
    v_rmvc.contentView.hidden = NO;
}

#pragma mark -
- (void)onReceiveViewControllerDirector:(NSNotification *)n {
	ViewControllerDirectorParameter *para = [n object];
	if ([para isKindOfClass:[ViewControllerDirectorParameter class]] == NO ){
		printf("WFFreeAppRootViewContoller:ERROR!!! onReceiveViewControllerDirector wrong parameter\n");
		return;
	}
	
	switch ((int)para.m_iViewControllerID) {
		case ViewControllerDirectorIDWeb_Stock_Quote: {
			if(para.m_sString1 != nil){
				//stockclick://0005.HK
				int prefixStringLength	= ([STOCK_QUOTE_LINK_PREFIX length]+[@"://" length]);
				NSString *dataString	= [para.m_sString1 substringFromIndex:prefixStringLength];
				
				NSArray *dataArray = [dataString componentsSeparatedByString:@"."];
				
				NSString *symbolString = [dataArray objectAtIndex:0];
				
				m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text = symbolString;
                [m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView onQuoteButtonPressed:nil];
                [m_oMHBEAFAQuoteView.m_oMHBEABasicDataView.m_oStockDataSegmentedButton setSelectedButtonIndex:0];
			}
			
			break;
		}
    }
}

- (void)onRelatedStockButtonIsClicked{
	//Related Symbol
	NSString *relatedSymbol = m_oMHBEAFAQuoteView.m_oMHStaticDataView.m_oRelatedStockValueLabel.text;
	
    if(relatedSymbol!=nil && [relatedSymbol length]>0 && !m_oMHBEAFAQuoteView.m_oMHStaticDataView.m_oRelatedStockValueLabel.hidden){
        if([MHUtility isSymbolInMarket:relatedSymbol market:MARKET_HONGKONG]){
            m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text = relatedSymbol;
            [m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView onQuoteButtonPressed:nil];
        }
    }
}

- (void)onBuyButtonPressed{
    isGoToBuyView = true;
    [self performSelectorInBackground:@selector(requestCheckMobileRegisterStatus) withObject:nil];
}

- (void)onSellButtonPressed{
    isGoToBuyView = false;
    [self performSelectorInBackground:@selector(requestCheckMobileRegisterStatus) withObject:nil];
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
	
    //	NSLog(@"Check mobile register status: %@",url);
    
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
		
//		NSLog(@"Receive from URL with an error: %@",result);
		[self performSelectorOnMainThread:@selector(handleNoReg) withObject:nil waitUntilDone:NO];
        
	}else{
        
//      NSLog(@"Receive from URL without error: %@",result);
		[self performSelectorOnMainThread:@selector(handleHaveReg:) withObject:result waitUntilDone:NO];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[[CoreData sharedCoreData].mask hiddenMask];
	[self performSelectorOnMainThread:@selector(handleNoReg) withObject:nil waitUntilDone:NO];
}

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
	NSString *symbol = m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text;
	NSString *lan = [[[LangUtil me] getLangPref] isEqualToString:@"en"]?@"Eng":@"Big5";
	
    // Use EAS account
	if ([[[LangUtil me] getDefaultAccount] isEqualToString:@"2"]) {
		buySellURLString = (isGoToBuyView)?MHBEA_URL_BUY_EAS:MHBEA_URL_SELL_EAS;
		ks = [MBKUtil getEASKS];
        
        // Use Cyberbanking account
	} else if ([[[LangUtil me] getDefaultAccount] isEqualToString:@"1"]) {
		buySellURLString = (isGoToBuyView)?MHBEA_URL_BUY_StockTrading:MHBEA_URL_SELL_StockTrading;
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
    para.m_sString0 = m_oMHBEAFAQuoteView.m_oMHBEAIndexQuoteView.m_oSymbolTextField.text;
    para.m_sString1 = urlString;
    if(isGoToBuyView){
        [[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDWebTradeBuy para:para];
        
    }else{
        [[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDWebTradeSell para:para];
    }
    [para release];
}

@end