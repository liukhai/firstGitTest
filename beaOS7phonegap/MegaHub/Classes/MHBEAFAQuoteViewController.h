//
//  MHBEAFAQuoteViewController.h
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTAChartView.h"
#import "ASIFormDataRequest.h"

@class MHTAChartView;
@class MHBEAFAQuoteView;
@class RotateMenu3ViewController;
@class MHFeedXMsgInGetLiteQuote;
@class MHFeedXObjQuote;
@class ASIHTTPRequest;

@interface MHBEAFAQuoteViewController: UIViewController <UIScrollViewDelegate, MHTAChartViewDelegate,ASIHTTPRequestDelegate>{
	MHBEAFAQuoteView			*m_oMHBEAFAQuoteView;
    MHTAChartView               *m_oMHTAChartView;
    RotateMenu3ViewController   *v_rmvc;
    
    BOOL                        isGoToBuyView;
    
    NSString                    *m_sLastQuoteSymbol; // For dismiss keyboard and then undo the code
}

- (id)init;
- (void)dealloc;
- (void)loadView;
- (void)viewDidLoad;
- (void)viewDidUnload;
- (void)didReceiveMemoryWarning;
- (void)reloadText;
- (void)clean;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)msg;
- (void)getRelatedStock:(MHFeedXObjQuote *)aQuote;
//- (void)setStockCode:(NSString*)stockCode;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)initChart;
- (void)clientDidRequestNewQuote:(NSString *)aNewSymbol;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
- (void)showHorizontalChart:(UIInterfaceOrientation)orientation;
- (void)hideHorizontalChart;
- (void)onReceiveViewControllerDirector:(NSNotification *)n;
- (void)onRelatedStockButtonIsClicked;
- (void)onBuyButtonPressed;
- (void)onSellButtonPressed;
- (void)requestCheckMobileRegisterStatus;
- (void)requestCheckMobileRegisterStatusInBackground;
- (void)requestStarted:(ASIHTTPRequest *)request;
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
- (void)handleNoReg;

@end