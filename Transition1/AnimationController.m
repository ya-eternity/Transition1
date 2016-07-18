//
//  AnimationController.m
//  Transition1
//
//  Created by bmxd-002 on 16/7/18.
//  Copyright © 2016年 bmxd-002. All rights reserved.
//

#import "AnimationController.h"

@implementation AnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    

}

@end
