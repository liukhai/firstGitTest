//
//  DashBoard.h
//  Citibank Card Offer
//
//  Created by MTel on 05/02/2010.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DashBoardDelegate;

@interface DashBoardController : UIViewController {

	NSMutableArray *icon_list;
	NSArray *filename_list, *label_list, *selected_filename_list;
	UIScrollView *scroll_view;
	UIImageView *background;
	float current_width;
	BOOL start_up_animation;
	id <DashBoardDelegate> delegate;
}

@property (nonatomic, assign) id <DashBoardDelegate> delegate;

-(id)initWithFilenames:(NSArray *)filenames Labels:(NSArray *)labels SelectedFilenames:(NSArray *)selected_filenames;
-(id)initWithFilenames:(NSArray *)filenames Labels:(NSArray *)labels SelectedFilenames:(NSArray *)selected_filenames StartUpAnimation:(BOOL)animation;
-(void)playStartUpAnimation;
-(void)setBackgroundImage:(NSString *)filename;
-(void)setFontColor:(UIColor *)color;
-(void)setSelectedIcon:(int)index;

@end

@protocol DashBoardDelegate

-(void)dashBoard:(DashBoardController *)dashBoard button:(UIButton *)button;

@end

