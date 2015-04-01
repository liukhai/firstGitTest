//
//  CardLoanApplyFormView.h
//  BEA
//
//  Created by Jeff Cheung on 11年3月28日.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CoreData.h"
#import "CardLoanPDFViewContoller.h"
#import "MBKUtil.h"
#import "subViewController.h"

@interface CardLoanApplyFormViewController : UIViewController
<UIAlertViewDelegate, MFMailComposeViewControllerDelegate, NSXMLParserDelegate,
UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>
{
	IBOutlet UILabel *title_label, *salutation_label, *apply_express_label, *call_now_label, *office_time_label, *please_label;
	IBOutlet UILabel *name_label, *mobile_label, *email_label, *loan_value_label, *repay_label, *terms_label, *announce_label;
    IBOutlet UILabel *announce_label2;
    IBOutlet UIButton *announce_btn2;
	IBOutlet UIButton *month12_btn, *month24_btn, *month36_btn, *month48_btn, *checkBox_btn, *clear_btn, *submit_btn;
	int salutation_index;
	BOOL up_boolean;
	IBOutlet UITextField *name_textfield, *mobile_textfield, *email_textfield, *loan_value_textfield;
	UITextField *current_textfield;
	UIAlertView *call_now_alert;
	IBOutlet UIScrollView *bg_scrollview;
	UITapGestureRecognizer *tapRecognizer;
    IBOutlet UIImageView *imageView1;
    IBOutlet UIView *backgdView;
    IBOutlet UIImageView *imageView2;
    
    IBOutlet UIView *namebgView;
    IBOutlet UIView *numberbgView;
    IBOutlet UIView *loanbgView;

	
    NSString *month_value;
	NSDictionary *merchant_info;
	
	IBOutlet UIButton *announce_button;
	
	//copy code jeff
	NSMutableArray *items_data;
	NSMutableDictionary *temp_record;
	NSArray *key;
	NSString *currentElementName;
	
	IBOutlet UIView *email_sent_view;
	IBOutlet UIButton *email_sent_ok_button;
	IBOutlet UITextView *email_sent_textview;
	IBOutlet UILabel *email_sent_label;
	IBOutlet UILabel *email_sent_contact_label;

	BOOL showBookmark;
	
	IBOutlet UIView *email_fail_view;
	IBOutlet UIButton *email_fail_button;
	IBOutlet UITextView *email_fail_textview;
	IBOutlet UILabel *email_fail_label;
//	IBOutlet UILabel *email_sent_label;
//	IBOutlet UILabel *email_sent_contact_label;
    
    
    IBOutlet UIButton *btn_repaymentPoriod;
    UIPickerView* pickerView;
    NSArray *list_repaymentPoriod_number;
    NSArray *list_repaymentPoriod_name;
    NSString* selected_repaymentPoriod_index;
    NSMutableArray *selectNameArr;
}

//-(IBAction)pressMonthButton:(UIButton*)button;
-(IBAction)clickCheckBox:(UIButton*)button;
-(IBAction)pressSalutationButton:(UIButton*)button;
-(IBAction)pressClearButton:(UIButton*)button;
-(IBAction)pressSubmitButton:(UIButton*)button;
-(IBAction)pressCallNowButton:(UIButton*)button;
-(void)handle_error_alert:(NSString*)message;
-(IBAction)pressAnnounceButton:(UIButton*)button;
-(IBAction)pressEmailSentOKButton:(UIButton*)button;
-(IBAction)pressEmailFailButton:(UIButton*)button;

-(IBAction)pressRepaymentPoriod:(UIButton*)button;

@property (nonatomic, assign) NSDictionary *merchant_info;
@property (nonatomic, retain) NSString *fromType;
//jeff
@property (nonatomic, assign) BOOL showBookmark;
@property (nonatomic, retain) NSArray* list_repaymentPoriod_number;
@property (nonatomic, retain) NSArray* list_repaymentPoriod_name;
@property (nonatomic, retain) UIButton *btn_repaymentPoriod;
@property (nonatomic, retain) NSString* selected_repaymentPoriod_index;
@property (nonatomic, retain) UIPickerView* pickerView;
@property (nonatomic, retain) NSMutableArray *selectNameArr;
@property (retain, nonatomic) IBOutlet UIButton *selectName;
@property (retain, nonatomic) UIView *customView;
- (IBAction)showSelectedName:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *repaymentBtn;
@property (retain, nonatomic) IBOutlet UIButton *callNowBtn;
@property (retain, nonatomic) IBOutlet UIButton *clear_btn;
@property (retain, nonatomic) IBOutlet UIButton *submit_btn;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *contactLabel;
@property (retain, nonatomic) subViewController *subVC;
@end
