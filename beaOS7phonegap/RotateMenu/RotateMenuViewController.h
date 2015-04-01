//  Created by yaojzy on 201303

#import <UIKit/UIKit.h>

#import "CoreData.h"
#import "RotateMenuUtil.h"
#import "LangUtil.h"

#define Orange_Red @"1"

@protocol RotateMenuViewControllerDelegate <NSObject>
@optional
-(void)doMenuButtonsPressed:(UIButton *)sender;
@end

//edit by chu 20150224
@protocol RotateMenuActionDelegate <NSObject>
@optional
-(void)onMenuButtonsPressed:(UIButton *)sender;
@end

@class RotateMenuUtil;

@interface RotateMenuViewController : UIViewController
{
    UIView *contentView;
    UIButton *btnmenu0;
    UIButton *btnmenu1;
    UIButton *btnmenu2;
    UIScrollView *svmenu;
    RotateMenuUtil* rmUtil;
    UIButton *btnHome;
    UIButton *btnMore;
    UIViewController <RotateMenuViewControllerDelegate> *vc_caller;
}

@property (retain, nonatomic) IBOutlet UIView *contentView;

@property (retain, nonatomic) IBOutlet UIButton *btnHome;
@property (retain, nonatomic) IBOutlet UIButton *btnmenu0;
@property (retain, nonatomic) IBOutlet UIButton *btnmenu1;
@property (retain, nonatomic) IBOutlet UIButton *btnmenu2;
@property (retain, nonatomic) IBOutlet UIScrollView *svmenu;
@property (retain, nonatomic) IBOutlet UIImageView *svmenuImage;

@property (retain, nonatomic) RotateMenuUtil* rmUtil;

@property (retain, nonatomic) IBOutlet UIButton *btnMore;
@property (retain, nonatomic) UIViewController <RotateMenuViewControllerDelegate> *vc_caller;

- (IBAction)test:(id)sender;

@end
