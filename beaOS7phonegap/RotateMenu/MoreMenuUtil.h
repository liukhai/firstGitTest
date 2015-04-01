//  Created by jasen on 201305

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "MoreMenuViewController.h"

#import "NearBySearchListViewController.h"

@class NearBySearchListViewController;
@class MoreMenuViewController;

@interface MoreMenuUtil : NSObject
{
    MoreMenuViewController* _MoreMenuViewController;
    UINavigationController *nav4process;
    UINavigationController *creditCardNav;
    NSString* funcIndex;
}

@property(nonatomic, retain) MoreMenuViewController* _MoreMenuViewController;
@property (retain, nonatomic) UINavigationController *nav4process;
@property (retain, nonatomic) UINavigationController *creditCardNav;
@property (retain, nonatomic) NSString* funcIndex;

+(MoreMenuUtil*) me;

-(void)showMe:(UINavigationController*)a_nav;
-(void)hiddenMe;
- (IBAction)doButtonPressed:(UIButton *)sender;

-(void)setMoreMenuViews4Common;
-(void)setMoreMenuViews4CreditCard;
-(void)setMoreMenuViews;

@end
