//
//  SettingViewController.m
//  BEA
//
//  Created by Algebra Lo on 10Âπ¥6Êúà27Êó•.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "MHBEADelegate.h"
#import "SideMenuUtil.h"

@implementation SettingViewController
@synthesize isScrollButtom,EntranceType, fromWhere;
-(void)setButtonsStatus
{
    NSString* langStr = [[LangUtil me] getLangPref];
    NSString* defaultPageStr = [[LangUtil me] getDefaultMainpage];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    NSLog(@"debug setButtonsStatus:%@--%@",langStr,defaultPageStr);
    
    if ([langStr isEqualToString:@"en"]) {
        [_btnLang_en setSelected:YES];
        [_btnLang_zh setSelected:NO];
    } else {
        [_btnLang_en setSelected:NO];
        [_btnLang_zh setSelected:YES];
    }
    
    if ([defaultPageStr isEqualToString:@"1"]) {
        [_btnDefaultPage_1 setSelected:YES];
        [_btnDefaultPage_2 setSelected:NO];
        [_btnDefaultPage_3 setSelected:NO];
    } else if ([defaultPageStr isEqualToString:@"2"]) {
        [_btnDefaultPage_1 setSelected:NO];
        [_btnDefaultPage_2 setSelected:YES];
        [_btnDefaultPage_3 setSelected:NO];
    } else if ([defaultPageStr isEqualToString:@"0"]) {
        [_btnDefaultPage_1 setSelected:NO];
        [_btnDefaultPage_2 setSelected:NO];
        [_btnDefaultPage_3 setSelected:YES];
    }
    
    if ([pageTheme isEqualToString:@"1"]) {
        [_btnPageTheme_1 setSelected:YES];
        [_btnPageTheme_2 setSelected:NO];
    } else {
        [_btnPageTheme_1 setSelected:NO];
        [_btnPageTheme_2 setSelected:YES];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ( [userDefaults boolForKey:@"notification_onOroff"] ) {
        [notification_on setSelected:YES];
        [notification_off setSelected:NO];
        NSLog(@"notification_onOroff   : true");
    } else {
        [notification_on setSelected:NO];
        [notification_off setSelected:YES];
        NSLog(@"notification_onOroff   : false");
    }
}

-(void)setButtonsStatus2
{
    NSLog(@"debug setButtonsStatus2 begin:%@", [[LangUtil me] getDefaultAccount]);
    
    if (cyberbanking_input_no_mobile && cybertrading_input_no_mobile) {
        [[LangUtil me] setDefaultAccount:@"0"];
    }
    
    if (!cyberbanking_input_no_mobile && cybertrading_input_no_mobile) {
        [[LangUtil me] setDefaultAccount:@"1"];
    }
    
    if (cyberbanking_input_no_mobile && !cybertrading_input_no_mobile) {
        [[LangUtil me] setDefaultAccount:@"2"];
    }
    
    NSLog(@"debug setButtonsStatus2 b:%@", [[LangUtil me] getDefaultAccount]);
    
    if ([[[LangUtil me] getDefaultAccount] isEqualToString:@""]) {
        [_btnDefaultAccount_1 setSelected:NO];
        [_btnDefaultAccount_2 setSelected:NO];
    } else if ([[[LangUtil me] getDefaultAccount] isEqualToString:@"1"]) {
        [_btnDefaultAccount_1 setSelected:YES];
        [_btnDefaultAccount_2 setSelected:NO];
    } else if ([[[LangUtil me] getDefaultAccount] isEqualToString:@"2"]) {
        [_btnDefaultAccount_1 setSelected:NO];
        [_btnDefaultAccount_2 setSelected:YES];
    }
    
    NSLog(@"debug setButtonsStatus2 c:%d--%d", [_btnDefaultAccount_1 isSelected], [_btnDefaultAccount_2 isSelected]);
    
}

- (void) moveViews
{
    NSLog(@"cyberbanking_input.text: %@ ,   cybertrading_input.text : %@",cyberbanking_input.text,cybertrading_input.text);
    if (cyberbanking_input_no_mobile || cybertrading_input_no_mobile) {
        [_view4Part1 setHidden:YES];
        [_view4Part2 setHidden:YES];
    }
    
    if (!cyberbanking_input_no_mobile && !cybertrading_input_no_mobile) {
        [_view4Part1 setHidden:NO];
        [_view4Part2 setHidden:NO];
    }
//    if ([cyberbanking_input.text isEqualToString:@""] || [cybertrading_input.text isEqualToString:@""]) {
//        [_view4Part1 setHidden:YES];
//        [_view4Part2 setHidden:YES];
//        NSLog(@"Hidden : YES");
//    }
//        
//    if (![cyberbanking_input.text isEqualToString:@""] && ![cybertrading_input.text isEqualToString:@""]) {
//        [_view4Part1 setHidden:NO];
//        [_view4Part2 setHidden:NO];
//        NSLog(@"Hidden : No");
//    }

    //moving...
    UIView* lastView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)] autorelease];
    if (![_view4Part1 isHidden]) {
        lastView = [self follow:lastView with:_view4Part1];
    }
    lastView = [self follow:lastView with:_view4MobileBanking];
    
    if (![_view4Part2 isHidden]) {
        lastView = [self follow:lastView with:_view4Part2];
    }
    
    lastView = [self follow:lastView with:_view4EAS];
    lastView = [self follow:lastView with:_view4Lang];
    lastView = [self follow:lastView with:_view4Version];
    
//    if (_view4Part1.hidden == NO ) {
//        CGSize size = scroll_view.contentSize;
//        size.height=size.height +_view4Part1.frame.size.height;
//        scroll_view.contentSize= size;
//    }
//    if (_view4Part2.hidden == NO ) {
//        CGSize size = scroll_view.contentSize;
//        size.height=size.height +_view4Part2.frame.size.height;
//        scroll_view.contentSize= size;
//    }

    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    //    [[UIDevice currentDevice].systemVersion doubleValue] == 6.1
    if (screenHeight == 480 ) {
        //        CGSize size = scroll_view.contentSize;
        CGSize size = CGSizeMake(320, 810);
//        scroll_view.frame = CGRectMake(scroll_view.frame.origin.x, scroll_view.frame.origin.y, scroll_view.frame.   size.width, scroll_view.frame.size.height);
        NSLog(@"%f",scroll_view.frame.size.height);
        //        size.height=self.view4Version.frame.origin.y +self.view4Version.frame.size.height+30;
        scroll_view.contentSize = size;
        NSLog(@"Move  scroll_view.contentSize: %f", scroll_view.contentSize.height);
    }
    if (screenHeight == 568 && [[UIDevice currentDevice].systemVersion doubleValue] >= 6.0) {
        CGSize size = CGSizeMake(320, 850);
        NSLog(@"%f",scroll_view.frame.size.height);
        scroll_view.contentSize = size;
        NSLog(@"Move  scroll_view.contentSize: %f", scroll_view.contentSize.height);
    }
//    if (screenHeight == 568 && [[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
//        //        CGSize size = scroll_view.contentSize;
//        CGSize size = CGSizeMake(320, 800);
//        //        scroll_view.frame = CGRectMake(scroll_view.frame.origin.x, scroll_view.frame.origin.y, scroll_view.frame.   size.width, scroll_view.frame.size.height);
//        NSLog(@"%f",scroll_view.frame.size.height);
//        //        size.height=self.view4Version.frame.origin.y +self.view4Version.frame.size.height+30;
//        scroll_view.contentSize = size;
//        NSLog(@"Move  scroll_view.contentSize: %f", scroll_view.contentSize.height);
//    }
    
//    if (screenHeight == 480 && [[UIDevice currentDevice].systemVersion doubleValue] == 7.1) {
//        CGSize size = scroll_view.contentSize;
//        scroll_view.frame = CGRectMake(scroll_view.frame.origin.x, scroll_view.frame.origin.y, scroll_view.frame.size.width, scroll_view.frame.size.height);
//        NSLog(@"%f",scroll_view.frame.size.height);
//        size.height=self.view4Version.frame.origin.y +self.view4Version.frame.size.height+30;
//        //        scroll_view.contentSize = size;
//        NSLog(@"Move  scroll_view.contentSize: %f", scroll_view.contentSize.height);
//    }
    

//    else {
//        CGSize size = scroll_view.contentSize;
//        size.height=self.view4Version.frame.origin.y +self.view4Version.frame.size.height+30;
//        scroll_view.contentSize= size;
//        NSLog(@"Move  scroll_view.contentSize: %f", scroll_view.contentSize.height);
//
//    }
}


- (UIView*)follow:(UIView*)lastView with:(UIView*)thisView
{
    CGRect frame;
    frame = thisView.frame;
    NSLog(@"follow:(UIView*)lastView  %f %f ",lastView.frame.origin.y ,lastView.frame.size.height);
    frame.origin.y = lastView.frame.origin.y + lastView.frame.size.height + 10;
    thisView.frame = frame;
    return thisView;
}
- (void)changeLangInitView{
    [self fitHeightTextView:cyberbanking_text];

    [self follow:cyberbanking_text with:cyberbanking_button h:-5];
    [self follow:cyberbanking_text with:cyberbanking_input h:-3];
    [self follow:cyberbanking_text with:save_button02 h:-5];
    int CyberbankingSBackImg_H = cyberbanking_button.frame.origin.y +cyberbanking_button.frame.size.height +10 - CyberbankingSBackImg.frame.origin.y;
    CyberbankingSBackImg.frame = CGRectMake(CyberbankingSBackImg.frame.origin.x, CyberbankingSBackImg.frame.origin.y, CyberbankingSBackImg.frame.size.width, CyberbankingSBackImg_H);
    CyberbankingSBottomImg.frame = CGRectMake(CyberbankingSBottomImg.frame.origin.x, CyberbankingSBackImg.frame.origin.y + CyberbankingSBackImg_H, CyberbankingSBottomImg.frame.size.width,  CyberbankingSBottomImg.frame.size.height);

    [self fitHeightTextView:cybertrading_text];
    [self fitHeightTextView:cybertrading_text3];
    [self fitHeightTextView:cybertrading_text4];
    
    [self follow:cybertrading_text with:Img1 h:2];
    [self follow:cybertrading_text with:cybertrading_text3 h:-5];
    [self follow:cybertrading_text3 with:Img2 h:-3];
    [self follow:cybertrading_text3 with:cybertrading_text4 h:-10];
    
    
    [self follow:cybertrading_text4 with:cybertrading_button h:-2];
    [self follow:cybertrading_text4 with:cybertrading_input h:-0];
    [self follow:cybertrading_text4 with:save_button h:-2];
    
    int cybertradingSBackImg_H = cybertrading_button.frame.origin.y +cybertrading_button.frame.size.height +10 - cybertradingSBackImg.frame.origin.y;
    cybertradingSBackImg.frame = CGRectMake(cybertradingSBackImg.frame.origin.x, cybertradingSBackImg.frame.origin.y, cybertradingSBackImg.frame.size.width, cybertradingSBackImg_H);
    cybertradingSBottomImg.frame = CGRectMake(cybertradingSBottomImg.frame.origin.x, cybertradingSBackImg.frame.origin.y + cybertradingSBackImg_H, cybertradingSBottomImg.frame.size.width,  cybertradingSBottomImg.frame.size.height);
    
    int view4MobileBanking_h =CyberbankingSBottomImg.frame.origin.y + CyberbankingSBottomImg.frame.size.height;
    self.view4MobileBanking.frame = CGRectMake(self.view4MobileBanking.frame.origin.x, self.view4MobileBanking.frame.origin.y, self.view4MobileBanking.frame.size.width,view4MobileBanking_h);

    int view4EAS_h =cybertradingSBottomImg.frame.origin.y + cybertradingSBottomImg.frame.size.height;
    self.view4EAS.frame = CGRectMake(self.view4EAS.frame.origin.x, self.view4EAS.frame.origin.y, self.view4EAS.frame.size.width,view4EAS_h);

}
- (UIView*)follow:(UIView*)lastView with:(UIView*)thisView h:(int)aH
{
    CGRect frame;
    frame = thisView.frame;
    NSLog(@"follow:(UIView*)lastView  %f %f ",lastView.frame.origin.y ,lastView.frame.size.height);
    frame.origin.y = lastView.frame.origin.y + lastView.frame.size.height + aH;
    thisView.frame = frame;
    return thisView;
}
- (IBAction)changeLang:(UIButton*)sender {
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openProperty = NO;
    delegate.openImportant = NO;
    if (sender.tag == 0 && [@"e" isEqualToString:[CoreData sharedCoreData].lang]) {
        return;
    }
    if (sender.tag == 1 && [@"zh_TW" isEqualToString:[CoreData sharedCoreData].lang]) {
        return;
    }
    [[CoreData sharedCoreData].mask showMask];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 6.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 7.0) {
        Img1.frame = CGRectMake(Img1.frame.origin.x, Img1.frame.origin.y + 10, Img1.frame.size.width, Img1.frame.size.height);
        NSLog(@"%@",NSStringFromCGRect(Img1.frame));
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sender.tag==0) {
                [[LangUtil me] setLang_en];
            } else {
                [[LangUtil me] setLang_hant];
            }
            [self setTexts];
            [[SideMenuUtil me] requestMenuDatas];
            [[MoreMenuUtil me] setMoreMenuViews];
            [SideMenuUtil me].menu_view.accessibilityElementsHidden = YES;
            [self setButtonsStatus];
            NSLog(@"changeLang");
            
//            [[CoreData sharedCoreData].mask hiddenMask];
        });
    });

}

- (IBAction)changeDefaultPage:(UIButton*)sender {
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openProperty = NO;
    delegate.openImportant = NO;
    [[LangUtil me] setDefaultMainpage:[NSString stringWithFormat:@"%d", sender.tag]];
    [self setButtonsStatus];
}

- (IBAction)changePageTheme:(UIButton *)sender {
    NSLog(@"-----Now change page theme.");
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openProperty = NO;
    delegate.openImportant = NO;
    NSString * string = [NSString stringWithFormat:@"%li", (long)sender.tag];
    [[PageUtil pageUtil] setPageTheme:string withView:self.view];
    [self setButtonsStatus];
    [self changeSettingButtonImage];
}

- (IBAction)changeDefaultAccount:(UIButton*)sender {
    [[LangUtil me] setDefaultAccount:[NSString stringWithFormat:@"%d", sender.tag]];
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openProperty = NO;
    delegate.openImportant = NO;
    NSLog(@"debug changeDefaultAccount:%@", [[LangUtil me] getDefaultAccount]);
    
    [self setButtonsStatus2];
}

- (void)changeSettingButtonImage {
    NSString *status = [[PageUtil pageUtil] getPageTheme];
    
    if ([status isEqualToString:@"1"]) {//TODO
        UIImage * imageOrange = [UIImage imageNamed:@"btn_blank_03.png"];
        UIImage * imageOrangeNormalLeft = [UIImage imageNamed:@"setting_switchbtn_01_left_off.png"];
        UIImage * imageOrangeSelectedLeft = [UIImage imageNamed:@"setting_switchbtn_01_left_on.png"];
        UIImage * imageOrangeNormalRight = [UIImage imageNamed:@"setting_switchbtn_01_right_off.png"];
        UIImage * imageOrangeSelectedRight = [UIImage imageNamed:@"setting_switchbtn_01_right_on.png"];
        
        UIImage * imageOrangeNormalLeft_2 = [UIImage imageNamed:@"setting_switchbtn_02_left_off.png"];
        UIImage * imageOrangeNormalMid = [UIImage imageNamed:@"setting_switchbtn_02_middle_off.png"];
        UIImage * imageOrangeNormalRight_2 = [UIImage imageNamed:@"setting_switchbtn_02_right_off.png"];
        UIImage * imageOrangeSelectedLeft_2 = [UIImage imageNamed:@"setting_switchbtn_02_left_on.png"];
        UIImage * imageOrangeSelectedMid = [UIImage imageNamed:@"setting_switchbtn_02_middle_on.png"];
        UIImage * imageOrangeSelectedRight_2 = [UIImage imageNamed:@"setting_switchbtn_02_right_on.png"];
        
        [save_button setBackgroundImage:imageOrange forState:UIControlStateNormal];
        [save_button02 setBackgroundImage:imageOrange forState:UIControlStateNormal];
        
        //btnLang
        [_btnLang_en setBackgroundImage:imageOrangeSelectedLeft forState:UIControlStateSelected];
        [_btnLang_en setBackgroundImage:imageOrangeNormalLeft forState:UIControlStateNormal];
        [_btnLang_zh setBackgroundImage:imageOrangeSelectedRight forState:UIControlStateSelected];
        [_btnLang_zh setBackgroundImage:imageOrangeNormalRight forState:UIControlStateNormal];
        
        //btnDefaultPage
        [_btnDefaultPage_1 setBackgroundImage:imageOrangeNormalLeft_2 forState:UIControlStateNormal];
        [_btnDefaultPage_1 setBackgroundImage:imageOrangeSelectedLeft_2 forState:UIControlStateSelected];
        [_btnDefaultPage_2 setBackgroundImage:imageOrangeNormalMid forState:UIControlStateNormal];
        [_btnDefaultPage_2 setBackgroundImage:imageOrangeSelectedMid forState:UIControlStateSelected];
        [_btnDefaultPage_3 setBackgroundImage:imageOrangeNormalRight_2 forState:UIControlStateNormal];
        [_btnDefaultPage_3 setBackgroundImage:imageOrangeSelectedRight_2 forState:UIControlStateSelected];
        
        //btnPageTheme
        [_btnPageTheme_1 setBackgroundImage:imageOrangeSelectedLeft forState:UIControlStateSelected];
//        [_btnPageTheme_1 setBackgroundImage:imageOrangeNormalLeft forState:UIControlStateNormal];
//        [_btnPageTheme_2 setBackgroundImage:imageOrangeSelectedRight forState:UIControlStateSelected];
        [_btnPageTheme_2 setBackgroundImage:imageOrangeNormalRight forState:UIControlStateNormal];
        
        //notification
        [notification_on setBackgroundImage:imageOrangeSelectedLeft forState:UIControlStateSelected];
        [notification_on setBackgroundImage:imageOrangeNormalLeft forState:UIControlStateNormal];
        [notification_off setBackgroundImage:imageOrangeSelectedRight forState:UIControlStateSelected];
        [notification_off setBackgroundImage:imageOrangeNormalRight forState:UIControlStateNormal];
        
    }else{
        
        UIImage * imageRed = [UIImage imageNamed:@"btn_blank_03_new.png"];
        UIImage * imageRedNormalLeft = [UIImage imageNamed:@"setting_switchbtn_01_left_off_new.png"];
        UIImage * imageRedSelectedLeft = [UIImage imageNamed:@"setting_switchbtn_01_left_on_new.png"];
        UIImage * imageRedNormalRight = [UIImage imageNamed:@"setting_switchbtn_01_right_off_new.png"];
        UIImage * imageRedSelectedRight = [UIImage imageNamed:@"setting_switchbtn_01_right_on_new.png"];
        
        UIImage * imageRedNormalLeft_2 = [UIImage imageNamed:@"setting_switchbtn_02_left_off_new.png"];
        UIImage * imageRedNormalMid = [UIImage imageNamed:@"setting_switchbtn_02_middle_off_new.png"];
        UIImage * imageRedNormalRight_2 = [UIImage imageNamed:@"setting_switchbtn_02_right_off_new.png"];
        UIImage * imageRedSelectedLeft_2 = [UIImage imageNamed:@"setting_switchbtn_02_left_on_new.png"];
        UIImage * imageRedSelectedMid = [UIImage imageNamed:@"setting_switchbtn_02_middle_on_new.png"];
        UIImage * imageRedSelectedRight_2 = [UIImage imageNamed:@"setting_switchbtn_02_right_on_new.png"];
        
        [save_button setBackgroundImage:imageRed forState:UIControlStateNormal];
        [save_button02 setBackgroundImage:imageRed forState:UIControlStateNormal];
        
        //btnLang
        [_btnLang_en setBackgroundImage:imageRedSelectedLeft forState:UIControlStateSelected];
        [_btnLang_en setBackgroundImage:imageRedNormalLeft forState:UIControlStateNormal];
        [_btnLang_zh setBackgroundImage:imageRedSelectedRight forState:UIControlStateSelected];
        [_btnLang_zh setBackgroundImage:imageRedNormalRight forState:UIControlStateNormal];
        
        //btnDefaultPage
        [_btnDefaultPage_1 setBackgroundImage:imageRedNormalLeft_2 forState:UIControlStateNormal];
        [_btnDefaultPage_1 setBackgroundImage:imageRedSelectedLeft_2 forState:UIControlStateSelected];
        [_btnDefaultPage_2 setBackgroundImage:imageRedNormalMid forState:UIControlStateNormal];
        [_btnDefaultPage_2 setBackgroundImage:imageRedSelectedMid forState:UIControlStateSelected];
        [_btnDefaultPage_3 setBackgroundImage:imageRedNormalRight_2 forState:UIControlStateNormal];
        [_btnDefaultPage_3 setBackgroundImage:imageRedSelectedRight_2 forState:UIControlStateSelected];
        
        //btnPageTheme
//        [_btnPageTheme_1 setBackgroundImage:imageRedSelectedLeft forState:UIControlStateSelected];
        [_btnPageTheme_1 setBackgroundImage:imageRedNormalLeft forState:UIControlStateNormal];
        [_btnPageTheme_2 setBackgroundImage:imageRedSelectedRight forState:UIControlStateSelected];
//        [_btnPageTheme_2 setBackgroundImage:imageRedNormalRight forState:UIControlStateNormal];
        
        //notification
        [notification_on setBackgroundImage:imageRedSelectedLeft forState:UIControlStateSelected];
        [notification_on setBackgroundImage:imageRedNormalLeft forState:UIControlStateNormal];
        [notification_off setBackgroundImage:imageRedSelectedRight forState:UIControlStateSelected];
        [notification_off setBackgroundImage:imageRedNormalRight forState:UIControlStateNormal];
    }
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

-(void)setTexts {
    [self setFlagOfInputting];
    [self setHintsWhenDidLoad];
    
    //	int footer;
    ////////////////////////////////////////////////////////////////////////////////////
    //	footer = _lbDefaultAccount_1.frame.origin.y + _lbDefaultAccount_1.frame.size.height + 10;
    ////////////////////////////////////////////////////////////////////////////////////
    _btnDefaultAccount_1BigBtn.accessibilityLabel = NSLocalizedString(@"setting_default_stock_account",nil);
    _btnDefaultAccount_2BigBtn.accessibilityLabel = NSLocalizedString(@"setting_default_stock_account",nil);
//    cyberbanking_input_label.accessibilityLabel = NSLocalizedString(@"setting_cyberbanking_input", nil);
//    cyberbanking_input_label.frame = CGRectMake(cyberbanking_input.frame.origin.x, cyberbanking_input.frame.origin.y-12, cyberbanking_input.frame.size.width, cyberbanking_input.frame.size.height);
    
//    cybertrading_input_label.accessibilityLabel = NSLocalizedString(@"setting_cyberbanking_input", nil);
//    cybertrading_input_label.frame = CGRectMake(cybertrading_input.frame.origin.x, cybertrading_input.frame.origin.y-18, cybertrading_input.frame.size.width, cybertrading_input.frame.size.height);
    
	_lbDefaultAccount_1.text = NSLocalizedString(@"setting_default_stock_account",nil);
	_lbDefaultAccount_2.text = NSLocalizedString(@"setting_default_stock_account",nil);
	setting_language.text = NSLocalizedString(@"setting_language",nil);
	setting_default_page.text = NSLocalizedString(@"setting_default_page",nil);
    setting_page_theme.text = NSLocalizedString(@"setting_page_theme", nil);
    [_btnLang_en setTitle:NSLocalizedString(@"setting_language_en", nil) forState:UIControlStateNormal];
    [_btnLang_zh setTitle:NSLocalizedString(@"setting_language_cht", nil) forState:UIControlStateNormal];
    [_btnDefaultPage_1 setTitle:NSLocalizedString(@"setting_default_banking", nil) forState:UIControlStateNormal];
    [_btnDefaultPage_1 setTitle:NSLocalizedString(@"setting_default_banking", nil) forState:UIControlStateSelected];
    [_btnDefaultPage_2 setTitle:NSLocalizedString(@"setting_default_wealth", nil) forState:UIControlStateNormal];
    [_btnDefaultPage_2 setTitle:NSLocalizedString(@"setting_default_wealth", nil) forState:UIControlStateSelected];
    [_btnDefaultPage_3 setTitle:NSLocalizedString(@"setting_default_lifestyle", nil) forState:UIControlStateNormal];
    [_btnDefaultPage_3 setTitle:NSLocalizedString(@"setting_default_lifestyle", nil) forState:UIControlStateSelected];
    
    [_btnPageTheme_1 setTitle:NSLocalizedString(@"setting_page_Orange", nil) forState:UIControlStateNormal];
    [_btnPageTheme_1 setTitle:NSLocalizedString(@"setting_page_Orange", nil) forState:UIControlStateSelected];
    [_btnPageTheme_2 setTitle:NSLocalizedString(@"setting_page_Red", nil) forState:UIControlStateNormal];
    [_btnPageTheme_2 setTitle:NSLocalizedString(@"setting_page_Red", nil) forState:UIControlStateSelected];
    
    notification_label.text = NSLocalizedString(@"Notification",nil);
    [notification_on setTitle:NSLocalizedString(@"Notification_on", nil) forState:UIControlStateNormal];
    [notification_on setTitle:NSLocalizedString(@"Notification_on", nil) forState:UIControlStateSelected];
    [notification_off setTitle:NSLocalizedString(@"Notification_off", nil) forState:UIControlStateNormal];
    [notification_off setTitle:NSLocalizedString(@"Notification_off", nil) forState:UIControlStateSelected];
    
	title_label.text = NSLocalizedString(@"SettingsPage",nil);
    
	[cyberbanking_button setTitle:[NSString stringWithFormat:@"%@:",NSLocalizedString(@"Mobile no.",nil)] forState:UIControlStateNormal];
	[cybertrading_button setTitle:[NSString stringWithFormat:@"%@:",NSLocalizedString(@"Mobile no.",nil)] forState:UIControlStateNormal];
	cyberbanking_title.text = NSLocalizedString(@"Setting Title 1",nil);
    //	cyberbanking_title.font = [UIFont boldSystemFontOfSize:16];
	CGSize maxSize = CGSizeMake(cyberbanking_title.frame.size.width - 20, 100000);
	CGSize text_area = [cyberbanking_title.text sizeWithFont:cyberbanking_title.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    //	cyberbanking_title.frame = CGRectMake(cyberbanking_title.frame.origin.x, cyberbanking_title.frame.origin.y, 300, text_area.height + 20);
    //	footer = cyberbanking_title.frame.origin.y + text_area.height + 10;
    
	cyberbanking_text.text = NSLocalizedString(@"Setting Text 1",nil);
    //	cyberbanking_text.font = [UIFont systemFontOfSize:16];
	maxSize = CGSizeMake(cyberbanking_text.frame.size.width - 20, 100000);
	text_area = [cyberbanking_text.text sizeWithFont:cyberbanking_text.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    //	cyberbanking_text.frame = CGRectMake(cyberbanking_text.frame.origin.x, footer, 300, text_area.height + 20);
    //	footer += text_area.height + 10;
    
    //	cyberbanking_button.center = CGPointMake(130, footer + 25.5);
    //	cyberbanking_input.center = CGPointMake(180, footer + 25.5);
    //	footer += 3;
    //	save_button02.center = CGPointMake(280, footer + 25.5);
    //	footer += 80;
    
    ////////////////////////////////////////////////////////////////////////////////////
    //    CGRect frame = _btnDefaultAccount_2.frame;
    //    frame.origin.y = footer+9;
    //    _btnDefaultAccount_2.frame = frame;
    //    frame = _lbDefaultAccount_2.frame;
    //    frame.origin.y = footer;
    //    _lbDefaultAccount_2.frame = frame;
    //	footer = _lbDefaultAccount_2.frame.origin.y + _lbDefaultAccount_2.frame.size.height + 10;
    ////////////////////////////////////////////////////////////////////////////////////
    
	////////////////////
	cybertrading_title.text = NSLocalizedString(@"Setting Title 2",nil);
    //	cybertrading_title.font = [UIFont boldSystemFontOfSize:16];
	maxSize = CGSizeMake(cybertrading_title.frame.size.width - 20, 100000);
	text_area = [cybertrading_title.text sizeWithFont:cybertrading_title.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    //	cybertrading_title.frame = CGRectMake(cybertrading_title.frame.origin.x, footer, 300, text_area.height + 20);
	//footer = cybertrading_text.frame.origin.y + text_area.height;
    //	footer += text_area.height + 10;
    
	cybertrading_text.text = NSLocalizedString(@"Setting Text 2",nil);
	cybertrading_text3.text = NSLocalizedString(@"Setting Text 3",nil);
	cybertrading_text4.text = NSLocalizedString(@"Setting Text 4",nil);
    //	cybertrading_text.font = [UIFont systemFontOfSize:16];
	maxSize = CGSizeMake(cybertrading_text.frame.size.width - 20, 100000);
	text_area = [cybertrading_text.text sizeWithFont:cybertrading_text.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    //	cybertrading_text.frame = CGRectMake(cybertrading_text.frame.origin.x, footer, 300, text_area.height + 20);
	//footer = cybertrading_text.frame.origin.y + text_area.height;
    //	footer += text_area.height + 10;
    
    //	cybertrading_button.center = CGPointMake(130, footer + 25.5);
    //	cybertrading_input.center = CGPointMake(180, footer + 25.5);
    //	footer += 3;
    //	save_button.center = CGPointMake(280, footer + 25.5);
    //	footer += 80;
    
    //	if (footer>416) {
    //		scroll_view.contentSize = CGSizeMake(320, footer + 150);
    //	}
    
	[save_button setTitle:NSLocalizedString(@"Save",nil) forState:UIControlStateNormal];
	[save_button02 setTitle:NSLocalizedString(@"Save",nil) forState:UIControlStateNormal];
	[self checkTextColor];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(infoDictionary);
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    [mVersionLabel setText:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"version", nil),app_build]];
    [mCopright setText: NSLocalizedString(@"Copyright", nil)];
    
    [self changeLangInitView];
    [self moveViews];
}

- (void)setFlagOfInputting {
    
    NSMutableDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
    if (user_setting==nil || [user_setting objectForKey:@"encryted_banking"]==nil || [user_setting objectForKey:@"encryted_trading"]==nil) {
    } else {
        if ([[user_setting objectForKey:@"encryted_banking"] length]>0) {
            cyberbanking_input_no_mobile = NO;
            
        } else {
            cyberbanking_input_no_mobile = YES;
        }
        if ([[user_setting objectForKey:@"encryted_trading"] length]>0) {
            cybertrading_input_no_mobile = NO;
            
        } else {
            cybertrading_input_no_mobile = YES;
        }
    }
    
}

- (void)setHintsWhenDidLoad {
    
    if (cyberbanking_input_no_mobile) {
        //cyberbanking_input.text = NSLocalizedString(@"setting_cyberbanking_input", nil);
        cyberbanking_input.accessibilityLabel = NSLocalizedString(@"setting_cyberbanking_input",nil);
    } else {
        cyberbanking_input.accessibilityLabel = NSLocalizedString(@"setting_cyberbanking_input",nil);
    }
    
    if (cybertrading_input_no_mobile) {
        //cybertrading_input.text = NSLocalizedString(@"setting_cyberbanking_input", nil);
        cybertrading_input.accessibilityLabel = NSLocalizedString(@"setting_cyberbanking_input",nil);
    } else {
        cybertrading_input.accessibilityLabel = NSLocalizedString(@"setting_cyberbanking_input",nil);
    }
    
}

- (void)setHintsWhenInputting {
    
    if (cyberbanking_input_no_mobile) {
        cyberbanking_input.text = @"";
        cyberbanking_input.accessibilityLabel = NSLocalizedString(@"setting_cyberbanking_input",nil);
    }
    
    if (cybertrading_input_no_mobile) {
        cybertrading_input.text = @"";
        cybertrading_input.accessibilityLabel = NSLocalizedString(@"setting_cyberbanking_input",nil);
    }

}

- (void)setFlagAfterInput {
    if ([cyberbanking_input.text isEqualToString:@""]) {
        cyberbanking_input_no_mobile = YES;
    } else {
        cyberbanking_input_no_mobile = NO;
    }
    if ([cybertrading_input.text isEqualToString:@""]) {
        cybertrading_input_no_mobile = YES;
    } else {
        cybertrading_input_no_mobile = NO;
    }
   
}

- (void)setTextBeforeSave {
    if ([cyberbanking_input.text isEqualToString:NSLocalizedString(@"setting_cyberbanking_input",nil)]) {
        cyberbanking_input.text = @"";
    }
    if ([cybertrading_input.text isEqualToString:NSLocalizedString(@"setting_cyberbanking_input",nil)]) {
        cybertrading_input.text = @"";
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.accessibilityViewIsModal = YES;

    [self setFlagOfInputting];
    
//    view4part1BigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_view4Part1 addSubview:view4part1BigBtn];
//    view4part1BigBtn.frame = CGRectMake(0, 0, _view4Part1.frame.size.width, _view4Part1.frame.size.height);
//    view4part1BigBtn.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:scroll_view];
    //    scroll_view.frame = CGRectMake(0, 63, 320, 397+[[MyScreenUtil me] getScreenHeightAdjust]);
    NSLog(@"Setting   scroll_view.contentSize: %f", scroll_view.contentSize.height);
    scroll_view.contentSize = scroll_view.frame.size;
    NSLog(@"Setting   scroll_view.contentSize: %f", scroll_view.contentSize.height);
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        frame.origin.y = 43;
        frame.size.height -=43;
    }else{
        frame.origin.y = 63;
        frame.size.height -=63;
    }
    scroll_view.frame = frame;

	NSMutableDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
	if (user_setting==nil || [user_setting objectForKey:@"encryted_banking"]==nil || [user_setting objectForKey:@"encryted_trading"]==nil) {
		user_setting = [NSMutableDictionary new];
		[user_setting setValue:@"" forKey:@"encryted_banking"];
		[user_setting setValue:@"" forKey:@"encryted_trading"];
		/*[user_setting setValue:@"" forKey:@"banking_login"];
		 [user_setting setValue:@"" forKey:@"trading_login"];*/
		[PlistOperator savePlistFile:@"user_setting" From:user_setting];
	} else {
		if ([[user_setting objectForKey:@"encryted_banking"] length]>0) {
//			NSData *banking = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_banking"]];
//			NSLog(@"SettingViewController viewDidLoad check get 1:%@", [NSString stringWithFormat:@"%@", banking]);
//			[self transform:banking];
//			NSLog(@"SettingViewController viewDidLoad check get 2:%@", [NSString stringWithFormat:@"%@", banking]);
//			cyberbanking_input.text = [[NSString alloc] initWithData:banking encoding:NSUTF8StringEncoding];
			cyberbanking_input.text = [MBKUtil decryption:[user_setting objectForKey:@"encryted_banking"]];
			NSLog(@"SettingViewController viewDidLoad check get 3:%@", cyberbanking_input.text);
        } else {
            //			cyberbanking_input.text = NSLocalizedString(@"Mobile no.",nil);
            cyberbanking_input.text = @"";
        }
		if ([[user_setting objectForKey:@"encryted_trading"] length]>0) {
//			NSData *trading = [NSData dataWithBase64Data:[user_setting objectForKey:@"encryted_trading"]];
//			[self transform:trading];
//			cybertrading_input.text = [[NSString alloc] initWithData:trading encoding:NSUTF8StringEncoding];
       		cybertrading_input.text = [MBKUtil decryption:[user_setting objectForKey:@"encryted_trading"]];
            NSLog(@"SettingViewController viewDidLoad check get 3:%@", cybertrading_input.text);
        } else {
            //			cybertrading_input.text = NSLocalizedString(@"Mobile no.",nil);
            cybertrading_input.text = @"";
		}
	}
    
    [self setTexts];
    
    [[MBKUtil me].queryButton1 addTarget:self action:@selector(queryButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    [v_rmvc.rmUtil setNav:self.navigationController];
    [self.view addSubview:v_rmvc.contentView];
    
    [self setButtonsStatus];
    
    [self setButtonsStatus2];
    
    [self moveViews];
    
    if (isScrollButtom) {
        [self scrollToBottom];
    }
    
    NSLog(@"Setting  scroll_view: %@",scroll_view);
 
    if ([fromWhere isEqualToString:@"fromEAS"]) {
        [scroll_view setContentOffset:CGPointMake(0, _view4MobileBanking.frame.size.height+10)];
    }
    
//    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 6.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 7.0) {
//        Img1.frame = CGRectMake(Img1.frame.origin.x, Img1.frame.origin.y + 10, Img1.frame.size.width, Img1.frame.size.height);
//        NSLog(@"%@",NSStringFromCGRect(Img1.frame));
//    }
    [cybertrading_text4 setScrollEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeSettingButtonImage];
}

- (void) scrollToBottom
{
    CGRect frame = scroll_view.frame;
    frame.origin.y += frame.size.height;
    [scroll_view scrollRectToVisible:frame animated:YES];
    
    //    CGPoint newOffset = scroll_view.contentOffset;
    //    newOffset.y = newOffset.y+scroll_view.contentSize.height;
    //    [scroll_view setContentOffset:newOffset animated:NO];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [self setBtnLang_en:nil];
    [self setBtnLang_zh:nil];
    [self setBtnDefaultPage_1:nil];
    [self setBtnDefaultPage_2:nil];
    [self setBtnDefaultPage_3:nil];
    [self setBtnDefaultAccount_1:nil];
    [self setBtnDefaultAccount_2:nil];
    [self setLbDefaultAccount_1:nil];
    [self setLbDefaultAccount_2:nil];
    [self setView4MobileBanking:nil];
    [self setView4EAS:nil];
    [self setView4Lang:nil];
    [self setView4Part1:nil];
    [self setView4Part2:nil];
    [mVersionLabel release];
    mVersionLabel = nil;
    [self setView4Version:nil];
    [mCopright release];
    mCopright = nil;
    [CyberbankingSBackImg release];
    CyberbankingSBackImg = nil;
    [CyberbankingSBottomImg release];
    CyberbankingSBottomImg = nil;
    [cybertradingSBackImg release];
    cybertradingSBackImg = nil;
    [cybertradingSBottomImg release];
    cybertradingSBottomImg = nil;
    [Img1 release];
    Img1 = nil;
    [Img2 release];
    Img2 = nil;
    [cybertrading_text release];
    cybertrading_text = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	NSLog(@"Setting dealloc");
  	[[MBKUtil me].queryButton1 removeTarget:self action:@selector(queryButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLang_en release];
    [_btnLang_zh release];
    [_btnDefaultPage_1 release];
    [_btnDefaultPage_2 release];
    [_btnDefaultPage_3 release];
    [_btnDefaultAccount_1 release];
    [_btnDefaultAccount_2 release];
    [_lbDefaultAccount_1 release];
    [_lbDefaultAccount_2 release];
    [_view4MobileBanking release];
    [_view4EAS release];
    [_view4Lang release];
    [_view4Part1 release];
    [_view4Part2 release];
    [mVersionLabel release];
    [_view4Version release];
    [mCopright release];
    [CyberbankingSBackImg release];
    [CyberbankingSBottomImg release];
    [cybertradingSBackImg release];
    [cybertradingSBottomImg release];
    [Img1 release];
    [Img2 release];
    [cybertrading_text release];
    [cybertrading_text release];
    [notification_label release];
    [notification_on release];
    [notification_off release];
    [_btnDefaultAccount_1BigBtn release];
    [_btnDefaultAccount_2BigBtn release];
    [cyberbanking_input_label release];
    [cybertrading_input_label release];
    [_btnPageTheme_1 release];
    [_btnPageTheme_2 release];
    [super dealloc];
}

-(void)checkTextColor {
    if ([cyberbanking_input.text isEqualToString:NSLocalizedString(@"setting_cyberbanking_input",nil)]
        ||[cyberbanking_input.text isEqualToString:@""]) {
        cyberbanking_input.textColor = [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1.0];
    } else {
        cyberbanking_input.textColor = [UIColor blackColor];
    }
    if ([cybertrading_input.text isEqualToString:NSLocalizedString(@"setting_cyberbanking_input",nil)] || [cybertrading_input.text isEqualToString:@""]) {
        cybertrading_input.textColor = [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1.0];
    } else {
        cybertrading_input.textColor = [UIColor blackColor];
    }
    
}

-(IBAction)saveButtonPressed:(UIButton *)button {
    [self setButtonsStatus2];
    [self moveViews];
    [self setTextBeforeSave];
    
//	NSData *cyberbanking_data = [cyberbanking_input.text dataUsingEncoding:NSUTF8StringEncoding];
//	NSData *cybertrading_data = [cybertrading_input.text dataUsingEncoding:NSUTF8StringEncoding];
//    
//	[self transform:cyberbanking_data];
//	[self transform:cybertrading_data];
//    
//	NSData *temp_banking = [cyberbanking_data base64Data];
//	//NSLog(@"%@",temp_banking);
//	NSData *temp_trading = [cybertrading_data base64Data];
//	//NSLog(@"%@",temp_trading);
	NSData *temp_banking = [MBKUtil encryption:cyberbanking_input.text];
	NSData *temp_trading = [MBKUtil encryption:cybertrading_input.text];
    
	NSMutableDictionary *user_setting = [NSMutableDictionary new];
	//	if ([cyberbanking_input.text isEqualToString:NSLocalizedString(@"Mobile no.",nil)]) {
//	if ([cyberbanking_input.text isEqualToString:@""]) {
    if ([cyberbanking_input.text length] == 0) {
		//[user_setting setValue:@"" forKey:@"banking_login"];
		[user_setting setValue:@"" forKey:@"encryted_banking"];
	} else if ([cyberbanking_input.text length] < 8 || [cyberbanking_input.text length] > 8) {
        UIAlertView *showAlert = [[[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Setting_no_length_invalid", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil] autorelease];
        showAlert.tag = 100;
        [showAlert show];
        return ;
    }
    else {
		//[user_setting setValue:cyberbanking_input.text forKey:@"banking_login"];
		[user_setting setValue:temp_banking forKey:@"encryted_banking"];
	}
	//	if ([cybertrading_input.text isEqualToString:NSLocalizedString(@"Mobile no.",nil)]) {
//	if ([cybertrading_input.text isEqualToString:@""]) {
    if ([cybertrading_input.text length] == 0) {
		//[user_setting setValue:@"" forKey:@"trading_login"];
		[user_setting setValue:@"" forKey:@"encryted_trading"];
	} else if ([cybertrading_input.text length] < 8 || [cybertrading_input.text length] > 8) {
        UIAlertView *showAlert = [[[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Setting_no_length_invalid", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil] autorelease];
        showAlert.tag = 100;
        [showAlert show];
        return ;
    }
    else {
		//[user_setting setValue:cybertrading_input.text forKey:@"trading_login"];
		[user_setting setValue:temp_trading forKey:@"encryted_trading"];
	}
	[PlistOperator savePlistFile:@"user_setting" From:user_setting];
    if (!(cyberbanking_input.text.length == 0 && cybertrading_input.text.length != 0)) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Setting saved",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];

    }
    if (cyberbanking_input.text.length == 0 && cybertrading_input.text.length != 0) {
//        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Setting saved",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//        [alert_view show];
//        [alert_view release];
//        if (button.) {
            [[CoreData sharedCoreData].bea_view_controller gotoCybertrading];
//        }
        
    }
    
    [self setFlagOfInputting];
    [self setHintsWhenDidLoad];

}



-(IBAction)saveButtonPressed02:(UIButton *)button {
    [self setButtonsStatus2];
    [self moveViews];
    [self setTextBeforeSave];

//	NSData *cyberbanking_data = [cyberbanking_input.text dataUsingEncoding:NSUTF8StringEncoding];
//	NSData *cybertrading_data = [cybertrading_input.text dataUsingEncoding:NSUTF8StringEncoding];
//    
//	[self transform:cyberbanking_data];
//	[self transform:cybertrading_data];
//    
//	NSData *temp_banking = [cyberbanking_data base64Data];
//	NSLog(@"%@ --- %@",cyberbanking_data, temp_banking);
//	NSData *temp_trading = [cybertrading_data base64Data];
//	NSLog(@"%@ --- %@",cybertrading_data, temp_trading);
	NSData *temp_banking = [MBKUtil encryption:cyberbanking_input.text];
	NSData *temp_trading = [MBKUtil encryption:cybertrading_input.text];
    
	NSMutableDictionary *user_setting = [NSMutableDictionary new];
	//	if ([cyberbanking_input.text isEqualToString:NSLocalizedString(@"Mobile no.",nil)]) {
//	if ([cyberbanking_input.text isEqualToString:@""]) {
    if ([cyberbanking_input.text length] == 0) {
		//[user_setting setValue:@"" forKey:@"banking_login"];
		[user_setting setValue:@"" forKey:@"encryted_banking"];
        
	} else if ([cyberbanking_input.text length] < 8 || [cyberbanking_input.text length] > 8) {
        UIAlertView *showAlert = [[[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Setting_no_length_invalid", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil] autorelease];
        showAlert.tag = 100;
        [showAlert show];
        return ;
    }
    else {
		//[user_setting setValue:cyberbanking_input.text forKey:@"banking_login"];
		[user_setting setValue:temp_banking forKey:@"encryted_banking"];
        NSLog(@"temp_banking is %@", [temp_banking base64String]);
	}
	//	if ([cybertrading_input.text isEqualToString:NSLocalizedString(@"Mobile no.",nil)]) {
//	if ([cybertrading_input.text isEqualToString:@""]) {
    if ([cybertrading_input.text length] == 0) {
		//[user_setting setValue:@"" forKey:@"trading_login"];
		[user_setting setValue:@"" forKey:@"encryted_trading"];
	} else if ([cybertrading_input.text length] < 8 || [cybertrading_input.text length] > 8) {
        UIAlertView *showAlert = [[[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Setting_no_length_invalid", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil] autorelease];
        [showAlert show];
        showAlert.tag = 101;
        return ;
    }
    else {
		//[user_setting setValue:cybertrading_input.text forKey:@"trading_login"];
		[user_setting setValue:temp_trading forKey:@"encryted_trading"];
	}
	[PlistOperator savePlistFile:@"user_setting" From:user_setting];
    if (!(cyberbanking_input.text.length != 0 && cybertrading_input.text.length==0 ) ) {
//        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Setting saved",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//        [alert_view show];
//        [alert_view release];

    }
    
    if (cyberbanking_input.text.length != 0 && cybertrading_input.text.length != 0) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Setting saved",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
        
    }
    
    if (cyberbanking_input.text.length == 0 && cybertrading_input.text.length != 0) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Setting saved",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
    }
    if (cyberbanking_input.text.length == 0 && cybertrading_input.text.length == 0) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Setting saved",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];
    }
    
	//	if ([cyberbanking_input.text isEqualToString:NSLocalizedString(@"Mobile no.",nil)] || [cyberbanking_input.text isEqualToString:@""])
    BOOL isEmptyMobileNo = [cyberbanking_input.text isEqualToString:@""];
    BOOL willGotoMBAIOLogon = [[MobileTradingUtil me].requestServer isEqualToString:@"MOBILETRADING"];
    if (isEmptyMobileNo && !willGotoMBAIOLogon) {
//		UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Setting saved",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//		[alert_view show];
//		[alert_view release];
	}
    if (EntranceType == 3) {
        P2PMenuViewController* vc = [[P2PMenuViewController alloc] initWithNibName:@"P2PMenuViewController" bundle:nil nav:[CoreData sharedCoreData].bea_view_controller.navigationController];
        [CoreData sharedCoreData].sP2PMenuViewController = vc;
        [self.navigationController pushViewController:vc animated:NO];
        [vc release];
        EntranceType =-1;
        return;
    }
	if ([[CoreData sharedCoreData].lastScreen isEqualToString:@"HotlineViewController"]) {
		[[CoreData sharedCoreData].hotline_view_controller checkMBKRegStatus];
        
	}else{
        
        if (willGotoMBAIOLogon) {//added by jasen
            if (!isEmptyMobileNo) {
                [[MobileTradingUtil me] checkMobileTradingRegStatus];
            }
        }else if (cybertrading_input.text.length == 0){
//            UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Setting saved",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//            alert_view.tag = 100;
//            [alert_view show];
//            [alert_view release];
            
            [[CoreData sharedCoreData].bea_view_controller checkMBKRegStatus];
            
        }
    }
    
    [self setFlagOfInputting];
    [self setHintsWhenDidLoad];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag == 100) {
//        return ;
//    }
//    if (cybertrading_input.text.length == 0) {
//        return;
//    }
    MHBEA_DELEGATE.m_sRequestServer = @"MOBILEBANKING";
    if (cyberbanking_input.text.length == 0 && cybertrading_input.text.length != 0) {
        [[CoreData sharedCoreData].bea_view_controller gotoCybertrading];
    }
    
//    if (cybertrading_input.text.length == 0 && alertView.tag == 100) {
//        [[CoreData sharedCoreData].bea_view_controller checkMBKRegStatus];
//    }
}

#pragma  mark -
#pragma mark UITextFieldDelegate

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
	NSLog(@"debug textFieldShouldBeginEditing:%@", textField);
    if (textField.keyboardType == UIKeyboardTypeNumberPad) {
        [[MBKUtil me].queryButton1 setHidden:NO];
//        [MBKUtil me].queryButtonWillShow = @"YES";
    }else{
        [[MBKUtil me].queryButton1 setHidden:YES];
    }

    CGPoint center = scroll_view.center;
    if (textField == cyberbanking_input) {
        [self setHintsWhenInputting];
        center.y = _view4MobileBanking.frame.origin.y + cyberbanking_input.frame.origin.y - cyberbanking_input.frame.size.height;
    } else if (textField == cybertrading_input) {
        [self setHintsWhenInputting];
        center.y = _view4EAS.frame.origin.y + cybertrading_input.frame.origin.y - cybertrading_input.frame.size.height;
    }
    center.x = 0;
    [scroll_view setContentOffset:center animated:TRUE];

	return TRUE;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self setFlagAfterInput];
    [self setHintsWhenDidLoad];
    [self checkTextColor];
    return YES;
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"debug textFieldShouldReturn:%@", textField);
	[textField resignFirstResponder];
    [scroll_view setContentOffset:CGPointMake(0, 0) animated:TRUE];
    
	if ([textField.text length]==0) {
		//		textField.text = NSLocalizedString(@"Mobile no.",nil);
		textField.text = @"";
	}
	[self checkTextColor];
	return TRUE;
}


-(void) queryButtonPress:(id *) button{
    [self screenPressed];
}

-(IBAction)screenPressed{
    //    [scroll_view setContentOffset:CGPointMake(0, 0) animated:TRUE];

    [cyberbanking_input resignFirstResponder];
	[cybertrading_input resignFirstResponder];
}
- (int) fitHeight:(UILabel*)sender
{
    //    NSLog(@"debug ATMCustomCellCMS fitHeight:%@", sender.text);
    
    CGSize maxSize = CGSizeMake(sender.frame.size.width, 50);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height);
    int height = sender.frame.origin.y + sender.frame.size.height;
    return height;
}
- (int) fitHeightTextView:(UITextView*)sender
{
    if ([[UIDevice currentDevice].systemVersion doubleValue] == 6.1) {
        CGSize maxSize = CGSizeMake(sender.frame.size.width, 120);
        CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height + 30);
        NSLog(@"%f",[[UIDevice currentDevice].systemVersion doubleValue]);
        int height = text_area.height;
        
        //    int height = sender.frame.origin.y + sender.frame.size.height;
        return height;
    }
    
    CGSize maxSize = CGSizeMake(sender.frame.size.width, 100);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height + 25);
    NSLog(@"%f",[[UIDevice currentDevice].systemVersion doubleValue]);
    int height = text_area.height;
//    cybertrading_text4.frame = CGRectMake(cybertrading_text4.frame.origin.x, cybertrading_text4.frame.origin.y, cybertrading_text4.frame.size.width, cybertrading_text4.frame.size.height);
    //    int height = sender.frame.origin.y + sender.frame.size.height;
        return height;
}

- (IBAction)clickNotificationOnOrOff:(UIButton *)sender {
    if (sender.tag==0 && !notification_on.selected) {
        [notification_on setSelected:YES];
        [notification_off setSelected:NO];
        if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        }else {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        
        [CoreData sharedCoreData].bea_view_controller.notification_onOroff = true;

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        [userDefaults setBool:true forKey:@"notification_onOroff"];

        [userDefaults synchronize];
        NSLog(@"notification_onOroff   : true");
    } else if (sender.tag==1  && !notification_off.selected){
        [notification_on setSelected:NO];
        [notification_off setSelected:YES];
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        [CoreData sharedCoreData].bea_view_controller.notification_onOroff = false;

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        [userDefaults setBool:false forKey:@"notification_onOroff"];

        [userDefaults synchronize];
        NSLog(@"notification_onOroff   : false");
    }
    
}
@end
