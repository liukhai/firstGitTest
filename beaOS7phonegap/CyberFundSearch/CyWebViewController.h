//
//  CyWebViewController.h
//  BEA
//
//  Created by Joseph on 4/21/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyWebViewController : UIViewController<UIWebViewDelegate>{
     NSURLRequest* urlRequest;
}
@property (retain, nonatomic) IBOutlet UIWebView *webView;

- (void)setUrlRequest:(NSURLRequest *)urlrequest;
@end
