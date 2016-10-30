//
//  UINavigationController+HMObjcSugar.h
//  HMObjcSugar
//
//  Created by 刘凡 on 16/3/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (HMObjcSugar)

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *hm_popGestureRecognizer;

@end
