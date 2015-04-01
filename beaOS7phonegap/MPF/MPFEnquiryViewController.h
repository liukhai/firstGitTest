//
//  MPFEnquiryViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import <MessageUI/MessageUI.h>

@interface MPFEnquiryViewController : UIViewController <MFMailComposeViewControllerDelegate>{
	NSString *ns_service;
	IBOutlet UIButton *btEmail, *btCall;

    IBOutlet UIImageView *lbTitleBackImg;
    IBOutlet UILabel *lbtag01;
    IBOutlet UILabel *lbtag02;
    IBOutlet UILabel *lbtag04;
    IBOutlet UILabel *lbtag05;
    IBOutlet UILabel *lbtag06;
    IBOutlet UILabel *lbtag07;
    IBOutlet UILabel *lbtag08;
    IBOutlet UILabel *lbtag09;
    IBOutlet UILabel *lbtag10;
    IBOutlet UITextView *tvAddress;
    IBOutlet UIImageView *lineImg;
    IBOutlet UIButton *button1;
    IBOutlet UIButton *button2;
    IBOutlet UIButton *button3;
    
}

-(IBAction)callToEnquiry;
-(IBAction)email;

@property(nonatomic,retain) IBOutlet UILabel *lbmpfCenter;
@property(nonatomic,retain) IBOutlet UILabel *lbhotline;
-(void) showContents;

@end
