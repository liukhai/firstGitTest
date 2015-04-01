//
//  HotlineCallViewController.h
//  BEA
//
//  Created by yelong on 2/28/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface HotlineCallViewController : UIViewController
<
ASIHTTPRequestDelegate,
UITableViewDelegate,
UITableViewDataSource,
NSXMLParserDelegate
>
{

	IBOutlet UILabel *lb_head, *lb_hotline;

	NSMutableArray *hotlinePhoneNumbers;
	NSMutableArray *hotlineBarItems;
	NSMutableArray *hotlineImgs;
	NSString *hotlineToCall;

    UITableView* table_view;

	NSArray *key;
    UILabel *result;
    NSString *currentAction, *currentElementName, *currentElementValue;
	NSMutableDictionary *temp_record;

}

//-(IBAction) call;

@property (retain, nonatomic) NSArray *hotlinePhoneNumbers, *hotlineBarItems, *hotlineImgs;
@property (retain, nonatomic) NSString *hotlineToCall;

@property (retain, nonatomic) IBOutlet UITableView* table_view;

- (void) getHotlineItems;
- (void) getHotlineDetail;

@end
