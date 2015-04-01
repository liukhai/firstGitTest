//
//  ViewController.m
//  LangUtil
//
//  Created by Yilia on 14-6-16.
//  Copyright (c) 2014年 Yilia. All rights reserved.
//

#import "ViewController.h"
#import "LangUtil.h"
#import "NewViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingLang:) name:@"ChangeLanguage" object:nil];
    [[LangUtil me] getLangFromplist];
    [[LangUtil me] setLang_en];
    [[LangUtil me] setLang_hans];
    [[LangUtil me] setLang_hant];
    UIImage *image = [[LangUtil me] getImage:@"crazyad_close.png"];
    UIImage *image1 = [UIImage imageNamed:@"123.png"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)settingLang:(NSNotification *)notification {
    NSLog(@"111111%@", [notification object]);
    UIImage *image1 = [UIImage imageNamed:@"123.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changEn:(id)sender {
    [[LangUtil me] setLang_en];
    UIImage *image = [[LangUtil me] getImage:@"crazyad_close.png"];
    UIImage *image1 = [UIImage imageNamed:@"123.png"];
}

- (IBAction)changCh:(id)sender {
    [[LangUtil me] setLang_hant];
    UIImage *image = [[LangUtil me] getImage:@"crazyad_close.png"];
//    [image release];
    UIImage *image1 = [UIImage imageNamed:@"123.png"];
}

- (IBAction)nex:(id)sender {
    NewViewController *new = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [self.navigationController pushViewController:new animated:YES];
}

- (void)dealloc {
    NSLog(@"dealloc viewcontroller");
    [super dealloc];
}
@end
