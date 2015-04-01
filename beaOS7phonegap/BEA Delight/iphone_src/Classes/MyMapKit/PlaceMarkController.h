//
//  PlaceMarkController.h
//  MapTest
//
//  Created by MTel on 24/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlaceMarkController : UIViewController {
	IBOutlet UILabel *distance;
	NSString *distance_text;
}

@property (nonatomic, assign) NSString *distance_text;

-(void)updateLabel;
@end
