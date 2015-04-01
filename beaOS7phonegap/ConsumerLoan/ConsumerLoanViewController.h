//
//  Created by NEO on 11/14/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "ConsumerLoanUtil.h"
#import "ConsumerLoanApplicationViewController.h"
#import "ConsumerLoanOffersViewController.h"
#import "AccProListViewController.h"

@interface ConsumerLoanViewController : UIViewController <UINavigationControllerDelegate, UITabBarDelegate,UINavigationBarDelegate> {
	UINavigationController *navigationController;
	UITabBar *tabBar;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;

-(void) showOffer:(NSString*)url
          hotline:(NSString*)hotline
         btnLabel:(NSString*)btnLabel
              tnc:(NSString*)TNCurl;

@end
