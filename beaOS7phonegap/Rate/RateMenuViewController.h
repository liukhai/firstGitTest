//
//  RateMenuViewController.h
//  BEA
//
//  Created by yaojzy on 15/5/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RateNoteViewController.h"
#import "RateTTViewController.h"
#import "RatePrimeViewController.h"

#import "RotateMenuUtil.h"
#import "RotateMenu2ViewController.h"

@class RotateMenu2ViewController;

@interface RateMenuViewController : UIViewController
<RotateMenuDelegate>
{
    RotateMenu2ViewController *v_rmvc;
    UINavigationController *m_nvc;
    UIViewController *mvc0;
    UIView *mv_content;
    int menuTag;
}

@property (retain, nonatomic) IBOutlet UIView *mv_content;
@property (retain, nonatomic) IBOutlet RotateMenu2ViewController* v_rmvc;

@property (nonatomic, retain) UINavigationController *m_nvc;
@property (nonatomic, assign) int menuTag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc;
-(void) welcome;
-(void) welcome:(int)tag;

@end
