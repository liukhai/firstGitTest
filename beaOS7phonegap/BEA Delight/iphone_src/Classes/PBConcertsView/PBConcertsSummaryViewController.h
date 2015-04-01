//
//  PBConcertsSummaryViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedImageView.h"
#import "TermsAndConditionsViewController.h"

@interface PBConcertsSummaryViewController : UIViewController {
	IBOutlet UIButton  *tnc, *share, *bookmark;
    CachedImageView *merchantImg;
	IBOutlet UITextView *description;
	IBOutlet UIScrollView *scroll_view;
	IBOutlet CachedImageView *preview;
	NSDictionary *merchant_info;
    NSArray *merchants;
    IBOutlet UILabel *merchant, *title_label;
	int alert_action;
    NSInteger pushType; // 1:
    BOOL isInit;
}
@property (retain, nonatomic) IBOutlet UIButton *bookButton;
@property (nonatomic, assign) NSDictionary *merchant_info;
@property (nonatomic, assign) UILabel *title_label;

-(IBAction)tncButtonPressed:(UIButton *)button;
-(IBAction)shareButtonPressed:(UIButton *)button;
-(IBAction)bookmarkButtonPressed:(UIButton *)button;
- (void)setViewControllerPushType:(NSInteger)type;

@end
