//
//  ConsumerLoanApplicationViewController.h
//  BEA
//
//  Created by NEO on 11/14/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface ConsumerLoanApplicationViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;


}
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, assign) BOOL *isShow;

-(void) btInterestRatePressed;
- (void)goHome;
-(void)webcallToEnquiry:(NSString *)enq_number;
@end
