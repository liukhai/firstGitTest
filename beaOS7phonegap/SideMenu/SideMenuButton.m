//  Created by jasen on 201304

#import "SideMenuButton.h"

#import "sCachedImageView.h"

#define menu_item_font_size 16
#define menu_item_text_x 60
#define menu_item_text_width 220

@implementation SideMenuButton

@synthesize token;

- (id)initWithFrame:(CGRect)aFrame
              title:(NSString*)title_text
               desc:(NSString*)desc_text
               icon:(NSString*)icon_url
                tag:(NSString*)tag_text
{
    self = [super initWithFrame:aFrame];
    if (self) {
        CGRect frame = aFrame;
//        NSLog(@"debug SideMenuButton 1:%f--%f--%f--%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        
        self.token = tag_text;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(menu_item_text_x, 5, menu_item_text_width, 20)];
        [title setText:title_text];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont boldSystemFontOfSize:menu_item_font_size];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.numberOfLines = 0;
        [self addSubview:title];

        frame = title.frame;
//        NSLog(@"debug SideMenuButton 2:%f--%f--%f--%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);

//        CGSize maxSize = CGSizeMake(title.frame.size.width - 20, 100000);
//        CGSize text_area = [title.text sizeWithFont:title.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
//        title.frame = CGRectMake(title.frame.origin.x, title.frame.origin.y, menu_item_text_width, text_area.height + 20);
//        int footer = title.frame.origin.y + title.frame.size.height + 5;
        int footer = [self fitHeight:title]+5;

        frame = title.frame;
//        NSLog(@"debug SideMenuButton 3::%f--%f--%f--%f--%d", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, footer);

        
        UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(menu_item_text_x, footer, menu_item_text_width, 45)];
        [desc setText:desc_text];
        desc.backgroundColor = [UIColor clearColor];
        desc.font = [UIFont systemFontOfSize:menu_item_font_size];
        desc.lineBreakMode = NSLineBreakByWordWrapping;
        desc.numberOfLines = 0;

        [self addSubview:desc];
        frame = desc.frame;
//        NSLog(@"debug SideMenuButton 4::%f--%f--%f--%f--%d", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, footer);
        if ([self fitH:desc]>frame.size.height) {
            footer = [self fitHeight:desc]+5;
        }else{
            footer = frame.size.height+5+footer;
        }


        frame = desc.frame;
//        NSLog(@"debug SideMenuButton 5:%f--%f--%f--%f--%d", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, footer);
        int imageY = (footer -58)/2;
        sCachedImageView* cached_image_view = [[sCachedImageView alloc] initWithFrame:CGRectMake(1, imageY, 58, 58)];
        cached_image_view.contentMode = UIViewContentModeScaleAspectFit;
        cached_image_view.backgroundColor = [UIColor clearColor];
        [cached_image_view loadImageWithURLPermanent:icon_url];
        [self addSubview:cached_image_view];

        [self setBackgroundImage:[UIImage imageNamed:@"sidemenu_bg.png"] forState:UIControlStateNormal];
        //        [self addTarget:self action:@selector(sideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        frame = self.frame;
        frame.size.height = footer;
        self.frame = frame;
        
//        NSLog(@"debug SideMenuButton 6:%f--%f--%f--%f--%d", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, footer);
        
    }
    return self;
}

- (int) fitHeight:(UILabel*)sender
{
    CGSize maxSize = CGSizeMake(sender.frame.size.width, 300);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, text_area.height);
    int height = sender.frame.origin.y + sender.frame.size.height;
    return height;    
}
- (int) fitH:(UILabel*)sender
{
    CGSize maxSize = CGSizeMake(sender.frame.size.width, 100);
    CGSize text_area = [sender.text sizeWithFont:sender.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    return text_area.height;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
