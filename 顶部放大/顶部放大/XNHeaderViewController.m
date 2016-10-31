//
//  XNHeaderViewController.m
//  顶部放大
//
//  Created by user on 16/10/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "XNHeaderViewController.h"
#import "HMObjcSugar.h"
#import "YYWebImage.h"
@import AFNetworking;


static NSString *cellID = @"cellID";
#define kHearderViewHeight 200

@interface XNHeaderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation XNHeaderViewController {
    UIView *_hearderView;
    UIImageView *_hearderImageView;
}

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

//设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//顶部视图
- (void)prepareHearderView {
    
    _hearderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHearderViewHeight)];
    
    _hearderView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_hearderView];
    
    _hearderImageView = [[UIImageView alloc] initWithFrame:_hearderView.bounds];
    
    _hearderImageView.backgroundColor = [UIColor blueColor];
    
    [_hearderView addSubview:_hearderImageView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.who.int/entity/campaigns/immunization-week/2015/large-web-banner.jpg?ua=1"];
    //AFN设置图片
//    [hearderImageView setImageWithURL:url];
    //YYWebImage 设置图片 网络指示器
    [_hearderImageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
    
    
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
#pragma mark: - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    
    if (offset < 0) {
        //放大
        _hearderView.hm_y = 0;
        _hearderView.hm_height = kHearderViewHeight - offset;
        _hearderImageView.hm_height =  _hearderView.hm_height;
    } else {
        //整体上移
    }
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

@end
