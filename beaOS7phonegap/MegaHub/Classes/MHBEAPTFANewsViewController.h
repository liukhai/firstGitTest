//
//  MHBEAFANewsViewController.h
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHBEAPTFANewsView;

@interface MHBEAPTFANewsViewController : UIViewController <UITextFieldDelegate> {
	MHBEAPTFANewsView		*m_oMHBEAPTFANewsView;
	NSMutableArray			*m_oNewsGroupTitleArray;
}

- (id)init;
- (void)dealloc;
- (void)loadView;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidUnload;
- (void)reloadText;
- (void)updateWebView;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)onSearchButtonPressed:(id)sender;

@end