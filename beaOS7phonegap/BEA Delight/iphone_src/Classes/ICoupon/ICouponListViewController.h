//
//  ICouponListViewController.h
//  BEA
//
//  Created by Algebra on 13/8/14.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "RotateMenu4ViewController.h"
#import "XMLDictionary.h"
#import "LangUtil.h"

#define Orange_Red @"1"

typedef enum {
    ICouponListStatusCouponList,
    ICouponListStatusRedeemCoupon,
    ICouponListStatusMyCouponList,
    ICouponListStatusUseCouponList
}ICouponListStatus;

@interface ICouponListViewController : UIViewController <UIWebViewDelegate,ASIHTTPRequestDelegate, RotateMenu4ViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,UITextFieldDelegate> {
    
    IBOutlet UITableView *table_view;
    IBOutlet UIWebView *web_view;
    ASIHTTPRequest *asi_request;
}
@property(nonatomic, retain) NSMutableArray *items_data;
@property(nonatomic, assign) ICouponListStatus *toListTag;
@property (retain, nonatomic) IBOutlet UITextField *txf_search;
@property (retain, nonatomic) IBOutlet UIView *view_search;
@property (retain, nonatomic) IBOutlet UIButton *btn_logout;
@property (nonatomic) ICouponListStatus status;
- (IBAction)logout:(id)sender;
- (void)goToLoginPage:(NSString *)couponId;
@end
