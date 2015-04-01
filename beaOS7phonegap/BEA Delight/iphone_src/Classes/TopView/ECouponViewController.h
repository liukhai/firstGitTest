//
//  ECouponViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月29日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedImageView.h"

@interface ECouponViewController : UIViewController {
	IBOutlet CachedImageView *ecoupon;
}
-(void)loadImageWithURL:(NSString *)url;
-(void)showCoupon;
-(void)hiddenCoupon;
-(IBAction)closeButtonPressed:(UIButton *)button;
@end
