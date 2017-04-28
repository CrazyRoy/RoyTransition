//
//  RoyThing.h
//  RoyTransitionAnimate
//
//  Created by ppdai-Roy on 2017/4/26.
//  Copyright © 2017年 ppdai-Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RoyThing : NSObject

@property (nonatomic, copy, readonly) NSString *title;    // 标题
@property (nonatomic, copy, readonly) NSString *des;  // 描述
@property (nonatomic, strong) UIImage *image;   // 图片

+ (NSArray *)exampleThings;
- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName overView:(NSString *)overStr;

@end
