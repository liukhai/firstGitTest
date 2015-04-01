//
//  SGGViewController.h
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "SGGUtil.h"

@interface SGGViewController : UIViewController <UINavigationControllerDelegate, UITabBarDelegate,UINavigationBarDelegate> {
	UINavigationController *navigationController;
	UIView *banner;
    IBOutlet UILabel *lbTitle;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UIView *banner;

-(void) welcome;
-(void)showIntro:(id)sender;
- (void) forwardNextView:(Class) viewController viewName:(NSString*)viewName;
-(void)showTNC:(id)sender;
-(void)checkLatestPromo:(id)sender;

@end
