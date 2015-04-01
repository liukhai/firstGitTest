//
//  HomeViewController.h
//  Citibank Card Offer
//
//  Created by Algebra Lo on 10年3月2日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CoreData.h"
#import "Badge.h"
#import "RootViewController.h"
#import "YearRoundOffersViewController.h"
//#import "QuarterlySurpriseListViewController.h"
#import "CardLoanListViewController.h"
#import "LatestPromotionsListViewController.h"
#import "SpendingRewardsListViewController.h"
#import "PBConcertsListViewController.h"
#import "GlobePassListViewController.h"
#import "ComingSoonViewController.h"
#import "RotateMenu3ViewController.h"
#import "RotateMenu2ViewController.h"
#import "ICouponMenuViewController.h"

@interface HomeViewController : UIViewController
<NSXMLParserDelegate,
RotateMenu3ViewControllerDelegate,UINavigationControllerDelegate>
{
	IBOutlet UIButton *back_to_home;
	IBOutlet UIButton *button0, *button1, *button2, *button3, *button4, *button5;
	IBOutlet UILabel *label0, *label1, *label2, *label3, *label4, *label5;
    IBOutlet UILabel *fundLabel;
    IBOutlet UILabel *creditCardTitle;
	IBOutlet Badge *badge0, *badge1, *badge2, *badge3, *badge4, *badge5;
	ASIHTTPRequest *check_request;
	NSDictionary *temp_record_number_data_dic;
	NSMutableDictionary *record_number_data, *temp_record_number_data;
	NSString *currentCat, *currentSubCat, *currentElementName;
	NSString *current_checksum, *current_lastpublish;
	BOOL record_updated;
	int getting;
}
@property (retain, nonatomic) IBOutlet UIButton *bottombanner;
@property (retain, nonatomic) IBOutlet UILabel *creditCardTitle;
@property (assign, nonatomic) BOOL isPop;
-(IBAction)buttonPressed:(UIButton *)button;
-(IBAction)backToHomePressed:(UIButton *)button;
-(void)reloadNew;
-(int)getBadgeExist;
- (IBAction)doMenuButtonsPressed:(UIButton *)sender;
- (void)hiddenScroller;
@end
