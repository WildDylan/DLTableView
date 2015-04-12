//
//  ViewController.m
//  DLTableView
//
//  Created by XueYulun on 15/4/12.
//  Copyright (c) 2015年 DL. All rights reserved.
//

#import "ViewController.h"

#import "DLTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Demo for use
    DLTableView * tableView = [[DLTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.EnableSmoothnessTableView = YES;
    tableView.FullHorizontalSeparateLine = YES;
    tableView.HideUncalledCell = YES;
    tableView.TBGColor = [UIColor greenColor];
    
    [self.view addSubview:tableView];
    
    [tableView setNumberOfSections:^NSInteger(UITableView * tableView) {
        
        return 2;
    }];
    
    [tableView setNumberOfRowsInSection:^NSInteger(UITableView * tableView, NSInteger section) {
        
        return 5;
    }];
    
    [tableView setCellForRowAtIndexPath:^UITableViewCell *(UITableView * tableView, NSIndexPath * indexPath) {
        
        UITableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
        if (!tableViewCell) {
            tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
        }
        tableViewCell.textLabel.text = @"DLTableView";
        return tableViewCell;
    }];
    
    [tableView setSelectIndex:^(UITableView * tableView, NSIndexPath * indexPath) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"Select IndexPath: %@", indexPath);
    }];
    
    [tableView setHeightForRowAtIndexPath:^CGFloat(UITableView * tableView, NSIndexPath * indexPath) {
        
        return 40.;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
