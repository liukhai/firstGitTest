//
//  ZoomImageView.m
//  Metro
//
//  Created by Algebra Lo on 10年6月15日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomImageView.h"


@implementation ZoomImageView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		image = [[CachedImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		image.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:image];
		self.maximumZoomScale = 5.0;
		self.bouncesZoom = FALSE;
		self.bounces = FALSE;
		self.showsHorizontalScrollIndicator = self.showsVerticalScrollIndicator = FALSE;
		self.delegate = self;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[image removeFromSuperview];
	[image release];
    [super dealloc];
}

-(void)loadImageWithURL:(NSString *)url {
	[image loadImageWithURL:url];
}

-(void)resetSize {
	if (self.zoomScale>1) {
		[UIView beginAnimations:nil context:NULL];
		self.zoomScale = 1.0;
		[UIView commitAnimations];
	}
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return image;
}

-(void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
	self.contentSize = image.frame.size;
}

@end
