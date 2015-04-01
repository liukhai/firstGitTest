//  Created by jasen on 201304

#import <UIKit/UIKit.h>

@interface SideMenuButton : UIButton
{
    NSString* token;
}

@property (nonatomic, retain)
NSString* token;

- (id)initWithFrame:(CGRect)frame
              title:(NSString*)title_text
               desc:(NSString*)desc_text
               icon:(NSString*)icon_url
                tag:(NSString*)tag_text;
- (id)initDefaultWithFrame:(CGRect)aFrame
                     title:(NSString*)title_text
                      desc:(NSString*)desc_text
                      icon:(NSString*)icon_url
                       tag:(NSString*)tag_text;
@end
