//
//  MPFImportantNoticeViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/06/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "WebViewController.h"
#import "MBKUtil.h"

@interface MPFImportantNoticeViewController : UIViewController<UITabBarDelegate> {
	BOOL isHiddenImportantNotice;
	IBOutlet UIImageView* imageView;
    IBOutlet UIButton *bt_question, *bt_securityTip;
    IBOutlet UIScrollView *scroll_view;
    IBOutlet UIView *text_view;
    NSTimer* timer1;
    IBOutlet UITabBar *tabBar;
    IBOutlet UIView *importantAlertView;
    IBOutlet UIView *btnView;
    IBOutlet UIButton *bt_loginMBK, *bt_callMPFhotline;
    int btnViewY;
    IBOutlet UIButton *bt_understood, *bt_cancel;
    IBOutlet UILabel *disclaimer_title;
    IBOutlet UIButton *start_scrollBtn;
}

@property(nonatomic, retain) IBOutlet UIScrollView *scroll_view;

@property(nonatomic, retain) IBOutlet UIView *text_view;
@property(nonatomic, retain) NSTimer* timer1;
@property(nonatomic, retain) UITabBar *tabBar;
@property (nonatomic, retain) IBOutlet UIView *importantAlertView;
@property (nonatomic, retain) IBOutlet UIView *btnView;
@property(nonatomic, retain) IBOutlet UIButton *bt_loginMBK, *bt_callMPFhotline, *bt_understood, *bt_cancel;

-(IBAction)showMe;
-(IBAction)hiddenMe;
-(IBAction)hiddenMe_goHome;
-(IBAction)hiddenMe_gotoMPF;

-(void)switchMe;

-(IBAction)start_scrollingdown;
-(void)setTexts;

@end