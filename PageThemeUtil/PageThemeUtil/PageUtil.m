//
//  PageUtil.m
//  BEA
//
//  Created by qwer on 15/3/24.
//  Copyright (c) 2015年 The Bank of East Asia, Limited. All rights reserved.
//

#import "PageUtil.h"

@implementation PageUtil

@synthesize btnArray;

static PageUtil *pageUtil;

+(PageUtil *)pageUtil {
    @synchronized(self)
    {
        if (!pageUtil)
        {
            pageUtil = [[self alloc] init];
            pageUtil.btnArray = [[NSMutableArray alloc] init];
            [PageUtil copyConfigSettingFile];
        }
    }
    return pageUtil;
}

-(NSString *)getPageTheme {
    NSMutableDictionary *user_setting = [NSMutableDictionary dictionaryWithContentsOfFile:[PageUtil getDocConfigSettingFilePath]];
    NSString *langname = [user_setting objectForKey:@"pageTheme"];
    if (!langname) {
        langname = @"1";
    }
    return langname;
}

- (void)setPageTheme:(NSString *)defaultname withView:(UIView *)view{
    NSMutableDictionary *setting = [NSMutableDictionary dictionaryWithContentsOfFile:[PageUtil getDocConfigSettingFilePath]];
    [setting setObject:defaultname forKey:@"pageTheme"];
    [setting writeToFile:[PageUtil getDocConfigSettingFilePath] atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangePageTheme" object:self];
    [self changeImageForTheme:view];
}

- (void)changeImageForTheme:(UIView *)view {
    for (UIView *subView in [view subviews]) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subView;
            if (button.orangeImageName != nil || button.redImageName != nil) {
                [self changeImageForButton:button];
            }
        } else if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)subView;
            if (imageView.orangeImageName != nil || imageView.redImageName != nil) {
                [self changeImageForImageView:imageView];
            }
        } else {
            if ([subView subviews] > 0) {
                [self changeImageForTheme:subView];
            }
        }
    }
}

- (void)changeImageForButton:(UIButton *)button {
    NSString *status = [[PageUtil pageUtil] getPageTheme];
    if ([status isEqualToString:@"1"]) {
        UIImage * image = [UIImage imageNamed:button.orangeImageName];
        [button setBackgroundImage:image forState:UIControlStateNormal];
    } else {
        UIImage * image = [UIImage imageNamed:button.redImageName];
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
}

- (void)changeImageForImageView:(UIImageView *)imageView {
    NSString *status = [[PageUtil pageUtil] getPageTheme];
    if ([status isEqualToString:@"1"]) {
        UIImage *image = [UIImage imageNamed:imageView.orangeImageName];
        [imageView setImage:image];
    } else {
        UIImage *image = [UIImage imageNamed:imageView.redImageName];
        [imageView setImage:image];
    }
}

+ (void)copyConfigSettingFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *newFilePath = [documentsDirectory stringByAppendingPathComponent:@"PageThemeConfigSetting.plist"];
    NSString *oldfilePath = [[NSBundle mainBundle] pathForResource:@"PageThemeConfigSetting" ofType:@"plist"];
    
    [[NSFileManager defaultManager] copyItemAtPath:oldfilePath
                                            toPath:newFilePath
                                             error:NULL];
    if ([[NSFileManager defaultManager] fileExistsAtPath:newFilePath]){
        NSLog(@"copyPageThemeConfigSettingFile created:%@", newFilePath);
    }else {
        NSLog(@"copyPageThemeConfigSettingFile fail:%@", newFilePath);
    }
}

+ (NSString *)getDocConfigSettingFilePath
{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PageThemeConfigSetting" ofType:@"plist"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"PageThemeConfigSetting.plist"];
    return filePath;
}


@end
