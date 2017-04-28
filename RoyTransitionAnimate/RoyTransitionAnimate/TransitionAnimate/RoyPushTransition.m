//
//  RoyPushTransition.m
//  RoyTransitionAnimate
//
//  Created by ppdai-Roy on 2017/4/26.
//  Copyright © 2017年 ppdai-Roy. All rights reserved.
//

#import "RoyPushTransition.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "RoyTableViewCell.h"

@implementation RoyPushTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 来源VC
    ViewController *fromVc = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 目的VC
    DetailViewController *toVc = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 获取转场视图
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval durationTime = [self transitionDuration:transitionContext];
    
    // 获取所点击cell中的imageView的快照
    RoyTableViewCell *selectCell = (RoyTableViewCell *)[fromVc.tableView cellForRowAtIndexPath:[fromVc.tableView indexPathForSelectedRow]];
    UIView *selectCellImageSnapshot = [selectCell.leftImageView snapshotViewAfterScreenUpdates:NO];
    UIView *desLabel = [selectCell.desLabel snapshotViewAfterScreenUpdates:NO];
    
    selectCellImageSnapshot.frame = [containerView convertRect:selectCell.leftImageView.frame fromView:selectCell.leftImageView.superview];
    desLabel.frame = [containerView convertRect:desLabel.frame fromView:selectCell.desLabel.superview];

    selectCell.leftImageView.hidden = YES;  // 默认隐藏imageView，然后后面更改快照的frame, 给用户一种是imageView在改变的错觉
    selectCell.desLabel.hidden = YES;
    
    // 设置转场后View的状态
    toVc.view.frame = [transitionContext finalFrameForViewController:toVc];
    toVc.view.alpha = 0;   // 透明第二个页面的view
    toVc.iv.hidden = YES;  // 隐藏第二个页面的imageView
    toVc.desL.hidden = YES;
    
    // 将快照和转场后的View添加到转场内容视图中: 一定要注意先后顺序(由于要有过渡的效果，故将快照在上层)
    [containerView addSubview:toVc.view];
    [containerView addSubview:selectCellImageSnapshot];
    [containerView addSubview:desLabel];
    
    // 转场动画
    [UIView animateWithDuration:durationTime animations:^{
        toVc.view.alpha = 1.0;
        // 获取转场后的imageView的frame
        CGRect imageFrame = [containerView convertRect:toVc.iv.frame fromView:toVc.view];
        CGRect labelFrame = [containerView convertRect:toVc.desL.frame fromView:toVc.view];
        // 改变快照的frame
        selectCellImageSnapshot.frame = imageFrame;
        desLabel.frame = labelFrame;
    } completion:^(BOOL finished) {
        toVc.iv.hidden = NO;
        toVc.desL.hidden = NO;
        selectCell.leftImageView.hidden = NO;   // 显示第一个页面的imageView
        selectCell.desLabel.hidden = NO;
        [selectCellImageSnapshot removeFromSuperview];
        [desLabel removeFromSuperview];
        
        // 调用完成转场动画的方法(一定要调用!!!)
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

@end
