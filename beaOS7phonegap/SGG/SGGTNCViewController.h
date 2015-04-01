//
//  SGGTNCViewController.h
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface SGGTNCViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
    IBOutlet UILabel *lbTitle;
}

@property(nonatomic, retain) UIWebView *webView;

- (void)goHome;
@end
