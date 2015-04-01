//
//  subViewController.m
//  BEA
//
//  Created by jerry on 14-3-8.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import "subViewController.h"

@interface subViewController ()

@end

@implementation subViewController
@synthesize table_view, dataSource;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSMutableArray *)dataArr
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataSource = [NSMutableArray new];
        dataSource = [dataArr retain];
        table_view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 240, 240) style:UITableViewStylePlain];
        table_view.dataSource = self;
        table_view.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 //   CGRect frame = CGRectMake(0, 100, 300, 260);
 //   self.view.frame = frame;
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 1.0;
  //  table_view.frame = frame;
   // [table_view setBounds:self.table_view.frame];
    [table_view setBounces:NO];
    [table_view setScrollEnabled:NO];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        UIView *customView = [[UIView alloc] initWithFrame:self.view.frame];
//        customView.backgroundColor = [UIColor blackColor];
//      //  UIImageView *customView = [[[UIImageView alloc] initWithFrame:self.view.frame] autorelease];
//     //   [customView setBackgroundColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0]];
//    //    [customView setImage:[UIImage imageNamed:@"popView_backgroundImage.png"]];
    self.table_view.backgroundView = nil;
    self.table_view.backgroundView.backgroundColor = [UIColor darkGrayColor];
//        //self.table_view.backgroundColor = [UIColor grayColor];
//        [customView addSubview:self.table_view];
//        [self.view addSubview:customView];
//    }
//    else {
        [self.view addSubview:table_view];
 //   }
}

- (void)dealloc
{
    [dataSource release];
    [table_view release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([dataSource count] != 0) {
        return [dataSource count];
    }
    else
        return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.table_view.frame.size.height/[dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"myCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (myCell == nil) {
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [myCell.textLabel setText:[dataSource objectAtIndex:indexPath.row]];
    myCell.textLabel.textAlignment = NSTextAlignmentCenter;
    myCell.contentView.backgroundColor = [UIColor whiteColor];
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton addTarget:self action:@selector(dismissAndChangeName:) forControlEvents:UIControlEventTouchUpInside];
    clickButton.backgroundColor = [UIColor clearColor];
    [clickButton setFrame:myCell.contentView.frame];
    clickButton.tag = indexPath.row;
    [myCell.contentView addSubview:clickButton];
    //    CGRect frame = myCell.contentView.frame;
//    [clickButton setFrame:CGRectMake(frame.size.width - 60, 10, 50, 50)];
//    clickButton.tag = 1000+indexPath.row;
//    [myCell.contentView addSubview:clickButton];
    return myCell;
}

- (void)dismissAndChangeName:(UIButton *)btn{
    NSLog(@"Click");
    NSString *nameString = [dataSource objectAtIndex:btn.tag];
    NSArray *dataArr = [NSArray arrayWithObjects:nameString,[NSNumber numberWithInt:btn.tag], nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeName" object:dataArr];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
////    UIButton *button = (UIButton *)[cell.contentView viewWithTag:indexPath.row+1000];
////    [button setBackgroundImage:[UIImage imageNamed:@"name_selected.png"] forState:UIControlStateNormal];
//    NSString *nameString = [dataSource objectAtIndex:indexPath.row];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeName" object:nameString];
//}
@end
