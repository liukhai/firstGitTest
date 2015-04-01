//
//  ArrowImgView.m
//  PhoneStream
//
//  Created by Megahub on 20/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ArrowImgView.h"
#import "MHUtility.h"
#import "MagicTraderAppDelegate.h"
#import "StyleConstant.h"

@implementation ArrowImgView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
	if (self){

		arrowImg = [[UIImage imageNamed:@"green_arrow.png"] retain];
		arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[arrowImgView setImage:arrowImg];
		[self addSubview:arrowImgView];
		[arrowImgView release];
	}
	
	return self;
}


-(id)init{
    self = [super init];
	if (self) {		
		arrowImg = [[UIImage imageNamed:@"green_arrow.png"] retain];
		arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		[arrowImgView setImage:arrowImg];
		[self addSubview:arrowImgView];
		[arrowImgView release];
	}
	return self;
}

-(void)changeValue:(double)f{
	if(f > 0){
		[self updateMode:0];
	}else if(f < 0){
		[self updateMode:2];
	}else{
		[self updateMode:1];
	}
}

-(void)updateMode:(int)i{
	
	if([MHUtility equalsIgnoreCase:[MT_DELEGATE loadDetailStyleString] anotherString:STYLE_DEFAULT]){
		switch (i) {
			case 0:
				@synchronized(arrowImg) {
					if(arrowImg != nil){
						[arrowImg release];
						arrowImg = nil;
					}
					arrowImg = [[UIImage imageNamed:@"green_arrow.png"] retain];
				}
				[self drawInContext:UIGraphicsGetCurrentContext()];
				break;
			case 1:
				@synchronized(arrowImg) {
					if(arrowImg != nil){
						[arrowImg release];
						arrowImg = nil;
					}
					arrowImg = [[UIImage imageNamed:@"invisible_arrow.png"] retain];
				}
				[self drawInContext:UIGraphicsGetCurrentContext()];
				break;
			case 2:
				@synchronized(arrowImg) {
					if(arrowImg != nil){
						[arrowImg release];
						arrowImg = nil;
					}
					arrowImg = [[UIImage imageNamed:@"red_arrow.png"] retain];
				}
				[self drawInContext:UIGraphicsGetCurrentContext()];
				break;
			default:
				break;
		}
		
	}else if([MHUtility equalsIgnoreCase:[MT_DELEGATE loadDetailStyleString] anotherString:STYLE_ChinaStyle]){
		
		switch (i) {
			case 0:
				@synchronized(arrowImg) {
					if(arrowImg != nil){
						[arrowImg release];
						arrowImg = nil;
					}
					arrowImg = [[UIImage imageNamed:@"red_arrow_up.png"] retain];
				}
				[self drawInContext:UIGraphicsGetCurrentContext()];
				break;
			case 1:
				@synchronized(arrowImg) {
					if(arrowImg != nil){
						[arrowImg release];
						arrowImg = nil;
					}
					arrowImg = [[UIImage imageNamed:@"invisible_arrow.png"] retain];
				}
				[self drawInContext:UIGraphicsGetCurrentContext()];
				break;
			case 2:
				@synchronized(arrowImg) {
					if(arrowImg != nil){
						[arrowImg release];
						arrowImg = nil;
					}
					arrowImg = [[UIImage imageNamed:@"green_arrow_down.png"] retain];
				}
				[self drawInContext:UIGraphicsGetCurrentContext()];
				break;
			default:
				break;
		}
		
	}
	
	
}

-(void)drawRect:(CGRect)rect{
	[self drawInContext:UIGraphicsGetCurrentContext()];
}

-(void)drawInContext:(CGContextRef)context{
	[arrowImgView setImage:arrowImg];
}

-(void)dealloc{
	
	if(arrowImg != nil){
		[arrowImg release];
		arrowImg = nil;
	}
		
	[super dealloc];
}




@end
