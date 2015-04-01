//
//  ICouponDetailViewController.h
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotateMenu3ViewController.h"
#import "CachedImageView.h"
@class CachedImageView;
@interface ICouponDetailViewController : UIViewController<RotateMenu4ViewControllerDelegate,UIWebViewDelegate>{
    ASIHTTPRequest *asi_request;
    ASIHTTPRequest *asi_request_redeem;
}

@property (retain, nonatomic) NSDictionary *data;
@property (retain, nonatomic) IBOutlet CachedImageView *imv_bigIcon;
@property (retain, nonatomic) IBOutlet CachedImageView *imv_smallIcon;
@property (retain, nonatomic) IBOutlet UILabel *lbl_title;
@property (retain, nonatomic) IBOutlet UILabel *lbl_subTitle;
@property (retain, nonatomic) IBOutlet UILabel *lbl_bonus;
@property (retain, nonatomic) IBOutlet UILabel *lbl_itemNo;
@property (retain, nonatomic) IBOutlet UIView *view_remark;
@property (retain, nonatomic) IBOutlet UITextView *txv_remark;
@property (retain, nonatomic) IBOutlet UILabel *lbl_remark;
@property (retain, nonatomic) IBOutlet UIView *view_webContent;

@property (retain, nonatomic) IBOutlet UIButton *btn_back;
@property (retain, nonatomic) IBOutlet UIButton *btn_redeem;

- (IBAction)back_onTouch:(id)sender;
- (IBAction)redeem_onTouch:(id)sender;

@end
