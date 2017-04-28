//
//  RoyTableViewCell.m
//  RoyTransitionAnimate
//
//  Created by ppdai-Roy on 2017/4/26.
//  Copyright © 2017年 ppdai-Roy. All rights reserved.
//

#import "RoyTableViewCell.h"
#import "RoyThing.h"

@implementation RoyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.leftImageView.layer.cornerRadius = 5.f;
    self.leftImageView.layer.masksToBounds = YES;
}

+ (instancetype)getReuseableCellWithTableView:(UITableView *)tableView {
    RoyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoyTableViewCell"];
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setupData:(RoyThing *)thing {
    self.titleLabel.text = thing.title;
    self.desLabel.text = thing.des;
    self.leftImageView.image = thing.image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
