//
//  LTApplicationViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/15/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBKUtil.h"
#import "ASIHTTPRequest.h"
#import "CoreData.h"
#import "LTApplicationResultViewController.h"
#import "LTApplicationResultFailViewController.h"
#import "LTUtil.h"

@interface LTApplicationViewController : UIViewController <UITextFieldDelegate, NSXMLParserDelegate,ASIHTTPRequestDelegate>{
	IBOutlet UITextField *tfName, *tfMobileno, *tfEmail, *tfLoanAmount;
	IBOutlet UIButton *btNamePre, *btLoanPlanGeneralCustomers, *btLoanPlanProfessionals, *btRepaymentPeriod12, *btRepaymentPeriod18;
	//IBOutlet UIButton *btNamePre, *btRepaymentPeriod12, *btRepaymentPeriod18;

	NSMutableArray *items_data;
	NSMutableDictionary *temp_record;
	NSArray *key;
	NSString *currentElementName, *currentElementValue;
    IBOutlet UIScrollView *scroll_view;
    IBOutlet UIView *contentView;
	IBOutlet UILabel *lbTitle;

	IBOutlet UILabel *lbTag00, *lbTag01, *lbTag02, *lbTag03, *lbTag04, *lbTag05, *lbTag06, *lbTag07, *lbTag08;
	IBOutlet UIButton *btCall, *btClear, *btSubmit, *btCheck, *btStatement;
	
	NSArray *namePre_list;
	int namePre_index;
	
	NSNumberFormatter *numberFormatter;

	NSString *ls_loanPlan;
	NSString *ls_repaymentPeriod;
	
	
}
@property(nonatomic, retain) NSString *ls_loanPlan;
@property(nonatomic, retain) NSString *ls_repaymentPeriod;

@property(nonatomic, retain) UIView *contentView;

@property(nonatomic, retain) NSNumberFormatter *numberFormatter;

@property(nonatomic, retain) NSArray *namePre_list;

@property(nonatomic, retain) IBOutlet UIScrollView *scroll_view;

-(IBAction)screenPressed;
-(IBAction)submitButtonPressed;

-(IBAction)btLoanPlanGeneralCustomersPressed;
-(IBAction)btLoanPlanProfessionalsPressed;
-(IBAction)btRepaymentPeriod12Pressed;
-(IBAction)btRepaymentPeriod18Pressed;
-(IBAction)btNamePrePressed;
-(IBAction)btClearPressed;

-(IBAction)call;
//-(void)queryFromKeypad:(UIButton *) btnQuery;
-(IBAction)btCheckPressed;
-(BOOL)validateFormValue;
-(IBAction)btStatementPressed:(id)sender;

-(IBAction)didEndEditName:(id)sender;
-(IBAction)didEndEditMobileNo:(id)sender;
-(IBAction)didEndEditEmail:(id)sender;
-(IBAction)didEndEditLoanAmount:(id)sender;

-(IBAction) didBeginEditName:(id)sender;
-(IBAction) didBeginEditMobileNo:(id)sender;
-(IBAction) didBeginEditEmail:(id)sender;

-(IBAction)setAmount;

@end
