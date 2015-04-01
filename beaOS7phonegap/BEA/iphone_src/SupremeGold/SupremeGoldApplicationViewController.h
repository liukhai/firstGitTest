//
//  SupremeGoldApplicationViewController.h
//  BEA
//
//  Created by Ledp944 on 14-9-3.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface SupremeGoldApplicationViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;
    
    
}
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, assign) BOOL *isShow;


-(void) btInterestRatePressed;
- (void)goHome;
-(void)webcallToEnquiry:(NSString *)enq_number;
@end
