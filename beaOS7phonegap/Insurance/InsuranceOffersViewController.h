//
//  InsuranceOffersViewController.h
//  BEA
//
//  Created by NEO on 03/01/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface InsuranceOffersViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView, *pop_webView;
	
	IBOutlet UILabel *lbTitle;
    IBOutlet UIImageView *lbTitleBackImg;
    NSString *InsurancePromoUrl;
    IBOutlet UIButton *callButton, *closeButton;
    IBOutlet UIButton *applyButton;
    NSString *InsuranceHotline;
    NSString *buttonCaption;
    NSString *webviewindex;
    BOOL *notFirst;
    RotateMenu2ViewController* v_rmvc;
}
@property(nonatomic, retain) UIWebView *webView, *pop_webView;
@property(nonatomic, retain) NSString *InsurancePromoUrl;
@property(nonatomic, retain) NSString *InsuranceHotline;
@property(nonatomic, retain) NSString *buttonCaption;
@property(nonatomic, retain) NSString *webviewindex;
@property(nonatomic, retain) UIButton *callButton, *closeButton;
@property(nonatomic, assign) int show;
@property (retain, nonatomic) IBOutlet UIScrollView *contentScroll;
- (IBAction) call;
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString*)url;
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString*)url hotline:(NSString*)hotline caption:(NSString*)caption;
-(void) btopenInApp:(NSString*)target;
-(IBAction) close_pop_webView;
@end
