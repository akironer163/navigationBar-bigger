//
//  DemoCell.m
//  顶部放大
//
//  Created by user on 16/11/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "DemoCell.h"
#import "YYWebImage.h"

@implementation DemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //YYWebImage要加载GIF图 ，必须使用YYAnimatedImageView
        //kvc修改imageView类型
        [self setValue:[[YYAnimatedImageView alloc]  init] forKey:@"imageView"];
        
        //1.栅格化 将cell中所有的内容生成一张独立的图像
        self.layer.shouldRasterize = YES;
        //指定分辨率，否则默认使用X1，生成图像
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        //2.异步绘制 如果cell比较复杂 推荐使用
        self.layer.drawsAsynchronously = YES;
    }
    
    return self;
}

@end
