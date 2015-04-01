//
//  MPFEnquiryViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "MPFEnquiryViewController.h"
#import "MPFUtil.h"


@implementation MPFEnquiryViewController
@synthesize lbmpfCenter,lbhotline;
 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[MyScreenUtil me] adjustmentcontrolY20:btEmail];
        [[MyScreenUtil me] adjustmentcontrolY20:btCall];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitleBackImg];
        [[MyScreenUtil me] adjustmentcontrolY20:lbtag01];
        [[MyScreenUtil me] adjustmentcontrolY20:lbtag02];
        [[MyScreenUtil me] adjustmentcontrolY20:lbtag04];
        
        [[MyScreenUtil me] adjustmentcontrolY20:lbtag05];
        [[MyScreenUtil me] adjustmentcontrolY20:lbtag06];
        [[MyScreenUtil me] adjustmentcontrolY20:lbtag07];
        [[MyScreenUtil me] adjustmentcontrolY20:lbtag08];
        
        [[MyScreenUtil me] adjustmentcontrolY20:lbtag09];
        [[MyScreenUtil me] adjustmentcontrolY20:lbtag10];
        [[MyScreenUtil me] adjustmentcontrolY20:tvAddress];
        [[MyScreenUtil me] adjustmentcontrolY20:lineImg];
        
        [[MyScreenUtil me] adjustmentcontrolY20:button1];
        [[MyScreenUtil me] adjustmentcontrolY20:button2];
        [[MyScreenUtil me] adjustmentcontrolY20:button3];

    }
    
	lbmpfCenter.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
    lbhotline.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];

    [[MPFUtil me] loadEnquiry:self];

}

-(void) showContents
{
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[MPFUtil me ]findEnquiryPlistPath]];
    if([MBKUtil isLangOfChi]) {
        [btCall setTitle:[NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text07_zh"]] forState:UIControlStateNormal];
        [btEmail setTitle:[NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text11_zh"]] forState:UIControlStateNormal];

        lbtag01.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text01_zh"]];
        lbtag02.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text02_zh"]];
        tvAddress.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text03_zh"]];
        lbtag04.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text04_zh"]];
        lbtag05.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text05_zh"]];
        lbtag06.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text06_zh"]];
        lbtag07.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text08_zh"]];
        lbtag08.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text04_zh"]];
        lbtag09.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text09_zh"]];
        lbtag10.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text10_zh"]];
    } else {
        [btCall setTitle:[NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text07_en"]] forState:UIControlStateNormal];
        [btEmail setTitle:[NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text11_en"]] forState:UIControlStateNormal];

        lbtag01.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text01_en"]];
        lbtag02.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text02_en"]];
        tvAddress.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text03_en"]];
        lbtag04.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text04_en"]];
        lbtag05.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text05_en"]];
        lbtag06.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text06_en"]];
        lbtag07.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text08_en"]];
        lbtag08.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text04_en"]];
        lbtag09.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text09_en"]];
        lbtag10.text = [NSString stringWithFormat:@"%@", [md_temp objectForKey:@"text10_en"]];
    }

}

 - (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   }

- (void)viewDidUnload {
    [lbTitleBackImg release];
    lbTitleBackImg = nil;
    [lineImg release];
    lineImg = nil;
    [button1 release];
    button1 = nil;
    [button2 release];
    button2 = nil;
    [button3 release];
    button3 = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [lbTitleBackImg release];
    [lineImg release];
    [button1 release];
    [button2 release];
    [button3 release];
    [super dealloc];
}

-(IBAction)callToEnquiry{
    ns_service = @"call";
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"mpf.enquiries.phone",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}
/*
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([ns_service isEqualToString:@"call"]) {
		if (buttonIndex==1) {
            NSString *telPhone = btCall.currentTitle;
            
            NSString* telString = [NSString stringWithFormat:
                                   @"tel:%@",[telPhone stringByReplacingOccurrencesOfString:@" " withString:@""]
                                   ];
            NSLog(@"call:%@", telString);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
		}
	}
}
*/
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([ns_service isEqualToString:@"email"]) {
		if (buttonIndex==0) {
			MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
			if (![MFMailComposeViewController canSendMail]) {
				[mail_controller release];
				return;
			}
			mail_controller.mailComposeDelegate = self;
			NSArray* to = [NSArray arrayWithObjects:@"TaxLoanEnquiryEmail",nil];
			NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"TaxLoanEnquiryEmailTitle",nil)];
			[mail_controller setToRecipients:to];
			[mail_controller setSubject:subject];
			[self presentViewController:mail_controller animated:YES completion:nil];
			[[MBKUtil me].queryButton1 setHidden:YES];
			[mail_controller release];
		}
	}else if ([ns_service isEqualToString:@"call"]) {
		if (buttonIndex==1) {
            NSString *telString = [NSString stringWithFormat:
                         @"tel:%@",[NSLocalizedString(@"mpf.enquiries.phone",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                         ];
            NSLog(@"%@", telString);
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
		}
	}
	
}

-(IBAction)email{
	ns_service = @"email";
	
	//	UIAlertView* share_alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Send us an email",nil) message:@"" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
	//	share_alert.delegate = self;
	//	[share_alert show];
	//	[share_alert release];
	
	
	MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
	if (![MFMailComposeViewController canSendMail]) {
		[mail_controller release];
		return;
	}
	mail_controller.mailComposeDelegate = self;
	NSArray* to = [NSArray arrayWithObjects:@"beampf@hkbea.com",nil];
	NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"MPFEnquiryEmailTitle",nil)];
	[mail_controller setToRecipients:to];
	[mail_controller setSubject:subject];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect rect = [CoreData sharedCoreData]._BEAAppDelegate.window.frame;
        rect.origin.y = 0;
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame = rect;
    }
	[self.navigationController presentViewController:mail_controller animated:YES completion:nil];
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
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
	[CoreData sharedCoreData].taxLoan_view_controller.tabBar.hidden = NO;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect rect = [CoreData sharedCoreData]._BEAAppDelegate.window.frame;
        rect.origin.y = 20;
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame = rect;
    }
}


@end
