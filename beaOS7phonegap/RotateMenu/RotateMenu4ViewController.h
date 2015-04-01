//
//  RotateMenu4ViewController.h
//  BEA
//
//  Created by Algebra on 13/8/14.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RotateMenu4ViewControllerDelegate <NSObject>
@optional
-(void)doMenuButtonsPressed:(UIButton *)sender;
@end

#import "CoreData.h"
#import "RotateMenuUtil.h"

#define Orange_Red @"1"

@class RotateMenuUtil;

@interface RotateMenu4ViewController : UIViewController
{
    UIView *contentView;
    UIButton *btnmenu0;
    UIButton *btnmenu1;
    UIButton *btnmenu2;
    UIScrollView *svmenu;
    RotateMenuUtil* rmUtil;
    UIButton *btnHome;
    UIButton *btnSidemenu;
    UIButton *btnMore;
    UIButton *btnBack;
    UIImageView *image_bg;
    UIViewController <RotateMenu4ViewControllerDelegate> *vc_caller;
}

@property (retain, nonatomic) IBOutlet UIView *contentView;

@property (retain, nonatomic) IBOutlet UIView *view_features;
@property (retain, nonatomic) IBOutlet UIButton *btnHome;
@property (retain, nonatomic) IBOutlet UIButton *btnmenu0;
@property (retain, nonatomic) IBOutlet UIButton *btnmenu1;
@property (retain, nonatomic) IBOutlet UIButton *btnmenu2;
@property (retain, nonatomic) IBOutlet UIScrollView *svmenu;
@property (retain, nonatomic) IBOutlet UIImageView *image_bg;

@property (retain, nonatomic) RotateMenuUtil* rmUtil;

@property (retain, nonatomic) IBOutlet UIButton *btnSidemenu;
@property (retain, nonatomic) IBOutlet UIButton *btnMore;
@property (retain, nonatomic) IBOutlet UIButton *btnBack;
@property (retain, nonatomic) IBOutlet UILabel *lbl_coupon;

@property (retain, nonatomic) UIViewController <RotateMenu4ViewControllerDelegate> *vc_caller;
@property (assign, nonatomic) NSString *rightOrLeft;
@property (assign, nonatomic) NSString *pageStyle;

//edit by chu 20150217
-(void) refreshMenu;
-(void) setSelectedMenu:(UIButton *)sender;
-(void) changePageTheme:(NSNotification *)notification;
@end
