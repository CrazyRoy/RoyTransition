//
//  RoyPopTransition.m
//  RoyTransitionAnimate
//
//  Created by ppdai-Roy on 2017/4/26.
//  Copyright © 2017年 ppdai-Roy. All rights reserved.
//

#import "RoyPopTransition.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "RoyTableViewCell.h"

@implementation RoyPopTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 来源VC
    DetailViewController *fromVc = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 目的VC
    ViewController *toVc = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 获取转场视图
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval durationTime = [self transitionDuration:transitionContext];
    
    // 获取当前页面中的imageView的快照
    UIImageView *currentImageView = fromVc.iv;
    UIView *imageSnapshot = [currentImageView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:currentImageView.frame fromView:currentImageView.superview];
    currentImageView.hidden = YES;
    
    // 设置转场后View的状态
    toVc.view.frame = [transitionContext finalFrameForViewController:toVc];
    toVc.view.alpha = 0;
    RoyTableViewCell *frontCell = (RoyTableViewCell *)[toVc.tableView cellForRowAtIndexPath:[toVc.tableView indexPathForSelectedRow]];
    frontCell.leftImageView.hidden = YES;
    
    [containerView addSubview:toVc.view];
    [containerView addSubview:imageSnapshot];
    
    // 转场动画
    [UIView animateWithDuration:durationTime animations:^{
        toVc.view.alpha = 1.0;
        CGRect frame = [containerView convertRect:frontCell.leftImageView.frame fromView:frontCell.leftImageView.superview];
        imageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        [imageSnapshot removeFromSuperview];
        frontCell.leftImageView.hidden = NO;
        currentImageView.hidden = NO;
        
        // 调用完成转场动画的方法(一定要调用!!!)
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
