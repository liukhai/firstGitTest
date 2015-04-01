//
//  LTEnquiryViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface LTEnquiryViewController : UIViewController <MFMailComposeViewControllerDelegate>{
	NSString *ns_service;
	
	IBOutlet UILabel *lbTitle;
	
	IBOutlet UILabel *lbTag00, *lbTag01, *lbTag02, *lbTag03, *lbTag04;
	
	IBOutlet UIButton *btEmail, *btCall;

}

-(IBAction)email;
-(IBAction)callToEnquiry;

@end
