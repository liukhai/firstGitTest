//
//  BasePromotion.h
//  BEA
//
//  Created by NEO on 14/03/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "MBKUtil.h"
#import "WebViewController.h"

@interface BasePromotion : UIViewController <UIWebViewDelegate>{
	BOOL isHiddenImportantNotice;
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *closeBtn;
}
@property(nonatomic, retain)UIWebView *webView;

-(void)showMe;
-(IBAction)hiddenMe;
-(void)switchMe;
-(void)saveCount;
-(IBAction)hiddenMeAndOpenAccpro;

@end