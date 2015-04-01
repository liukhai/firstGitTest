//
//  TaxLoanApplicationResultFailViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface TaxLoanApplicationResultFailViewController : UIViewController {
	IBOutlet UILabel *lbErrorCode, *lbCodeDesc, *lbTimestamp;
	NSMutableDictionary *temp_record;
	
	IBOutlet UILabel *lbTitle;

	IBOutlet UILabel *lbTag00, *lbTag01, *lbTag02;

	IBOutlet UIButton *btOK;
	
}

-(IBAction)btOKPressed;
@property(nonatomic, retain) NSMutableDictionary *temp_record;

@end
