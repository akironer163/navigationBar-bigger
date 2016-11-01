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
    UIView *_lineView;
    
    UIStatusBarStyle _barStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self prepareTableView];
    [self prepareheaderView];
    
    _barStyle = UIStatusBarStyleLightContent;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //取消自动调整滚动视图间距
    //ViewController + NAV 会自动调整tableView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES]; 
}

//设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return _barStyle;;
}

//顶部视图
- (void)prepareheaderView {
    
    //顶部视图
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeaderHeight)];
    _headerView.backgroundColor = [UIColor hm_colorWithHex:0xf8f8f8];
    
    [self.view addSubview:_headerView];
    
    //图像视图
    _headerImageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    _headerImageView.backgroundColor = [UIColor hm_colorWithHex:0x000033];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill; //填充模式 解决图片变形问题
    _headerImageView.clipsToBounds = YES; //设置图像裁切
    
    [_headerView addSubview:_headerImageView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.who.int/entity/campaigns/immunization-week/2015/large-web-banner.jpg?ua=1"];
    //AFN设置图片
    //    [headerImageView setImageWithURL:url];
    //YYWebImage 设置图片 网络指示器
    [_headerImageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
    
    //分割线
    CGFloat lineHeight = 1 / [UIScreen hm_scale];
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.hm_height - lineHeight, self.view.hm_width, lineHeight)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:_lineView];
    
    
    
}

//表格视图
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
    
    if (offset <= 0) {
        _headerView.hm_y = 0;
        _headerView.hm_height = -scrollView.contentOffset.y;
        _headerImageView.alpha = 1;
    } else {
        // 1. 固定高度
        _headerView.hm_height = kHeaderHeight;
        
        // 2. 移动顶部视图 - 固定预留出导航栏的位置
        CGFloat min = kHeaderHeight - 64;
        _headerView.hm_y = -MIN(min, offset);
        
        // 3. 透明度处理
        CGFloat progress = offset / min;
        _headerImageView.alpha = 1 - progress;
        
        // 4. 状态栏亮度
        _barStyle = (_headerImageView.alpha < 0.5) ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    }
    
    _headerImageView.hm_height = _headerView.hm_height;
    _lineView.hm_y = _headerView.hm_height - _lineView.hm_height;
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
