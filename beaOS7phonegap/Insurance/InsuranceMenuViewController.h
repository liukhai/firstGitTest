//
//  InsuranceMenuViewController.h
//  BEA
//
//  Created by jasen on 17/5/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RotateMenuUtil.h"
#import "RotateMenu2ViewController.h"

@interface InsuranceMenuViewController : UIViewController
<UIScrollViewDelegate,
RotateMenuDelegate>
{
    RotateMenu2ViewController *v_rmvc;
    UINavigationController *m_nvc;
    UIView *mv_content;
    NSInteger puppy;
    NSInteger rotateMenuShowIndex;
}
@property (retain, nonatomic) IBOutlet UIView *mv_content;

@property (retain, nonatomic) IBOutlet RotateMenu2ViewController* v_rmvc;

@property (nonatomic, retain) UINavigationController *m_nvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc;
-(void) welcome;
-(void) welcome:(int)tag;

@end
