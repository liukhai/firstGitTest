//
//  AccProEnquiryViewController.h
//  BEA
//
//  Created by NEO on 06/16/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface AccProEnquiryViewController : UIViewController
<
MFMailComposeViewControllerDelegate,
UIWebViewDelegate,
NSXMLParserDelegate
>
{
	NSString *ns_service;
	
//    IBOutlet UIWebView *enqWebView;
//    
//	IBOutlet UILabel *lbTitle;
//	
//	IBOutlet UILabel *lbTag00, *lbTag01, *lbTag02, *lbTag03, *lbTag04;
//	
//	IBOutlet UIButton *btEmail, *btCall;

	NSMutableArray *items_data;
	NSArray *key;
	NSArray *key_sub;
	NSString *currentAction, *currentElementName, *currentElementValue;
	NSMutableDictionary *temp_record;
	NSMutableDictionary *temp_record_sub;
    BOOL isItem;
    BOOL isSubitem;
	NSMutableArray *temp_groups;
	NSMutableArray *temp_groups_items;
	NSMutableDictionary *temp_groups_item;
	NSMutableDictionary *temp_groups_item_sub;

    IBOutlet UIScrollView *contentView;
}

//@property(nonatomic, retain) UIWebView *enqWebView;

//-(IBAction)email;
//-(IBAction)callToEnquiry;
//-(void)webcallToEnquiry:(NSString *)enq_number;
//-(void)sendEmailToBEA:(NSString*) mailto;
-(void) refreshViewContent;

@end
