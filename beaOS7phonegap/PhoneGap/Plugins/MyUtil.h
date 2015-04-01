//  Created by yaojzy on 201307.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AssetsLibrary/ALAssetsLibrary.h>

#import "MainViewController.h"

@interface MyUtil : NSObject
<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIWebViewDelegate,
NSURLConnectionDelegate,
ABPeoplePickerNavigationControllerDelegate>
{
    MainViewController* mainVC;
    UIViewController* testVC;
    UIButton* btn_close;
    UIButton* btn_print;
    UIWebView *webView_4print;
    NSString* firstName;
    NSString* phoneNumber;
    CDVInvokedUrlCommand* msgcommand;
}

@property(nonatomic, retain) MainViewController* mainVC;
@property(nonatomic, retain) UIViewController* testVC;
@property(nonatomic, retain) UIButton* btn_close;
@property(nonatomic, retain) UIButton* btn_print;
@property(nonatomic, retain) UIWebView* webView_4print;
@property(nonatomic, retain) NSString* firstName;
@property(nonatomic, retain) NSString* phoneNumber;
@property(nonatomic, retain) CDVInvokedUrlCommand* msgcommand;


+(MyUtil*) me;
- (void)do_print_pdf;
- (void)do_airprint;
- (void)showPDFOnScreen;
- (void)do_print_pdf2:(UIWebView*)contentView;
- (void)do_print_pdf:(NSString*)content;
- (void)do_gotoMBK;
- (void)accessUATserver;
- (NSString*)do_getPhoneNum;
- (void)showScreenCaptureOnScreen;
- (NSString*)do_getNameByMobileNo:(NSString*)content;
- (NSString*)do_getPhoneNumbers;

@end
