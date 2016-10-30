//
//  XNHeaderViewController.m
//  顶部放大
//
//  Created by user on 16/10/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "XNHeaderViewController.h"

static NSString *cellID = @"cellID";

@interface XNHeaderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation XNHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self prepareTableView];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)prepareTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:tableView];
    
}

#pragma mark: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}
#pragma mark: - UITableViewDelegate

@end
