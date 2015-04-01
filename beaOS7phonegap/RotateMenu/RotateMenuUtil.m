//  Created by yaojzy on 201303

#import "RotateMenuUtil.h"
#import "MoreMenuUtil.h"
#import "SideMenuUtil.h"
#import "SideMenuButton.h"
#import "BEAViewController.h"

@implementation RotateMenuUtil

@synthesize rotateMenuTextArray;
@synthesize rotateButtonArray;
@synthesize mainMenuViewArray;
@synthesize rmVC;
@synthesize nav4process;
@synthesize caller;

-(id)init
{
    self = [super init];
    if (self) {
        puppy = 0;
        self.rotateMenuTextArray = [NSLocalizedString(@"rotatemenu.texts",nil) componentsSeparatedByString:@","];
        rotateMenuShowIndex = 0;
        self.caller = nil;
    }
    
    return self;
}

-(void)setNav:(UINavigationController*)a_nav
{
    NSLog(@"debug RotateMenuUtil setNav begin:%@", a_nav);
    //    NSArray *navCtl = self.nav4process.viewControllers;
    //    NSArray *navCt2 = a_nav.viewControllers;
    self.nav4process = a_nav;
    NSLog(@"debug RotateMenuUtil setNav end:%@", self.nav4process);
}

-(void)setTextArray:(NSArray*)a_btns
{
    self.rotateMenuTextArray = a_btns;
}

-(void)setButtonArray:(NSArray*)a_btns
{
    self.rotateButtonArray = a_btns;
}

-(void)setShowIndex:(int)show
{
    NSLog(@"debug welcome:debug setShowIndex:%d", show);
    rotateMenuShowIndex = show;
}

-(void)setViewArray:(NSArray*)a_views
{
    self.mainMenuViewArray = a_views;
    //    NSLog(@"RotateMenuUtil setViewArray:%@",self.mainMenuViewArray);
    
}

-(void)showMenu
{
    [self showMenu:rotateMenuShowIndex];
}

-(void)showMenu:(int)show
{
    rotateMenuShowIndex = show;
    NSLog(@"show no. %i", show);
    for (int i=0; i<[self.mainMenuViewArray count]; i++) {
        UIView* view = [self.mainMenuViewArray objectAtIndex:i];
        view.accessibilityElementsHidden = YES;
        if (i==show) {
            view.accessibilityElementsHidden = NO;
            [view setHidden:NO];
            //            NSLog(@"RotateMenuUtil showMenu on:%@", view);
        }else{
            [view setHidden:YES];
        }
    }
    int middle = show;
    int left = middle - 1;
    if (left<0) {
        left = [self.rotateMenuTextArray count]-1;
    }
    int right = middle + 1;
    if (right>=[self.rotateMenuTextArray count]) {
        right = 0;
    }
    
    //    NSLog(@"RotateMenuUtil showMenu:%d--%@", rotateMenuShowIndex, self.rotateMenuTextArray);
    UIButton *btn0 = [self.rotateButtonArray objectAtIndex:0];
    UIButton *btn1 = [self.rotateButtonArray objectAtIndex:1];
    UIButton *btn2 = [self.rotateButtonArray objectAtIndex:2];
    
    [btn0 setTitle:[self.rotateMenuTextArray objectAtIndex:left] forState:UIControlStateNormal];
    [btn1 setTitle:[self.rotateMenuTextArray objectAtIndex:middle] forState:UIControlStateNormal];
    [btn2 setTitle:[self.rotateMenuTextArray objectAtIndex:right] forState:UIControlStateNormal];
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (self.rotateMenuTextArray.count == 3 && delegate.openProperty == NO && delegate.openImportant == NO) {
        NSArray *rotateMenuAccessibilityTextArray = self.rotateMenuTextArray;
        
        btn0.accessibilityLabel = [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"page",nil),[rotateMenuAccessibilityTextArray objectAtIndex:left], NSLocalizedString(@"button", nil)];
        btn1.accessibilityLabel = [NSString stringWithFormat:@"%@ %@ %@ %@", NSLocalizedString(@"page",nil),[rotateMenuAccessibilityTextArray objectAtIndex:middle],NSLocalizedString(@"button",nil), NSLocalizedString(@"selected", nil)];
        btn2.accessibilityLabel = [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"page",nil),[rotateMenuAccessibilityTextArray objectAtIndex:right], NSLocalizedString(@"button", nil)];
    }else {
        NSArray *rotateMenuAccessibilityTextArray = self.rotateMenuTextArray;
        btn0.accessibilityLabel = [NSString stringWithFormat:@"%@ %@",[rotateMenuAccessibilityTextArray objectAtIndex:left], NSLocalizedString(@"button", nil)];
        btn1.accessibilityLabel = [NSString stringWithFormat:@"%@ %@ %@", [rotateMenuAccessibilityTextArray objectAtIndex:middle],NSLocalizedString(@"button",nil), NSLocalizedString(@"selected", nil)];
        btn2.accessibilityLabel = [NSString stringWithFormat:@"%@ %@",[rotateMenuAccessibilityTextArray objectAtIndex:right], NSLocalizedString(@"button", nil)];
    }
    
    [btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if (![pageTheme isEqualToString:@"1"]) {
        [btn1 setTitleColor:[UIColor colorWithRed:251/255.0 green:221/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    } else {
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (self.caller) {
        [self.caller showMenu:rotateMenuShowIndex];
    }
}

- (BOOL)accessibilityElementIsFocused{
    return YES;
}
-(void)rotateMenu
{
    if (scrollView4Buttons) {
        [scrollView4Buttons setContentOffset:CGPointMake(0, scrollView4Buttons.contentOffset.y)];
    }
    
    rotateMenuShowIndex++;
    NSLog(@"rotateMenu:%d--%d",rotateMenuShowIndex,[self.mainMenuViewArray count]);
    if (rotateMenuShowIndex>=[self.mainMenuViewArray count]) {
        rotateMenuShowIndex = 0;
    }
//    if (self.caller && ([self.caller isKindOfClass:[ConsumerLoanMenuViewController class]] || [self.caller isKindOfClass:[SupremeGoldMenuViewController class]]) && rotateMenuShowIndex == 3) {
//        [self.caller showMenu:rotateMenuShowIndex];
//        rotateMenuShowIndex --;
//        if (rotateMenuShowIndex<0) {
//            rotateMenuShowIndex = [self.mainMenuViewArray count]-1;
//        }
//    }
    //    NSLog(@"rotateMenu:%d",rotateMenuShowIndex);
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.5];
    
    [self showMenu:rotateMenuShowIndex];
    
    //    [UIView commitAnimations];
    
    //    scrollView4Buttons.bounces = YES;
    
}

-(void)rotateMenuF
{
    if (scrollView4Buttons) {
        [scrollView4Buttons setContentOffset:CGPointMake(0, scrollView4Buttons.contentOffset.y)];
    }
    
    rotateMenuShowIndex--;
    NSLog(@"rotateMenuF:%d--%d",rotateMenuShowIndex,[self.mainMenuViewArray count]);
    if (rotateMenuShowIndex<0) {
        rotateMenuShowIndex = [self.mainMenuViewArray count]-1;
    }
//    if (self.caller && ([self.caller isKindOfClass:[ConsumerLoanMenuViewController class]] || [self.caller isKindOfClass:[SupremeGoldMenuViewController class]]) && rotateMenuShowIndex == 3) {
//        [self.caller showMenu:rotateMenuShowIndex];
//        rotateMenuShowIndex ++;
//        if (rotateMenuShowIndex>=[self.mainMenuViewArray count]) {
//            rotateMenuShowIndex = 0;
//        }
//    }
    //    NSLog(@"rotateMenuF:%d",rotateMenuShowIndex);
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.5];
    
    [self showMenu:rotateMenuShowIndex];
    
    //    [UIView commitAnimations];
    
    //    scrollView4Buttons.bounces = YES;
    
}
-(void)rotateMenuM
{
    //    if (scrollView4Buttons) {
    //        [scrollView4Buttons setContentOffset:CGPointMake(0, scrollView4Buttons.contentOffset.y)];
    //    }
    //    NSLog(@"rotateMenuF:%d--%d",rotateMenuShowIndex,[self.mainMenuViewArray count]);
    //    if (rotateMenuShowIndex<0) {
    //        rotateMenuShowIndex = [self.mainMenuViewArray count]-1;
    //    }
    
    [self showMenu:rotateMenuShowIndex];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    scrollView4Buttons = scrollView;
    puppy = scrollView.contentOffset.x;
    NSLog(@"debug scrollViewWillBeginDragging:%f", scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    puppy -= scrollView.contentOffset.x;
    if (puppy<0) {
        //        scrollView.bounces = NO;
        [self rotateMenu];
    } else if (puppy>0) {
        //        scrollView.bounces = NO;
        [self rotateMenuF];
    }
    NSLog(@"debug scrollViewDidEndDragging:%f", scrollView.contentOffset.x);
    
    //    CGRect frame = scrollView.frame;
    //    NSLog(@"debug scrollViewDidEndDragging scrollView.frame:%f--%f", frame.origin.x, frame.origin.y);
    //    frame.origin.x = 0;
    //    [scrollView scrollRectToVisible:frame animated:NO];
    //
    //    CGPoint center = scrollView.contentOffset;
    //    NSLog(@"debug scrollViewDidEndDragging scrollView.contentOffset:%f--%f", center.x, center.y);
    //    center.x = 0.0;
    //    [scrollView setContentOffset:center animated:NO];
    
    scrollView4Buttons = scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"debug scrollViewDidScroll:%f", scrollView.contentOffset.x);
    if (scrollView.contentOffset.x >= 10) {
        [scrollView setContentOffset:CGPointMake(10, scrollView.contentOffset.y)];
    }
    if (scrollView.contentOffset.x <= -10) {
        [scrollView setContentOffset:CGPointMake(-10, scrollView.contentOffset.y)];
    }
}

- (IBAction)doMenuButtonsPressed:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            //            [self.nav4process popViewControllerAnimated:YES];
            [[CoreData sharedCoreData].bea_view_controller sideMenuButtonPressed:sender];
            break;
        case 1:
            //            NSLog(@"more");
        {
            //            NSArray *navCtl = self.nav4process.viewControllers;
            //            NSArray *navCtl2 = [MoreMenuUtil me].creditCardNav.viewControllers;
            [[MoreMenuUtil me] showMe:self.nav4process];
        }
            break;
        case 2:
            NSLog(@"RotateMenuUtil back:%@", self.nav4process);
            
            //<!--------------MegaHub----------------------------
            if([[[self.nav4process.viewControllers.lastObject description] substringToIndex:3] isEqualToString:@"<MH"] && [[CoreData sharedCoreData].bea_view_controller.m_oMHViewControllers count] > 0){
                [[CoreData sharedCoreData].bea_view_controller backButtonPressed:sender];
            }else{
                //                NSArray *viewControllers = [self.nav4process viewControllers];
                //                if ((self.nav4process == [CoreData sharedCoreData].main_view_controller) && (self.nav4process.viewControllers.count == 2)) {
                //                    CGRect frame = self.nav4process.view.frame;
                //                    frame.size.height = [[MyScreenUtil me] getScreenHeight];
                //                    self.nav4process.view.frame = frame;
                //                }
                BEAAppDelegate *delegate = (BEAAppDelegate *)[[UIApplication sharedApplication] delegate];
//                if (delegate.isClick == YES) {
//                    if ([[CoreData sharedCoreData].lastScreen isEqualToString:@"ConsumerLoanViewController"]) {
//                        NSArray *viewControllers=[self.nav4process viewControllers];
//                        UIViewController *controller=[viewControllers objectAtIndex:[self.nav4process viewControllers].count - 3];
//                        [self.nav4process popToViewController:controller animated:NO];
//                    }else {
//                        [self.nav4process popViewControllerAnimated:NO];
//                        if ([[self.nav4process.viewControllers lastObject] isEqual:[CoreData sharedCoreData].home_view_controller]) {
//                            [self.nav4process popViewControllerAnimated:NO];
//                        }
//                    }
//                    delegate.isClick = NO;
                if (!self.noPop) {
                    [self.nav4process popViewControllerAnimated:NO];
                }
                if ([[self.nav4process.viewControllers lastObject] class] == [HomeViewController class] && ((HomeViewController *)[self.nav4process.viewControllers lastObject]).isPop) {
                    [[MoreMenuUtil me] setMoreMenuViews4Common];
                    [self.nav4process popViewControllerAnimated:NO];
                }
                
            }
            //----------------MegaHub--------------------------!>
            
            break;
            
        default:
            break;
    }
    
}

@end
