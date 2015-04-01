//  Created by jasen on 201305

#import <UIKit/UIKit.h>
#import "MoreMenuUtil.h"

@class MoreMenuUtil;

@interface MoreMenuViewController : UIViewController
{
    UIView *viewBG;
    MoreMenuUtil* _MoreMenuUtil;
    IBOutlet UIButton *btn0, *btn1, *btn2, *btn3, *btn4, *btn5, *btn6;
    IBOutlet UILabel *lb0;
    UIImageView *mImageView;
    IBOutlet UIButton *btn_close;
}

@property (retain, nonatomic) IBOutlet UIView *viewBG;
@property (retain, nonatomic) MoreMenuUtil* _MoreMenuUtil;
@property (retain, nonatomic) IBOutlet UIImageView *mImageView;

- (IBAction)doButtonPressed:(UIButton *)sender;
- (void)setViewsForType:(NSString*)type;

@end
