//  Created by yaojzy on 201303

#import <Foundation/Foundation.h>

@protocol RotateMenuDelegate
@optional
-(void) showMenu:(int)index;
@end

@protocol RotateMenuDelegate2
@optional
-(void) goMainFaster;
@end

#import "CoreData.h"
#import "LangUtil.h"

@class RotateMenuViewController;

@interface RotateMenuUtil : NSObject
<UIScrollViewDelegate>
{
    NSInteger puppy;
    NSArray* rotateMenuTextArray;
    NSInteger rotateMenuShowIndex;
    NSArray* rotateButtonArray;
    NSArray* mainMenuViewArray;
    id rmVC;

    UINavigationController *nav4process;
    id <RotateMenuDelegate> caller;
    UIScrollView * scrollView4Buttons;
}

@property (retain, nonatomic) NSArray* rotateMenuTextArray;
@property (retain, nonatomic) NSArray* rotateButtonArray;
@property (retain, nonatomic) NSArray* mainMenuViewArray;
@property (retain, nonatomic) id rmVC;
@property (retain, nonatomic) UINavigationController *nav4process;

@property (retain, nonatomic) id <RotateMenuDelegate> caller;

@property (assign, nonatomic) BOOL noPop;

-(void)setTextArray:(NSArray*)a_btns;
-(void)setButtonArray:(NSArray*)a_btns;
-(void)setViewArray:(NSArray*)a_views;
-(void)showMenu:(int)show;
-(void)showMenu;
-(void)setShowIndex:(int)show;
-(void)rotateMenu;
-(void)rotateMenuF;
-(void)rotateMenuM;
-(void)setNav:(UINavigationController*)a_nav;
- (IBAction)doMenuButtonsPressed:(UIButton *)sender;

@end

