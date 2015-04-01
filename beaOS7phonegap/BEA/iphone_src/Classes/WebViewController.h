//
//  WebViewController.h
//  BEA
//
//  Created by Algebra Lo on 10年6月27日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "RotateMenu3ViewController.h"
@class RotateMenu3ViewController;

@interface WebViewController : UIViewController <UIWebViewDelegate> {
	IBOutlet UIWebView *web_view;
    RotateMenu3ViewController *v_rmvc;
    NSURLRequest* urlRequest;
    UINavigationController * v_nav;
}

@property (nonatomic, assign) IBOutlet UIWebView *web_view;
@property (nonatomic, retain) RotateMenu3ViewController* v_rmvc;
@property (nonatomic, retain) NSURLRequest* urlRequest;
@property (nonatomic, retain) UINavigationController * v_nav;

-(void)setNav:(UINavigationController*)a_nav;

@end
