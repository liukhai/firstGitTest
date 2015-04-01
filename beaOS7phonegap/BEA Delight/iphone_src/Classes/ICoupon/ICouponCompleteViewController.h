//
//  iCouponCompleteViewController.h
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+MDQRCode.h"
#import "RotateMenu3ViewController.h"
// Views
#import "JBCountdownLabel.h"
#import "UILabel+DynamicFontSize.h"
typedef enum{
    THANKYOU_STYLE_METHOD1 = 1,
    THANKYOU_STYLE_METHOD2 = 2,
    THANKYOU_STYLE_METHOD3 = 3
}THANKYOU_STYLE;

#define     CODE_STYLE_QR  @"QRCode"
#define     CODE_STYLE_BAR @"BarCode"
@interface ICouponCompleteViewController : UIViewController<RotateMenu3ViewControllerDelegate>{
    ASIHTTPRequest *asi_request;
}
@property (retain, nonatomic) RotateMenu4ViewController* v_rmvc;
//Method 1 View
@property (retain, nonatomic) IBOutlet UIView *view_method1;
@property (retain, nonatomic) IBOutlet CachedImageView *imv_icon1;
@property (retain, nonatomic) IBOutlet UILabel *lbl_title1;
@property (retain, nonatomic) IBOutlet UILabel *lbl_subTitle1;
@property (retain, nonatomic) IBOutlet UILabel *lbl_couponId1;
@property (retain, nonatomic) IBOutlet UILabel *lbl_couponTitle;
@property (retain, nonatomic) IBOutlet UIImageView *imv_thanks1;
@property (retain, nonatomic) IBOutlet UILabel *lbl_tranId1;
@property (retain, nonatomic) IBOutlet UIButton *btn_done1;
@property (retain, nonatomic) IBOutlet UILabel *lbl_presentLabel2;



//Method 2 & 3 View
@property (retain, nonatomic) IBOutlet UIScrollView *scv_container;
@property (retain, nonatomic) IBOutlet UIImageView *imv_qrCode;
@property (retain, nonatomic) IBOutlet UIView *view_timerContent;
@property (retain, nonatomic) IBOutlet UIView *view_QR;
@property (retain, nonatomic) IBOutlet UIView *view_QR_linedown;
@property (retain, nonatomic) IBOutlet UIView *view_QR_lineup;
@property (retain, nonatomic) IBOutlet UILabel *lbl_tranId;
@property (retain, nonatomic) IBOutlet UILabel *lbl_couponId;
@property (retain, nonatomic) IBOutlet UIImageView *imv_thanks;
@property (retain, nonatomic) IBOutlet CachedImageView *imv_icon;
@property (retain, nonatomic) IBOutlet UILabel *lbl_title;
@property (retain, nonatomic) IBOutlet UILabel *lbl_subTitle;
@property (retain, nonatomic) IBOutlet UILabel *lbl_description;
@property (retain, nonatomic) IBOutlet UIButton *btn_done;
@property (retain, nonatomic) IBOutlet UIView *view_qrFrame;
@property (retain, nonatomic) IBOutlet UILabel *lbl_presentLabel;





//Assign Value
@property (retain, nonatomic) NSDictionary *data_couponDetails;
@property (retain, nonatomic) NSDictionary *data_response;
@property (assign, nonatomic) NSString *codeType;
@property (assign, nonatomic) THANKYOU_STYLE style;
@property (copy, nonatomic) NSNumber *remainTime;
- (IBAction)back_onTouch:(id)sender ;
@end
