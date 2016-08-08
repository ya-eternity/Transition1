//
//  AnimationController.h
//  Transition1
//
//  Created by bmxd-002 on 16/7/18.
//  Copyright © 2016年 bmxd-002. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) UINavigationControllerOperation operation;

- (instancetype)initWithOperation:(UINavigationControllerOperation)operation;

@end
