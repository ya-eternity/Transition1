//
//  AnimationController.m
//  Transition1
//
//  Created by bmxd-002 on 16/7/18.
//  Copyright © 2016年 bmxd-002. All rights reserved.
//

#import "AnimationController.h"

@interface UIView (anchorPoint)

- (void)setAnchorPointTo:(CGPoint)point;

@end

@implementation UIView (anchorPoint)

- (void)setAnchorPointTo:(CGPoint)point{
    self.frame = CGRectOffset(self.frame, (point.x - self.layer.anchorPoint.x) * self.frame.size.width, (point.y - self.layer.anchorPoint.y) * self.frame.size.height);
    self.layer.anchorPoint = point;
}

@end

@implementation AnimationController

- (instancetype)initWithOperation:(UINavigationControllerOperation)operation
{
    self = [super init];
    if (self) {
        _operation = operation;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    if (_operation == UINavigationControllerOperationPop) {
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *containerView = [transitionContext containerView];
        //拿到push时候的
        UIView *tempView = containerView.subviews.lastObject;
        [containerView addSubview:toVC.view];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            tempView.layer.transform = CATransform3DIdentity;
            fromVC.view.subviews.lastObject.alpha = 1.0;
            tempView.subviews.lastObject.alpha = 0.0;
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            }else{
                [transitionContext completeTransition:YES];
                [tempView removeFromSuperview];
                toVC.view.hidden = NO;
            }
        }];
        return;
    }
    

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取fromView的快照
    UIView *tempView = [fromVC.view viewWithTag:300];
    tempView. layer.masksToBounds = YES;
    tempView.layer.cornerRadius = 0;
    
    UIView *tempFrontView = [tempView snapshotViewAfterScreenUpdates:YES];
    UIView *tempBackView = [[fromVC.view viewWithTag:200] snapshotViewAfterScreenUpdates:NO];
 
    tempFrontView.frame = [tempView convertRect:tempFrontView.frame toView:[UIApplication sharedApplication].keyWindow];
    tempBackView.frame = [[fromVC.view viewWithTag:200] convertRect:[fromVC.view viewWithTag:200].frame toView:[UIApplication sharedApplication].keyWindow];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempBackView];
    fromVC.view.hidden = YES;
    toVC.view.alpha = 0;
    [containerView addSubview:tempFrontView];
//    [containerView insertSubview:toVC.view atIndex:0];

    [UIView animateWithDuration:0.5 animations:^{
        tempFrontView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 235);
        
//        toVC.view.alpha = 1;
        tempBackView.frame = CGRectMake(0, 235, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 235);
        tempBackView.alpha = 0;
        
    } completion:^(BOOL finished) {
        tempFrontView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 235);
        tempFrontView.alpha = 1;
        toVC.view.alpha = 1;
        [(UITableView *)toVC.view setTableHeaderView:tempFrontView];

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [containerView bringSubviewToFront:toVC.view];
        
//        [tempFrontView setNeedsUpdateConstraints];
//        [tempFrontView updateConstraintsIfNeeded];
        
        if ([transitionContext transitionWasCancelled]) {
            fromVC.view.hidden = NO;
            [tempBackView removeFromSuperview];
            [tempFrontView removeFromSuperview];

        }
    }];
    
    NSLog(@"%@", fromVC.view);
    
    
}

- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
 
}


@end
