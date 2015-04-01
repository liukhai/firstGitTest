//
//  SGGRetryViewController.h
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGGRetryViewController : UIViewController
{
	IBOutlet UITextField *answer_input;
	IBOutlet UIScrollView *scroll_view;
}

- (IBAction)startGame:(id)sender;
- (IBAction)checkLatestPromo:(id)sender;
- (IBAction)screenPressed;
- (IBAction)showIntro:(id)sender;

@end
