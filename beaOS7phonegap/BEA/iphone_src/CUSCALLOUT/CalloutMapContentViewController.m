//  Created by jasen on 201303

#import "CalloutMapContentViewController.h"
#import "LangUtil.h"
@interface CalloutMapContentViewController ()

@end

@implementation CalloutMapContentViewController

@synthesize calloutTitle;
@synthesize address;
@synthesize service;
@synthesize strTitle, strAddress, strService, strTel, strFax;
@synthesize imgAddress, imgHour, imgTel, btnTel, imgBG, btnClose, imgFax, fax_Label;
@synthesize viewContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setText4ATM
{
    [self.calloutTitle setText:strTitle];
    [self.address setText:strAddress];
    [self.service setText:strService];
    [self.btnTel setTitle:strTel forState:UIControlStateNormal];
    [self.fax_Label setText:strFax];
    
    //edit buy chu 20150223
    self.calloutTitle.accessibilityLabel = strTitle;
    self.address.accessibilityLabel = strAddress;
    self.service.accessibilityLabel = strService;
    self.btnTel.accessibilityLabel = strTel;
    self.fax_Label.accessibilityLabel = strFax;
    
    self.calloutTitle.accessibilityTraits = UIAccessibilityTraitStaticText;
    self.address.accessibilityTraits = UIAccessibilityTraitStaticText;
    self.service.accessibilityTraits = UIAccessibilityTraitStaticText;
    self.btnTel.accessibilityTraits = UIAccessibilityTraitStaticText;
    self.fax_Label.accessibilityTraits = UIAccessibilityTraitStaticText;
    
    self.btnTel.accessibilityLabel = strTel;
    self.btnClose.accessibilityLabel = NSLocalizedString(@"tag_moremenu_close", nil);
    self.btnClose2.accessibilityLabel = NSLocalizedString(@"tag_moremenu_close", nil);
    self.btnClose2.isAccessibilityElement = NO;
    
    self.closeImage.accessibilityLabel = NSLocalizedString(@"tag_moremenu_close", nil);
    
    [self setPlace4ATM];
}

- (void)setPlace4ATM
{
    int footer;
    CGRect frame;
    footer = [self fitHeight:calloutTitle] + 5;
    
    if ([address.text length]>0) {
        frame = address.frame;
        frame.origin.y = footer;
        address.frame = frame;
        
        frame = imgAddress.frame;
        frame.origin.y = footer;
        imgAddress.frame = frame;
        [imgAddress setHidden:NO];
        footer = [self fitHeight:address] + 5;
    } else {
        [imgAddress setHidden:YES];
    }
    
    if ([service.text length]>0) {
        frame = imgHour.frame;
        frame.origin.y = footer;
        imgHour.frame = frame;
        [imgHour setHidden:NO];
        
        frame = service.frame;
        frame.origin.y = footer;
        service.frame = frame;
        footer = [self fitHeight:service] + 5;
    } else {
        [imgHour setHidden:YES];
        footer += 5;
    }
    
    if (strTel !=nil && ![strTel isEqualToString:@""]) {
        frame = imgTel.frame;
        frame.origin.y = footer;
        imgTel.frame = frame;
        
        frame = btnTel.frame;
        frame.origin.y = footer;
        btnTel.frame = frame;
        footer += btnTel.frame.size.height + 5;
    } else {
        [imgTel setHidden:YES];
        [btnTel setHidden:YES];
    }
    
//    if (strFax !=nil && ![strFax isEqualToString:@""]) {
//        frame = imgFax.frame;
//        frame.origin.y = footer;
//        imgFax.frame = frame;
//        
//        frame = fax_Label.frame;
//        frame.origin.y = footer;
//        fax_Label.frame = frame;
//        footer += fax_Label.frame.size.height + 5;
//    } else {
//        [imgFax setHidden:YES];
//        [fax_Label setHidden:YES];
//    }

    frame = imgBG.frame;
    frame.size.height = footer;
    imgBG.frame = frame;

    frame = self.view.frame;
    frame.size.height = footer;
    self.view.frame = frame;
}

- (void)setText4CreditCard
{
    [self.calloutTitle setText:strTitle];
//    [self.address setText:strAddress];
//    [self.service setText:strService];
//    [self.btnTel setTitle:strTel forState:UIControlStateNormal];
    
    [self setPlace4CreditCard];
}

- (void)setPlace4CreditCard
{
    int footer;
    CGRect frame;
    footer = [self fitHeight:calloutTitle] + 5;
    
//    frame = address.frame;
//    frame.origin.y = footer;
//    address.frame = frame;
//    
//    frame = imgAddress.frame;
//    frame.origin.y = footer;
//    imgAddress.frame = frame;
    [imgAddress setHidden:YES];
    
//    footer = [self fitHeight:address] + 5;
//    
//    frame = imgHour.frame;
//    frame.origin.y = footer;
//    imgHour.frame = frame;
    [imgHour setHidden:YES];

//    frame = service.frame;
//    frame.origin.y = footer;
//    service.frame = frame;
//    footer = [self fitHeight:service];
//    
//    footer = [self fitHeight:service] + 5;
//    
//    if (strTel !=nil && ![strTel isEqualToString:@""]) {
//        frame = imgTel.frame;
//        frame.origin.y = footer;
//        imgTel.frame = frame;
//        
//        frame = btnTel.frame;
//        frame.origin.y = footer;
//        btnTel.frame = frame;
//        footer += btnTel.frame.size.height + 5;
//    } else {
        [imgTel setHidden:YES];
        [btnTel setHidden:YES];
//    }
    
    frame = imgBG.frame;
    frame.size.height = footer;
    imgBG.frame = frame;
    
    frame = self.view.frame;
    frame.size.height = footer;
    self.view.frame = frame;
}

- (int) fitHeight:(UILabel*)sender
{
    CGSize maxSize = CGSizeMake(sender.frame.size.width, MAXFLOAT);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height);
    int height = sender.frame.origin.y + sender.frame.size.height;
    return height;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setText4ATM];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [imgAddress release];
    [imgHour release];
    [imgTel release];
    [btnTel release];
    [imgBG release];
    [btnClose release];
    [viewContent release];
    [_btnClose2 release];
    [imgFax release];
    [fax_Label release];
    [_closeImage release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setImgAddress:nil];
    [self setImgHour:nil];
    [self setImgTel:nil];
    [self setBtnTel:nil];
    [self setImgBG:nil];
    [self setBtnClose:nil];
    [self setViewContent:nil];
    [super viewDidUnload];
}

- (IBAction)closeButtonPressed:(id)sender {
    NSLog(@"debug callout closed");
    [self.viewContent setHidden:YES];
}

- (IBAction)doCall:(UIButton*)sender {
    //[viewContent setHidden:YES];
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:strTel message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
    [alert_view show];
    [alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *targetURL = [NSString stringWithFormat:@"tel:%@", [alertView title],nil];
    
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[targetURL stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    }
}


@end
