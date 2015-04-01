//  Created by jasen on 201307

#import "EnquiryCellViewController.h"
#import "AccProMenuViewController.h"
#import "SupremeGoldMenuViewController.h"

@interface EnquiryCellViewController ()

@end

@implementation EnquiryCellViewController

@synthesize nsTitle, nsEmail, nsCall, nsService, nsSubject;
@synthesize navvc;
@synthesize v_content;

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
    // Do any additional setup after loading the view from its nib.
    [self setViewContent];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setViewContent
{
    [lbTitle setText:nsTitle];
    [tvServiceDetails setText:nsService];
    [btnCall setTitle:nsCall forState:UIControlStateNormal];
    [btnEmail setTitle:NSLocalizedString(@"tag_send_us_email", nil) forState:UIControlStateNormal];
    [self setFrame];
}
-(void)setFrame{
    
    lbTitle.numberOfLines = 0;
    [self fitLabelHeight:lbTitle];
    
    mBorderLine.frame = CGRectMake(mBorderLine.frame.origin.x, lbTitle.frame.origin.y, mBorderLine.frame.size.width, [self fitLabelHeight:lbTitle]);
    
//    int height = lbTitle.frame.origin.y + lbTitle.frame.size.height;
    int height = mTopLine.frame.size.height + mBorderLine.frame.size.height;
    NSString *status = [[PageUtil pageUtil] getPageTheme];
    if (![@"" isEqualToString:self.nsAddress]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, height+5, 18, 18)];
        if ([status isEqualToString:@"1"]) {
            imageView.image = [UIImage imageNamed:@"icon_address.png"];
        } else {
            imageView.image = [UIImage imageNamed:@"icon_address_new.png"];
        }
        [self.v_content addSubview:imageView];
        [imageView release];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(48, height+5, 250, 18)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        label.text = self.nsAddress;
        label.numberOfLines = 0;
        [self fitLabelHeight:label];
        [self.v_content addSubview:label];
        height = label.frame.origin.y + label.frame.size.height;
        
    }
    
//    tvServiceDetails.backgroundColor = [UIColor orangeColor];
    tvServiceDetails.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    if (height == lbTitle.frame.origin.y + lbTitle.frame.size.height) {
        mTime.frame = CGRectMake(22, 20, 18, 18);
        tvServiceDetails.frame = CGRectMake(48, 18, 250, 18);
        [self fitLabelHeight:tvServiceDetails];
    } else {
        if (![@"" isEqualToString:self.nsAddress]){
            if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)|| ([[[UIDevice currentDevice] systemVersion] floatValue] == 6.0 && [[UIScreen mainScreen] bounds].size.height > 480)){
                if ([[CoreData sharedCoreData].lang hasPrefix:@"zh_TW"]) {
                    mTime.frame = CGRectMake(22, height+3, 18, 18);
                    tvServiceDetails.frame = CGRectMake(48, height+1, 250, 18);
                    [self fitLabelHeight: tvServiceDetails];
                    //tvServiceDetails.contentInset = UIEdgeInsetsMake(-9.0,0.0,0,0.0);
                    height = tvServiceDetails.frame.origin.y + tvServiceDetails.frame.size.height;
                }else {
                    mTime.frame = CGRectMake(22, height+8, 18, 18);
                    tvServiceDetails.frame = CGRectMake(48, height-4, 250, 18);
                    [self fitLabelHeight: tvServiceDetails];
                    height = tvServiceDetails.frame.origin.y + tvServiceDetails.frame.size.height;
                }
                
            }else {
                mTime.frame = CGRectMake(22, height+8, 18, 18);
                tvServiceDetails.frame = CGRectMake(48, height+6, 250, 18+50);
                [self fitLabelHeight: tvServiceDetails];
                height = tvServiceDetails.frame.origin.y + tvServiceDetails.frame.size.height;
                //tvServiceDetails.contentInset = UIEdgeInsetsMake(-9.0,0.0,0,0.0);
            }

        }else {
            if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) || ([[[UIDevice currentDevice] systemVersion] floatValue] == 6.0 && [[UIScreen mainScreen] bounds].size.height > 480)){
                if ([[CoreData sharedCoreData].lang hasPrefix:@"zh_TW"]) {
                    mTime.frame = CGRectMake(22, height+3, 18, 18);
                    tvServiceDetails.frame = CGRectMake(48, height+1, 250, 18);
                    [self fitLabelHeight: tvServiceDetails];
                    height = tvServiceDetails.frame.origin.y + tvServiceDetails.frame.size.height;
                    //tvServiceDetails.contentInset = UIEdgeInsetsMake(-9.0,0.0,0,0.0);
                }else {
                    mTime.frame = CGRectMake(22, height+8, 18, 18);
                    tvServiceDetails.frame = CGRectMake(48, height-2, 250, 18);
                    [self fitLabelHeight: tvServiceDetails];
                    height = tvServiceDetails.frame.origin.y + tvServiceDetails.frame.size.height;
                }
                
            }else {
                mTime.frame = CGRectMake(22, height+8, 18, 18);
                tvServiceDetails.frame = CGRectMake(48, height+6, 250, 18);
                [self fitLabelHeight: tvServiceDetails];
                height = tvServiceDetails.frame.origin.y + tvServiceDetails.frame.size.height;
                //tvServiceDetails.contentInset = UIEdgeInsetsMake(-9.0,0.0,0,0.0);
            }

        }
        
    }
    
    CGRect mframe;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) || ([[[UIDevice currentDevice] systemVersion] floatValue] == 6.0 && [[UIScreen mainScreen] bounds].size.height > 480)){
        if ([[CoreData sharedCoreData].lang hasPrefix:@"zh_TW"]){
            if (tvServiceDetails.frame.size.height < 55) {
                mframe = mPhone.frame;
                mframe.origin.y = height-5;
                mPhone.frame = mframe;
                
                mframe = btnCall.frame;
                mframe.origin.y = height-5;
                btnCall.frame = mframe;
                height = btnCall.frame.origin.y + btnCall.frame.size.height;
            }else {
                mframe = mPhone.frame;
                mframe.origin.y = height+3;
                mPhone.frame = mframe;
                
                mframe = btnCall.frame;
                mframe.origin.y = height+3;
                btnCall.frame = mframe;
                height = btnCall.frame.origin.y + btnCall.frame.size.height;
            }
            
        }else {
            mframe = mPhone.frame;
            mframe.origin.y = height-2;
            mPhone.frame = mframe;
            
            mframe = btnCall.frame;
            mframe.origin.y = height-2;
            btnCall.frame = mframe;
            height = btnCall.frame.origin.y + btnCall.frame.size.height;
        }
        
    }else {
        if (![@"" isEqualToString:self.nsAddress]){
            mframe = mPhone.frame;
            mframe.origin.y = height-7;
            mPhone.frame = mframe;
            
            mframe = btnCall.frame;
            mframe.origin.y = height-7;
            btnCall.frame = mframe;
            height = btnCall.frame.origin.y + btnCall.frame.size.height;
        }else{
            if (tvServiceDetails.frame.size.height < 50) {
                mframe = mPhone.frame;
                mframe.origin.y = height-9;
                mPhone.frame = mframe;
                
                mframe = btnCall.frame;
                mframe.origin.y = height-9;
                btnCall.frame = mframe;
                height = btnCall.frame.origin.y + btnCall.frame.size.height;
            }else {
                mframe = mPhone.frame;
                mframe.origin.y = height-7;
                mPhone.frame = mframe;
                
                mframe = btnCall.frame;
                mframe.origin.y = height-7;
                btnCall.frame = mframe;
                height = btnCall.frame.origin.y + btnCall.frame.size.height;
            }
            
        }
        
    }
    
    
//    mframe = fitView.frame;
//    mframe.origin.y =  height+10;
//    fitView.frame = mframe;
    
    
    
    if (![@"" isEqualToString:self.nsFax]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, height+5, 18, 18)];
        if ([status isEqualToString:@"1"]) {
            imageView.image = [UIImage imageNamed:@"icon_telephone_15.png"];
        } else {
            imageView.image = [UIImage imageNamed:@"icon_telephone_15_new.png"];
        }
        [self.v_content addSubview:imageView];
        [imageView release];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btnCall.frame.origin.x, height+5, 118, 19);
        [button setTitle:self.nsFax forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(fax:) forControlEvents:UIControlEventTouchUpInside];
        [self.v_content addSubview:button];
        height = button.frame.origin.y + button.frame.size.height;
    }
    
    if ([nsEmail isEqualToString:@""]) {
        btnEmail.hidden = YES;
        height = btnCall.frame.origin.y + btnCall.frame.size.height;
    }else {
        mframe = btnEmail.frame;
        mframe.origin.y = height+7;
        btnEmail.frame = mframe;
        height = btnEmail.frame.origin.y + btnEmail.frame.size.height;
    }
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//        if (![@"" isEqualToString:self.nsAddress]){
//            mframe = mBackgroudImg.frame;
//            mframe.origin.y = lbTitle.frame.origin.y + lbTitle.frame.size.height+7;
//            mframe.size.height = height - mframe.origin.y - 5;
//            mBackgroudImg.frame = mframe;
//        }else {
//            mframe = mBackgroudImg.frame;
//            mframe.origin.y = lbTitle.frame.origin.y + lbTitle.frame.size.height+7;
//            mframe.size.height = height + tvServiceDetails.frame.size.height;
//            mBackgroudImg.frame = mframe;
//        }
//    }else {
        mframe = mBackgroudImg.frame;
        mframe.origin.y = lbTitle.frame.origin.y + lbTitle.frame.size.height+7;
        mframe.size.height = height - mframe.origin.y - 5;
        mBackgroudImg.frame = mframe;
//    }
    
    
    
    mBottomImg.frame = CGRectMake(mBackgroudImg.frame.origin.x, mBackgroudImg.frame.origin.y+mBackgroudImg.frame.size.height, mBottomImg.frame.size.width, mBottomImg.frame.size.height);
    
    mframe = v_content.frame;
    mframe.size.height = mBottomImg.frame.origin.y + mBottomImg.frame.size.height;
    v_content.frame = mframe;
    
}

- (int) fitHeight:(UITextView*)sender
{
    NSLog(@"debug  fitHeight:%@", sender.text);
    
    CGSize maxSize = CGSizeMake(sender.frame.size.width, 2940);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width+10, text_area.height);
    int height = sender.frame.origin.y + sender.frame.size.height;
    NSLog(@"debug  fitHeight:%d", height);
    return height;
}

- (int) fitLabelHeight:(UILabel*)sender
{
    NSLog(@"debug  fitHeight:%@", sender.text);
    
    CGSize maxSize = CGSizeMake(sender.frame.size.width, 1940);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height+2);
    int height = sender.frame.origin.y + sender.frame.size.height;
    NSLog(@"debug  fitHeight:%d", height);
    return height;
}

-(IBAction)call{
    ns_service = @"call";
    
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nsCall message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
    [alert_view show];
    [alert_view release];
}

- (void)fax:(UIButton *)btn{
    ns_service = @"fax";
    
//    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:self.nsFax message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Fax",nil),nil];
//    [alert_view show];
//    [alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *targetURL = [NSString stringWithFormat:@"tel:%@", [[alertView title] stringByReplacingOccurrencesOfString:@" " withString:@""],nil];
    NSLog(@"targetURL is %@", targetURL);
    if ([ns_service isEqualToString:@"call"]) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:targetURL]];
        }
    }
    
}

-(IBAction)email{
    ns_service = @"email";
    
    //	MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
    //	if (![MFMailComposeViewController canSendMail]) {
    //		[mail_controller release];
    //		return;
    //	}
    //	mail_controller.mailComposeDelegate = self;
    //	NSArray* to = [NSArray arrayWithObjects:nsEmail,nil];
    //	NSString* subject = [NSString stringWithFormat:@"%@", nsSubject];
    //	[mail_controller setToRecipients:to];
    //	[mail_controller setSubject:subject];
    //	[self.navvc presentViewController:mail_controller animated:YES completion:nil];
    //
    //    NSLog(@"debug 20140128 EnquiryCellViewController email:%@--%f--%f", self.navvc.view, frame.origin.y, frame.size.height);
    //
    //	[mail_controller release];
    //start -- comment by xu xin long
    //    EMailViewController* email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
    //    NSArray* to = [NSArray arrayWithObjects:nsEmail,nil];
    //    NSString* subject = [NSString stringWithFormat:@"%@", nsSubject];
    //
    //    [email createComposerWithSubject2:subject to:to];
    //    [[CoreData sharedCoreData].bea_view_controller.vc4process.view addSubview:email.view];
    //end -- comment by xu xin long
    
    MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
    if (![MFMailComposeViewController canSendMail]) {
        [mail_controller release];
        return;
    }
    mail_controller.mailComposeDelegate = self;
    NSArray* to = nil;
    to = [NSArray arrayWithObjects:self.nsEmail,nil];
    NSString* subject = [NSString stringWithFormat:@"%@", nsSubject];
    [mail_controller setToRecipients:to];
    [mail_controller setSubject:subject];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect rect = [CoreData sharedCoreData]._BEAAppDelegate.window.frame;
        rect.origin.y = 0;
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame = rect;
    }
    [[CoreData sharedCoreData].main_view_controller presentViewController:mail_controller animated:NO completion:nil];
    [CoreData sharedCoreData].taxLoan_view_controller.tabBar.hidden = YES;
    [[MBKUtil me].queryButton1 setHidden:YES];
    [mail_controller release];
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            
            break;
        case MFMailComposeResultSaved:
            
            break;
        case MFMailComposeResultSent:
            NSLog(@"Sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Fail");
            break;
    }
    [self.navvc dismissViewControllerAnimated:YES completion:nil];
    //    self.navvc.view.frame = frame;
    //    [[MyScreenUtil me] adjustView2Top20:self.navvc.view];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame=CGRectMake(0, 20, 320,[[MyScreenUtil me] getScreenHeight]);
    }
    NSLog(@"debug 20140128 EnquiryCellViewController didFinishWithResult:%@--%f--%f", self.navvc.view, frame.origin.y, frame.size.height);
}

//-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
//	switch (result) {
//		case MFMailComposeResultCancelled:
//
//			break;
//		case MFMailComposeResultSaved:
//
//			break;
//		case MFMailComposeResultSent:
//			NSLog(@"Sent");
//			break;
//		case MFMailComposeResultFailed:
//			NSLog(@"Fail");
//			break;
//	}
//    //	[self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        [CoreData sharedCoreData]._BEAAppDelegate.window.frame=CGRectMake(0, 20, 320,[[MyScreenUtil me] getScreenHeight]);
//    }
//}

- (void)dealloc {
    [mPhone release];
    [mBackgroudImg release];
    [mBottomImg release];
    [fitView release];
    [mTime release];
    [mTopLine release];
    [super dealloc];
}
- (void)viewDidUnload {
    [mPhone release];
    mPhone = nil;
    [mBackgroudImg release];
    mBackgroudImg = nil;
    [mBottomImg release];
    mBottomImg = nil;
    [super viewDidUnload];
}
@end
