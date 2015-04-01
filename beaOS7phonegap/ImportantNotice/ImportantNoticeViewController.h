//
//  ImportantNoticeViewController.h
//  BEA
//
//  Created by YAO JASEN on 14/03/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "WebViewController.h"

@interface ImportantNoticeViewController : UIViewController {
	BOOL isHiddenImportantNotice;
	IBOutlet UIImageView* imageView;
    IBOutlet UIButton *bt_question, *bt_securityTip;
    
}

-(void)showMe;
-(IBAction)hiddenMe;
-(IBAction)gotoWebside:(UIButton *) uiButton;
-(void)switchMe;

@end