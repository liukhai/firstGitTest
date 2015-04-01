//  Amended by jasen on 201307

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface ConsumerLoanEnquiryViewController : UIViewController
<MFMailComposeViewControllerDelegate,
UIWebViewDelegate,
ASIHTTPRequestDelegate,
NSXMLParserDelegate>
{
	NSString *ns_service;
	
//    IBOutlet UIWebView *enqWebView;
    
//	IBOutlet UILabel *lbTitle;
	
//	IBOutlet UILabel *lbTag00, *lbTag01, *lbTag02, *lbTag03, *lbTag04;
	
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
//    IBOutlet UITextView *serviceDetails;
}

//@property(nonatomic, retain) UIWebView *enqWebView;

//-(IBAction)email;
//-(IBAction)callToEnquiry;
//-(void)webcallToEnquiry:(NSString *)enq_number;
//-(void)sendEmailToBEA;

@end
