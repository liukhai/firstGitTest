//
//  P2PMenuViewController.h
//  BEA
//
//  Created by yaojzy on 24/12/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RotateMenuViewController.h"
#import "MainViewController.h"

@interface P2PMenuViewController : UIViewController
<RotateMenuDelegate, UIWebViewDelegate>
{
    UINavigationController *m_nvc;
    UIView *mv_content;
    RotateMenuViewController* mv_rmvc;
    MainViewController *mvc0, *mvc1, *mvc2;
    BOOL isOtherViewToSettingView;
    NSString *ToSettingView_Url;
}

@property (retain, nonatomic) IBOutlet UIView *mv_content;
@property (nonatomic, retain) UINavigationController *m_nvc;
@property (nonatomic, retain) RotateMenuViewController *mv_rmvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc;
-(void)setSettingURL:(NSString *) _url;
-(void)openBrowserURL:(NSString *) url;
@end
