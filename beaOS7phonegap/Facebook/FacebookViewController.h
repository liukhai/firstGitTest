//
//  FacebookViewController.h
//  BEA
//
//  Created by Helen on 14-8-25.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "RotateMenu3ViewController.h"

@class RotateMenu3ViewController;
@interface FacebookViewController : UIViewController<UIWebViewDelegate> {
    
    IBOutlet UIWebView *webView;
    IBOutlet UIScrollView *contentScroll;
    RotateMenu3ViewController *v_rmvc;
    NSURLRequest *urlRequest;
    UINavigationController * v_nav;
}
@property (retain, nonatomic) IBOutlet UIScrollView *contentScroll;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) RotateMenu3ViewController* v_rmvc;
@property (nonatomic, retain) NSURLRequest* urlRequest;
@property (nonatomic, retain) UINavigationController * v_nav;

-(void)setNav:(UINavigationController*)a_nav;
- (void)setUrlRequest:(NSURLRequest *)urlrequest setTitle:(NSString *)title;
@end
