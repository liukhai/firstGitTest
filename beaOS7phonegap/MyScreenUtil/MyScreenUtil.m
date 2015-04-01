//Created by Jasen on 201209

#import "MyScreenUtil.h"

@implementation MyScreenUtil

@synthesize nav_bar_bg;
@synthesize _mainScreenCenter;
@synthesize _mainScreenLeft;
@synthesize _mainScreenRight;
@synthesize _mainScreenCenter_20;
@synthesize _mainScreenLeft_20;
//@synthesize _mainScreenLeft_P20;
@synthesize _mainScreenRight_20;

+(MyScreenUtil*)me
{
    static MyScreenUtil* me;
    if (!me){
        me = [[MyScreenUtil alloc] init];
    }
    return me;
}

-(id)init
{
    self = [super init];
    if (self){
        self.nav_bar_bg = [UIImage imageNamed:@"bea_logo.png"];
        CGSize result = [[UIScreen mainScreen] bounds].size;
        screeHeight=result.height;
        int ios7VY=0;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            ios7VY=20;
        }
        self._mainScreenCenter = CGPointMake(160, result.height/2);
        self._mainScreenLeft = CGPointMake(-160, result.height/2);
        self._mainScreenRight = CGPointMake(480, result.height/2);
        self._mainScreenCenter_20 = CGPointMake(160, result.height/2-ios7VY);
        self._mainScreenLeft_20 = CGPointMake(-160, result.height/2-ios7VY);
//        self._mainScreenLeft_P20 = CGPointMake(-160, result.height/2+ios7VY);
        self._mainScreenRight_20 = CGPointMake(480, result.height/2-ios7VY);
        if(result.height == 480)
        {
            mainMenuIconColCount=3;
            mainMenuIconPageCount=9;
        }
        if(result.height == 568)
        {
            mainMenuIconColCount=3;
            mainMenuIconPageCount=12;
        }
        screeHeightAdjust = result.height-480;
    
        NSLog(@"debug 20140128 MyScreenUtil init:%f--%f--%d", result.width, result.height, ios7VY);

//        NSLog(@"debug init:%f--%f", self._mainScreenCenter.x, self._mainScreenCenter.y);
    }
    return self;
}

-(BOOL)adjustNavBackground:(UINavigationController *)navc
{
    NSString *reqSysVer = @"5.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//    NSLog(@"debug adjustNavBackground:%@--%@", navc, currSysVer);
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
    {
        [navc.navigationBar setBackgroundImage:self.nav_bar_bg forBarMetrics:UIBarMetricsDefault];
        navc.navigationBar.translucent = NO;
    }
//    NSLog(@"debug adjustNavBackground end navigationBar:%@", [navc.navigationBar.subviews description]);
    return [currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending;
}

-(BOOL)adjustModuleView:(UIView *)view
{
//    NSLog(@"debug adjustModuleView begin:%@", view);
    [self adjustView2Screen:view];
    view.center = self._mainScreenRight;
//    NSLog(@"debug adjustModuleView end:%@", view);
    return YES;
}

-(BOOL)adjustView2Screen:(UIView*)view
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    view.frame = frame;
    return YES;
}
-(BOOL)adjustNavView:(UIView*)view
{
    NSLog(@"debug adjustNavView:%@", view);
    CGRect frame = view.frame;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        frame.size.height=screeHeight-20;
    } else {
        frame.size.height=screeHeight;
    }
    view.frame = frame;
    return YES;
}
-(BOOL)adjustViewWithStatusNavbar:(UIView*)view
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.y += 64;
    frame.size.height -= 84;
    view.frame = frame;
    return YES;
}

-(BOOL)adjustModuleTabView:(UIView *)view
{
    CGRect frame = view.frame;
//    NSLog(@"debug adjustModuleTabView begin:%@", view);
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
        frame.origin.y = 64;
        frame.size.height = 367;
    }
    if(result.height == 568)
    {
        frame.origin.y = 64;
        frame.size.height = 455;
    }
    view.frame = frame;
//    NSLog(@"debug adjustModuleView end:%@", view);
    return YES;
}

-(CGPoint)getmainScreenCenter:(id)caller
{
//    NSLog(@"debug getmainScreenCenter:%@ :_mainScreenCenter: %f", caller ,self._mainScreenCenter.y);
    return self._mainScreenCenter;
}

-(CGPoint)getmainScreenLeft:(id)caller
{
//    NSLog(@"debug getmainScreenLeft:%@", caller);
    return self._mainScreenLeft;
}

-(CGPoint)getmainScreenRight:(id)caller
{
//    NSLog(@"debug getmainScreenRight:%@", caller);
    return self._mainScreenRight;
}
//-(CGPoint)getmainScreenCenter_20:(id)caller
//{
//    //    NSLog(@"debug getmainScreenCenter:%@", caller);
//    CGSize result = [[UIScreen mainScreen] bounds].size;
//    int vy = 0;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0) {
//        vy=20;
//    }
//    return CGPointMake(160, result.height/2-vy);
//}
-(CGPoint)getmainScreenCenter_20 :(id)caller
{
    
    return self._mainScreenCenter_20;
}
-(CGPoint)getmainScreenRight_20:(id)caller
{
    return _mainScreenRight_20;
}
-(CGPoint)getmainScreenLeft_20:(id)caller
{
    return self._mainScreenLeft_20;
}
-(int)getMainMenuIconColCount
{
    return mainMenuIconColCount;
}

-(int)getMainMenuIconPageCount
{
    return mainMenuIconPageCount;
}

-(int)getScreenHeight
{
//    NSLog(@"debug getScreenHeight:%d", screeHeight);
    return screeHeight;
}
-(int)getScreenHeight_IOS7_20
{
    //    NSLog(@"debug getScreenHeight:%d", screeHeight);
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        return screeHeight-20;
    }
    return screeHeight;
}
-(int)getScreenHeightAdjust
{
//    NSLog(@"debug getScreenHeightAdjust:%d", screeHeightAdjust);
    return screeHeightAdjust;
}
-(int)getScreenHeightAdjust_20
{
    //    NSLog(@"debug getScreenHeightAdjust:%d", screeHeightAdjust);
    return screeHeightAdjust-20;
}
-(void)adjustView2Top0:(UIView*)pView
{
    int vy = 20;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0) {
        vy=0;
    }
    CGRect frame = pView.frame;
    frame.origin.y = 0;
    pView.frame = frame;
    return;
}

-(void)adjustView2Top20:(UIView*)pView
{
    int vy = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0) {
        vy=20;
    }
    CGRect frame = pView.frame;
    frame.origin.y = vy;
    pView.frame = frame;
    return;
}
/**
 调整控件的Y坐标 向下移动20
 */
-(void)adjustmentcontrolY20:(UIView*)pView{
    pView.frame = CGRectMake(pView.frame.origin.x, pView.frame.origin.y+ 20,pView.frame.size.width, pView.frame.size.height);
}
@end
