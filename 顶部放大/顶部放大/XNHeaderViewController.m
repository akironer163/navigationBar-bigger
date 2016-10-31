//
//  XNHeaderViewController.m
//  顶部放大
//
//  Created by user on 16/10/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "XNHeaderViewController.h"

static NSString *cellID = @"cellID";
#define kHearderViewHeight 200

@interface XNHeaderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation XNHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self prepareTableView];
    [self prepareHearderView];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //取消自动调整滚动视图间距
    //ViewController + NAV 会自动调整tableView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES]; 
}

//顶部视图
- (void)prepareHearderView {
    
    UIView *hearderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHearderViewHeight)];
    
    hearderView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:hearderView];
    
    UIImageView *hearderImageView = [[UIImageView alloc] initWithFrame:hearderView.bounds];
    
    hearderImageView.backgroundColor = [UIColor blueColor];
    
    [hearderView addSubview:hearderImageView];
}

- (void)prepareTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:tableView];
    
    //设置表格的间距
    tableView.contentInset = UIEdgeInsetsMake(kHearderViewHeight, 0, 0, 0);
    
    //设置滚动指示器的间距
    tableView.scrollIndicatorInsets = tableView.contentInset;
    
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
