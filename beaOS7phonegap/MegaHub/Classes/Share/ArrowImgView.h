//
//  ArrowImgView.h
//  PhoneStream
//
//  Created by Megahub on 20/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ArrowImgView : UIView {
	UIImage			*arrowImg;
	UIImageView		*arrowImgView;
}


-(void)drawInContext:(CGContextRef)context;
-(void)updateMode:(int)i;
-(void)changeValue:(double)f;

@end
