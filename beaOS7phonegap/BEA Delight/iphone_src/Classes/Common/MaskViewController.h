//
//  MaskViewController.h
//  PIPTrade
//
//  Created by Algebra Lo on 10年1月16日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MaskViewController : UIViewController {
	IBOutlet UIActivityIndicatorView *loading;
}

-(void)showMask;
-(void)hiddenMask;

@end
