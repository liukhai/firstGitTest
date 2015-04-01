//
//  WebViewController2.h
//  BEA
//
//  Created by Joseph on 3/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "RotateMenu3ViewController.h"
@class RotateMenu3ViewController;
@interface WebViewController2 : UIViewController <UIWebViewDelegate> {
	IBOutlet UIWebView *web_view;
    RotateMenu3ViewController *v_rmvc;
    NSURLRequest* urlRequest;
    UINavigationController * v_nav;
    NSString * mTitle;
}

@property (nonatomic, assign) IBOutlet UIWebView *web_view;
@property (nonatomic, retain) RotateMenu3ViewController* v_rmvc;
@property (retain, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (nonatomic, retain) NSURLRequest* urlRequest;
@property (nonatomic, retain) UINavigationController * v_nav;

-(void)setNav:(UINavigationController*)a_nav;
- (void)setUrlRequest:(NSURLRequest *)urlrequest setTitle:(NSString *)title;

@end
