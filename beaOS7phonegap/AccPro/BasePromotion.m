//
//  BasePromotion.h
//  BEA
//
//  Created by NEO on 14/03/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "BasePromotion.h"
#import "AccProUtil.h"
#import "InsuranceUtil.h"


@implementation BasePromotion

/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

@synthesize webView;

- (void)viewDidLoad {
	[super viewDidLoad];
    
    closeBtn.accessibilityLabel = NSLocalizedString(@"basePromotion.close", nil);
//    closeBtn1.accessibilityLabel = NSLocalizedString(@"basePromotion.close", nil);
//    closeBtn2.accessibilityLabel = NSLocalizedString(@"basePromotion.close", nil);
//    webView.accessibilityElementsHidden = YES;
//    viewForAccessibility.backgroundColor = [UIColor clearColor];
//    viewForAccessibility.accessibilityLabel = NSLocalizedString(@"basePromotion.crazy_ad", nil);
//    view_background.isAccessibilityElement = YES;
    self.view.accessibilityViewIsModal = YES;
    
    self.view.frame = CGRectMake(0, 0, 320, 480+[[MyScreenUtil me] getScreenHeightAdjust]);
    closeBtn.frame = CGRectMake(199, 37+[[MyScreenUtil me] getScreenHeightAdjust]/2, 90, 25);
    webView.frame = CGRectMake(0, 64+[[MyScreenUtil me] getScreenHeightAdjust]/2, 320, 323);
    [closeBtn setBackgroundImage:[[LangUtil me] getImage:@"crazyad_close.png"] forState:UIControlStateNormal ];
    [self.view setAlpha:0.0f];
   
}


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
    [super dealloc];
}


-(void)switchMe{
    [self showMe];
}

-(void)showMe {
    if ([MBKUtil wifiNetWorkAvailable]) {
        [self.webView loadRequest:[HttpRequestUtils getPostRequest4BasePromotionNews]];

        [self saveCount];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5]; 
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.view setAlpha:1.0f];
        [UIView commitAnimations];
    }
}

-(void)saveCount{
    int count;
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[AccProUtil me ]findPlistPath]];
    NSString *date_stamp = [md_temp objectForKey:@"ClickCount"];
    count = [date_stamp intValue]; 
    NSLog(@"hiddenMe beforecount:%d",count);
    
    NSString *counts = [NSString stringWithFormat:@"%d",count+1];
    [md_temp setValue:counts forKey:@"ClickCount"];
    [md_temp writeToFile:[[AccProUtil me ]findPlistPath] atomically:YES];
}

-(IBAction)hiddenMe {
    NSLog(@"[BasePromotion hiddenMe]");
    self.view.accessibilityElementsHidden = YES;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [self.view setAlpha:0.0f];
//    [UIView commitAnimations];
//    isHiddenImportantNotice=YES;
    [self.webView stopLoading];
   
    [[AccProUtil me]._BasePromotion.view removeFromSuperview];
    
//    [[AccProUtil me]._BasePromotion dealloc];

    [UIView commitAnimations];
    [[CoreData sharedCoreData]._BEAAppDelegate registerFirstNotification];
    [[CoreData sharedCoreData]._BEAAppDelegate performSelector:@selector(registerFirstNotification) withObject:nil afterDelay:0.2];
}

-(IBAction)hiddenMeAndOpenAccproForAccessibility {
    NSLog(@"Show Latest Promotion List");
    self.view.accessibilityElementsHidden = YES;
    
    UIButton* acc_pro_button=[[UIButton alloc] init];
    acc_pro_button.tag=13;
    [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
    [self hiddenMe];
    [acc_pro_button release];
}

-(IBAction)hiddenMeAndOpenAccpro{
    NSLog(@"[BasePromotion hiddenMeAndOpenAccpro]");

    [self hiddenMe];
    
//    UIButton* acc_pro_button=[[UIButton alloc] init];
//    acc_pro_button.tag=13;
//    [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];

    [CoreData sharedCoreData].lastScreen = @"LTViewController";
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[CoreData sharedCoreData].root_view_controller setContent:0];
    [(RootViewController*)[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers objectAtIndex:0] setContent:2];
    [CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
    [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
    [UIView commitAnimations];
    [[CoreData sharedCoreData]._BEAAppDelegate performSelector:@selector(registerFirstNotification) withObject:nil afterDelay:0.5];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"BasePromotion webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"BasePromotion didFailLoadWithError:%@", error);
    [self hiddenMe];

}

- (BOOL)webView:(UIWebView *)local_webview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{ 
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/GoToInsurance"]) { 
        NSLog(@"Show Travel Insurance application page");
        [InsuranceUtil me].nextTab = @"news";
        [InsuranceUtil me].quoteAndApply = @"YES";
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=21;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToInsTApply"]) { 
        NSLog(@"Show Travel Insurance application page");
        [InsuranceUtil me].nextTab = @"application";
        [InsuranceUtil me].quoteAndApply = @"YES";
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=21;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToAccPro"]) { 
        NSLog(@"Show Latest Promotion List");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=13;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToTaxLoan"]){
        NSLog(@"Show Tax Loan Offer Page");
        [CoreData sharedCoreData].lastScreen = @"LTViewController";
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[CoreData sharedCoreData].root_view_controller setContent:0];
        [(RootViewController*)[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers objectAtIndex:0] setContent:2];
        [CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
        [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
        [UIView commitAnimations];
        [self hiddenMe];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToConsumerLoans"]) { 
        NSLog(@"goToConsumerLoans");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=6;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToPropertyLoans"]) { 
        NSLog(@"goToPropertyLoans");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=9;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToATM"]) { 
        NSLog(@"goToATM");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=5;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToMKGeCard"]) { 
        NSLog(@"goToMKGeCard");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=17;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToMBK"]) { 
        NSLog(@"goToMBK");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=1;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToEAS"]) { 
        NSLog(@"goToEAS");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=10;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToStockWatch"]) { 
        NSLog(@"goToStockWatch");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=11;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToMPF"]) { 
        NSLog(@"goToMPF");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=12;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToStockGame"]) { 
        NSLog(@"goToStockGame");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=16;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToRateEnquiry"]) { 
        NSLog(@"goToRateEnquiry");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=14;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToHotline"]) { 
        NSLog(@"goToHotline");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=8;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToCardPromo"]) { 
        NSLog(@"goToCardPromo");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=102;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToCardConcert"]) { 
        NSLog(@"goToCardConcert");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=104;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToCardCashInHand"]) { 
        NSLog(@"goToCardCashInHand");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=101;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToCardAllYear"]) { 
        NSLog(@"goToCardAllYear");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=100;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToCardSpending"]) { 
        NSLog(@"goToCardSpending");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=103;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/goToCardGlobalPass"]) { 
        NSLog(@"goToCardGlobalPass");
        UIButton* acc_pro_button=[[UIButton alloc] init];
        acc_pro_button.tag=105;
        [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:acc_pro_button];
        [self hiddenMe];
        [acc_pro_button release];
        return false;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/acc_pro/crazyad_zh.html"]) { 
        return true;
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/acc_pro/crazyad_en.html"]) { 
        return true;
    }      
    return false; 
} 

@end
