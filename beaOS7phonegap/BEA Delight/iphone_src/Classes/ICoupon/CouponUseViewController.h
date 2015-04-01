//
//  CouponUseViewController.h
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLabel.h"
#import "RotateMenu3ViewController.h"
#import "ZBarSDK.h"
#import "QRCodeScannerViewController.h"
#import "CachedImageView.h"
#import "SKSTableView.h"
typedef enum {
    ICouponUseMethodOne = 1,
    ICouponUseMethodTwo = 2,
    ICouponUseMethodThree = 3
}ICouponUseMethod;
typedef enum {
    ICouponUseStatusUseCoupon,
    ICouponUseStatusQRConfirmUse,
    IcouponUseStatusFinishUse
}ICouponUseStatus;

@interface CouponUseViewController : UIViewController<RTLabelDelegate,RotateMenu4ViewControllerDelegate,ZBarReaderDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,didQRScannedDelegate,SKSTableViewDelegate,UIWebViewDelegate,UIAlertViewDelegate>
{
    int num;
    BOOL upOrdown;
    
    ASIHTTPRequest *asi_request_detail;
}
//Main Views
@property (retain, nonatomic) IBOutlet CachedImageView *imv_icon;
@property (retain, nonatomic) IBOutlet CachedImageView *imv_icon2;
@property (retain, nonatomic) IBOutlet UILabel *lbl_title;
@property (retain, nonatomic) IBOutlet UILabel *lbl_subTitle;
@property (retain, nonatomic) IBOutlet UILabel *lbl_expiryDate;
@property (retain, nonatomic) IBOutlet UIView *viewrc_steps;
@property (retain, nonatomic) IBOutlet UIView *viewrc_notes;
@property (retain, nonatomic) IBOutlet UIView *view_remark;
@property (retain, nonatomic) IBOutlet UIButton *btn_back;
@property (retain, nonatomic) IBOutlet SKSTableView *sktbv_stepNotes;
@property (retain, nonatomic) IBOutlet UIButton *btn_useNow;
@property (retain, nonatomic) IBOutlet UIWebView *wv_backgroundLogin;

//Passed from My wallet data.
@property (retain, nonatomic) NSDictionary *data;



- (IBAction)useNow_onTouch:(id)sender;
- (IBAction)back_onTouch:(id)sender;


//Note Views
@property (retain, nonatomic) IBOutlet UITextView *txv_remark;
@property (retain, nonatomic) IBOutlet UILabel *lbl_remark;
@property (retain, nonatomic) IBOutlet UIView *view_notes;
@property (retain, nonatomic) IBOutlet UIButton *btn_close;
@property (retain, nonatomic) IBOutlet UIWebView *wv_notes;
@property (retain, nonatomic) IBOutlet UIScrollView *scv_noteContent;
- (IBAction)close_onTouch:(id)sender;


@end


