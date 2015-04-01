//
//  ConsumerLoanMenuViewController.h
//  BEA
//
//  Created by yaojzy on 17/5/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RotateMenuUtil.h"
#import "RotateMenu2ViewController.h"

#import "TaxLoanEnquiryViewController.h"

@class RotateMenu2ViewController;

@interface ConsumerLoanMenuViewController : UIViewController
<RotateMenuDelegate>
{
    UINavigationController *m_nvc;
    UIView *mv_content;
    RotateMenu2ViewController* mv_rmvc;
    UIViewController *mvc0, *mvc1, *mvc2;
    int showIndex;
}
@property (retain, nonatomic) IBOutlet UIView *mv_content;

@property (nonatomic, retain) UINavigationController *m_nvc;
@property (nonatomic, retain) RotateMenu2ViewController* mv_rmvc;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc;
-(void) welcome;
-(void) showMenu:(int)index;

@end
