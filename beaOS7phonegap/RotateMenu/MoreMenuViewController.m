//
//  MoreMenuViewController.m
//  BEA
//
//  Created by jasen on 14/5/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//

#import "MoreMenuViewController.h"

@interface MoreMenuViewController ()

@end

@implementation MoreMenuViewController

@synthesize viewBG;
@synthesize _MoreMenuUtil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    btn_close.accessibilityLabel = NSLocalizedString(@"tag_moremenu_close", nil);
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMMVCPageTheme:) name:@"ChangePageTheme" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
- (IBAction)doButtonPressed:(UIButton *)sender {
    [self._MoreMenuUtil doButtonPressed:sender];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [viewBG release];
    [btn_close release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setViewBG:nil];
    [super viewDidUnload];
}

- (void)setViewsForType:(NSString*)type
{
    NSLog(@"debug setViewsForType:%@", type);
    [lb0 setText:NSLocalizedString(@"tag_more", nil)];
    btn_close.accessibilityLabel = NSLocalizedString(@"tag_moremenu_close", nil);

    if ([type isEqualToString:@"CreditCard"]) {
        [btn5 setHidden:YES];
        [btn6 setHidden:YES];
        
        UIImage* image=[UIImage imageNamed:@"n_4_MoreMenuBG.PNG"];
        CGSize Imgsize = image.size;
        [self.mImageView setImage:image];
        CGRect imgFrame = self.mImageView.frame;
        imgFrame.size = Imgsize;
        self.mImageView.frame = imgFrame;
        
//        CGRect frame = btn1.frame;
//        frame.size.height = 43;
//        btn1.frame = frame;
//        
//        frame = btn2.frame;
//        frame.size.height = 43;
//        btn2.frame = frame;
//        
//        frame = btn3.frame;
//        frame.size.height = 43;
//        frame.origin.y = 208;
//        btn3.frame = frame;
//        
//        frame = btn4.frame;
//        frame.size.height = 43;
//        frame.origin.y = 208;
//        btn4.frame = frame;
        
        [btn1 setTitle:NSLocalizedString(@"tag_moremenu_nearby", nil) forState:UIControlStateNormal];
        [btn2 setTitle:NSLocalizedString(@"tag_moremenu_search", nil) forState:UIControlStateNormal];
        [btn3 setTitle:NSLocalizedString(@"tag_moremenu_shareapp", nil) forState:UIControlStateNormal];
        [btn4 setTitle:NSLocalizedString(@"tag_moremenu_mybookmark", nil) forState:UIControlStateNormal];
        
//        btn1.accessibilityLabel = NSLocalizedString(@"tag_moremenu_nearby", nil);
//        btn2.accessibilityLabel = NSLocalizedString(@"tag_moremenu_search", nil);
//        btn3.accessibilityLabel = NSLocalizedString(@"tag_moremenu_shareapp", nil);
//        btn4.accessibilityLabel = NSLocalizedString(@"tag_moremenu_mybookmark", nil);
    } else {
        [btn5 setHidden:YES];
        [btn6 setHidden:YES];
        
        UIImage* image=[UIImage imageNamed:@"n_4_MoreMenuBG.PNG"];
        CGSize Imgsize = image.size;
        [self.mImageView setImage:image];
        CGRect imgFrame = self.mImageView.frame;
        imgFrame.size = Imgsize;
        self.mImageView.frame = imgFrame;
        
        //        CGRect frame = btn1.frame;
        //        frame.size.height = 43;
        //        btn1.frame = frame;
        //
        //        frame = btn2.frame;
        //        frame.size.height = 43;
        //        btn2.frame = frame;
        //
        //        frame = btn3.frame;
        //        frame.size.height = 43;
        //        frame.origin.y = 208;
        //        btn3.frame = frame;
        //
        //        frame = btn4.frame;
        //        frame.size.height = 43;
        //        frame.origin.y = 208;
        //        btn4.frame = frame;
        
        [btn1 setTitle:NSLocalizedString(@"tag_moremenu_mainmenu", nil) forState:UIControlStateNormal];
        [btn2 setTitle:NSLocalizedString(@"tag_moremenu_settings", nil) forState:UIControlStateNormal];
        [btn3 setTitle:NSLocalizedString(@"tag_moremenu_favourites", nil) forState:UIControlStateNormal];
        [btn4 setTitle:NSLocalizedString(@"tag_moremenu_importantnotice", nil) forState:UIControlStateNormal];
        
//        btn1.accessibilityLabel = NSLocalizedString(@"tag_moremenu_mainmenu", nil);
//        btn2.accessibilityLabel = NSLocalizedString(@"tag_moremenu_settings", nil);
//        btn3.accessibilityLabel = NSLocalizedString(@"tag_moremenu_favourites", nil);
//        btn4.accessibilityLabel = NSLocalizedString(@"tag_moremenu_importantnotice", nil);
    }
    
    
//    else {
//        [btn5 setHidden:NO];
//        [btn6 setHidden:NO];
//        
//        UIImage* image=[UIImage imageNamed:@"MoreMenuBG.png"];
//        CGSize Imgsize = image.size;
//        [self.mImageView setImage:image];
//        CGRect imgFrame = self.mImageView.frame;
//        imgFrame.size = Imgsize;
//        self.mImageView.frame = imgFrame;
//        
////        CGRect frame = btn1.frame;
////        frame.size.height = 43;
////        btn1.frame = frame;
////        
////        frame = btn2.frame;
////        frame.size.height = 43;
////        btn2.frame = frame;
////        
////        frame = btn3.frame;
////        frame.size.height = 43;
////        frame.origin.y = 208;
////        btn3.frame = frame;
////        
////        frame = btn4.frame;
////        frame.size.height = 43;
////        frame.origin.y = 208;
////        btn4.frame = frame;
//        
//        [btn1 setTitle:NSLocalizedString(@"tag_moremenu_mainmenu", nil) forState:UIControlStateNormal];
//        [btn2 setTitle:NSLocalizedString(@"tag_moremenu_sitemap", nil) forState:UIControlStateNormal];
//        [btn3 setTitle:NSLocalizedString(@"tag_moremenu_favourites", nil) forState:UIControlStateNormal];
//        [btn4 setTitle:NSLocalizedString(@"tag_moremenu_importantnotice", nil) forState:UIControlStateNormal];
//        [btn5 setTitle:NSLocalizedString(@"tag_moremenu_settings", nil) forState:UIControlStateNormal];
//        [btn6 setTitle:NSLocalizedString(@"tag_moremenu_exit", nil) forState:UIControlStateNormal];
//    }
}

- (void)changeMMVCPageTheme:(NSNotification *)notification {
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([pageTheme isEqualToString:@"1"]) {
        UIImage *image = [UIImage imageNamed:@"btn_close.png"];
        [btn_close setBackgroundImage:image forState:UIControlStateNormal];
    } else {
        UIImage *image = [UIImage imageNamed:@"btn_close_new.png"];
        [btn_close setBackgroundImage:image forState:UIControlStateNormal];
    }
}

@end
