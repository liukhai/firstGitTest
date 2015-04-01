//
//  ShareViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月25日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "CoreData.h"

@interface ShareViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	IBOutlet UIButton *email;
	IBOutlet UILabel *share_label;
}

-(IBAction)emailButtonPressed:(UIButton *)button;
@end
