//  Created by jasen on 201303

#import <UIKit/UIKit.h>

@interface CalloutMapContentViewController : UIViewController
{
    UILabel *calloutTitle;
    UILabel *address;
    UILabel *service;
    NSString* strTitle, *strAddress, *strService, *strTel, *strFax;
    NSMutableArray* accessibleElements;
}

@property (retain, nonatomic) NSString* strTitle, *strAddress, *strService, *strTel, *strFax;


@property (retain, nonatomic) IBOutlet UILabel *calloutTitle;
@property (retain, nonatomic) IBOutlet UILabel *address;
@property (retain, nonatomic) IBOutlet UILabel *service;
@property (retain, nonatomic) IBOutlet UIButton *btnTel;
@property (retain, nonatomic) IBOutlet UIButton *btnClose;
@property (retain, nonatomic) IBOutlet UIButton *btnClose2;

@property (retain, nonatomic) IBOutlet UIImageView *imgBG;
@property (retain, nonatomic) IBOutlet UIImageView *imgAddress;
@property (retain, nonatomic) IBOutlet UIImageView *imgHour;
@property (retain, nonatomic) IBOutlet UIImageView *imgTel;
@property (retain, nonatomic) IBOutlet UIImageView *imgFax;
@property (retain, nonatomic) IBOutlet UILabel *fax_Label;
@property (retain, nonatomic) IBOutlet UIImageView *closeImage;

@property (retain, nonatomic) IBOutlet UIView *viewContent;
- (IBAction)closeButtonPressed:(id)sender;

- (void)setText4ATM;
- (void)setText4CreditCard;

@end
