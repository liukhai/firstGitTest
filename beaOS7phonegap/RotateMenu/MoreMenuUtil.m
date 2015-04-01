//  Created by jasen on 201305

#import "MoreMenuUtil.h"
#import "CoreData.h"
#import "MyScreenUtil.h"
#import "LangUtil.h"
@implementation MoreMenuUtil

@synthesize _MoreMenuViewController;
@synthesize nav4process, creditCardNav;
@synthesize funcIndex;

+(MoreMenuUtil*) me
{
    static MoreMenuUtil* _me;
    if (!_me) {
        _me = [[MoreMenuUtil alloc] init];
    }
    return _me;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.funcIndex = @"Common";
        
        self._MoreMenuViewController = [[MoreMenuViewController alloc] initWithNibName:@"MoreMenuViewController" bundle:nil];
        self._MoreMenuViewController._MoreMenuUtil = self;
        [[MyScreenUtil me] adjustView2Screen:self._MoreMenuViewController.view];
        [[MyScreenUtil me] adjustView2Screen:self._MoreMenuViewController.viewBG];
        
        [self setMoreMenuViews4Common];
        
        [self hiddenMe];
    }
    return self;
}

-(void)setMoreMenuViews4Common
{
    self.funcIndex = @"Common";
    [self setMoreMenuViews];
}

-(void)setMoreMenuViews4CreditCard
{
    self.funcIndex = @"CreditCard";
    [self setMoreMenuViews];
}

-(void)setMoreMenuViews
{
    [self._MoreMenuViewController setViewsForType:self.funcIndex];
}

-(void)showMe:(UINavigationController*)a_nav
{
    self.nav4process = a_nav;
    [CoreData sharedCoreData].main_view_controller.view.accessibilityElementsHidden = YES;
    [self._MoreMenuViewController.view accessibilityElementDidBecomeFocused];
	self._MoreMenuViewController.view.userInteractionEnabled = TRUE;
	self._MoreMenuViewController.view.hidden = FALSE;
}

-(void)hiddenMe
{
    [CoreData sharedCoreData].main_view_controller.view.accessibilityElementsHidden = NO;
	self._MoreMenuViewController.view.userInteractionEnabled = FALSE;
	self._MoreMenuViewController.view.hidden = TRUE;
}

- (IBAction)doButtonPressed:(UIButton *)sender
{
    [self hiddenMe];
    
    NSLog(@"debug MoreMenuUtil doButtonPressed:%@--%d", self.funcIndex, sender.tag);
    
    if ([self.funcIndex isEqualToString:@"CreditCard"]) {
        switch (sender.tag) {
            case 0://close
                break;
            case 1://nearby
            {
//                [self.nav4process popViewControllerAnimated:NO];
//                UIButton* btn=[[UIButton alloc] init];
//                btn.tag=20106;
//                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:btn];
//                [btn release];
//                NSArray *navCtl = self.nav4process.viewControllers;
//                NSArray *navCtl2 = self.creditCardNav.viewControllers;
             //jerry   [self.nav4process popViewControllerAnimated:NO];
                UIButton* btn=[[UIButton alloc] init];
                btn.tag=6;
                [[CoreData sharedCoreData].home_view_controller buttonPressed:btn];
                [btn release];
            }
                break;
            case 2://search
            {
//                NSArray *navCtl = self.nav4process.viewControllers;
//                NSArray *navCtl2 = self.creditCardNav.viewControllers;
            //    [self.nav4process popViewControllerAnimated:NO];
                UIButton* btn=[[UIButton alloc] init];
                btn.tag=20107;
                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:btn];
                [btn release];
            }
                break;
            case 3://share
            {
//                [[CoreData sharedCoreData].email createComposerWithSubject:NSLocalizedString(@"Check out",nil) Message:NSLocalizedString(@"Main share app",nil)];
//                EMailViewController *email = [CoreData sharedCoreData].email;
                EMailViewController* email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
                [email createComposerWithSubject:NSLocalizedString(@"Check out",nil)
                                         Message:NSLocalizedString(@"Main share app",nil)];
                NSLog(@"%@",email.view.window);
//                if (!email.view.window) {
//                    [[UIApplication sharedApplication].keyWindow addSubview:email.view];
//                }
//                EMailViewController* email = [[EMailViewController alloc] initWithNibName:@"EMailView" bundle:nil];
//                [email createComposerWithSubject:NSLocalizedString(@"Check out",nil)
//                                         Message:NSLocalizedString(@"Main share app",nil)];
//                [sender.superview addSubview:email.view];
            }
                break;
            case 4://favourites
            {
              //  NSArray *navCtl = self.nav4process.viewControllers;
              //  [self.nav4process popViewControllerAnimated:NO];
                UIButton* btn=[[UIButton alloc] init];
                btn.tag=2024;
                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:btn];
//                [[CoreData sharedCoreData].root_view_controller menuButtonPressed:btn];
                [btn release];
            }
                break;
            default:
                break;
        }
    }else {
        NSString * defaultPageStr = [[LangUtil me] getDefaultMainpage];
        switch (sender.tag) {
            case 0://close
                break;
            case 1://main menu
                if ([CoreData sharedCoreData].bea_view_controller != Nil) {
                    [[CoreData sharedCoreData].bea_view_controller.v_rmvc.rmUtil showMenu:[defaultPageStr intValue]];
                }
                [self.nav4process popToRootViewControllerAnimated:YES];
                
                NSLog(@"count =  %lu", (unsigned long)[self.nav4process.viewControllers count]);
                break;
            case 2://settings
            {
                //                [self.nav4process popViewControllerAnimated:NO];
                //                UIButton* btn=[[UIButton alloc] init];
                //                btn.tag=4;
                //                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:btn];
                //                [btn release];
                SettingViewController *vc = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
                if (self.nav4process == nil) {
                    [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:vc animated:TRUE];
                } else {
                    if ([[[CoreData sharedCoreData].main_view_controller topViewController] class] == NSClassFromString(@"RateViewController")) {
                        [[CoreData sharedCoreData].main_view_controller pushViewController:vc animated:TRUE];
                    } else {
                        [self.nav4process pushViewController:vc animated:TRUE];
                    }
                }
                [vc release];
                
            }
                break;
            case 3://favourites
            {
                //                [self.nav4process popViewControllerAnimated:NO];
                //                UIButton* btn=[[UIButton alloc] init];
                //                btn.tag=23;
                //                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:btn];
                //                [btn release];
                FavouriteListViewController* vc = [[FavouriteListViewController alloc] initWithNibName:@"FavouriteListView" bundle:nil];
                if (self.nav4process == nil) {
                    
                    NSLog(@"debug :self.navigationController.view 3:%@ ",[CoreData sharedCoreData].bea_view_controller.navigationController.view);
                    
                    [[MyScreenUtil me] adjustNavView:[CoreData sharedCoreData].bea_view_controller.navigationController.view];
                    
                    [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:vc animated:TRUE];
                } else {
                    NSLog(@"debug :self.navigationController.view 4:%@ ",self.nav4process.view);
                    
                    //                    [[MyScreenUtil me] adjustNavView:self.nav4process.view];
                    
                    [self.nav4process pushViewController:vc animated:TRUE];
                }
                [vc release];
            }
                break;
            case 4://important notice
            {
                //                [self.nav4process popViewControllerAnimated:NO];
                //                UIButton* btn=[[UIButton alloc] init];
                //                btn.tag=24;
                //                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:btn];
                //                [btn release];
                if (self.nav4process == nil) {
                    ImportantNoticeMenuViewController* vc = [[ImportantNoticeMenuViewController alloc] initWithNibName:@"ImportantNoticeMenuViewController" bundle:nil nav:[CoreData sharedCoreData].bea_view_controller.navigationController];
                    [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:vc animated:TRUE];
                    [vc release];
                } else {
                    ImportantNoticeMenuViewController* vc = [[ImportantNoticeMenuViewController alloc] initWithNibName:@"ImportantNoticeMenuViewController" bundle:nil nav:self.nav4process.navigationController];
                    [self.nav4process pushViewController:vc animated:TRUE];
                    [vc release];
                }
            }
                break;
            default:
                break;
        }
    }

//    else {
//         NSString * defaultPageStr = [[LangUtil me] getDefaultMainpage];
//        switch (sender.tag) {
//            case 0://close
//                break;
//            case 1://main menu
//                if ([CoreData sharedCoreData].bea_view_controller != Nil) {
//                  [[CoreData sharedCoreData].bea_view_controller.v_rmvc.rmUtil showMenu:[defaultPageStr intValue]];
//                }
//                [self.nav4process popToRootViewControllerAnimated:YES];
//                break;
//            case 2://site map
//                [[CoreData sharedCoreData].bea_view_controller sideMenuButtonPressed:sender];
//                break;
//            case 3://favourites
//            {
////                [self.nav4process popViewControllerAnimated:NO];
////                UIButton* btn=[[UIButton alloc] init];
////                btn.tag=23;
////                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:btn];
////                [btn release];
//                FavouriteListViewController* vc = [[FavouriteListViewController alloc] initWithNibName:@"FavouriteListView" bundle:nil];
//                if (self.nav4process == nil) {
//                    
//                    NSLog(@"debug :self.navigationController.view 3:%@ ",[CoreData sharedCoreData].bea_view_controller.navigationController.view);
//
//                    [[MyScreenUtil me] adjustNavView:[CoreData sharedCoreData].bea_view_controller.navigationController.view];
//
//                    [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:vc animated:TRUE];
//                } else {
//                    NSLog(@"debug :self.navigationController.view 4:%@ ",self.nav4process.view);
//
////                    [[MyScreenUtil me] adjustNavView:self.nav4process.view];
//
//                    [self.nav4process pushViewController:vc animated:TRUE];
//                }
//                [vc release];
//            }
//                break;
//            case 4://important notice
//            {
////                [self.nav4process popViewControllerAnimated:NO];
////                UIButton* btn=[[UIButton alloc] init];
////                btn.tag=24;
////                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:btn];
////                [btn release];
//                if (self.nav4process == nil) {
//                    ImportantNoticeMenuViewController* vc = [[ImportantNoticeMenuViewController alloc] initWithNibName:@"ImportantNoticeMenuViewController" bundle:nil nav:[CoreData sharedCoreData].bea_view_controller.navigationController];
//                    [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:vc animated:TRUE];
//                    [vc release];
//                } else {
//                    ImportantNoticeMenuViewController* vc = [[ImportantNoticeMenuViewController alloc] initWithNibName:@"ImportantNoticeMenuViewController" bundle:nil nav:self.nav4process.navigationController];
//                    [self.nav4process pushViewController:vc animated:TRUE];
//                    [vc release];
//                }
//            }
//                break;
//            case 5://settings
//            {
////                [self.nav4process popViewControllerAnimated:NO];
////                UIButton* btn=[[UIButton alloc] init];
////                btn.tag=4;
////                [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:btn];
////                [btn release];
//                SettingViewController *vc = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
//                if (self.nav4process == nil) {
//                    [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:vc animated:TRUE];
//                } else {
//                    [self.nav4process pushViewController:vc animated:TRUE];
//                }
//                [vc release];
//
//            }
//                break;
//            case 6://exit
//            {
//                UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"warningmsg_exit",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
//                [alert_view show];
//                [alert_view release];
//            }
//                break;
//            default:
//                break;
//        }
//    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        exit(0);
    }
}

@end
