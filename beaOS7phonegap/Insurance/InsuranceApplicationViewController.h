//
//  InsuranceApplicationViewController.h
//  BEA
//
//  Created by NEO on 03/01/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface InsuranceApplicationViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView, *pop_webView;
	IBOutlet UILabel *lbTitle;
    IBOutlet UIImageView *lbTitleBackImg;
    UIScrollView *scrollView;
    IBOutlet UIButton *closeButton;
    NSString *webviewindex;

}
@property(nonatomic, retain) UIWebView *webView, *pop_webView;
@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, retain) UIButton *closeButton;
@property(nonatomic, retain) NSString *webviewindex;

-(void) btInterestRatePressed;
- (void)goHome;
-(void)webcallToEnquiry:(NSString *)enq_number;
-(void) btopenInApp:(NSString*)target;
-(IBAction) close_pop_webView;

@end
