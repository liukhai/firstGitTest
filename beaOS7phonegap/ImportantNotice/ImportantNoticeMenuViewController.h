//  Created by Jasen on 201308

#import <UIKit/UIKit.h>
#import "RotateMenu2ViewController.h"
#import "ImportantNoticeContentViewController.h"

@interface ImportantNoticeMenuViewController : UIViewController
<NSXMLParserDelegate,
RotateMenuDelegate>
{
    RotateMenu2ViewController* mv_rmvc;
    UINavigationController *m_nvc;
    UIView *mv_content;
    
    NSMutableArray *items_data;
	NSMutableDictionary *temp_record;
	NSString *currentElementName;

    ImportantNoticeContentViewController *content_faq, *content_security, *contect_accessibility;
    NSString* urlcurrent, *urlfaq, *urlsecurity, *step;
	NSArray *key;
    int mTag;
}

@property (nonatomic, retain) UINavigationController *m_nvc;
@property (retain, nonatomic) IBOutlet UIView *mv_content;

@property(nonatomic, retain) NSMutableArray *items_data;
@property(nonatomic, retain) NSString* urlcurrent, *urlfaq, *urlsecurity, *step, *urlacc;
@property(nonatomic, retain) NSArray *key;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc;
-(void) welcome:(int)tag;

@end
