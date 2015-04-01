//
//  NewsPhotosViewController.h
//  GZDaily
//
//  Created by Algebra Lo on 10年2月4日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomImageView.h"

@interface NewsPhotosViewController : UIViewController <UIScrollViewDelegate> {
	IBOutlet UILabel *title_label;
	IBOutlet UIPageControl *page_control;
	IBOutlet UIScrollView *scroll_view;
	CGRect scroll_view_original_frame;
	NSArray *items_data;
	NSMutableArray *image_list;
	int news_id, number_of_photos;
}

@property (nonatomic, assign) NSArray *items_data;
@property (nonatomic, assign) int news_id;

-(void)updateContent;
- (IBAction)changePage:(id)sender;
-(void)setItems_data:(NSArray *)itemsdata setNewsid:(int)newsid;
@end
