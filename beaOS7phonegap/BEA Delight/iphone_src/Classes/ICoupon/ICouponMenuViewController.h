//
//  ICouponMenuViewController.h
//  BEA
//
//  Created by Keith Wong on 6/10/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotateMenu4ViewController.h"
#import "ICouponListViewController.h"
@interface ICouponMenuViewController : UIViewController<UINavigationControllerDelegate>
//for add icoupon title by chu - 20150216
@property (retain, nonatomic) IBOutlet UILabel *lb_pagetitle;
@property (retain, nonatomic) IBOutlet UIButton *but_fullList;
@property (retain, nonatomic) IBOutlet UIButton *but_mywallet;
@property (retain, nonatomic) IBOutlet UILabel *lbl_fullList;
@property (retain, nonatomic) IBOutlet UILabel *lbl_myWallet;

@end
