//
//  SupremeGoldUtil.m
//  BEA
//
//  Created by Ledp944 on 14-9-10.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

//
//  ConsumerLoanUtil.m
//  BEA
//
//  Created by NEO on 11/14/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "SupremeGoldUtil.h"
#import "SupremeGoldOffersViewController.h"
#import "SGViewController.h"


@implementation SupremeGoldUtil

@synthesize SupremeGold_view_controller;
@synthesize strSend;
@synthesize frompage;
@synthesize revolvingLoanUrl;

+ (SupremeGoldUtil *)me
{
	static SupremeGoldUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[SupremeGoldUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"SupremeGoldUtil init");
    self = [super init];
    if (self) {
        self.SupremeGold_view_controller = nil;
        
        self.strSend = nil;
        self.frompage = nil;
        self.revolvingLoanUrl = nil;
        
    }
    
    return self;
}

-(void)callToApply{
	UIAlertView *alert_view = [[UIAlertView alloc]
                               initWithTitle:NSLocalizedString(@"LTAlert_ApplicationHotline",nil)
                               message:nil
                               delegate:self
                               cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                               otherButtonTitles:NSLocalizedString(@"LTAlert_SupremeGold",nil),
                               NSLocalizedString(@"LTAlert_AutoPayroll",nil),
                               NSLocalizedString(@"LTAlert_TaxLoan",nil),
                               nil
                               ];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex:%d", buttonIndex);
    NSString* telString=nil;
	if (buttonIndex==1) {
        telString = [NSString stringWithFormat:
                     @"tel:%@",[NSLocalizedString(@"LTAlert_SupremeGold.call",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                     ];
	}else if (buttonIndex==2) {
        telString = [NSString stringWithFormat:
                     @"tel:%@",[NSLocalizedString(@"LTAlert_AutoPayroll.call",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                     ];
	}else if (buttonIndex==3) {
        telString = [NSString stringWithFormat:
                     @"tel:%@",[NSLocalizedString(@"LTAlert_TaxLoan.call",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]
                     ];
	}else {
        return;
    }
    NSLog(@"call:%@", telString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
}

+ (BOOL) isLangOfChi
{
	return [[[[LangUtil me] getLangPref] lowercaseString] hasPrefix:@"zh"];
}

-(BOOL)isSend
{
    return ([self.strSend isEqualToString:@"YES"]);
}

//-(void)showConsumerLoanOffersViewController:(NSString*)url
//                                    hotline:(NSString*)hotline
//                                   btnLanel:(NSString*)btnLabel//added by jasen on 20111118
//                                        tnc:(NSString*)tncurl
//                                       url2:url2
//                                  url2label:url2label
-(void)showSupremeGoldOffersViewController:(NSDictionary*)merchant
{
    RootViewController* _RootViewController = (RootViewController*)[[SupremeGoldUtil me].SupremeGold_view_controller.navigationController.viewControllers objectAtIndex:0];
    [_RootViewController.navigationController popToRootViewControllerAnimated:NO];
    SupremeGoldOffersViewController* current_view_controller =
    //    [[ConsumerLoanOffersViewController alloc] initWithNibName:@"ConsumerLoanOffersViewController"
    //                                                       bundle:nil
    //                                                          url:url
    //                                                      hotline:hotline
    //                                                     btnLabel:btnLabel
    //                                                          tnc:tncurl
    //                                                         url2:url2
    //                                                    url2label:url2label];
    [[SupremeGoldOffersViewController alloc] initWithNibName:@"SupremeGoldOffersViewController"
                                                       bundle:nil
                                                     merchant:merchant];
    
    current_view_controller.functionName = NSLocalizedString(@"tag_fav_privileges",nil);
    current_view_controller.submenuName = @"";
    
    //    NSLog(@"ConsumerLoanUtil showConsumerLoanOffersViewController current_view_controller:%@-\n-%@-\n-%@-\n-%@-\n-%@",
    //          [CoreData sharedCoreData].bea_view_controller.vc4process,
    //          _RootViewController,
    //          current_view_controller,
    //          url,
    //          tncurl);
    NSLog(@"SupremeGoldnUtil showSupremeGoldOffersViewController current_view_controller:%@-\n-%@-\n-%@-\n-%@",
          [CoreData sharedCoreData].bea_view_controller.vc4process,
          _RootViewController,
          current_view_controller,
          merchant);
    [_RootViewController.navigationController pushViewController:current_view_controller animated:NO];
}

//-(void)showConsumerLoanViewController:(NSString*)lastScreenName
//                                  url:(NSString*)url
//                              hotline:(NSString*)hotline
//                             btnLanel:(NSString*)btnLabel//added by jasen on 20111118
//                                  tnc:(NSString*)tncurl
//                                  url2:(NSString*)url2
//                                  url2label:(NSString*)url2label
-(void)showSupremeGoldViewController:(NSString*)lastScreenName
                             merchant:(NSDictionary*)merchant
{
    self.frompage = lastScreenName;
    //    self.revolvingLoanUrl = url;
    self.revolvingLoanUrl = [merchant objectForKey:@"image"];
    NSLog(@"SupremeGoldUtil showSupremeGoldViewController from:%@", self.frompage);
    
    if ([self.frompage isEqualToString:@"AccProListViewController"]){
        //        if ([CoreData sharedCoreData].bea_view_controller->jump1) {
        //            [CoreData sharedCoreData].bea_view_controller->jump1 = NO;
        //
        //            [[CoreData sharedCoreData].root_view_controller setContent:0];
        //            [self showConsumerLoanOffersViewController:url
        //                                               hotline:hotline
        //                                              btnLanel:btnLabel
        //                                                   tnc:tncurl];
        //            [ConsumerLoanUtil me].ConsumerLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
        //            [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
        //            [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
        //        } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[CoreData sharedCoreData].root_view_controller setContent:0];
        //            [self showConsumerLoanOffersViewController:url
        //                                               hotline:hotline
        //                                              btnLanel:btnLabel
        //                                                   tnc:tncurl
        //                                                  url2:url2
        //                                             url2label:url2label];
        [self showSupremeGoldOffersViewController:merchant];
        [SupremeGoldUtil me].SupremeGold_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
        [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
        [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
        [UIView commitAnimations];
        //        }
    }else if ([self.frompage isEqualToString:@"SupremeGoldListViewController"]){
        /*
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDuration:0.5];
         [[CoreData sharedCoreData].root_view_controller setContent:0];
         [self showConsumerLoanOffersViewController:url
         hotline:hotline
         btnLanel:btnLabel
         tnc:tncurl
         url2:url2
         url2label:url2label];
         [ConsumerLoanUtil me].ConsumerLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
         [CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
         [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
         [UIView commitAnimations];
         */
        SupremeGoldOffersViewController* current_view_controller =
        //        [[ConsumerLoanOffersViewController alloc] initWithNibName:@"ConsumerLoanOffersViewController"
        //                                                           bundle:nil
        //                                                              url:url
        //                                                          hotline:hotline
        //                                                         btnLabel:btnLabel
        //                                                              tnc:tncurl
        //                                                             url2:url2
        //                                                        url2label:url2label];
        [[SupremeGoldOffersViewController alloc] initWithNibName:@"SupremeGoldOffersViewController"
                                                           bundle:nil
                                                         merchant:merchant];
        current_view_controller.fromType = @"SG";
        current_view_controller.functionName = NSLocalizedString(@"ConsumerLoanMenu",nil);
        current_view_controller.submenuName = NSLocalizedString(@"tag_offers",nil);
        
        NSLog(@"SupremeGoldUtil showSupremeGoldViewController current_view_controller:%@-\n-%@-\n-%@",
              [CoreData sharedCoreData].bea_view_controller.vc4process,
              current_view_controller,
              merchant);
        [[CoreData sharedCoreData].sg_view_controller.navigationController pushViewController:current_view_controller animated:NO];
    }
}

-(void)backToFromPage//added by jasen on 20111118
{
    NSLog(@"ConsumerLoanUtil backToFromPage to:%@", self.frompage);
    
    if ([self.frompage isEqualToString:@"SupremeGoldListViewController"]){
        
        /*       [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDuration:0.5];
         [ConsumerLoanUtil me].ConsumerLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];           */
        //        [CoreData sharedCoreData].taxLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
        [[CoreData sharedCoreData].main_view_controller pushViewController:[CoreData sharedCoreData].sg_view_controller animated:NO];
        NSLog(@"Navigation Revamp - Consumer Loan - ConsumerLoanUtil.m");
        /*    [UIView commitAnimations];            */
        self.frompage=@"";
    }else if ([self.frompage isEqualToString:@"AccProListViewController"]){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [SupremeGoldUtil me].SupremeGold_view_controller.view.center = [[MyScreenUtil me] getmainScreenRight:self];
        [AccProUtil me].AccPro_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
        [UIView commitAnimations];
        self.frompage=@"";
    }
}

-(void)showNearBy//added by jasen on 20111118
{
    [CoreData sharedCoreData].lastScreen = @"ConsumerLoanRevamp";
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[CoreData sharedCoreData].root_view_controller setContent:0];
    [CoreData sharedCoreData].atmlocation_view_controller.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    [ConsumerLoanUtil me].ConsumerLoan_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
    [[CoreData sharedCoreData].atmlocation_view_controller welcome];
    
    [UIView commitAnimations];
    
}
@end

