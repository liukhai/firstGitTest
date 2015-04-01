//
//  ZoomImageView.h
//  Metro
//
//  Created by Algebra Lo on 10年6月15日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedImageView.h"

@class CachedImageView;
@interface ZoomImageView : UIScrollView <UIScrollViewDelegate> {
	CachedImageView *image;
}

-(void)loadImageWithURL:(NSString *)url;
-(void)resetSize;
@end
