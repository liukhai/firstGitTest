//  Created by yaojzy on 201303

#import <UIKit/UIKit.h>

@protocol RotateMenu3ViewControllerDelegate <NSObject>
@optional
-(void)doMenuButtonsPressed:(UIButton *)sender;
@end

#import "CoreData.h"
#import "RotateMenuUtil.h"

@class RotateMenuUtil;

@interface RotateMenu3ViewController : UIViewController
{
    UIView *contentView;
    UIButton *btnmenu0;
    UIButton *btnmenu1;
    UIButton *btnmenu2;
    UIScrollView *svmenu;
    RotateMenuUtil* rmUtil;
    UIButton *btnHome;
    UIButton *btnSidemenu;
    UIButton *btnMore;
    UIButton *btnBack;
    UIViewController <RotateMenu3ViewControllerDelegate> *vc_caller;
}

@property (retain, nonatomic) IBOutlet UIView *contentView;

@property (retain, nonatomic) IBOutlet UIButton *btnHome;
@property (retain, nonatomic) IBOutlet UIButton *btnmenu0;
@property (retain, nonatomic) IBOutlet UIButton *btnmenu1;
@property (retain, nonatomic) IBOutlet UIButton *btnmenu2;
@property (retain, nonatomic) IBOutlet UIScrollView *svmenu;

@property (retain, nonatomic) RotateMenuUtil* rmUtil;

@property (retain, nonatomic) IBOutlet UIButton *btnSidemenu;
@property (retain, nonatomic) IBOutlet UIButton *btnMore;
@property (retain, nonatomic) IBOutlet UIButton *btnBack;

@property (retain, nonatomic) UIViewController <RotateMenu3ViewControllerDelegate> *vc_caller;


@end
