//
//  SettingViewController.h
//  BEA
//
//  Created by Algebra Lo on 10年6月27日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "Base64.h"
#import "PlistOperator.h"
#import "RotateMenuViewController.h"
#import "RotateMenu2ViewController.h"
#import "PageUtil.h"

@interface SettingViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
	
	IBOutlet UILabel *title_label, *setting_language, *setting_default_page, *setting_page_theme;
	IBOutlet UIScrollView *scroll_view;
	IBOutlet UITextView *cyberbanking_title, *cybertrading_title, *cyberbanking_text, *cybertrading_text3, *cybertrading_text4;
	IBOutlet UIButton *cyberbanking_button, *cybertrading_button, *save_button, *save_button02;
	IBOutlet UITextField *cyberbanking_input, *cybertrading_input;
    IBOutlet UILabel *cyberbanking_input_label;
    IBOutlet UILabel *cybertrading_input_label;
    BOOL isScrollButtom;
    IBOutlet UILabel *mVersionLabel;
    IBOutlet UILabel *mCopright;

    
    IBOutlet UIImageView *CyberbankingSBackImg;
    IBOutlet UIImageView *CyberbankingSBottomImg;
    IBOutlet UIImageView *cybertradingSBackImg;
    IBOutlet UITextView *cybertrading_text;
    
    IBOutlet UIImageView *cybertradingSBottomImg;
    int EntranceType; //入口类型 3 为p2p 进来的
    IBOutlet UIImageView *Img1;
    IBOutlet UIImageView *Img2;
    IBOutlet UILabel *notification_label;
    IBOutlet UIButton *notification_on;
    IBOutlet UIButton *notification_off;
    
    BOOL cyberbanking_input_no_mobile, cybertrading_input_no_mobile;
}

-(void)checkTextColor;
-(IBAction)saveButtonPressed:(UIButton *)button;
-(IBAction)saveButtonPressed02:(UIButton *)button;
-(IBAction)screenPressed;
@property BOOL isScrollButtom;
@property (retain, nonatomic) IBOutlet UIButton *btnLang_en;
@property (retain, nonatomic) IBOutlet UIButton *btnLang_zh;
@property (retain, nonatomic) IBOutlet UIButton *btnDefaultPage_1;
@property (retain, nonatomic) IBOutlet UIButton *btnDefaultPage_2;
@property (retain, nonatomic) IBOutlet UIButton *btnDefaultPage_3;
@property (retain, nonatomic) IBOutlet UIButton *btnPageTheme_1;
@property (retain, nonatomic) IBOutlet UIButton *btnPageTheme_2;
@property (retain, nonatomic) IBOutlet UIButton *btnDefaultAccount_1;
@property (retain, nonatomic) IBOutlet UIButton *btnDefaultAccount_2;
@property (retain, nonatomic) IBOutlet UIButton *btnDefaultAccount_1BigBtn;
@property (retain, nonatomic) IBOutlet UIButton *btnDefaultAccount_2BigBtn;
@property (retain, nonatomic) IBOutlet UILabel *lbDefaultAccount_1;
@property (retain, nonatomic) IBOutlet UILabel *lbDefaultAccount_2;
@property (retain, nonatomic) IBOutlet UIView *view4MobileBanking;
@property (retain, nonatomic) IBOutlet UIView *view4EAS;
@property (retain, nonatomic) IBOutlet UIView *view4Lang;
@property (retain, nonatomic) IBOutlet UIView *view4Part1;
@property (retain, nonatomic) IBOutlet UIView *view4Part2;
@property (retain, nonatomic) IBOutlet UIView *view4Version;
@property (nonatomic, assign) int EntranceType;
@property (nonatomic, retain) NSString *fromWhere;
- (IBAction)changeLang:(UIButton*)sender;
- (IBAction)changeDefaultPage:(UIButton*)sender;
- (IBAction)changePageTheme:(UIButton *)sender;
- (IBAction)changeDefaultAccount:(UIButton*)sender;
- (void) scrollToBottom;
- (void)scrollCybertradingTextFieldToTop;
@end
