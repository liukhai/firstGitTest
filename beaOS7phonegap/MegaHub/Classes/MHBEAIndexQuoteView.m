//
//  MHBEAIndexQuoteView.m
//  BEA
//
//  Created by MegaHub on 09/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAIndexQuoteView.h"

#import "MHFeedXMsgInGetLiteQuote.h"
#import "ViewControllerDirector.h"
#import "MHNumberKeyboardView.h"
#import "MHBEAStyleConstant.h"
#import "MHFeedConnectorX.h"
#import "StyleConstant.h"
#import "MHBEADelegate.h"
#import "MHUILabel.h"
#import "MHUtility.h"
#import "CoreData.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"

@implementation MHBEAIndexQuoteView

@synthesize m_oIndexDespLabel;
@synthesize m_oIndexNomialLabel;
@synthesize m_oIndexChangeLabel;
@synthesize m_oIndexPChangeLabel;
@synthesize m_oStockPriceLabel;
@synthesize m_oStockChangeLabel;
@synthesize m_oStockChangePercentageLabel;
@synthesize m_oStockChangeImageLabel;
@synthesize m_oSymbolTextField;
@synthesize m_oQuoteButton;
@synthesize m_oAddButton;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        isAddedWatchlist = NO;
        
        UIView *indexBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        indexBackgroundView.backgroundColor = MHIndexBarView_indexBackgroundView_background_color;
        indexBackgroundView.layer.cornerRadius = 10;
        indexBackgroundView.layer.masksToBounds = YES;
        [self addSubview:indexBackgroundView];
        [indexBackgroundView release];
        
        // Desp
		m_oIndexDespLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 52, 30)];
		[m_oIndexDespLabel setBackgroundColor:[UIColor clearColor]];
		[m_oIndexDespLabel setFont:[UIFont boldSystemFontOfSize:16]];
		[m_oIndexDespLabel setTextColor:[UIColor whiteColor]];
		[self addSubview:m_oIndexDespLabel];
		[m_oIndexDespLabel release];
		
		// Nomial
		m_oIndexNomialLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 80, 30)];
		[m_oIndexNomialLabel setBackgroundColor:[UIColor clearColor]];
		[m_oIndexNomialLabel setFont:[UIFont boldSystemFontOfSize:16]];
		[m_oIndexNomialLabel setTextAlignment:NSTextAlignmentRight];
        [m_oIndexNomialLabel setTextColor:[UIColor whiteColor]];
		[self addSubview:m_oIndexNomialLabel];
		[m_oIndexNomialLabel release];
        
		// Change Label
		m_oIndexChangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 87, 30)];
		[m_oIndexChangeLabel setBackgroundColor:[UIColor clearColor]];
		[m_oIndexChangeLabel setFont:[UIFont boldSystemFontOfSize:16]];
		[m_oIndexChangeLabel setTextAlignment:NSTextAlignmentRight];
        [m_oIndexChangeLabel setTextColor:[UIColor whiteColor]];
		[self addSubview:m_oIndexChangeLabel];
		[m_oIndexChangeLabel release];
		
		// pertenage change label
		m_oIndexPChangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(232, 0, 80, 30)];
		[m_oIndexPChangeLabel setBackgroundColor:[UIColor clearColor]];
		[m_oIndexPChangeLabel setFont:[UIFont boldSystemFontOfSize:16]];
		[m_oIndexPChangeLabel setTextAlignment:NSTextAlignmentRight];
        [m_oIndexPChangeLabel setTextColor:[UIColor whiteColor]];
		[self addSubview:m_oIndexPChangeLabel];
		[m_oIndexPChangeLabel release];
		
		//-----------------------------------------------------------------
		
        UIView *stockBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 28, 320, 35)];
        stockBackgroundView.backgroundColor = MHIndexBarView_stockBackgroundView_background_color;
        [self addSubview:stockBackgroundView];
        [stockBackgroundView release];
        
        // Add button
		m_oAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oAddButton setFrame:CGRectMake(10, 32, 28, 28)];
        [m_oAddButton setBackgroundColor:Default_button_title_background_color];
        [m_oAddButton setTitleColor:Default_label_text_color forState:UIControlStateNormal];
        [m_oAddButton setTitle:@"+" forState:UIControlStateNormal];
        [m_oAddButton.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
        m_oAddButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
        m_oAddButton.layer.cornerRadius = 10;
        m_oAddButton.layer.masksToBounds = YES;
		[m_oAddButton addTarget:self action:@selector(onAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_oAddButton];
        
		// Quote Button
        m_oQuoteButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oQuoteButton setFrame:CGRectMake(95, 30, 50, 30)];
		[m_oQuoteButton.titleLabel setTextAlignment:NSTextAlignmentRight];
        [m_oQuoteButton setBackgroundColor:Default_button_title_background_color];
        [m_oQuoteButton setTitleColor:Default_label_text_color forState:UIControlStateNormal];
        [m_oQuoteButton.titleLabel setFont:MHStockQuoteBarView_m_oQuoteButton_font];
        m_oQuoteButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        m_oQuoteButton.layer.cornerRadius = 8;
        m_oQuoteButton.layer.masksToBounds = YES;
        [m_oQuoteButton addTarget:self action:@selector(onQuoteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_oQuoteButton];

        // Symbol Text Field
		m_oSymbolTextField = [[UITextField alloc] initWithFrame:CGRectMake(42, 30, 61, 31)];
		[m_oSymbolTextField setFont:[UIFont systemFontOfSize:15]];
        [m_oSymbolTextField setBackgroundColor:Default_textfield_background_color];
		m_oSymbolTextField.borderStyle = UITextBorderStyleRoundedRect;
		m_oSymbolTextField.autocorrectionType = UITextAutocorrectionTypeNo;
		[m_oSymbolTextField setTextAlignment:NSTextAlignmentRight];
		[m_oSymbolTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[m_oSymbolTextField setClearsOnBeginEditing:YES];
		[m_oSymbolTextField setDelegate:self];
		m_oSymbolTextField.text = [NSString stringWithFormat:@"%05d",[[CoreData sharedCoreData].m_sLastQuoteSymbol intValue]];
        [self addSubview:m_oSymbolTextField];
		[m_oSymbolTextField release];
        
        UIView *symbolBackgroundMaskView = [[UIView alloc] initWithFrame:CGRectMake(97, 30, 6, 30)];
        [symbolBackgroundMaskView setBackgroundColor:Default_button_title_background_color];
        [self addSubview:symbolBackgroundMaskView];
        [symbolBackgroundMaskView release];
        
        // Price
		m_oStockPriceLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(142, 30, 90, 30)];
		[m_oStockPriceLabel setTextColor:MHStockQuoteBarView_m_oPriceLabel_text_color];
		[m_oStockPriceLabel setTextAlignment:NSTextAlignmentRight];
		[m_oStockPriceLabel setFont:MHStockQuoteBarView_m_oPriceLabel_font];
		[m_oStockPriceLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:m_oStockPriceLabel];
		[m_oStockPriceLabel release];
        
        // Change image
        m_oStockChangeImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, 30, 15, 30)];
		[m_oStockChangeImageLabel setBackgroundColor:[UIColor clearColor]];
		[m_oStockChangeImageLabel setFont:[UIFont boldSystemFontOfSize:12]];
		[m_oStockChangeImageLabel setTextAlignment:NSTextAlignmentRight];
        [m_oStockChangeImageLabel setTextColor:[UIColor whiteColor]];
		[self addSubview:m_oStockChangeImageLabel];
		[m_oStockChangeImageLabel release];
		
        // Change
		m_oStockChangeLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(245, 30, 65, 15)];
		[m_oStockChangeLabel setTextAlignment:NSTextAlignmentRight];
		[m_oStockChangeLabel setFont:[UIFont boldSystemFontOfSize:14]];
		[m_oStockChangeLabel setBackgroundColor:[UIColor clearColor]];
        [m_oStockChangeLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:m_oStockChangeLabel];
		[m_oStockChangeLabel release];
		
        // Percentage Change
		m_oStockChangePercentageLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(245, 45, 65, 15)];
		[m_oStockChangePercentageLabel setTextAlignment:NSTextAlignmentRight];
		[m_oStockChangePercentageLabel setFont:[UIFont boldSystemFontOfSize:14]];
		[m_oStockChangePercentageLabel setBackgroundColor:[UIColor clearColor]];
        [m_oStockChangePercentageLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:m_oStockChangePercentageLabel];
		[m_oStockChangePercentageLabel release];
        
        changeDefaultFrame = m_oStockChangeLabel.frame;
        percentChangeDefaultFrame = m_oStockChangePercentageLabel.frame;
		
		[[MHFeedConnectorX sharedMHFeedConnectorX] addGetLiteQuoteObserver:self action:@selector(onMHFeedXMsgInGetLiteQuote:)];
        
        [self cleanIndex];
        [self reloadText];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame controller:(UIViewController*)aController{

    self = [self initWithFrame:frame];
    if (self) {
        m_oController = aController;
    }
    return self;
}

- (void)dealloc {
	[[MHFeedConnectorX sharedMHFeedConnectorX] removeGetLiteQuoteObserver:self];    
    [super dealloc];
}

- (void)reloadText {
	m_oIndexDespLabel.text = MHLocalizedStringFile(@"MHBEAIndexBarView.m_oDespLabel", nil, MHLanguage_BEAString);
	[m_oQuoteButton setTitle:MHLocalizedStringFile(@"MHBEAIndexBarView.m_oQuoteButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
    
    [self onQuoteButtonPressed:nil];
}


#pragma mark -
- (void)cleanIndex {
	m_oIndexNomialLabel.text	= @"";
	m_oIndexChangeLabel.text	= @"0.00";
	m_oIndexPChangeLabel.text	= @"0.00%";
}

- (void)cleanStock {
    m_oStockPriceLabel.text             = @"";
    m_oStockChangeLabel.text            = @"";
    m_oStockChangePercentageLabel.text  = @"";
    m_oStockChangeImageLabel.text       = @"";
}

-(void)displayInvalidStock{
	[self cleanStock];
	m_oSymbolTextField.text	= @"";
    if ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable || [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
        UIAlertView *m_oAlertView = [[UIAlertView alloc] initWithTitle:MHLocalizedStringFile(@"MHBEAFAQuoteViewController.title.invalid_stock", nil, MHLanguage_BEAString)
                                                               message:nil
                                                              delegate:self
                                                     cancelButtonTitle:MHLocalizedStringFile(@"MHBEAFAQuoteViewController.ok", nil, MHLanguage_BEAString)
                                                     otherButtonTitles:nil];
        [m_oAlertView show];
    }
//    else {
//        if ([[CoreData sharedCoreData].lastScreen isEqual:@"main_view_controller"]) {
//            NSLog(@"");
//        }else {
//            UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//            [alert_view show];
//            [alert_view release];
//        }
//        
//        
//    }

}

- (void)syncStockCode {
    m_oSymbolTextField.text = [NSString stringWithFormat:@"%05d", [[CoreData sharedCoreData].m_sLastQuoteSymbol intValue]];
    [self onQuoteButtonPressed:nil];
    
    [CoreData sharedCoreData].m_sLastQuoteSymbol = BEA_DEFAULT_STOCK;
}


#pragma mark -
#pragma mark Button callback functions
- (void)onQuoteButtonPressed:(id)sender {
	[MHNumberKeyboardView dismiss];
	[m_oSymbolTextField resignFirstResponder];

	m_uiMsgIDIndex = [MHBEA_DELEGATE getFAHSI];
	if (m_oSymbolTextField.text != nil && [m_oSymbolTextField.text length] > 0) {
        [self cleanStock];
		m_uiMsgIDStockInfo = [MHBEA_DELEGATE getFreeQuote:m_oSymbolTextField.text];
        m_oSymbolTextField.text = [NSString stringWithFormat:@"%05d",[m_oSymbolTextField.text intValue]];
	}
}

- (void)onAddButtonPressed:(id)sender {
    
    isAddedWatchlist = YES;
    
	[MHNumberKeyboardView dismiss];
	[m_oSymbolTextField resignFirstResponder];
    
    m_uiMsgIDStockInfo = [MHBEA_DELEGATE getFreeQuote:m_oSymbolTextField.text];
}


#pragma mark -
#pragma mark MHFeedX callback function
- (void)performMHFeedXMsgInGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)msg {
	[msg retain];
    
    //Stock
    if(msg.m_uiMessageID == m_uiMsgIDStockInfo){
        MHFeedXObjStockQuote *stockQuote = nil;
        MHFeedXObjQuote *quote = nil;
        if (msg.m_oStockQuoteArray!= nil && [msg.m_oStockQuoteArray count] > 0) {
            stockQuote = [msg.m_oStockQuoteArray objectAtIndex:0];
            if (stockQuote.m_oQuoteArray != nil && [stockQuote.m_oQuoteArray count] >0) {
                quote = [stockQuote.m_oQuoteArray objectAtIndex:0];
                
                float prevClose = [quote.m_sPrevClose floatValue];
                float nominal = [quote.m_sLast floatValue];
                float change = [quote.m_sChange floatValue];
                float pChange = [quote.m_sPctChange floatValue];
          
                m_oStockPriceLabel.text				= [MHUtility floatPriceToString:nominal market:MARKET_HONGKONG];
                
                if(prevClose > 0){
                    m_oStockChangeLabel.text			= [MHUtility floatPriceChangeToString:change market:MARKET_HONGKONG];
                    m_oStockChangePercentageLabel.text	= [MHUtility floatIndexPencentageChangeToString:pChange market:MARKET_HONGKONG];
                }else{
                    m_oStockChangeLabel.text			= @"";
                    m_oStockChangePercentageLabel.text	= @"";
                }
                
                if (change > 0) {
                    m_oStockPriceLabel.textColor = [UIColor blackColor];
                    m_oStockChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;
                    m_oStockChangePercentageLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;
                    m_oStockChangeImageLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;
                    m_oStockChangeImageLabel.text = @"▲";
                    
                } else if (change == 0) {
                    m_oStockPriceLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
                    m_oStockChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
                    m_oStockChangePercentageLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
                    m_oStockChangeImageLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
                    m_oStockChangeImageLabel.text = @"";
                    
                } else if (change < 0) {
                    m_oStockPriceLabel.textColor = [UIColor blackColor];
                    m_oStockChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
                    m_oStockChangePercentageLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
                    m_oStockChangeImageLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
                    m_oStockChangeImageLabel.text = @"▼";
                }
                
                CGSize changeSize = [m_oStockChangeLabel.text sizeWithFont:m_oStockChangeLabel.font constrainedToSize:changeDefaultFrame.size lineBreakMode:m_oStockChangeLabel.lineBreakMode];
                m_oStockChangeLabel.frame = CGRectMake(305-changeSize.width, m_oStockChangeLabel.frame.origin.y, changeSize.width, m_oStockChangeLabel.frame.size.height);
                
                CGSize percentChangeSize = [m_oStockChangePercentageLabel.text sizeWithFont:m_oStockChangePercentageLabel.font constrainedToSize:percentChangeDefaultFrame.size lineBreakMode:m_oStockChangePercentageLabel.lineBreakMode];
                m_oStockChangePercentageLabel.frame = CGRectMake(305-percentChangeSize.width, m_oStockChangePercentageLabel.frame.origin.y, percentChangeSize.width, m_oStockChangePercentageLabel.frame.size.height);
                
                int changeImageX = changeSize.width > percentChangeSize.width ? m_oStockChangeLabel.frame.origin.x : m_oStockChangePercentageLabel.frame.origin.x;
                m_oStockChangeImageLabel.frame = CGRectMake(changeImageX-m_oStockChangeImageLabel.frame.size.width, m_oStockChangeImageLabel.frame.origin.y, m_oStockChangeImageLabel.frame.size.width, m_oStockChangeImageLabel.frame.size.height);
                
                if(isAddedWatchlist){
                    if([m_oSymbolTextField.text length]>0 && [m_oSymbolTextField.text intValue]>0 && [MHBEA_DELEGATE addStockWatchlist:m_oSymbolTextField.text]) {
                        [MHBEA_DELEGATE showAddedStockToWatchlist];
                    }
                }
                
            }else{
                // invalid stock
                [self displayInvalidStock];
            }
            
        }else{
            // invalid stock
            [self displayInvalidStock];
        }
        
        isAddedWatchlist = NO;
        
        if(m_oController && [m_oController respondsToSelector:@selector(performMHFeedXMsgInGetLiteQuote:)]){
            [m_oController performMHFeedXMsgInGetLiteQuote:msg];
        }
        
        if(m_oController && [m_oController respondsToSelector:@selector(reloadDataSource)]){
            [m_oController reloadDataSource];
        }
        
        
	}else if(msg.m_uiMessageID == m_uiMsgIDIndex){
        for (int i = 0; i < [msg.m_oStockQuoteArray count]; i++) {
            MHFeedXObjStockQuote *stockQuote = [msg.m_oStockQuoteArray objectAtIndex:i];
            if([stockQuote.m_oQuoteArray count] == 1){
                MHFeedXObjQuote *quote	= [stockQuote.m_oQuoteArray objectAtIndex:0];
                if([MHUtility equalsIgnoreCase:quote.m_sSymbol anotherString:@"HSI"]){
                    
                    float fLast			= [quote.m_sLast floatValue];
                    float fChg			= [quote.m_sChange floatValue];
                    float fPChg         = [quote.m_sPctChange floatValue];
                    
                    NSString *sLast		= [MHUtility floatIndexToString:fLast market:MARKET_HONGKONG];
                    NSString *sChg		= [NSString stringWithFormat:@"%@", [MHUtility floatIndexChangeToString:fChg market:MARKET_HONGKONG]];
                    NSString *sPChg		= [NSString stringWithFormat:@"%@", [MHUtility floatIndexPencentageChangeToString:fPChg market:MARKET_HONGKONG]];
                    
                    if(fChg == 0){
                        m_oIndexChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
                        m_oIndexPChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_leveloff;
                    }else if(fChg < 0){
                        m_oIndexChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
                        m_oIndexPChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_down;
                        sChg = [NSString stringWithFormat:@"%@%@", @"▾", sChg];
                    }else if(fChg > 0){
                        m_oIndexChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;
                        m_oIndexPChangeLabel.textColor = MHIndexBarView_m_oChangeLabel_text_color_up;
                        sChg = [NSString stringWithFormat:@"%@%@", @"▴", sChg];
                    }
                    
                    [m_oIndexChangeLabel setText:sChg];
                    [m_oIndexPChangeLabel setText:sPChg];
                    [m_oIndexNomialLabel setText:sLast];
                    
                }
            }
        }
    }
	
	[msg release];
}

- (void)onMHFeedXMsgInGetLiteQuote:(NSNotification *)n {
	[self performSelectorOnMainThread:@selector(performMHFeedXMsgInGetLiteQuote:) withObject:[n object] waitUntilDone:NO];
}


#pragma mark -
#pragma mark UITextField Delegate Functions
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	[MHNumberKeyboardView setDecimalPlace:0];
	[MHNumberKeyboardView setEnableComma:NO];
	return [MHNumberKeyboardView show:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self onQuoteButtonPressed:nil];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	int newLen = range.location + range.length;
	return newLen<=5;
}

@end