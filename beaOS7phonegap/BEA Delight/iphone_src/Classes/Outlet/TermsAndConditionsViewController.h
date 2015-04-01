//
//  TermsAndConditionsViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TermsAndConditionsViewController : UIViewController {
	IBOutlet UILabel *title_label;
	IBOutlet UITextView *tnc;
    NSString * mTncStr;
}

@property (nonatomic, assign) UILabel *title_label;
@property (nonatomic, assign) UITextView *tnc;
- (void)setTncStr:(NSString *)tncStr;
@end
