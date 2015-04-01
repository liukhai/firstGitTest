//
//  PropertyLoanEnquiryViewController.h
//  BEA
//
//  Created by YAO JASEN on 28/02/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface PropertyLoanEnquiryViewController : UIViewController <MFMailComposeViewControllerDelegate,
UIWebViewDelegate,
ASIHTTPRequestDelegate,
NSXMLParserDelegate>
{
	NSString *ns_service;
	
//    IBOutlet UIView *FirstView;
//	IBOutlet UILabel *lbTitle;
//	
//	IBOutlet UILabel *lbTag00, *lbTag01, *lbTag02;
//	
//    IBOutlet UILabel *lbExcept;
//    IBOutlet UILabel *lbTime02;
//    IBOutlet UILabel *lbTime01;
//    IBOutlet UILabel *lbTag03;
//	IBOutlet UIButton *btCall;
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

// -(IBAction)email;
-(IBAction)callToEnquiry;

@end
