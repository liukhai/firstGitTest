//
//  LTTNCViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "LTOffersViewController.h"

@interface LTTNCViewController : UIViewController {
	IBOutlet UILabel *lbTitle;
	IBOutlet UIWebView *webView;
}
@property(nonatomic, retain)UIWebView *webView;

@end
