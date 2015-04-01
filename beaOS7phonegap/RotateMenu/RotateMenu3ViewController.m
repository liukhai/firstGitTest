//  Created by yaojzy on 201303


#import "RotateMenu3ViewController.h"

@interface RotateMenu3ViewController ()

@end

@implementation RotateMenu3ViewController

@synthesize contentView;

@synthesize btnmenu0,
btnmenu1,
btnmenu2,
svmenu,
rmUtil,
btnHome;

@synthesize btnSidemenu;
@synthesize btnMore;
@synthesize btnBack;

@synthesize vc_caller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.rmUtil = [[RotateMenuUtil alloc] init];
        self.rmUtil.rmVC = self;
        CGRect frame3 = self.contentView.frame;
        frame3.origin.x =0;
        frame3.origin.y =0;
        self.view.frame = frame3;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeLanguage:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRM3VCPageTheme:) name:@"ChangePageTheme" object:nil];
    // Do any additional setup after loading the view from its nib.
    [self setupController];

}

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
    
    [self changeRM3VCPageTheme:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [contentView release];
    [rmUtil release];
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

- (void)changeLanguage:(NSNotification *)notification {
    btnMore.accessibilityLabel = NSLocalizedString(@"MoreFunctions", nil);
    btnSidemenu.accessibilityLabel = NSLocalizedString(@"Menu", nil);
    btnBack.accessibilityLabel = NSLocalizedString(@"Back", nil);
}

- (void)changeRM3VCPageTheme:(NSNotification *)notification {
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([pageTheme isEqualToString:@"1"]) {
        UIImage *imageBack = [UIImage imageNamed:@"btn_back.png"];
        [self.btnBack setBackgroundImage:imageBack forState:UIControlStateNormal];
    } else {
        UIImage *imageBack = [UIImage imageNamed:@"btn_back_new.png"];
        [self.btnBack setBackgroundImage:imageBack forState:UIControlStateNormal];
    }
}

@end
