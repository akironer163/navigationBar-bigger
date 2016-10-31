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
#define kHeaderHeight 200

@interface XNHeaderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation XNHeaderViewController {
    UIView *_headerView;
    UIImageView *_headerImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self prepareTableView];
    [self prepareheaderView];
    
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
- (void)prepareheaderView {
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeaderHeight)];
    
    _headerView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_headerView];
    
    _headerImageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    
    _headerImageView.backgroundColor = [UIColor blueColor];
    
    [_headerView addSubview:_headerImageView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.who.int/entity/campaigns/immunization-week/2015/large-web-banner.jpg?ua=1"];
    
    //AFN设置图片
//    [headerImageView setImageWithURL:url];
    //YYWebImage 设置图片 网络指示器
    [_headerImageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
    
    //填充模式 解决图片变形问题
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    //设置图像裁切
    _headerImageView.clipsToBounds = YES;
    
}

- (void)prepareTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:tableView];
    
    //设置表格 滚动指示器 的间距
    tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    
}

#pragma mark: - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    
    if (offset < 0) {
        
        //放大
        _headerView.hm_y = 0;
        _headerView.hm_height = kHeaderHeight - offset;
        _headerImageView.hm_height =  _headerView.hm_height;
    } else {
        
        //整体上移
        _headerView.hm_height = kHeaderHeight;
        _headerImageView.hm_height =  _headerView.hm_height;
        
        CGFloat min = kHeaderHeight - 64; //headerVeiw最小y值
        _headerView.hm_y = -MIN(min, offset);
        
//        NSLog(@"%f", offset / min); //offset / min == 1 隐藏_headerViewImage 
        CGFloat progress = 1 - (offset / min);
        _headerImageView.alpha = progress;
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
