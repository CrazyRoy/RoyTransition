//
//  DetailViewController.m
//  RoyTransitionAnimate
//
//  Created by ppdai-Roy on 2017/4/26.
//  Copyright © 2017年 ppdai-Roy. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"
#import "RoyPopTransition.h"
#import "RoyThing.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width

@interface DetailViewController ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;   // pop返回手势过程中的交互

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self initData];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.layer.cornerRadius = 6.f;
    imageView.layer.masksToBounds = YES;
    CGFloat width = SCREENW - 2*80;
    imageView.frame = CGRectMake(80, 180, width, width);
    [self.view addSubview:imageView];
    self.iv = imageView;
    
    UILabel *desLable = [[UILabel alloc] init];
    desLable.frame = CGRectMake(35, CGRectGetMaxY(imageView.frame) + 15, SCREENW - 2*35, 60);
    desLable.numberOfLines = 0;
    desLable.textAlignment = NSTextAlignmentCenter;
    desLable.textColor = [UIColor lightGrayColor];
    desLable.font = [UIFont systemFontOfSize:16.f];
    [self.view addSubview:desLable];
    self.desL = desLable;
    
    // 创建屏幕边缘手势
    UIScreenEdgePanGestureRecognizer *popGesRecog = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(popGesRecoHandler:)];
    popGesRecog.edges = UIRectEdgeLeft; // 设置触发手势的边缘
    [self.view addGestureRecognizer:popGesRecog];
}

- (void)initData {
    self.title = self.thing.title;
    self.iv.image = self.thing.image;
    self.desL.text = self.thing.des;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if(fromVC == self && [toVC isKindOfClass:[ViewController class]]) {
        return [[RoyPopTransition alloc] init];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if([animationController isKindOfClass:[RoyPopTransition class]]) {
        return self.interactivePopTransition;
    }
    return nil;
}

- (void)popGesRecoHandler:(UIScreenEdgePanGestureRecognizer*)recognizer {
    //计算用户拖动距离
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    NSLog(@"progress: %f", progress);
    progress = MIN(1.0, MAX(0.0, progress));    // 处理边界情况
    if(recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if(recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state ==  UIGestureRecognizerStateCancelled) {
        if(progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];    // 执行pop动画完成
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];    // 取消pop动画
        }
        
        self.interactivePopTransition = nil;
    }
}

@end 
