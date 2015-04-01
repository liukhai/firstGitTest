//
//  MHBEABottomView.m
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEABottomView.h"
#import "MHBEAStyleConstant.h"
#import "MHBEAConstant.h"
#import "MHLanguage.h"
#import "ViewControllerDirector.h"
#import "MHBEADelegate.h"
#import "LangUtil.h"
#import "CoreData.h"

#define BUTTON_PADDING  5

@implementation MHBEABottomView

@synthesize m_oBuyButton;
@synthesize m_oQuoteButton;
@synthesize m_oNewsButton;
@synthesize m_oStockButton;
@synthesize m_oSellButton;

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MHBEABottomView_background_color;
        
        isNewsView = NO;
        isQuoteView = NO;
        isGoToBuyView = NO;
        
        m_oBuyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oBuyButton.titleLabel setFont:MHBEABottomView_button_text_font];
        [m_oBuyButton setTitleColor:MHBEABottomView_button_text_color forState:UIControlStateNormal];
        [m_oBuyButton setBackgroundImage:MHBEABottomView_m_oBuyButton_background_image forState:UIControlStateNormal];
        [m_oBuyButton setBackgroundImage:MHBEABottomView_m_oBuyButton_selected_background_image forState:UIControlStateSelected];
        [self addSubview:m_oBuyButton];
		
        m_oQuoteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oQuoteButton.titleLabel setFont:MHBEABottomView_button_text_font];
        [m_oQuoteButton setTitleColor:MHBEABottomView_button_text_color forState:UIControlStateNormal];
        [m_oQuoteButton setBackgroundImage:MHBEABottomView_m_oQuoteButton_background_image forState:UIControlStateNormal];
        [m_oQuoteButton setBackgroundImage:MHBEABottomView_m_oQuoteButton_selected_background_image forState:UIControlStateSelected];
        [self addSubview:m_oQuoteButton];
        
        m_oNewsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oNewsButton.titleLabel setFont:MHBEABottomView_button_text_font];
        [m_oNewsButton setTitleColor:MHBEABottomView_button_text_color forState:UIControlStateNormal];
        [m_oNewsButton setBackgroundImage:MHBEABottomView_m_oNewsButton_background_image forState:UIControlStateNormal];
        [m_oNewsButton setBackgroundImage:MHBEABottomView_m_oNewsButton_selected_background_image forState:UIControlStateSelected];
        [self addSubview:m_oNewsButton];
        
        m_oStockButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oStockButton.titleLabel setFont:MHBEABottomView_button_text_font];
        [m_oStockButton setTitleColor:MHBEABottomView_button_text_color forState:UIControlStateNormal];
        [m_oStockButton setBackgroundImage:MHBEABottomView_m_oStockButton_background_image forState:UIControlStateNormal];
        [m_oStockButton setBackgroundImage:MHBEABottomView_m_oStockButton_selected_background_image forState:UIControlStateSelected];
        [self addSubview:m_oStockButton];
        
        m_oSellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oSellButton.titleLabel setFont:MHBEABottomView_button_text_font];
        [m_oSellButton setTitleColor:MHBEABottomView_button_text_color forState:UIControlStateNormal];
        [m_oSellButton setBackgroundImage:MHBEABottomView_m_oSellButton_background_image forState:UIControlStateNormal];
        [m_oSellButton setBackgroundImage:MHBEABottomView_m_oSellButton_selected_background_image forState:UIControlStateSelected];
        [self addSubview:m_oSellButton];
        
        [m_oBuyButton addTarget:self action:@selector(onBuyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [m_oQuoteButton addTarget:self action:@selector(onQuoteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [m_oNewsButton addTarget:self action:@selector(onNewsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [m_oStockButton addTarget:self action:@selector(onStockButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [m_oSellButton addTarget:self action:@selector(onSellButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [self setShowFiveButtons:YES];
        [self reloadText];
    
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)reloadText {
	[m_oBuyButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oBuyButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
    [m_oQuoteButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oQuoteButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
    [m_oNewsButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oNewsButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
    [m_oStockButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oStockButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
    [m_oSellButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oSellButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
    
    [m_oBuyButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oBuyButton", nil, MHLanguage_BEAString) forState:UIControlStateSelected];
    [m_oQuoteButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oQuoteButton", nil, MHLanguage_BEAString) forState:UIControlStateSelected];
    [m_oNewsButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oNewsButton", nil, MHLanguage_BEAString) forState:UIControlStateSelected];
    [m_oStockButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oStockButton", nil, MHLanguage_BEAString) forState:UIControlStateSelected];
    [m_oSellButton setTitle:MHLocalizedStringFile(@"MHBEABottomBarView.m_oSellButton", nil, MHLanguage_BEAString) forState:UIControlStateSelected];
}

- (void)setSelectedIndex:(int)index{
    switch(index){
        case 0:
            [m_oSellButton addTarget:self action:@selector(onSellButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [m_oBuyButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            m_oBuyButton.selected = YES;
            m_oSellButton.selected = NO;
            break;
        case 1:
            [m_oQuoteButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            m_oQuoteButton.selected = YES;
            isQuoteView = YES;
            break;
        case 2:
            [m_oNewsButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            m_oNewsButton.selected = YES;
            isNewsView = YES;
            break;
        case 3:
            if(m_oStockButton.hidden){
                [m_oSellButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                m_oSellButton.selected = YES;
            }else{
                [m_oStockButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                m_oStockButton.selected = YES;
            }
            break;
        case 4:
            [m_oBuyButton addTarget:self action:@selector(onBuyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [m_oSellButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            m_oBuyButton.selected = NO;
            m_oSellButton.selected = YES;
            break;
    }
}

- (void)setShowFiveButtons:(BOOL)isSHowFiveButtons{
    if (isSHowFiveButtons) {
        m_oStockButton.hidden = NO;
        
        int buttonWidth = (320-BUTTON_PADDING*10)/5;
        
        m_oBuyButton.frame = CGRectMake(BUTTON_PADDING, 3, buttonWidth, 25);
        m_oQuoteButton.frame = CGRectMake(m_oBuyButton.frame.origin.x+m_oBuyButton.frame.size.width+BUTTON_PADDING*2, 3, buttonWidth, 25);
        m_oNewsButton.frame = CGRectMake(m_oQuoteButton.frame.origin.x+m_oQuoteButton.frame.size.width+BUTTON_PADDING*2, 3, buttonWidth, 25);
        m_oStockButton.frame = CGRectMake(m_oNewsButton.frame.origin.x+m_oNewsButton.frame.size.width+BUTTON_PADDING*2, 3, buttonWidth, 25);
        m_oSellButton.frame = CGRectMake(m_oStockButton.frame.origin.x+m_oStockButton.frame.size.width+BUTTON_PADDING*2, 3, buttonWidth, 25);
        
    }else{
        m_oStockButton.hidden = YES;
        
        int buttonWidth = (320-BUTTON_PADDING*8)/4;
        
        m_oBuyButton.frame = CGRectMake(BUTTON_PADDING, 3, buttonWidth, 25);
        m_oQuoteButton.frame = CGRectMake(m_oBuyButton.frame.origin.x+m_oBuyButton.frame.size.width+BUTTON_PADDING*2, 3, buttonWidth, 25);
        m_oNewsButton.frame = CGRectMake(m_oQuoteButton.frame.origin.x+m_oQuoteButton.frame.size.width+BUTTON_PADDING*2, 3, buttonWidth, 25);
        m_oSellButton.frame = CGRectMake(m_oNewsButton.frame.origin.x+m_oNewsButton.frame.size.width+BUTTON_PADDING*2, 3, buttonWidth, 25);
        
    }
}


#pragma mark - Buttons
- (void)onQuoteButtonPressed{
    [[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDQuote para:nil];
}

- (void)onNewsButtonPressed{
    [[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDNews para:nil];
}

- (void)onStockButtonPressed{
    [[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDStock para:nil];
}

- (void)onBuyButtonPressed{
    isGoToBuyView = YES;
    if(isNewsView){
        [self requestCheckMobileRegisterStatus];
    }else if(!isQuoteView){
        [[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDBuy para:nil];
    }
}

- (void)onSellButtonPressed{
    isGoToBuyView = NO;
    if(isNewsView){
        [self requestCheckMobileRegisterStatus];
    }else if(!isQuoteView){
        [[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDSell para:nil];
    }
}


#pragma mark - Check register status
- (void)requestCheckMobileRegisterStatus{
    
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
    
    NSLog(@"ASIHTTPRequest responseString: %@",result);
    
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
    
    if(isGoToBuyView){
        [[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDBuy para:nil];
        
    }else{
        [[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDSell para:nil];
    }
}

@end