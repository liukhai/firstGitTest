//
//  CardLoanPDFViewContoller.h
//  BEA
//
//  Created by Mtel on 11年4月7日.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"


@interface CardLoanPDFViewContoller : UIViewController {
	IBOutlet UIBarButtonItem *closeButton;
	IBOutlet UIWebView *webView;
}

-(IBAction)clickCloseButton:(UIBarButtonItem*)button;

@end
