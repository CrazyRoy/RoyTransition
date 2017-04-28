//
//  RoyTableViewCell.h
//  RoyTransitionAnimate
//
//  Created by ppdai-Roy on 2017/4/26.
//  Copyright © 2017年 ppdai-Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RoyThing;

@interface RoyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

+ (instancetype)getReuseableCellWithTableView:(UITableView *)tableView;

- (void)setupData:(RoyThing *)thing;

@end
