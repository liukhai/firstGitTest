//
//  MHSubmenuItem.h
//  MagicTrader
//
//  Created by Megahub on 10/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MHSubmenuItem : UIButton {
	int			m_iMHSubmenuItemID;
	
}
@property (nonatomic, assign) int m_iMHSubmenuItemID;

//Use this
-(id)initWithMHSubmenuItemID:(int)aSubmenuItemID withFrame:(CGRect)aframe;
+(NSString *)convertMHSubmenuItemIDToMHSubmenuItemString:(int)aSubmenuItemID;
-(void)reloadText;


- (void)dealloc;
@end
