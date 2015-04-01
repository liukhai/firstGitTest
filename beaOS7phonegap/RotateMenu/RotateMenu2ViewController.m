//  Created by yaojzy on 201303


#import "RotateMenu2ViewController.h"

@interface RotateMenu2ViewController ()

@end

@implementation RotateMenu2ViewController

@synthesize contentView;
@synthesize vc_caller;
@synthesize btnmenu0,
btnmenu1,
btnmenu2,
svmenu,
rmUtil,
btnHome;

@synthesize btnSidemenu;
@synthesize btnMore;
@synthesize btnBack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.rmUtil = [[RotateMenuUtil alloc] init];
        self.rmUtil.rmVC = self;
        CGRect frame = self.contentView.frame;
        frame.origin.x =0;
        frame.origin.y =0;
        self.view.frame = frame;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeLanguage:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRM2VCPageTheme:) name:@"ChangePageTheme" object:nil];
    // Do any additional setup after loading the view from its nib.
    [self setupController];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [[PageUtil pageUtil] changeImageForTheme:self.view];
//    NSString *status = [[PageUtil pageUtil] getPageTheme];
//    if ([status isEqualToString:@"1"]) {
//        UIImage *image = [UIImage imageNamed:@"topbar_main_navigation_bar.png"];
//        [self.svmenuImage setImage:image];
//    } else {
//        UIImage *image = [UIImage imageNamed:@"topbar_main_navigation_bar_new.png"];
//        [self.svmenuImage setImage:image];
//    }
//}

- (void)setupController
{
    self.svmenu.delegate = self.rmUtil;
    self.svmenu.contentSize = CGSizeMake(self.svmenu.frame.size.width * 1, self.svmenu.frame.size.height);

    self.btnmenu0.titleLabel.numberOfLines = 0;
    self.btnmenu0.titleLabel.backgroundColor = [UIColor clearColor];
    self.btnmenu0.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnmenu0.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.btnmenu1.titleLabel.numberOfLines = 0;
    self.btnmenu1.titleLabel.backgroundColor = [UIColor clearColor];
    self.btnmenu1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnmenu1.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.btnmenu2.titleLabel.numberOfLines = 0;
    self.btnmenu2.titleLabel.backgroundColor = [UIColor clearColor];
    self.btnmenu2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnmenu2.titleLabel.textAlignment = NSTextAlignmentCenter;

    NSArray* a_btns = [NSArray arrayWithObjects:self.btnmenu0,self.btnmenu1,self.btnmenu2, nil];
    [self.rmUtil setButtonArray:a_btns];
    [self changeRM2VCPageTheme:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [contentView release];
    [rmUtil release];
    [_svmenuImage release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setContentView:nil];
    [super viewDidUnload];
}

- (IBAction)doMenuButtonsPressed:(UIButton *)sender {
    [rmUtil doMenuButtonsPressed:sender];
    if (self.vc_caller) {
        [self.vc_caller doMenuButtonsPressed:sender];
    }
}

- (IBAction)doPressButtonLeft:(id)sender {
    [self.rmUtil rotateMenuF];
}

- (IBAction)doPressButtonRight:(id)sender {
    [self.rmUtil rotateMenu];
}
- (IBAction)doPressButtonMid:(id)sender {
    [self.rmUtil rotateMenuM];
}

- (void)changeLanguage:(NSNotification *)notification {
    btnMore.accessibilityLabel = NSLocalizedString(@"MoreFunctions", nil);
    btnSidemenu.accessibilityLabel = NSLocalizedString(@"Menu", nil);
    btnBack.accessibilityLabel = NSLocalizedString(@"Back", nil);
}

- (void)changeRM2VCPageTheme:(NSNotification *)notification {
    NSLog(@" %@", [self description]);
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    NSLog(@"%@", pageTheme);
    if ([pageTheme isEqualToString:Orange_Red]) {
        UIImage *image = [UIImage imageNamed:@"topbar_main_navigation_bar.png"];
        [self.btnmenu1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_svmenuImage setImage:image];
        UIImage *imageBack = [UIImage imageNamed:@"btn_back.png"];
        [self.btnBack setBackgroundImage:imageBack forState:UIControlStateNormal];
    } else {
        UIImage *image = [UIImage imageNamed:@"topbar_main_navigation_bar_new.png"];
        [self.btnmenu1 setTitleColor:[UIColor colorWithRed:251/255.0 green:221/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
        [_svmenuImage setImage:image];
        UIImage *imageBack = [UIImage imageNamed:@"btn_back_new.png"];
        [self.btnBack setBackgroundImage:imageBack forState:UIControlStateNormal];
    }
}

@end
