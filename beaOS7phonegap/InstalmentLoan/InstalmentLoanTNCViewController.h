//
//  InstalmentLoanTNCViewController.h
//  BEA
//
//  Created by NEO on 01/12/12.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface InstalmentLoanTNCViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UILabel *lbTitle;
	IBOutlet UIWebView *webView;
}
@property(nonatomic, retain)UIWebView *webView;
- (void)goHome;
@end
