//  Created by jasen on 201307

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface EnquiryCellViewController : UIViewController
<MFMailComposeViewControllerDelegate,UITextViewDelegate>
{
	NSString *ns_service;
    NSString *nsTitle, *nsEmail, *nsCall, *nsService, *nsSubject, *nsFax;
    UIViewController* navvc;
	IBOutlet UILabel *lbTitle;
	IBOutlet UIButton *btnEmail, *btnCall;
	IBOutlet UILabel *tvServiceDetails;
    IBOutlet UIView *v_content;
    IBOutlet UIImageView *mTime;
    
    IBOutlet UIImageView *mPhone;
    IBOutlet UIImageView *mBackgroudImg;
    IBOutlet UIImageView *mBorderLine;
    CGRect frame;
    IBOutlet UIImageView *mBottomImg;
    IBOutlet UIView *fitView;
    IBOutlet UIImageView *mTopLine;
}

@property (nonatomic, retain) NSString *nsTitle, *nsEmail, *nsCall, *nsService, *nsSubject, *nsAddress, *nsFax;
@property (nonatomic, retain) UIViewController* navvc;
@property (nonatomic, retain) UIView *v_content;

@end
