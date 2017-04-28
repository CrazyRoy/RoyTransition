//
//  DetailViewController.h
//  RoyTransitionAnimate
//
//  Created by ppdai-Roy on 2017/4/26.
//  Copyright © 2017年 ppdai-Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RoyThing;

@interface DetailViewController : UIViewController<UINavigationControllerDelegate>

@property(nonatomic, strong) RoyThing *thing;

@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UILabel *desL;

@end
