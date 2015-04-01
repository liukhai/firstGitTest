//
//  FacebookListViewController.h
//  BEA
//
//  Created by Helen on 14-8-22.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "ASIHTTPRequest.h"
#import "LargeImageCell.h"
#import "RotateMenu3ViewController.h"
#import "CoreData.h"

@interface FacebookListViewController : UIViewController<RotateMenuDelegate, NSXMLParserDelegate> {
    IBOutlet UILabel *fun_label;
    IBOutlet UILabel *joy_label;
    IBOutlet UIImageView *fun_image;
    IBOutlet UIView *fun_view;
    IBOutlet UIButton *fun_button;
    IBOutlet UIImageView *joy_image;
    IBOutlet UIView *joy_view;
    IBOutlet UIButton *joy_button;
    RotateMenuViewController* mv_rmvc;
    IBOutlet UIButton *funBtn;
    IBOutlet UIButton *joyBtn;
    UINavigationController * v_nav;
    IBOutlet UILabel *funLabel;
    IBOutlet UILabel *joyLabel;
}
@property (nonatomic, retain) UINavigationController * v_nav;
@property (nonatomic, retain) RotateMenu3ViewController* v_rmvc;

-(void)setNav:(UINavigationController*)a_nav;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc;

-(void) loadPlistData;
-(void) didSelectRowAtIndexPath:(int)index;

- (IBAction)funBtnClick:(id)sender;
- (IBAction)joyBtnClick:(id)sender;


@end
