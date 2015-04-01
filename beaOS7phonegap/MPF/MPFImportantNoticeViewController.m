//
//  MPFImportantNoticeViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/06/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MPFImportantNoticeViewController.h"
#import "MPFUtil.h"

@implementation MPFImportantNoticeViewController

@synthesize scroll_view, text_view;
@synthesize timer1;
@synthesize tabBar;
@synthesize importantAlertView;
@synthesize btnView;
@synthesize bt_loginMBK, bt_callMPFhotline, bt_cancel, bt_understood;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */
-(void)setTexts{
    [bt_question setTitle:NSLocalizedString(@"Frequently Asked Questions", nil) forState:UIControlStateNormal];
    [bt_securityTip setTitle:NSLocalizedString(@"Security Tips", nil) forState:UIControlStateNormal];
    ((UITabBarItem *)[tabBar.items objectAtIndex:0]).title = NSLocalizedString(@"MyMPF",nil);
    [self.bt_loginMBK setTitle:NSLocalizedString(@"Logintomobilebanking",nil) forState:UIControlStateNormal];
    [self.bt_callMPFhotline setTitle:NSLocalizedString(@"CallMPFhotline",nil) forState:UIControlStateNormal];
    [bt_understood setTitle:NSLocalizedString(@"cyberfundsearch.btn.understood",nil) forState:UIControlStateNormal];
    [bt_cancel setTitle:NSLocalizedString(@"cyberfundsearch.btn.Cancel",nil) forState:UIControlStateNormal];
    
    disclaimer_title.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.title",nil);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.accessibilityViewIsModal = YES;
    [[MyScreenUtil me] adjustView2Screen:self.view];
    self.view.center = [[MyScreenUtil me] getmainScreenCenter_20:self];
    btnViewY = 396+[[MyScreenUtil me] getScreenHeightAdjust];
    
    self.importantAlertView.frame = CGRectMake(20, 75+[[MyScreenUtil me] getScreenHeightAdjust]/2, 280, 343);
    tabBar.frame = CGRectMake(0, [[MyScreenUtil me] getScreenHeight]-49, 320, 49);
    
    [bt_question setTitle:NSLocalizedString(@"Frequently Asked Questions", nil) forState:UIControlStateNormal];
    [bt_securityTip setTitle:NSLocalizedString(@"Security Tips", nil) forState:UIControlStateNormal];
    isHiddenImportantNotice=YES;
    [self.view setAlpha:0.0f];
    
    [scroll_view addSubview:text_view];
    [scroll_view setContentSize:CGSizeMake(scroll_view.frame.size.width, text_view.frame.size.height)];
    
    tabBar.delegate = self;
    ((UITabBarItem *)[tabBar.items objectAtIndex:0]).title = NSLocalizedString(@"MyMPF",nil);
    
    CGRect frame = btnView.frame;
    frame.origin.y = btnViewY+37;
    btnView.frame = frame;
    [btnView setHidden:YES];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.bt_understood.backgroundColor = [UIColor whiteColor];
        self.bt_cancel.backgroundColor = [UIColor whiteColor];
        self.bt_understood.layer.cornerRadius = 7.0;
        self.bt_understood.layer.borderWidth = 1.0;
        [self.bt_understood setTitleColor:[UIColor colorWithRed:36/255.0 green:50/255.0 blue:95/255.0 alpha:0.9] forState:UIControlStateNormal];
        [self.bt_cancel setTitleColor:[UIColor colorWithRed:36/255.0 green:50/255.0 blue:95/255.0 alpha:0.9] forState:UIControlStateNormal];
        self.bt_cancel.layer.cornerRadius = 7.0;
        self.bt_cancel.layer.borderWidth = 1.0;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguage" object:nil];
}

-(void) showContents
{
    start_scrollBtn.accessibilityLabel = NSLocalizedString(@"start_scrollBtn", nil);
    NSArray *subviews = [text_view subviews];
    for (int i=0; i<[subviews count]; i++) {
        UIView *subview = [subviews objectAtIndex:i];
        [subview removeFromSuperview];
    }
    
    subviews = [scroll_view subviews];
    for (int i=0; i<[subviews count]; i++) {
        UIView *subview = [subviews objectAtIndex:i];
        [subview removeFromSuperview];
    }
    [self.bt_loginMBK setTitle:NSLocalizedString(@"Logintomobilebanking",nil) forState:UIControlStateNormal];
    [self.bt_loginMBK addTarget:self action:@selector(call_Logintomobilebanking:) forControlEvents:UIControlEventTouchUpInside];
    self.bt_loginMBK.titleLabel.numberOfLines = 2;
    self.bt_loginMBK.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bt_loginMBK.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.bt_callMPFhotline setTitle:NSLocalizedString(@"CallMPFhotline",nil) forState:UIControlStateNormal];
    [self.bt_callMPFhotline addTarget:self action:@selector(call_CallMPFhotline:) forControlEvents:UIControlEventTouchUpInside];
    self.bt_callMPFhotline.titleLabel.numberOfLines = 2;
    self.bt_callMPFhotline.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bt_callMPFhotline.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    int footer=0;
    
    bt_understood.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [bt_understood setTitle:NSLocalizedString(@"cyberfundsearch.btn.understood",nil) forState:UIControlStateNormal];
    [bt_cancel setTitle:NSLocalizedString(@"cyberfundsearch.btn.Cancel",nil) forState:UIControlStateNormal];
    
    disclaimer_title.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.title",nil);
    
    UITextView *disclaimer_text = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, text_view.frame.size.width, 20)];
    [disclaimer_text setBackgroundColor:[UIColor clearColor]];
    [disclaimer_text setFont:[UIFont systemFontOfSize:13]];
    [disclaimer_text setTextColor:[UIColor whiteColor]];
    [disclaimer_text setScrollEnabled:NO];
    [disclaimer_text setEditable:NO];
    [disclaimer_text setUserInteractionEnabled:NO];
    
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[MPFUtil me ]findImportantNoticePlistPath]];
    if([MBKUtil isLangOfChi]) {
        disclaimer_text.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text_zh"]];
        NSLog(@"disclaimer_text.text :%@", disclaimer_text.text);
    } else {
        disclaimer_text.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text_en"]];
    }
    [text_view addSubview:disclaimer_text];
    
    CGSize maxSize = CGSizeMake(disclaimer_text.frame.size.width, 10000);
    CGSize text_area = [disclaimer_text.text sizeWithFont:disclaimer_text.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    
    disclaimer_text.frame = CGRectMake(disclaimer_text.frame.origin.x, disclaimer_text.frame.origin.y, disclaimer_text.frame.size.width, text_area.height);
    //    [disclaimer_text scrollsToTop];
    footer += disclaimer_text.frame.origin.y + disclaimer_text.frame.size.height + 20;
    
    [text_view addSubview:bt_understood];
    [text_view addSubview:bt_cancel];
    
    bt_understood.frame = CGRectMake(bt_understood.frame.origin.x, footer, bt_understood.frame.size.width, bt_understood.frame.size.height);
    footer += bt_understood.frame.size.height + 20;
    
    bt_cancel.frame = CGRectMake(bt_cancel.frame.origin.x, footer, bt_cancel.frame.size.width, bt_cancel.frame.size.height);
    footer += bt_cancel.frame.size.height + 20;
    
    text_view.frame = CGRectMake(text_view.frame.origin.x, text_view.frame.origin.y, text_view.frame.size.width, footer);
    [scroll_view addSubview:text_view];
    [scroll_view setContentSize:CGSizeMake(scroll_view.frame.size.width, footer)];
    
}

-(void)showBtnView
{
    [btnView setHidden:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = importantAlertView.frame;
    frame.origin.y = 38+[[MyScreenUtil me] getScreenHeightAdjust]/2;
    importantAlertView.frame = frame;
    
    frame = btnView.frame;
    frame.origin.y = btnViewY;
    btnView.frame = frame;
    
    [UIView commitAnimations];
}

-(void)call_Logintomobilebanking:(UIButton *)button
{
    [[MPFUtil me] call_Logintomobilebanking];
}

-(void)call_CallMPFhotline:(UIButton *)button
{
    [[MPFUtil me] call_CallMPFhotline];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

-(void)switchMe{
    if(isHiddenImportantNotice){
        //        [[MPFUtil me] checkingMPFServerReady:self];
        [[MPFUtil me] loadImportantNotice:self];
    }else{
        [self hiddenMe];
    }
}

-(void)showMe {
    CGRect frame1 = btnView.frame;
    frame1.origin.y = btnViewY+37;
    btnView.frame = frame1;
    [btnView setHidden:YES];
    
    CGRect frame2 = importantAlertView.frame;
    frame2.origin.y = 75+[[MyScreenUtil me] getScreenHeightAdjust]/2;
    importantAlertView.frame = frame2;
    
    CGRect frame = scroll_view.frame;
    frame.origin.y = 0;
    [scroll_view scrollRectToVisible:frame animated:YES];
    self.timer1=nil;
    
    [self showContents];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.view setAlpha:1.0f];
    [UIView commitAnimations];
    isHiddenImportantNotice=NO;
}

-(IBAction)hiddenMe_goHome {
    [self hiddenMe];
    
    [[MPFUtil me].MPF_view_controller goHome];
}

-(IBAction)hiddenMe_gotoMPF {
    [self hiddenMe];
    if ([MPFUtil me].MPF_view_controller) {
        [[MPFUtil me].MPF_view_controller release];
        [MPFUtil me].MPF_view_controller = nil;
    }
    [MPFUtil me].MPF_view_controller = [[MPFViewController alloc] initWithNibName:@"MPFViewController" bundle:nil];
    [CoreData sharedCoreData].lastScreen = @"MPFViewController";
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.5];
    //    [MPFUtil me].MPF_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter_20:self];
    //    [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
    //    [[MPFUtil me].MPF_view_controller welcome];
    [[CoreData sharedCoreData].main_view_controller pushViewController:[MPFUtil me].MPF_view_controller animated:NO];
    //    [UIView commitAnimations];
}

-(IBAction)hiddenMe {
    if(self.timer1!=nil) [self.timer1 invalidate];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [self.view setAlpha:0.0f];
    [UIView commitAnimations];
    isHiddenImportantNotice=YES;
}


-(IBAction)exit{
    [[CoreData sharedCoreData].bea_view_controller.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)start_scrollingdown
{
    if(self.timer1==nil){
        self.timer1 =
        [NSTimer
         scheduledTimerWithTimeInterval:0.1
         target:self
         selector:@selector(scrollingdown:)
         userInfo:nil
         repeats:TRUE];
    }
}

-(void)scrollingdown:(NSTimer *)timer
{
    int step=5;
    if(scroll_view.bounds.origin.y < (text_view.frame.size.height-scroll_view.frame.size.height)){
        CGRect frame = scroll_view.frame;
        frame.origin.y = scroll_view.bounds.origin.y+step;
        NSLog(@"scroll_view.bounds.origin.y:%f",scroll_view.bounds.origin.y);
        [scroll_view scrollRectToVisible:frame animated:YES];
    }else{
        if(self.timer1!=nil) [self.timer1 invalidate];
    }
}

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [btnView setHidden:YES];
    
    NSDictionary *user_setting = [PlistOperator openPlistFile:@"user_setting" Datatype:@"NSDictionary"];
    if (user_setting==nil || [[user_setting objectForKey:@"encryted_banking"] length]<=0) {
        
        [self showBtnView];
        
    }else{
        
        [[MPFUtil me] call_Logintomobilebanking];
        
    }
    return;
}

- (void)changeLanguage:(NSNotification *)notification {
    [self setTexts];
    [self showContents];
}
@end
