//
//  ConsumerLoanOffersViewController.h
//  BEA
//
//  Created by NEO on 11/14/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface ConsumerLoanOffersViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;
    NSString *consumerLoanPromoUrl;
    NSString *consumerLoanTNCUrl;
    NSString *consumerLoanPromoHotline;
    NSString *consumerLoanBtnLabel;
    NSString *url2;
    NSString *url2label;
    NSString *title;
    NSString *tnc;
//    IBOutlet UIWebView *callwebView;
    IBOutlet UIButton *callButton;
    IBOutlet UIButton *btnTC;
    IBOutlet UIButton *btnShare;
    IBOutlet UIButton *btnBookmark;
    IBOutlet UIButton *btnGotoURL;
	int alert_action;
    
    NSDictionary* merchant_info;
    NSString *functionName, *submenuName;
    Boolean mfirst;
    NSInteger pushType;
    NSString *fromType;
}

@property (retain, nonatomic) IBOutlet UIButton *bookButton;
@property(nonatomic, retain) NSString *functionName, *submenuName;

@property (retain, nonatomic) IBOutlet UIScrollView *contentScroll;
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) NSString *consumerLoanPromoUrl;
@property(nonatomic, retain) NSString *consumerLoanTNCUrl;
@property(nonatomic, retain) NSString *consumerLoanPromoHotline;
@property(nonatomic, retain) NSString *consumerLoanBtnLabel;
@property(nonatomic, retain) NSString *url2;
@property(nonatomic, retain) NSString *url2label;
@property(nonatomic, retain) NSString *tnc_label;
@property(nonatomic, retain) NSString *tnc;
//@property(nonatomic, retain) UIWebView *callwebView;
@property (retain, nonatomic) IBOutlet UIButton *btnGotoURL;

@property(nonatomic, retain) NSDictionary* merchant_info;
@property (nonatomic, retain) NSString *fromType;

//-(IBAction) btInterestRatePressed;
- (IBAction) call;
- (IBAction) openTNC;
//- (id) initWithNibName:(NSString *)nibNameOrNil
//                bundle:(NSBundle *)nibBundleOrNil
//                   url:(NSString*)url
//               hotline:(NSString *)hotline
//              btnLabel:(NSString*)btnLabel
//                   tnc:(NSString*)TNCurl
//                  url2:(NSString*)url2
//             url2label:(NSString*)url2label;

- (id) initWithNibName:(NSString *)nibNameOrNil
                bundle:(NSBundle *)nibBundleOrNil
              merchant:(NSDictionary*)merchant;

- (IBAction)doButtonsPressed:(id)sender;
- (void) hideBookmark;
- (void)setViewControllerPushType:(NSInteger)type;
@end
