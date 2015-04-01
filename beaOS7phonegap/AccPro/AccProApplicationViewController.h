//
//  AccProApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
//#import "AccProRepaymentTableViewController.h"
//#import "AccProTNCViewController.h"

@interface AccProApplicationViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;


}
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, assign) BOOL *isShow;

-(void) btInterestRatePressed;
- (void)goHome;
-(void)webcallToEnquiry:(NSString *)enq_number;
-(void) refreshViewContent;
@end
