//
//  subViewController.h
//  BEA
//
//  Created by jerry on 14-3-8.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataSource;
}
@property (nonatomic, retain) UITableView *table_view;
@property (nonatomic, retain) NSMutableArray *dataSource;
//@property (retain, nonatomic) IBOutlet UITableView *table_view;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSMutableArray *)dataArr;
@end
