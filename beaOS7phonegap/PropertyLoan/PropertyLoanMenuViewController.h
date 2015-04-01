//
//  PropertyLoanMenuViewController.h
//  BEA
//
//  Created by Helen on 15/2/25.
//  Copyright (c) 2015年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RotateMenu2ViewController.h"
#import "RotateMenuUtil.h"
#import "PropertyLoanCalculatorViewController.h"

@class RotateMenu2ViewController;

@interface PropertyLoanMenuViewController : UIViewController<RotateMenuDelegate>
{
    UINavigationController *m_nvc;
    UIView *mv_content;
    RotateMenu2ViewController* mv_rmvc;
    int showIndex;
    UIViewController *mvc0, *mvc1, *mvc2;
}
@property (retain, nonatomic) IBOutlet UIView *mv_content;

@property (nonatomic, retain) UINavigationController *m_nvc;
@property (nonatomic, retain) RotateMenu2ViewController* mv_rmvc;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc;
-(void) welcome;
-(void) showMenu:(int)index;
@end
