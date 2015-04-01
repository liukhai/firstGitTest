//  Created by jasen on 201306

#import <UIKit/UIKit.h>

#import "RotateMenu2ViewController.h"

@interface AccProMenuViewController : UIViewController
<RotateMenuDelegate>
{
    UINavigationController *m_nvc;
    UIView *mv_content;
    RotateMenu2ViewController* mv_rmvc;
    UIViewController *mvc0, *mvc1, *mvc2;
    int mShowInt;
}
@property (retain, nonatomic) IBOutlet UIView *mv_content;
@property (nonatomic, assign) int mShowInt;
@property (nonatomic, retain) UINavigationController *m_nvc;
@property (nonatomic, retain) RotateMenu2ViewController* mv_rmvc;
@property (nonatomic, retain) UIViewController *mvc0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc;
-(void)setShowIndex:(int)index;
@end
