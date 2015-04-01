    //
//  MHBEAFANewsViewController.m
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAPTFANewsViewController.h"
#import "MHNumberKeyboardView.h"
#import "MHBEAPTFANewsView.h"
#import "MHPickerTextField.h"
#import "MHFeedConnectorX.h"
#import "StyleConstant.h"
#import "MHUtility.h"

@implementation MHBEAPTFANewsViewController

- (id)init {
	self = [super init];
	if (self != nil) {
		m_oNewsGroupTitleArray = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc {
	[m_oNewsGroupTitleArray release];
    [m_oMHBEAPTFANewsView release];
	[super dealloc];
}

- (void)loadView {
	m_oMHBEAPTFANewsView = [[MHBEAPTFANewsView alloc] initWithFrame:CGRectMake(0, 94, 320, [MHUtility getAppHeight]-15-31-94)];
	self.view = m_oMHBEAPTFANewsView;
    
    [m_oNewsGroupTitleArray addObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.all", nil, MHLanguage_BEAString)]];
    [m_oNewsGroupTitleArray addObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.overview", nil, MHLanguage_BEAString)]];
    [m_oNewsGroupTitleArray addObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.market", nil, MHLanguage_BEAString)]];
    [m_oNewsGroupTitleArray addObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.overseas", nil, MHLanguage_BEAString)]];
    [m_oNewsGroupTitleArray addObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.commentary", nil, MHLanguage_BEAString)]];
   
    [m_oMHBEAPTFANewsView.m_oNewsGroupTextField setUserInteractionEnabled:YES];
	[m_oMHBEAPTFANewsView.m_oNewsGroupTextField set_pickerDataSource:m_oNewsGroupTitleArray];
	[m_oMHBEAPTFANewsView.m_oNewsGroupTextField set_selectRow:0];
	
	[m_oMHBEAPTFANewsView.m_oSearchButton addTarget:self action:@selector(onSearchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[m_oMHBEAPTFANewsView.m_oNewsGroupTextField addTarget:self doneAction:@selector(updateWebView)];
	[m_oMHBEAPTFANewsView.m_oStockSymbolTextField setDelegate:self];
    
}

- (void)viewDidLoad {
	[super viewDidLoad];
    [self updateWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadText];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	[m_oMHBEAPTFANewsView release];
	m_oMHBEAPTFANewsView = nil;
}

- (void)reloadText {
    
    [m_oNewsGroupTitleArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.all", nil, MHLanguage_BEAString)]];
    [m_oNewsGroupTitleArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.overview", nil, MHLanguage_BEAString)]];
    [m_oNewsGroupTitleArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.market", nil, MHLanguage_BEAString)]];
    [m_oNewsGroupTitleArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.overseas", nil, MHLanguage_BEAString)]];
    [m_oNewsGroupTitleArray replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@", MHLocalizedStringFile(@"MHBEAPTFANewsViewController.m_oMHFeedXObjNewsGroupArray.commentary", nil, MHLanguage_BEAString)]];
    [m_oMHBEAPTFANewsView.m_oNewsGroupTextField set_selectRow:0];
    
    [m_oMHBEAPTFANewsView reloadText];
    [self updateWebView];
}

#pragma mark -
#pragma mark UpdateFunctions
- (void)updateWebView {
	int selectedRow = [m_oMHBEAPTFANewsView.m_oNewsGroupTextField get_selectRow];
	NSString *grpID = [NSString stringWithFormat:@"%d", selectedRow];
    
    NSString *urlString = [[MHFeedConnectorX sharedMHFeedConnectorX] urlNewsStyle:PT_WEBVIEW_STYLE
                                                                         language:[MHLanguage getCurrentLanguage]
                                                                           source:@"4"
                                                                            group:grpID
                                                                            stock:m_oMHBEAPTFANewsView.m_oStockSymbolTextField.text
                                                                           action:@"-1"
                                                                          version:URL_VERSION_1_0
                                                                                v:nil];

	[m_oMHBEAPTFANewsView loadURLString:urlString];
}


#pragma mark -
#pragma mark UITextField Delegate Functions 
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if ([textField isEqual:m_oMHBEAPTFANewsView.m_oStockSymbolTextField]) {
		[MHNumberKeyboardView setDecimalPlace:0];
		return [MHNumberKeyboardView show:textField];
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	[MHNumberKeyboardView dismiss];
	
	[self updateWebView];
	
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	[textField resignFirstResponder];
	[MHNumberKeyboardView dismiss];
	[self updateWebView];	
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	int newLen = range.location + range.length;
	return newLen<=5;
}

#pragma mark -
#pragma mark Button callback Functions
- (void)onSearchButtonPressed:(id)sender {
	[MHNumberKeyboardView dismiss];
	[self updateWebView];	
}

@end