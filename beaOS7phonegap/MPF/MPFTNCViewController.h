//
//  MPFTNCViewController.h
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface MPFTNCViewController : UIViewController {
	IBOutlet UILabel *lbTitle;
	IBOutlet UIWebView *webView;
    IBOutlet UIImageView *lbTitleBackImg;
    NSInteger btnTag;

}
@property(nonatomic, retain)UIWebView *webView;
@property NSInteger btnTag;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil buttonTag:(NSInteger) tag;
@end
