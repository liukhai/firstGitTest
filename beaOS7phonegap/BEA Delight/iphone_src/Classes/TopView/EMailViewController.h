//
//  EMailViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年5月10日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MBKUtil.h"

@interface EMailViewController : UIViewController <MFMailComposeViewControllerDelegate> {

	MFMailComposeViewController *mail_controller;
    
    
}

@property (nonatomic, assign) MFMailComposeViewController *mail_controller;

-(void)createComposerWithSubject:(NSString *)subject Message:(NSString *)body;
-(void)createComposerWithSubject2:(NSString *)subject to:(NSArray *)addresss;
@end
