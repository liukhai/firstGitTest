//
//  SGGGameViewController.h
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGGGameViewController : UIViewController <ASIHTTPRequestDelegate>
{
	IBOutlet UITextField *answer_input;
	IBOutlet UIScrollView *scroll_view;
}
- (IBAction)submitAns:(id)sender;
- (IBAction)checkLatestPromo:(id)sender;
- (IBAction)screenPressed;

@end
