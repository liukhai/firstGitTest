//
//  LTApplicationResultViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface LTApplicationResultViewController : UIViewController {

	IBOutlet UILabel *lbRefno, *lbName, *lbMobileno, *lbEmail, *lbLoanDetail, *lbTimestamp;
	NSMutableDictionary *temp_record;
	
	IBOutlet UILabel *lbTitle;

	IBOutlet UILabel *lbTag00, *lbTag01, *lbTag02, *lbTag03, *lbTag04, *lbTag05, *lbTag06, *lbTag07;

	IBOutlet UIButton *btOK;
	
}

-(IBAction)btOKPressed;
@property(nonatomic, retain) NSMutableDictionary *temp_record;

@end
