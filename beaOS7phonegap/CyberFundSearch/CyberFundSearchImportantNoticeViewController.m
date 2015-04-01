//  Amended by yaojzy on 3/7/12.

#import "CyberFundSearchImportantNoticeViewController.h"
#import "CyberFundSearchUtil.h"

@implementation CyberFundSearchImportantNoticeViewController

@synthesize scroll_view, text_view;
@synthesize timer1, bt_cancel, bt_understood;
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
    NSArray *subviews = [text_view subviews];
    for (int i=0; i<[subviews count]; i++) {
        UIView *subview = [subviews objectAtIndex:i];
        [subview removeFromSuperview];
    }
    int footer=0;
    
    bt_understood.titleLabel.font = [UIFont boldSystemFontOfSize:13];
	[bt_understood setTitle:NSLocalizedString(@"cyberfundsearch.btn.understood",nil) forState:UIControlStateNormal];
    
	[bt_cancel setTitle:NSLocalizedString(@"cyberfundsearch.btn.Cancel",nil) forState:UIControlStateNormal];
    
    disclaimer_title.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.title",nil);
    if([MBKUtil isLangOfChi]){
        UITextView *disclaimer_text = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, text_view.frame.size.width, 20)];
        [disclaimer_text setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text setFont:[UIFont systemFontOfSize:13]];
        [disclaimer_text setTextColor:[UIColor whiteColor]];
        [disclaimer_text setScrollEnabled:NO];
        [disclaimer_text setEditable:NO];
        [disclaimer_text setUserInteractionEnabled:NO];
        disclaimer_text.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text",nil);
        [text_view addSubview:disclaimer_text];
        
        CGSize maxSize = CGSizeMake(disclaimer_text.frame.size.width, 10000);
//        CGSize maxSize = CGSizeMake(240, 10000);
        CGSize text_area = [disclaimer_text.text sizeWithFont:disclaimer_text.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text.frame = CGRectMake(disclaimer_text.frame.origin.x, disclaimer_text.frame.origin.y, disclaimer_text.frame.size.width, text_area.height);
        footer = disclaimer_text.frame.origin.y + disclaimer_text.frame.size.height;
        
        [text_view addSubview:bt_understood];
        [text_view addSubview:bt_cancel];
        
        bt_understood.frame = CGRectMake(bt_understood.frame.origin.x, footer, bt_understood.frame.size.width, bt_understood.frame.size.height);
        footer += bt_understood.frame.size.height + 20;
        
        bt_cancel.frame = CGRectMake(bt_cancel.frame.origin.x, footer, bt_cancel.frame.size.width, bt_cancel.frame.size.height);
        footer += bt_cancel.frame.size.height + 20;
        
        text_view.frame = CGRectMake(text_view.frame.origin.x, text_view.frame.origin.y, text_view.frame.size.width, footer);
        
        [scroll_view setContentSize:CGSizeMake(scroll_view.frame.size.width, footer)];
    }else{
        UITextView *disclaimer_text_0 = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, text_view.frame.size.width, 20)];
        [disclaimer_text_0 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_0 setFont:[UIFont boldSystemFontOfSize:13]];
        [disclaimer_text_0 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_0 setScrollEnabled:NO];
        [disclaimer_text_0 setEditable:NO];
        [disclaimer_text_0 setUserInteractionEnabled:NO];
        disclaimer_text_0.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.0",nil);
        [text_view addSubview:disclaimer_text_0];
        
        CGSize maxSize = CGSizeMake(disclaimer_text_0.frame.size.width, 10000);
        CGSize text_area = [disclaimer_text_0.text sizeWithFont:disclaimer_text_0.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_0.frame = CGRectMake(disclaimer_text_0.frame.origin.x, disclaimer_text_0.frame.origin.y, disclaimer_text_0.frame.size.width, text_area.height);
        footer = disclaimer_text_0.frame.origin.y + disclaimer_text_0.frame.size.height;
        
        
        UITextView *disclaimer_text_1 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 85)];
        [disclaimer_text_1 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_1 setFont:[UIFont systemFontOfSize:13]];
        [disclaimer_text_1 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_1 setScrollEnabled:NO];
        [disclaimer_text_1 setEditable:NO];
        [disclaimer_text_1 setUserInteractionEnabled:NO];
        disclaimer_text_1.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.1",nil);
        [text_view addSubview:disclaimer_text_1];
        
        maxSize = CGSizeMake(disclaimer_text_1.frame.size.width, 10000);
        text_area = [disclaimer_text_1.text sizeWithFont:disclaimer_text_1.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_1.frame = CGRectMake(disclaimer_text_1.frame.origin.x, disclaimer_text_1.frame.origin.y, disclaimer_text_1.frame.size.width, text_area.height);
        footer = disclaimer_text_1.frame.origin.y + disclaimer_text_1.frame.size.height;
        
        
        UITextView *disclaimer_text_2 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 20)];
        [disclaimer_text_2 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_2 setFont:[UIFont boldSystemFontOfSize:13]];
        [disclaimer_text_2 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_2 setScrollEnabled:NO];
        [disclaimer_text_2 setEditable:NO];
        [disclaimer_text_2 setUserInteractionEnabled:NO];
        disclaimer_text_2.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.2",nil);
        [text_view addSubview:disclaimer_text_2];
        
        maxSize = CGSizeMake(disclaimer_text_2.frame.size.width, 10000);
        text_area = [disclaimer_text_2.text sizeWithFont:disclaimer_text_2.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_2.frame = CGRectMake(disclaimer_text_2.frame.origin.x, disclaimer_text_2.frame.origin.y, disclaimer_text_2.frame.size.width, text_area.height + 5);
        footer = disclaimer_text_2.frame.origin.y + disclaimer_text_2.frame.size.height + 5;
        
        
        UITextView *disclaimer_text_3 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 20)];
        [disclaimer_text_3 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_3 setFont:[UIFont systemFontOfSize:13]];
        [disclaimer_text_3 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_3 setScrollEnabled:NO];
        [disclaimer_text_3 setEditable:NO];
        [disclaimer_text_3 setUserInteractionEnabled:NO];
        disclaimer_text_3.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.3",nil);
        [text_view addSubview:disclaimer_text_3];
        
        maxSize = CGSizeMake(disclaimer_text_3.frame.size.width, 10000);
        text_area = [disclaimer_text_3.text sizeWithFont:disclaimer_text_3.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_3.frame = CGRectMake(disclaimer_text_3.frame.origin.x, disclaimer_text_3.frame.origin.y, disclaimer_text_3.frame.size.width, text_area.height);
        footer = disclaimer_text_3.frame.origin.y + disclaimer_text_3.frame.size.height;
        
        
        UITextView *disclaimer_text_4 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 20)];
        [disclaimer_text_4 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_4 setFont:[UIFont boldSystemFontOfSize:13]];
        [disclaimer_text_4 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_4 setScrollEnabled:NO];
        [disclaimer_text_4 setEditable:NO];
        [disclaimer_text_4 setUserInteractionEnabled:NO];
        disclaimer_text_4.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.4",nil);
        [text_view addSubview:disclaimer_text_4];
        
        maxSize = CGSizeMake(disclaimer_text_4.frame.size.width, 10000);
        text_area = [disclaimer_text_4.text sizeWithFont:disclaimer_text_4.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_4.frame = CGRectMake(disclaimer_text_4.frame.origin.x, disclaimer_text_4.frame.origin.y, disclaimer_text_4.frame.size.width, text_area.height);
        footer = disclaimer_text_4.frame.origin.y + disclaimer_text_4.frame.size.height;
        
        
        UITextView *disclaimer_text_5 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 20)];
        [disclaimer_text_5 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_5 setFont:[UIFont systemFontOfSize:13]];
        [disclaimer_text_5 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_5 setScrollEnabled:NO];
        [disclaimer_text_5 setEditable:NO];
        [disclaimer_text_5 setUserInteractionEnabled:NO];
        disclaimer_text_5.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.5",nil);
        [text_view addSubview:disclaimer_text_5];
        
        maxSize = CGSizeMake(disclaimer_text_5.frame.size.width, 10000);
        text_area = [disclaimer_text_5.text sizeWithFont:disclaimer_text_5.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_5.frame = CGRectMake(disclaimer_text_5.frame.origin.x, disclaimer_text_5.frame.origin.y, disclaimer_text_5.frame.size.width, text_area.height);
        footer = disclaimer_text_5.frame.origin.y + disclaimer_text_5.frame.size.height;
        
        [text_view addSubview:bt_understood];
        [text_view addSubview:bt_cancel];
        
        bt_understood.frame = CGRectMake(bt_understood.frame.origin.x, footer, bt_understood.frame.size.width, bt_understood.frame.size.height);
        footer += bt_understood.frame.size.height + 20;
        
        bt_cancel.frame = CGRectMake(bt_cancel.frame.origin.x, footer, bt_cancel.frame.size.width, bt_cancel.frame.size.height);
        footer += bt_cancel.frame.size.height + 20;
        
        text_view.frame = CGRectMake(text_view.frame.origin.x, text_view.frame.origin.y, text_view.frame.size.width, footer);
        
        [scroll_view setContentSize:CGSizeMake(scroll_view.frame.size.width, footer)];
        
    }
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    
//    self.view.frame = CGRectMake(0, 20, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    pop_view.frame = CGRectMake(20, 75+[[MyScreenUtil me] getScreenHeightAdjust]/2, 280, 343);
    
    isHiddenImportantNotice=YES;
    [self.view setAlpha:0.0f];
    
    [scroll_view addSubview:text_view];
    
	int footer=0;
    
    bt_understood.titleLabel.font = [UIFont boldSystemFontOfSize:13];
	[bt_understood setTitle:NSLocalizedString(@"cyberfundsearch.btn.understood",nil) forState:UIControlStateNormal];
    
	[bt_cancel setTitle:NSLocalizedString(@"cyberfundsearch.btn.Cancel",nil) forState:UIControlStateNormal];
    
    disclaimer_title.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.title",nil);
    
    if([MBKUtil isLangOfChi]){
        UITextView *disclaimer_text = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, text_view.frame.size.width, 20)];
        [disclaimer_text setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text setFont:[UIFont systemFontOfSize:13]];
        [disclaimer_text setTextColor:[UIColor whiteColor]];
        [disclaimer_text setScrollEnabled:NO];
        [disclaimer_text setEditable:NO];
        [disclaimer_text setUserInteractionEnabled:NO];
        disclaimer_text.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text",nil);
        [text_view addSubview:disclaimer_text];
        
        CGSize maxSize = CGSizeMake(disclaimer_text.frame.size.width, 10000);
        CGSize text_area = [disclaimer_text.text sizeWithFont:disclaimer_text.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text.frame = CGRectMake(disclaimer_text.frame.origin.x, disclaimer_text.frame.origin.y, disclaimer_text.frame.size.width, text_area.height);
        footer = disclaimer_text.frame.origin.y + disclaimer_text.frame.size.height;
        
        [text_view addSubview:bt_understood];
        [text_view addSubview:bt_cancel];
        
        bt_understood.frame = CGRectMake(bt_understood.frame.origin.x, footer, bt_understood.frame.size.width, bt_understood.frame.size.height);
        footer += bt_understood.frame.size.height + 20;
        
        bt_cancel.frame = CGRectMake(bt_cancel.frame.origin.x, footer, bt_cancel.frame.size.width, bt_cancel.frame.size.height);
        footer += bt_cancel.frame.size.height + 20;
        
        text_view.frame = CGRectMake(text_view.frame.origin.x, text_view.frame.origin.y, text_view.frame.size.width, footer);
        
        [scroll_view setContentSize:CGSizeMake(scroll_view.frame.size.width, footer)];
    }else{
        UITextView *disclaimer_text_0 = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, text_view.frame.size.width, 20)];
        [disclaimer_text_0 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_0 setFont:[UIFont boldSystemFontOfSize:13]];
        [disclaimer_text_0 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_0 setScrollEnabled:NO];
        [disclaimer_text_0 setEditable:NO];
        [disclaimer_text_0 setUserInteractionEnabled:NO];
        disclaimer_text_0.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.0",nil);
        [text_view addSubview:disclaimer_text_0];
        
        CGSize maxSize = CGSizeMake(disclaimer_text_0.frame.size.width, 10000);
        CGSize text_area = [disclaimer_text_0.text sizeWithFont:disclaimer_text_0.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_0.frame = CGRectMake(disclaimer_text_0.frame.origin.x, disclaimer_text_0.frame.origin.y, disclaimer_text_0.frame.size.width, text_area.height);
        footer = disclaimer_text_0.frame.origin.y + disclaimer_text_0.frame.size.height;
        
        
        UITextView *disclaimer_text_1 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 85)];
        [disclaimer_text_1 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_1 setFont:[UIFont systemFontOfSize:13]];
        [disclaimer_text_1 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_1 setScrollEnabled:NO];
        [disclaimer_text_1 setEditable:NO];
        [disclaimer_text_1 setUserInteractionEnabled:NO];
        disclaimer_text_1.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.1",nil);
        [text_view addSubview:disclaimer_text_1];
        
        maxSize = CGSizeMake(disclaimer_text_1.frame.size.width, 10000);
        text_area = [disclaimer_text_1.text sizeWithFont:disclaimer_text_1.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_1.frame = CGRectMake(disclaimer_text_1.frame.origin.x, disclaimer_text_1.frame.origin.y, disclaimer_text_1.frame.size.width, text_area.height);
        footer = disclaimer_text_1.frame.origin.y + disclaimer_text_1.frame.size.height;
        
        
        UITextView *disclaimer_text_2 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 20)];
        [disclaimer_text_2 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_2 setFont:[UIFont boldSystemFontOfSize:13]];
        [disclaimer_text_2 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_2 setScrollEnabled:NO];
        [disclaimer_text_2 setEditable:NO];
        [disclaimer_text_2 setUserInteractionEnabled:NO];
        disclaimer_text_2.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.2",nil);
        [text_view addSubview:disclaimer_text_2];
        
        maxSize = CGSizeMake(disclaimer_text_2.frame.size.width, 10000);
        text_area = [disclaimer_text_2.text sizeWithFont:disclaimer_text_2.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_2.frame = CGRectMake(disclaimer_text_2.frame.origin.x, disclaimer_text_2.frame.origin.y, disclaimer_text_2.frame.size.width, text_area.height + 5);
        footer = disclaimer_text_2.frame.origin.y + disclaimer_text_2.frame.size.height + 5;
        
        
        UITextView *disclaimer_text_3 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 20)];
        [disclaimer_text_3 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_3 setFont:[UIFont systemFontOfSize:13]];
        [disclaimer_text_3 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_3 setScrollEnabled:NO];
        [disclaimer_text_3 setEditable:NO];
        [disclaimer_text_3 setUserInteractionEnabled:NO];
        disclaimer_text_3.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.3",nil);
        [text_view addSubview:disclaimer_text_3];
        
        maxSize = CGSizeMake(disclaimer_text_3.frame.size.width, 10000);
        text_area = [disclaimer_text_3.text sizeWithFont:disclaimer_text_3.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_3.frame = CGRectMake(disclaimer_text_3.frame.origin.x, disclaimer_text_3.frame.origin.y, disclaimer_text_3.frame.size.width, text_area.height);
        footer = disclaimer_text_3.frame.origin.y + disclaimer_text_3.frame.size.height;
        
        
        UITextView *disclaimer_text_4 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 20)];
        [disclaimer_text_4 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_4 setFont:[UIFont boldSystemFontOfSize:13]];
        [disclaimer_text_4 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_4 setScrollEnabled:NO];
        [disclaimer_text_4 setEditable:NO];
        [disclaimer_text_4 setUserInteractionEnabled:NO];
        disclaimer_text_4.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.4",nil);
        [text_view addSubview:disclaimer_text_4];
        
        maxSize = CGSizeMake(disclaimer_text_4.frame.size.width, 10000);
        text_area = [disclaimer_text_4.text sizeWithFont:disclaimer_text_4.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_4.frame = CGRectMake(disclaimer_text_4.frame.origin.x, disclaimer_text_4.frame.origin.y, disclaimer_text_4.frame.size.width, text_area.height);
        footer = disclaimer_text_4.frame.origin.y + disclaimer_text_4.frame.size.height;
        
        
        UITextView *disclaimer_text_5 = [[UITextView alloc] initWithFrame:CGRectMake(0, footer, text_view.frame.size.width, 20)];
        [disclaimer_text_5 setBackgroundColor:[UIColor clearColor]];
        [disclaimer_text_5 setFont:[UIFont systemFontOfSize:13]];
        [disclaimer_text_5 setTextColor:[UIColor whiteColor]];
        [disclaimer_text_5 setScrollEnabled:NO];
        [disclaimer_text_5 setEditable:NO];
        [disclaimer_text_5 setUserInteractionEnabled:NO];
        disclaimer_text_5.text = NSLocalizedString(@"cyberfundsearch.Disclaimer.text.5",nil);
        [text_view addSubview:disclaimer_text_5];
        
        maxSize = CGSizeMake(disclaimer_text_5.frame.size.width, 10000);
        text_area = [disclaimer_text_5.text sizeWithFont:disclaimer_text_5.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        disclaimer_text_5.frame = CGRectMake(disclaimer_text_5.frame.origin.x, disclaimer_text_5.frame.origin.y, disclaimer_text_5.frame.size.width, text_area.height);
        footer = disclaimer_text_5.frame.origin.y + disclaimer_text_5.frame.size.height;
        
        [text_view addSubview:bt_understood];
        [text_view addSubview:bt_cancel];
        
        bt_understood.frame = CGRectMake(bt_understood.frame.origin.x, footer, bt_understood.frame.size.width, bt_understood.frame.size.height);
        footer += bt_understood.frame.size.height + 20;
        
        bt_cancel.frame = CGRectMake(bt_cancel.frame.origin.x, footer, bt_cancel.frame.size.width, bt_cancel.frame.size.height);
        footer += bt_cancel.frame.size.height + 20;
        
        text_view.frame = CGRectMake(text_view.frame.origin.x, text_view.frame.origin.y, text_view.frame.size.width, footer);
        
        [scroll_view setContentSize:CGSizeMake(scroll_view.frame.size.width, footer)];
        
    }
    
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
    [start_scrollBtn release];
    [super dealloc];
}

-(void)switchMe{
    if(isHiddenImportantNotice){
        [self showMe];
    }else{
        [self hiddenMe];
    }
}

-(void)showMe {
    start_scrollBtn.accessibilityLabel = NSLocalizedString(@"start_scrollBtn", nil);
    CGRect frame = scroll_view.frame;
    frame.origin.y = 0;
    [scroll_view scrollRectToVisible:frame animated:YES];
    self.timer1=nil;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.view setAlpha:1.0f];
	[UIView commitAnimations];
	isHiddenImportantNotice=NO;
}

-(IBAction)hiddenMe_goHome {
    NSLog(@"hiddenMe_goHome");
    [self hiddenMe];
    
//    [[CyberFundSearchUtil me].CyberFundSearch_view_controller goHome];
}

-(IBAction)hiddenMe_gotoCFS {
    NSLog(@"hiddenMe_gotoCFS");
    [self hiddenMe];
    
    [CoreData sharedCoreData].lastScreen = @"CyberFundSearchViewController";
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    [CyberFundSearchUtil me].CyberFundSearch_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter_20:self];
//    [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
    [CyberFundSearchUtil me].CyberFundSearch_view_controller = [[CyberFundSearchViewController alloc] initWithNibName:@"CyberFundSearchViewController" bundle:nil];
    [[CoreData sharedCoreData].main_view_controller pushViewController:[CyberFundSearchUtil me].CyberFundSearch_view_controller animated:NO];
    
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

- (void)changeLanguage:(NSNotification *)notification {
    [self setTexts];
}
@end
