//Created by Jasen on 201209

#import <Foundation/Foundation.h>

@interface MyScreenUtil : NSObject
{
    UIImage *nav_bar_bg;
    CGPoint _mainScreenCenter;
    CGPoint _mainScreenCenter_20;
    CGPoint _mainScreenLeft;
    CGPoint _mainScreenRight;
    int mainMenuIconColCount;
    int mainMenuIconPageCount;
    int screeHeight;
    int screeHeightAdjust;
}

@property (nonatomic, retain) UIImage *nav_bar_bg;
@property (nonatomic) CGPoint _mainScreenCenter;
@property (nonatomic) CGPoint _mainScreenLeft;
@property (nonatomic) CGPoint _mainScreenRight;
@property (nonatomic) CGPoint _mainScreenCenter_20;
@property (nonatomic) CGPoint _mainScreenLeft_20;
//@property (nonatomic) CGPoint _mainScreenLeft_P20;
@property (nonatomic) CGPoint _mainScreenRight_20;

+(MyScreenUtil*)me;
-(BOOL)adjustNavBackground:(UINavigationController *)navc;
-(BOOL)adjustModuleView:(UIView *)view;
-(CGPoint)getmainScreenCenter:(id)caller;
-(CGPoint)getmainScreenCenter_20:(id)caller;
-(CGPoint)getmainScreenLeft:(id)caller;
-(CGPoint)getmainScreenRight:(id)caller;
-(CGPoint)getmainScreenRight_20:(id)caller;
-(CGPoint)getmainScreenLeft_20:(id)caller;
-(int)getMainMenuIconColCount;
-(int)getMainMenuIconPageCount;
-(int)getScreenHeight;
-(BOOL)adjustModuleTabView:(UIView *)view;
-(BOOL)adjustView2Screen:(UIView*)view;
-(BOOL)adjustViewWithStatusNavbar:(UIView*)view;
-(int)getScreenHeightAdjust;
-(BOOL)adjustNavView:(UIView*)view;
-(void)adjustView2Top0:(UIView*)pView;
-(void)adjustView2Top20:(UIView*)pView;
-(int)getScreenHeightAdjust_20;
-(int)getScreenHeight_IOS7_20;
-(void)adjustmentcontrolY20:(UIView*)pView;
@end
