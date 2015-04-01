//
//  OutletMapViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMapViewController.h"
#import "NearBySearchListViewController.h"

@class MyMapViewController;

@interface OutletMapViewController : UIViewController
//<MyMapViewDelegate>
{
	IBOutlet UIView *content_view;
	IBOutlet UIButton *share, *bookmark;
	MyMapViewController *map_view_controller;
	NSMutableArray *annotations;
	NSArray *annotations_detail;
    NSArray  *annotationsDetail;
    NSInteger index;
    float delta;
    BOOL hidden;
}

@property (retain, nonatomic) IBOutlet UIButton *listButton;
@property (retain, nonatomic) IBOutlet UIButton *settingButton;
@property (nonatomic ,retain) MyMapViewController *map_view_controller;
@property (nonatomic, retain) NSDictionary *settingDic;
@property (nonatomic, assign) BOOL isNeedBox;
-(void)hiddenButton:(BOOL)ishidden;
-(void)addAnnotations:(NSArray *)annotationsDetail;
-(void)setSelectedAnnotation:(NSInteger)index Delta:(float)delta;
-(IBAction)shareButtonPressed:(UIButton *)button;
-(IBAction)bookmarkButtonPressed:(UIButton *)button;
@end
