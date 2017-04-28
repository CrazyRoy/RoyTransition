//
//  ViewController.m
//  RoyTransitionAnimate
//
//  Created by ppdai-Roy on 2017/4/26.
//  Copyright © 2017年 ppdai-Roy. All rights reserved.
//

#import "ViewController.h"
#import "RoyThing.h"
#import "RoyPushTransition.h"
#import "RoyTableViewCell.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate> {
    NSArray *_things;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Things";
    
    // DataSource
    _things = [RoyThing exampleThings];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _things.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoyTableViewCell *cell = [RoyTableViewCell getReuseableCellWithTableView:tableView];
    RoyThing *thing = _things[indexPath.row];
    [cell setupData:thing];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RoyThing *thing = _things[indexPath.row];
    DetailViewController *deVc = [[DetailViewController alloc] init];
    deVc.thing = thing;
    [self.navigationController pushViewController:deVc animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if(fromVC == self && [toVC isKindOfClass:[DetailViewController class]]) {
        return [[RoyPushTransition alloc] init];
    }
    return nil;
}

@end
