//
//  ViewController.m
//  顶部放大
//
//  Created by user on 16/10/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ViewController.h"
#import "XNHeaderViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)clickBtn:(id)sender {
    
    XNHeaderViewController *vc = [[XNHeaderViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
