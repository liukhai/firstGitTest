//
//  NewViewController.m
//  LangUtil
//
//  Created by Yilia on 14-6-17.
//  Copyright (c) 2014年 Yilia. All rights reserved.
//

#import "NewViewController.h"
#import "LangUtil.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingLang:) name:@"ChangLanguage" object:nil];
    [[LangUtil me] getLangFromplist];
    [[LangUtil me] setLang_en];
    [[LangUtil me] setLang_hans];
    [[LangUtil me] setLang_hant];
    UIImage *image = [[LangUtil me] getImage:@"crazyad_close.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"next" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(80, 80, 150, 150);
    [self.view addSubview:button];
    // Do any additional setup after loading the view from its nib.
}

- (void)settingLang:(NSNotification *)notification {
    NSLog(@"222222%@", [notification object]);
}

- (void)next:(UIButton *)sender {
    NewViewController *newVC = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [self.navigationController pushViewController:newVC animated:YES];
    [newVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"dealloc new");
}


@end
